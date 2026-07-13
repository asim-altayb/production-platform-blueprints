# ADR 0002: Secret boundaries

## Status

Accepted

## Context

Leaked infrastructure repos are common. Embedding secret *values* in Terraform state or Kubernetes YAML is an avoidable class of incidents.

## Decision

1. Git may contain secret *names* and IAM bindings only.
2. Values live in a managed secret store (e.g. Secret Manager).
3. Workloads consume secrets via CSI / env injection at runtime.
4. CI scans for high-confidence secret patterns.

## Consequences

- Terraform plans remain shareable in PRs with less redaction risk
- Rotation does not require Git commits of secret material
- Engineers must learn the secret store workflow
