variable "project_id" { type = string }
variable "region" { type = string }
variable "network_name" { type = string }
variable "subnet_cidr" { type = string }

resource "google_compute_network" "this" {
  name                    = var.network_name
  auto_create_subnetworks = false
  project                 = var.project_id
}

resource "google_compute_subnetwork" "nodes" {
  name          = "${var.network_name}-nodes"
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.this.id
  project       = var.project_id

  private_ip_google_access = true
}

output "network_id" { value = google_compute_network.this.id }
output "subnet_id" { value = google_compute_subnetwork.nodes.id }
