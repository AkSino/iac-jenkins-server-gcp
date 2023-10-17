output "network_id" {
  description = "ID of the created VPC"
  value       = google_compute_network.vpc_network.self_link
}

output "subnetwork_id" {
  description = "ID of the created subnet"
  value       = google_compute_subnetwork.private_network.self_link
}
