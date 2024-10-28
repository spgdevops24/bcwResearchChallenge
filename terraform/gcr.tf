
resource "google_artifact_registry_repository" "gcr_repo" {
  provider = google-beta
  project  = var.project_id
  location = var.region
  repository_id = "docker-repo"
  description   = "Docker image repository"
  format        = "DOCKER"
}
