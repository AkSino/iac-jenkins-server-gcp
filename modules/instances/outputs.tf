output "instance_public_ips" {
  description = "List of public IP addresses of instances"
  value = tolist([
    for instance in google_compute_instance.linux_instance :
    instance.network_interface[0].access_config[0].nat_ip
  ])
}

output "instance_names" {
  description = "List of public IP addresses of instances"
  value = tolist([
    for instance in google_compute_instance.linux_instance :
    instance.name
  ])
}
