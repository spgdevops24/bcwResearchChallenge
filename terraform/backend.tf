terraform {
  backend "gcs" {
    bucket = "bcw-challenge-tf-state-bucket"
    prefix  = "terraform/state"
  }
}
