resource "google_compute_instance" "linux_instance" {
  count          = var.instance_count
  name           = "${var.linux_type_instance}-${count.index}"
  machine_type   = var.machine_type
  zone           = var.gcp_zone
  can_ip_forward = true

  tags = var.instance_tags

  boot_disk {
    initialize_params {
      image = var.instance_image
    }
  }

  // Local SSD disk

  network_interface {
    network    = var.network_id
    subnetwork = var.subnetwork_id
    network_ip = "${var.network_ip_base}${count.index}"

    access_config {
      // Ephemeral IP
    }
  }

  service_account {
    scopes = var.scopes
  }

  metadata = merge({
    sshKeys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
    }, var.include_pod_cidr ? {
    pod-cidr = "10.200.${count.index}.0/24"
  } : {})

  metadata_startup_script = var.instance_startup_script
}
