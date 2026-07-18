# HCL: HashiCorp Configuration Language
# GCP Configuration

# terraform init
# terraform fmt
# terraform validate
# terraform apply
# terraform apply
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.8.0"
    }
  }
}

provider "google" {
  project = "pulumi-gcp-501610"
  region  = "us-central1"
  zone    = "us-central1-c"
}

# Cloud Run with Container Image
resource "google_cloud_run_service" "cloudrun-exchange-app" {
  name     = "cloudrun-exchange-app"
  location = "us-central1"

  template {
    spec {
      containers {
        image = "gcr.io/pulumi-gcp-501610/exchange-app-terraform:latest"

        ports {
          container_port = 8080
        }

        resources {
          limits = {
            memory = "1024Mi"
            cpu    = "2"
          }
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

data "google_iam_policy" "admin" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers"
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "policy" {
  location    = google_cloud_run_service.cloudrun-exchange-app.location
  project     = google_cloud_run_service.cloudrun-exchange-app.project
  service     = google_cloud_run_service.cloudrun-exchange-app.name
  policy_data = data.google_iam_policy.admin.policy_data
}


# resource "google_compute_network" "vpc_network" {
#   name = "terraform-network"
# }

# resource "google_storage_bucket" "udemy-iac-training" {
#   name          = "udemy-iac-training"
#   location      = "EU"
#   force_destroy = true

#   uniform_bucket_level_access = true
# }

# terraform {
#   cloud {
#     organization = "udemy-iac-course"

#     workspaces {
#       name = "udemy-iac-course"
#     }
#   }
# }
