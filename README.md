# GadgetHumans MCP — 46 AI Agent Tools + 329 REST endpoints

**One MCP endpoint. Zero friction. Free tier, no API key.**

Docs & source: https://github.com/gadgethumans-dev/gadgethumans-mcp · Endpoint: https://api.gadgethumans.com/mcp

## ⚡ Install (one line)

```bash
curl -fsSL https://gadgethumans.com/install.sh | bash
```

Auto-detects Claude Code, Cursor, Cline, or Codex and wires the endpoint in. Or add manually:

```json
{
  "mcpServers": {
    "gadgethumans": {
      "type": "http",
      "url": "https://api.gadgethumans.com/mcp"
    }
  }
}
```

## What You Get

46 MCP tools across 8 categories — no API keys, no signup. Free tier: 5 requests/day; Pro $2.99/mo for 500 requests/day.

**AI & Agents** — Chat completions, tone analysis, text generation, entity extraction
**Weather & Geo** — Current weather, 7-day forecast, air quality, geocoding
**Crypto & Finance** — Live prices, loan calculator, mortgage calc, ROI, currency converter
**Web & Scraping** — URL content extraction, RSS feed parsing, link checking, SSL verification
**Code & Dev** — SQL formatter, JSON tools, code complexity, regex testing
**DNS & Network** — DNS lookup, reverse DNS, port checking, SSL cert check
**Marketing & SEO** — SEO metadata generator, keyword analysis, Open Graph scraping
**Data & Math** — Stats, matrix operations, hex dumps, unit conversion, color tools

## Pricing

| Tier | Price | Calls |
|------|-------|-------|
| Free | $0 | 5 requests/day |
| Pro | $2.99/month | 500 requests/day |
| Pay-per-call (x402) | $0.001/call | Unlimited |

**Buy credit packs — instant delivery:**
- [**$4.99** — 1,000 API calls](https://buy.stripe.com/cNi7sL1AeddebW0ePXabK0q)
- [**$24.99** — 10,000 API calls](https://buy.stripe.com/00wcN592G5KM2lq8rzabK0r)

Pay by card or USDC on Base. No subscription required.

## Quick Start

```bash
# Any MCP client
# Just add to your config:
{
  "mcpServers": {
    "gadgethumans": {
      "url": "https://api.gadgethumans.com/mcp"
    }
  }
}
```

Works with Claude Desktop, Cline, Continue.dev, Codex, Windsurf, and any MCP-compatible client.

## Why GadgetHumans?

- **No API keys to manage** — just point and connect
- **Pay per call OR flat rate** — your choice
- **46 MCP tools out of the box** — weather, crypto, web, code, AI, and more
- **Production infrastructure** — HTTPS, auto-healing, Stripe payments
- **Listed on MCP.so, Glama, Smithery, and the official MCP Registry**

---

**Built with x402 — the payment protocol for the agent economy.**
