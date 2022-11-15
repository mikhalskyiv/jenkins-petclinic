terraform {
  backend "gcs" {
    bucket = "terraform-state-mikhalskyi"
    prefix = "terraform/tf-state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  # credentials = file("tf-sa-test-cred.json")
}

data "google_service_account" "petclinic-sa" {
  account_id = "petclinic-sa"
}

resource "google_compute_instance" "default" {
  name         = "test-debian-instance"
  machine_type = "e2-micro"
  zone         = var.zone

  tags = var.network_tags

  boot_disk {
    size = 10
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = data.google_service_account.petclinic-sa.email
    scopes = ["cloud-platform"]
  }
}