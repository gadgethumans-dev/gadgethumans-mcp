#!/bin/bash
# GadgetHumans MCP — one-line installer
# Gives any AI agent 46 MCP tools + 300+ REST tools via one endpoint.
# Works with: Claude Code, Cursor, Cline, Codex, and any MCP client.
#
# Install:  curl -fsSL https://gadgethumans.com/install.sh | bash
#
set -euo pipefail

MCP_URL="${GADGETHUMANS_MCP_URL:-https://api.gadgethumans.com/mcp}"
NPM_PKG="gadgethumans-mcp"

log()  { printf '\033[1;32m[gadgethumans]\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m[gadgethumans]\033[0m %s\n' "$*" >&2; }
die()  { printf '\033[1;31m[gadgethumans]\033[0m %s\n' "$*" >&2; exit 1; }

# ─── Detect MCP client ────────────────────────────────────────────
detect_client() {
  local found=""
  if [ -n "${CLAUDE_CODE_ENTRYPOINT:-}" ] || command -v claude >/dev/null 2>&1; then found="$found claude"; fi
  if command -v cursor >/dev/null 2>&1; then found="$found cursor"; fi
  if command -v cline >/dev/null 2>&1 || [ -n "${CLINE_WS:-}" ]; then found="$found cline"; fi
  if command -v codex >/dev/null 2>&1; then found="$found codex"; fi
  if [ -n "${found}" ]; then echo "$found"; else echo "generic"; fi
}

# ─── Config helpers ────────────────────────────────────────────────
json_config() {
  local client="$1"
  case "$client" in
    claude)
      local dir="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
      mkdir -p "$dir"
      echo "$dir/claude_desktop_config.json"
      ;;
    cursor)
      echo "$HOME/.cursor/mcp.json"
      ;;
    cline)
      echo "$HOME/.cline/cline_mcp_settings.json"
      ;;
    codex)
      echo "$HOME/.codex/config.toml"
      ;;
    *)
      echo ""
      ;;
  esac
}

install_remote() {
  local client="$1" file
  file="$(json_config "$client")"
  case "$client" in
    claude)
      if [ -f "$file" ]; then
        python3 - "$file" "$MCP_URL" <<'PY'
import json, sys
path, url = sys.argv[1], sys.argv[2]
try:
    cfg = json.load(open(path))
except Exception:
    cfg = {}
servers = cfg.setdefault("mcpServers", {})
servers["gadgethumans"] = {"type": "http", "url": url, "enabled": True}
json.dump(cfg, open(path, "w"), indent=2)
PY
      else
        cat > "$file" <<EOF
{
  "mcpServers": {
    "gadgethumans": { "type": "http", "url": "$MCP_URL", "enabled": true }
  }
}
EOF
      fi
      log "Claude Code configured → $file"
      ;;
    cursor)
      mkdir -p "$HOME/.cursor"
      if [ -f "$file" ]; then
        python3 - "$file" "$MCP_URL" <<'PY'
import json, sys
path, url = sys.argv[1], sys.argv[2]
try:
    cfg = json.load(open(path))
except Exception:
    cfg = {}
cfg["mcpServers"] = cfg.get("mcpServers", {})
cfg["mcpServers"]["gadgethumans"] = {"url": url}
json.dump(cfg, open(path, "w"), indent=2)
PY
      else
        printf '{\n  "mcpServers": {\n    "gadgethumans": { "url": "%s" }\n  }\n}\n' "$MCP_URL" > "$file"
      fi
      log "Cursor configured → $file"
      ;;
    cline)
      mkdir -p "$HOME/.cline"
      if [ -f "$file" ]; then
        python3 - "$file" "$MCP_URL" <<'PY'
import json, sys
path, url = sys.argv[1], sys.argv[2]
try:
    cfg = json.load(open(path))
except Exception:
    cfg = {}
mcp = cfg.setdefault("mcpServers", {})
mcp["gadgethumans"] = {"type": "http", "url": url, "enabled": True}
json.dump(cfg, open(path, "w"), indent=2)
PY
      else
        printf '{\n  "mcpServers": {\n    "gadgethumans": { "type": "http", "url": "%s", "enabled": true }\n  }\n}\n' "$MCP_URL" > "$file"
      fi
      log "Cline configured → $file"
      ;;
    codex)
      mkdir -p "$HOME/.codex"
      if [ -f "$file" ] && grep -q "mcp_servers" "$file" 2>/dev/null; then
        python3 - "$file" "$MCP_URL" <<'PY'
import sys, re
path, url = sys.argv[1], sys.argv[2]
txt = open(path).read()
txt = txt.rstrip() + f'\n\n[mcp_servers.gadgethumans]\ncommand = "npx"\nargs = ["-y", "gadgethumans-mcp"]\n'
open(path, "w").write(txt)
PY
      else
        cat >> "$file" <<EOF

[mcp_servers.gadgethumans]
command = "npx"
args = ["-y", "gadgethumans-mcp"]
EOF
      fi
      log "Codex configured → $file"
      ;;
  esac
}

# ─── Main ─────────────────────────────────────────────────────────
log "GadgetHumans MCP installer — 46 tools + 300+ REST endpoints, free tier: 100 req/day"
echo ""

# 1. Verify endpoint is alive
if command -v curl >/dev/null 2>&1; then
  status=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "$MCP_URL" 2>/dev/null || echo "000")
  if [ "$status" = "405" ] || [ "$status" = "200" ]; then
    log "Endpoint OK: $MCP_URL (HTTP $status)"
  else
    warn "Endpoint check returned HTTP $status — continuing anyway (may need POST)."
  fi
fi

# 2. Detect and configure clients
clients="$(detect_client)"
log "Detected clients:$clients"
for c in $clients; do
  if [ "$c" = "generic" ]; then
    warn "No Claude Code/Cursor/Cline/Codex detected on PATH."
    warn "Add manually to any MCP client:"
    printf '    { "mcpServers": { "gadgethumans": { "url": "%s" } } }\n' "$MCP_URL"
    printf '\n    or via npm:\n    npx -y gadgethumans-mcp\n'
  else
    install_remote "$c"
  fi
done

echo ""
log "Done! Restart your MCP client to load gadgethumans tools."
log "Free tier: 100 requests/day. Pro: \$2.99/mo. Pay-per-call: \$0.001 via x402."
log "Docs: https://gadgethumans.com | API: https://api.gadgethumans.com"
