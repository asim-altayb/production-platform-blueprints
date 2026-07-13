variable "project_id" {
  type        = string
  description = "GCP project id for the reference environment"
}

variable "region" {
  type    = string
  default = "europe-west1"
}

variable "network_name" {
  type    = string
  default = "ref-platform"
}

variable "subnet_cidr" {
  type    = string
  default = "10.20.0.0/20"
}

variable "cluster_name" {
  type    = string
  default = "ref-gke"
}

variable "secret_ids" {
  type    = list(string)
  default = ["app-db-password", "app-jwt-hmac"]
}
