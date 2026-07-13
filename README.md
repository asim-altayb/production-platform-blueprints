# Production Platform Blueprints

Practical **platform-engineering reference patterns** for GKE-centric delivery: Terraform module layout, Kubernetes deployment defaults, Argo CD GitOps, secret boundaries, observability, and incident runbooks.

> Sanitized reference infrastructure only. **No real project IDs, credentials, domains, IPs, or customer config.**

[![CI](https://github.com/asim-altayb/production-platform-blueprints/actions/workflows/ci.yml/badge.svg)](https://github.com/asim-altayb/production-platform-blueprints/actions/workflows/ci.yml)

## What you get

| Area | Content |
|---|---|
| Terraform modules | Network, GKE, Secret Manager shells with clear boundaries |
| Kubernetes | Deployment with probes, HPA, PDB, preStop drain, Workload Identity SA |
| GitOps | Argo CD app-of-apps + AppProject allow-lists |
| Observability | ServiceMonitor, Grafana dashboard skeleton, Promtail snippet |
| Operations | Zero/minimal-downtime migration notes, rollback, incident runbooks |
| Governance | ADRs for delivery and secret handling |
| CI | `terraform fmt/validate`, YAML parse checks, secret pattern scan |

## Repository map

```text
terraform/
  modules/{network,gke,secrets}   # reusable building blocks
  envs/reference                  # composition example (fake project id)
k8s/
  base                            # probes, HPA, PDB, SA
  overlays/reference
argocd/
  projects / apps                 # app-of-apps root
observability/
  prometheus / grafana / loki
docs/
  adr / runbooks
```

## Design principles

1. **Modules own mechanisms; envs own values.** Secrets values never enter Git.
2. **Git is the desired state.** Argo CD reconciles continuously with prune + self-heal.
3. **Pods must be disposable.** Readiness gates traffic; PDBs protect capacity; preStop drains.
4. **Identity beats long-lived keys.** Prefer Workload Identity / cloud SA federation.
5. **Observability ships with the service**, not as a later ticket.

## Quick validation (no cloud account required)

```bash
# Terraform formatting + validate (backend disabled)
terraform -chdir=terraform/envs/reference init -backend=false
terraform -chdir=terraform/envs/reference validate

# Render manifests
kubectl kustomize k8s/overlays/reference
```

CI runs the same class of checks on every push.

## Migration & rollback

See:

- [Zero / minimal downtime migration strategy](docs/runbooks/zero-downtime-migration.md)
- [Rollback procedures](docs/runbooks/rollback.md)
- [Incident response](docs/runbooks/incident-response.md)

## Related public work

- Flagship application reference: [spring-payments-platform](https://github.com/asim-altayb/spring-payments-platform)
- Realtime plane reference: [realtime-platform-blueprint](https://github.com/asim-altayb/realtime-platform-blueprint)

## License

Apache-2.0 · [Asim Abdalla](https://github.com/asim-altayb)
