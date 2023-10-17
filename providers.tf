terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.0.0"
    }
  }
}

locals {
  project_id = var.gcp_project
}

provider "google" {
  credentials = file(var.gcp_auth_file)
  project     = local.project_id
  region      = var.gcp_region
  zone        = var.gcp_zone
}

