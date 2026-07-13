# Zero / minimal-downtime migration strategy

## Intent

Move traffic between environments (or clouds) with controlled risk. Production experience includes an AWS→GCP cutover on the order of **~20 minutes** of coordinated downtime for stateful edges; many API cutovers can be closer to zero with dual-running.

## Pattern

1. **Build target green** — IaC, GitOps, observability, identity, backups verified.
2. **Dual-run read path** where possible (replicas, async replication, or read-only mirrors).
3. **Freeze risky writes** or enter maintenance for components that cannot dual-write safely.
4. **DNS / LB cutover** with low TTL prepared in advance.
5. **Validate** synthetic checks + business KPIs before declaring success.
6. **Keep rollback path warm** for one full business cycle.

## Application tactics

| Component | Tactic |
|---|---|
| Stateless API | Blue/green or rolling with readiness gates |
| WebSocket plane | Drain connections; clients reconnect with backoff |
| PostgreSQL | Logical replication / vendor migration service; plan a short write freeze if required |
| Secrets/config | Pre-create in target secret store; never copy via chat |
| Observability | Dashboards live before cutover |

## Exit criteria

- Error budget burn normal for 30–60 minutes post-cutover
- No elevated auth / DB connection failures
- Rollback owner still online
