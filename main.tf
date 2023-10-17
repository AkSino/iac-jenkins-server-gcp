module "network" {
  source                       = "./modules/network"
  private_subnet_cidr_block    = "10.240.3.0/24"
  public_subnet_cidr_block     = "10.240.4.0/24"
  vpc_name                     = "jenkins-vpc"
  private_subnet_name          = "jenkins-private-subnet"
  public_subnet_name           = "jenkins-public-subnet"
  router_name                  = "jenkins-router"
  router_nat_name              = "jenkins-router-nat"
  allow_internal_firewall_name = "jenkins-allow-internal"
  allow_external_firewall_name = "jenkins-allow-external"
}

module "jenkins_instances" {
  source                  = "./modules/instances"
  instance_count          = 1
  instance_tags           = ["jenkins-server"]
  instance_startup_script = "apt-get install -y python"
  machine_type            = "e2-small"
  linux_type_instance     = "jenkins"
  instance_image          = "ubuntu-2204-jammy-v20230919"
  gcp_zone                = var.gcp_zone
  network_id              = module.network.network_id
  subnetwork_id           = module.network.subnetwork_id
  scopes                  = ["compute-rw", "storage-ro", "service-management", "service-control", "logging-write", "monitoring"]
  network_ip_base         = "10.240.3.1"
}

resource "local_file" "ansible_inventory" {
  content = <<-EOT
[master]
${module.jenkins_instances.instance_names[0]} ansible_host=${module.jenkins_instances.instance_public_ips[0]}

[all:vars]
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_extra_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
ansible_ssh_private_key_file=${var.ansible_ssh_private_key_file}
ansible_user=ubuntu
  EOT

  file_permission = "0600"
  filename        = "ansible_inventory"
}
