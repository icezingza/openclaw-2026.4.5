#!/bin/bash
# OpenClaw Gateway - Startup Script (Google Gemini)
# Usage: GOOGLE_API_KEY=AQ.xxx ./start.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SESSION_DIR="${HOME}/.openclaw-session"
mkdir -p "$SESSION_DIR"

PROXY_PATCH="$SESSION_DIR/proxy-patch.mjs"

# สร้าง proxy patch สำหรับ sandbox
cat > "$PROXY_PATCH" << 'EOF'
import { setGlobalDispatcher, ProxyAgent } from '/sessions/inspiring-optimistic-edison/mnt/openclaw-2026.4.5/node_modules/undici/index.js';
const dispatcher = new ProxyAgent({
  uri: 'http://127.0.0.1:3128',
  requestTls: { rejectUnauthorized: false },
  proxyTls: { rejectUnauthorized: false }
});
setGlobalDispatcher(dispatcher);
process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0';
console.error('[openclaw] HTTPS proxy configured');
EOF

if [ -z "$GOOGLE_API_KEY" ]; then
  echo "Error: GOOGLE_API_KEY is required"
  exit 1
fi

export NODE_OPTIONS="--import $PROXY_PATCH"

echo "[openclaw] Starting gateway on port 18789 (Google Gemini)..."
cd "$SCRIPT_DIR"
exec node openclaw.mjs gateway --port 18789
