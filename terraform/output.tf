output "kubernetes_cluster_name" {
  value = google_container_cluster.helloweb3.name
}

output "repository_url" {
  value = "gcr.io/${var.project_id}/docker-repo"
}