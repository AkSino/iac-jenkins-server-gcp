resource "google_compute_network" "vpc_network" {
  name                            = var.vpc_name
  auto_create_subnetworks         = false
  delete_default_routes_on_create = true
}

resource "google_compute_subnetwork" "private_network" {
  name                     = var.private_subnet_name
  ip_cidr_range            = var.private_subnet_cidr_block
  network                  = google_compute_network.vpc_network.self_link
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "public_network" {
  name          = var.public_subnet_name
  ip_cidr_range = var.public_subnet_cidr_block
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_firewall" "internal" {
  name    = var.allow_internal_firewall_name
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "udp"
  }

  allow {
    protocol = "tcp"
  }

  #source_ranges = [var.private_subnet_cidr_block, "10.200.0.0/16", var.public_subnet_cidr_block]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "external" {
  name    = var.allow_external_firewall_name
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "udp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "6443", "8080", "2379-2380", "10250", "10257", "10259", "30000-32767"]
  }

  source_ranges = ["0.0.0.0/0"]
}


resource "google_compute_router" "router" {
  name    = var.router_name
  network = google_compute_network.vpc_network.self_link
}

resource "google_compute_router_nat" "nat" {
  name                               = var.router_nat_name
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "MANUAL_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.private_network.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  nat_ips = [google_compute_address.nat.self_link]
}

resource "google_compute_route" "private_network_internet_route" {
  name             = "private-network-internet"
  dest_range       = "0.0.0.0/0"
  network          = google_compute_network.vpc_network.self_link
  next_hop_gateway = "default-internet-gateway"
  priority         = 100
}

resource "google_compute_address" "nat" {
  name         = "nat"
  address_type = "EXTERNAL"
}
