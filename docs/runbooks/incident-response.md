# Incident response runbook (reference)

## Severity cues

| Sev | Example |
|---|---|
| SEV1 | Total API unavailability, data corruption risk, auth outage |
| SEV2 | Elevated 5xx, partial region degradation, significant latency |
| SEV3 | Single non-critical feature broken |

## First 15 minutes

1. Declare an incident channel and commander.
2. Capture timeline start + symptoms (not theories).
3. Check: deploys in last 2h, cert expiry, dependency status, saturation metrics.
4. Decide: roll back last change vs mitigate in place.

## Useful signals

- `kube_deployment_status_replicas_unavailable`
- HPA at max + elevated latency
- DB connection errors / lock waits
- Ingress 5xx rate
- Certificate notAfter

## Communications

- Internal: status every 15–30 minutes during SEV1/2
- External: only through agreed owner; no speculative root cause

## Close-out

- Root cause, trigger, detection gap, action items with owners
- Add or update a runbook step if humans improvised
