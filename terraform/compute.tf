variable "ssh_pub_key" {}
variable "instance_name" {}

resource "openstack_compute_keypair_v2" "ssh-key" {
  name = "naavre-dev-vm-access"
  public_key = file(var.ssh_pub_key)
}

resource "openstack_compute_instance_v2" "dev-vm" {
  name        = var.instance_name
  image_name  = "Ubuntu 24.04"
  flavor_name = "4cpu.8ram"
  key_pair    = openstack_compute_keypair_v2.ssh-key.name
  security_groups = [openstack_networking_secgroup_v2.dev-vm.name]

  block_device {
    source_type           = "image"
    uuid = "3e29832d-215f-4062-ab50-1231756a99be"  # Ubuntu 24.04
    volume_size           = 100
    destination_type      = "volume"
    delete_on_termination = true
  }

  network {
    name = "SNE-LAB-VM"
  }

  provisioner "remote-exec" {
    inline = ["cloud-init status --wait"]
    on_failure = continue
    connection {
      host = self.access_ip_v4
      type = "ssh"
      user = "ubuntu"
      agent_identity = var.ssh_pub_key
    }
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu -i '${self.access_ip_v4},' ../playbooks/all.yaml"
  }
}
