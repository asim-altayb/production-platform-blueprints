# ADR 0001: GitOps as the delivery control plane

## Status

Accepted

## Context

Imperative `kubectl apply` from laptops creates configuration drift and unreviewable production changes.

## Decision

Desired state for cluster workloads lives in Git and is reconciled by Argo CD (app-of-apps). Human operators change Git; the controller changes the cluster.

## Consequences

- Every production change is reviewable and revertible via Git history
- Drift is visible as OutOfSync
- Break-glass manual changes must be documented and re-imported or discarded
