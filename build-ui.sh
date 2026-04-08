#!/bin/bash
# OpenClaw - Build Control UI
# Usage: bash build-ui.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "[openclaw] Installing UI dependencies..."
cd ui
pnpm install

echo "[openclaw] Building Control UI..."
cd ..
pnpm ui:build

echo ""
echo "[openclaw] UI build complete!"
echo "[openclaw] Start gateway then open: http://localhost:18789"
