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
  project     = "pulumi-gcp-501610"
  region      = "us-central1"
  zone        = "us-central1-c"
}

# resource "google_compute_network" "vpc_network" {
#   name = "terraform-network"
# }

resource "google_storage_bucket" "udemy-iac-training" {
  name          = "udemy-iac-training"
  location      = "EU"
  force_destroy = true

  uniform_bucket_level_access = true
}