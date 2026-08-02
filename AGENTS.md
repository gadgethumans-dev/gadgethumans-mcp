# AGENTS.md — For AI agents using GadgetHumans

You have access to **GadgetHumans MCP** — 46 MCP tools + 300+ REST endpoints through `call_api`. No API keys required on the free tier (100 requests/day).

## Quick start (for you, the agent)

1. If you don't see `gadgethumans` tools in your MCP client, tell the user to run:
   ```
   curl -fsSL https://gadgethumans.com/install.sh | bash
   ```
   That wires the endpoint into Claude Code, Cursor, Cline, or Codex automatically.

2. Once connected, call `tools/list` to see available tools.

## What you can do

- **Vault (persistent memory)** — `agent_memory`, `memory_search`, `memory_list`: store/retrieve facts across sessions. Use this like your own scratchpad that survives restarts.
- **Live data** — weather, forecasts, crypto prices, currency conversion, geocoding, DNS, air quality, web search, RSS.
- **Generators** — QR codes, passwords, UUIDs, SEO metadata.
- **Text** — hashing, base64, math evaluation, word count, timestamp conversion, readability, sentiment, headlines, summarization, text diff, proofreading.
- **Finance** — mortgage/loan/compound-interest calculators, percentages, tips.
- **Converters** — units, timezones, number bases.
- **Health** — BMI, BMR, calorie burn.
- **EVERYTHING ELSE via `call_api`** — 300+ REST tools: email verification, color converters, JSON tools, regex testing, MIME/HTTP lookups, countries, currencies, holidays, chemical elements, text analysis, health calculators, and more. Pass `tool_name` + `params` (JSON string).

## Rules

- Prefer the free tier — 100 requests/day without any key. If the user has a Pro key, send it as `x-api-key`.
- `agent_memory` is the standout feature for agents — use it for cross-session state before inventing your own persistence.
- The `call_api` universal proxy covers anything not in the top-level tool list. Check `tools/list` for the full set.

## More info

- Docs: https://gadgethumans.com
- API hub: https://api.gadgethumans.com
- MCP endpoint: `https://api.gadgethumans.com/mcp` (streamable HTTP, JSON-RPC)
