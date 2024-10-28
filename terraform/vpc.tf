resource "google_compute_network" "vpc_network" {
  name                    = "gke-vpc"
  routing_mode            = "REGIONAL"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "gke_subnet" {
  name                     = "gke-subnet"
  ip_cidr_range            = "10.0.0.0/16"
  network                  = google_compute_network.vpc_network.self_link
  private_ip_google_access = true
  region                   = local.region

  # Define Secondary IP Ranges for kubernetes pods and services
  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = "10.1.0.0/16"
  }

  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = "10.2.0.0/16"
  }
}

resource "google_compute_firewall" "allow_gke_app_traffic" {
  name    = "allow-gke-app-traffic"
  network = google_compute_network.vpc_network.self_link

  allow {
    protocol = "tcp"
    ports    = ["3000"]
  }

  source_ranges = ["0.0.0.0/0"]  # Allows access from any IP
  target_tags   = ["gke-app"]    # Use this tag to specify GKE nodes
  description   = "Allow incoming traffic to GKE application on port 3000"
}

###Aditional configuration candidate might fined usefull to add
