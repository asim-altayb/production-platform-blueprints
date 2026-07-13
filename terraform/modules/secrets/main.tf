variable "project_id" { type = string }
variable "secret_ids" {
  type        = list(string)
  description = "Logical secret names only — never values."
}

resource "google_secret_manager_secret" "this" {
  for_each  = toset(var.secret_ids)
  project   = var.project_id
  secret_id = each.value

  replication {
    auto {}
  }
}

# IAM bindings belong at the env layer so service accounts stay environment-scoped.
output "secret_names" {
  value = { for k, s in google_secret_manager_secret.this : k => s.name }
}
