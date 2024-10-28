resource "google_container_cluster" "helloweb3" {
    name = "helloweb3-cluster"
    location = local.region
    network = google_compute_network.vpc_network.self_link
    subnetwork = google_compute_subnetwork.gke_subnet.self_link

    # Define IP allocation for kubernetes resources
    ip_allocation_policy {
      cluster_secondary_range_name = "pods"
      services_secondary_range_name = "services"
    }

    # Enable Google Cloud's kubernetes engine features
    remove_default_node_pool = true
    initial_node_count = 1
    deletion_protection = false
    node_config {
      disk_size_gb = "50"
    }
}

resource "google_container_node_pool" "app_pool" {
    name = "app-pool"
    cluster = google_container_cluster.helloweb3.name
    location = google_container_cluster.helloweb3.location
    node_count = 2

    # Define the Machine type and node configuration
    node_config {
      machine_type = "e2-medium"
      disk_size_gb = "20"
      oauth_scopes = [
        "https://www.googleapis.com/auth/cloud-platform"
      ]
      labels = local.default_labels
      service_account = data.google_compute_default_service_account.default.email
    }

    # Autoscaling configs
    autoscaling {
      min_node_count = 1
      max_node_count = 1 # change to 3 after test
    }
}
