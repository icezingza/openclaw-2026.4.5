#!/bin/bash
# OpenClaw Gateway Startup Script
# Usage: ./start-gateway.sh [port]

PORT=${1:-18789}
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "[openclaw] Starting gateway on port $PORT..."
cd "$SCRIPT_DIR"

node openclaw.mjs gateway \
  --port "$PORT" \
  --allow-unconfigured \
  --verbose
