# Fleet Resource Monitor

Independent Raspberry Pi watcher that SSHes over Tailscale to always-on hosts,
checks disk / RAM / load, and pages a self-hosted [ntfy](https://ntfy.sh) topic
on threshold crossings and recoveries.

Designed to sit next to Uptime Kuma — not a replacement for it. No Prometheus,
no docker prune, just resource paging with no silent death if the checker dies.

## Features

- Docker Compose deployment (classic `docker-compose` friendly on Pi)
- Inventory-driven hosts (YAML), optional `ProxyJump` via `server1`
- Localhost self-check for the Pi
- Disk warn ≥85% / critical ≥92% (configurable; optional extra mounts)
- RAM critical ≥90% using `MemAvailable`
- Load alert only if `load1 ≥ 2× nproc` for **two consecutive** checks
- ntfy alerts with high priority for critical events
- State file: alert on **state change**, re-alert every **6 hours** while still unhealthy
- Heartbeat file + Docker `HEALTHCHECK` so a wedged loop is visible
- Checker failures themselves attempt an ntfy page
- `--once` / `--dry-run` for safe first runs

## Layout

```
fleet-resource-monitor/
  Dockerfile
  docker-compose.yml
  .env.example
  config/hosts.example.yml
  src/fleet_monitor/     # application
  scripts/healthcheck.sh
  tests/
  README.md
```

## Alert policy (state file)

Persisted in `STATE_FILE` (default `/data/state.json`):

1. **Transition alert** — first time a condition becomes warn/critical, or severity changes, or the host becomes unreachable.
2. **Recovery alert** — when the condition returns to OK (or the host is reachable again).
3. **Cooldown re-alert** — if still unhealthy after `ALERT_COOLDOWN_SECONDS` (default `21600` = 6h), page again so long-running problems are not forgotten, without spamming every 15-minute loop.

## Pi deploy (Computerman)

### 1. Copy the project onto the Pi

```bash
# from this repo (or after splitting into its own repo)
cd fleet-resource-monitor
```

### 2. Configure

```bash
cp .env.example .env
cp config/hosts.example.yml config/hosts.yml
mkdir -p ssh data

# Install the SSH identity used to reach Tailscale hosts (read-only in compose)
cp ~/.ssh/id_ed25519 ssh/id_ed25519
chmod 600 ssh/id_ed25519

# known_hosts must already contain the fleet host keys (or jump host keys)
cp ~/.ssh/known_hosts ssh/known_hosts
# or: ssh-keyscan -H 100.100.126.125 >> ssh/known_hosts
```

Edit `.env`:

- `NTFY_URL` — e.g. `https://ntfy.your.domain`
- `NTFY_TOPIC` — e.g. `fleet-resources`
- `NTFY_TOKEN` — optional bearer token if the topic is protected

Edit `config/hosts.yml` if IPs/users/jumps differ. `proxy_jump: server1` resolves to `max-kendall@100.100.126.125` from the inventory.

Ensure the identity can SSH (BatchMode) to each host, and that `server1` accepts ProxyJump for the LXC/VM hosts.

### 3. Dry-run once

```bash
docker-compose build
docker-compose run --rm fleet-monitor python -m fleet_monitor --once --dry-run -v
```

You should see per-host metrics and any ntfy payloads logged without publishing.

### 4. Start 24/7

```bash
docker-compose up -d
docker-compose logs -f fleet-monitor
```

Default interval is **900 seconds (15 minutes)**. Compose uses `network_mode: host` so the container shares the Pi’s Tailscale routing and can self-check `localhost`.

### 5. Confirm health

```bash
docker inspect --format='{{.State.Health.Status}}' fleet-resource-monitor
cat data/heartbeat
```

If the process hangs or stops writing heartbeats for ~2 intervals, Docker marks the container unhealthy (`restart: unless-stopped` will not alone fix a wedged PID — check logs / recreate).

## Local development (without Docker)

```bash
cd fleet-resource-monitor
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt pytest
export PYTHONPATH=src
export HOSTS_FILE=config/hosts.example.yml
export NTFY_URL=https://ntfy.example.com
export NTFY_TOPIC=test
export STATE_FILE=/tmp/fleet-state.json
export HEARTBEAT_FILE=/tmp/fleet-heartbeat
export SSH_IDENTITY_FILE=$HOME/.ssh/id_ed25519
export SSH_KNOWN_HOSTS=$HOME/.ssh/known_hosts

python -m fleet_monitor --once --dry-run -v
pytest -q
```

## Environment reference

| Variable | Default | Meaning |
|---|---|---|
| `NTFY_URL` | _(required)_ | Base URL of ntfy server |
| `NTFY_TOPIC` | _(required)_ | Topic name |
| `NTFY_TOKEN` | _(empty)_ | Optional bearer token |
| `HOSTS_FILE` | `/config/hosts.yml` | Inventory path |
| `STATE_FILE` | `/data/state.json` | Alert state |
| `HEARTBEAT_FILE` | `/data/heartbeat` | Loop liveness stamp |
| `SSH_IDENTITY_FILE` | `/ssh/id_ed25519` | Private key (mounted ro) |
| `SSH_KNOWN_HOSTS` | `/ssh/known_hosts` | known_hosts (mounted ro) |
| `SSH_CONNECT_TIMEOUT` | `10` | SSH `ConnectTimeout` |
| `CHECK_INTERVAL_SECONDS` | `900` | Loop sleep (15m) |
| `ALERT_COOLDOWN_SECONDS` | `21600` | Re-alert while still bad (6h) |
| `DISK_WARN_PERCENT` | `85` | Disk warn threshold |
| `DISK_CRITICAL_PERCENT` | `92` | Disk critical threshold |
| `RAM_CRITICAL_PERCENT` | `90` | RAM critical (MemAvailable) |
| `LOAD_MULTIPLIER` | `2` | `load1` vs `nproc` factor |
| `LOAD_CONSECUTIVE_REQUIRED` | `2` | Consecutive elevated checks |

## SSH behaviour

- `BatchMode=yes` (no password prompts)
- Short `ConnectTimeout`
- `StrictHostKeyChecking=yes` + mounted `known_hosts`
- Optional `ProxyJump` from inventory

Remote collection is a small POSIX shell snippet over SSH stdin (disk via `df -P`, RAM via `/proc/meminfo`, load via `/proc/loadavg`, CPUs via `nproc`).

## Non-goals

- Not Prometheus / Grafana
- Not an Uptime Kuma replacement (no HTTP uptime probes)
- No automatic docker prune or remediation
