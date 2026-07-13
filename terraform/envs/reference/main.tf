# Sanitized reference composition. Replace project/region via tfvars — never commit real IDs.
terraform {
  required_version = ">= 1.6.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

module "network" {
  source       = "../../modules/network"
  project_id   = var.project_id
  region       = var.region
  network_name = var.network_name
  subnet_cidr  = var.subnet_cidr
}

module "gke" {
  source       = "../../modules/gke"
  project_id   = var.project_id
  region       = var.region
  cluster_name = var.cluster_name
  network_id   = module.network.network_id
  subnet_id    = module.network.subnet_id
}

module "secrets" {
  source     = "../../modules/secrets"
  project_id = var.project_id
  secret_ids = var.secret_ids
}
