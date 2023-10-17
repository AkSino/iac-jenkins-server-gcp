variable "machine_type" {
  description = "Instance type for the GCE instance"
  type        = string
}

variable "instance_image" {
  description = "Instance image for the GCE instance"
  type        = string
}

variable "network_id" {
  description = "Network ID"
  type        = string
}

variable "subnetwork_id" {
  description = "Subnetwork ID"
  type        = string
}

variable "gcp_zone" {
  type        = string
  description = "GCP zone"
}

variable "network_ip_base" {
  description = "Base Adress IP"
  type        = string
}

variable "scopes" {
  description = "List of scopes"
  type        = list(string)
  default     = ["compute-rw", "storage-ro", "service-management", "service-control", "logging-write", "monitoring"]
}

variable "instance_startup_script" {
  description = "Instance startup script"
  type        = string
  default     = ""
}

variable "include_pod_cidr" {
  description = "Include pod_cidr ?"
  type        = bool
  default     = false
}

variable "gce_ssh_user" {
  default = "ubuntu"
}
variable "gce_ssh_pub_key_file" {
  default = "~/.ssh/google_compute_engine_ubuntu.pub"
}
variable "linux_type_instance" {
  type = string
}

variable "instance_tags" {
  description = "Instance Tags"
  type        = list(string)
  default     = []
}

variable "instance_count" {
  description = "Instance count"
  type        = number
  default     = 1
}
