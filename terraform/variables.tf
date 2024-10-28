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

variable "cluster_name" {
  description = "GKE Cluster Name"
  type        = string
  default     = "bcw-gke-cluster"
}

variable "node_count" {
  description = "Number of nodes in the GKE cluster"
  type        = number
  default     = 1
}

variable "machine_type" {
  description = "Machine type for GKE nodes"
  type        = string
  default     = "e2-medium"
}