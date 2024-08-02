terraform {
  backend "gcs" {
    bucket = "tf-state-942874504477"
  }

  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.39.1"
    }
  }
}

provider "google" {
  project = "firebase-playground-9845"
}

data "google_project" "current" {}

resource "google_storage_bucket" "tf-state" {
  name     = "tf-state-${data.google_project.current.number}"
  location = "EUROPE-WEST4"

  force_destroy               = false
  public_access_prevention    = "enforced"
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }
}