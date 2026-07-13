# Rollback procedures

## GitOps rollback (preferred)

```bash
# Identify bad revision
argocd app history payments-api

# Roll application source revision back (example)
git revert <bad-commit>
git push origin main
# Argo CD self-heal applies previous manifests
```

## Kubernetes deployment rollback

```bash
kubectl -n payments-ref rollout undo deployment/payments-api
kubectl -n payments-ref rollout status deployment/payments-api
```

## Terraform rollback

1. Revert the Git commit that changed infrastructure.
2. `terraform plan` in a controlled pipeline.
3. Apply only after confirming blast radius (especially node pools and networking).

## Database rollback

- Prefer **forward fixes** for additive migrations.
- Expand/contract pattern: never deploy code that requires a column you just dropped.
- Restore from PITR only with an explicit incident commander decision.
