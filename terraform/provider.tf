locals {
  project_id = var.project_id
  region     = var.region
  default_labels = {
    managed-by = "terraform"
  }
}

terraform {
  required_version = "~> 1.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.2"
    }
  }

}

provider "google" {
  project = local.project_id
  region  = local.region
}

provider "google-beta" {
  project = local.project_id
  region  = local.region
}

data "google_project" "this" {}

# This data block will fetch default service account
data "google_compute_default_service_account" "default" {}