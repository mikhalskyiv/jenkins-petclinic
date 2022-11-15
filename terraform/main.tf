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

resource "google_compute_instance" "default" {
  name         = "test-debian-instance"
  machine_type = "e2-micro"
  zone         = var.zone

  tags = var.network_tags

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
      size = 10
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = "tf-sa-test@gcp-2022-1-phase2-mikhalskyi.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
}