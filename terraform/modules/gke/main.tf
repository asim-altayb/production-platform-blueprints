variable "project_id" { type = string }
variable "region" { type = string }
variable "cluster_name" { type = string }
variable "network_id" { type = string }
variable "subnet_id" { type = string }
variable "release_channel" {
  type    = string
  default = "REGULAR"
}

resource "google_container_cluster" "this" {
  name     = var.cluster_name
  location = var.region
  project  = var.project_id

  # Reference shape: regional control plane, VPC-native, Workload Identity.
  networking_mode = "VPC_NATIVE"
  network         = var.network_id
  subnetwork      = var.subnet_id

  remove_default_node_pool = true
  initial_node_count       = 1

  release_channel {
    channel = var.release_channel
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  # Private cluster toggles intentionally left conservative for a public reference.
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
  }

  lifecycle {
    prevent_destroy = false
  }
}

resource "google_container_node_pool" "general" {
  name     = "general"
  cluster  = google_container_cluster.this.name
  location = var.region
  project  = var.project_id

  autoscaling {
    min_node_count = 1
    max_node_count = 10
  }

  node_config {
    machine_type = "e2-standard-4"
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]

    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    labels = {
      workload = "general"
    }
  }
}

output "cluster_name" { value = google_container_cluster.this.name }
