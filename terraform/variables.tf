variable "region" {
  description = "GCP Region in which the resources need to be managed"
  type = string
  nullable = false
}

variable "project_id" {
  description = "GCP Project ID in which the resources need to be managed"
  type = string
  nullable = false
}

variable "credentials_path" {
  description = "The path to your GCP service account credentials JSON file"
}

variable "bucket_name" {
  description = "The desired name for your Terraform state bucket"
  default = "bcw-challenge-tf-state-bucket"
}