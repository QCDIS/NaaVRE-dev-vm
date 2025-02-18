resource "openstack_networking_secgroup_v2" "dev-vm" {
  name = "naavre-dev-vm"
}

resource "openstack_networking_secgroup_rule_v2" "dev-vm-icmp-4" {
  description = "allow ping"
  security_group_id = openstack_networking_secgroup_v2.dev-vm.id
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
}

resource "openstack_networking_secgroup_rule_v2" "dev-vm-icmp-6" {
  description = "allow ping"
  security_group_id = openstack_networking_secgroup_v2.dev-vm.id
  direction = "ingress"
  ethertype = "IPv6"
  protocol = "ipv6-icmp"
  remote_ip_prefix  = "::/0"
}

resource "openstack_networking_secgroup_rule_v2" "dev-vm-wireguard-4" {
  description = "allow ingress wireguard"
  security_group_id = openstack_networking_secgroup_v2.dev-vm.id
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "udp"
  port_range_min = 51820
  port_range_max = 51820
  remote_ip_prefix  = "0.0.0.0/0"
}

resource "openstack_networking_secgroup_rule_v2" "dev-vm-wireguard-6" {
  description = "allow ingress wireguard"
  security_group_id = openstack_networking_secgroup_v2.dev-vm.id
  direction = "ingress"
  ethertype = "IPv6"
  protocol = "udp"
  port_range_min = 51820
  port_range_max = 51820
  remote_ip_prefix  = "::/0"
}

resource "openstack_networking_secgroup_rule_v2" "dev-vm-ssh-4" {
  description = "allow ingress ssh"
  security_group_id = openstack_networking_secgroup_v2.dev-vm.id
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 22
  port_range_max = 22
  remote_ip_prefix  = "0.0.0.0/0"
}

resource "openstack_networking_secgroup_rule_v2" "dev-vm-ssh-6" {
  description = "allow ingress ssh"
  security_group_id = openstack_networking_secgroup_v2.dev-vm.id
  direction = "ingress"
  ethertype = "IPv6"
  protocol = "tcp"
  port_range_min = 22
  port_range_max = 22
  remote_ip_prefix  = "::/0"
}
