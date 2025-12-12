# MCP Configuration Guides

Role-specific quick-start guides for configuring MCP servers optimized for your workflow.

---

## 📚 Available Guides

| Role | Servers | Tools | Key Focus |
|------|---------|-------|-----------|
| **[Frontend Developer](frontend-developer-setup.md)** | Playwright, Lighthouse, DevTools, Vitest, GitHub, Filesystem | ~50-60 | UI testing, performance, accessibility |
| **[Backend Developer](backend-developer-setup.md)** | PostgreSQL, Redis, Supabase, Docker, GitHub, Filesystem, Sequential Thinking | ~60-70 | Database, caching, API, containers |
| **[QA/Testing Engineer](qa-testing-setup.md)** | Playwright, Puppeteer, Lighthouse, DevTools, Vitest, GitHub, Filesystem | ~55-65 | Cross-browser testing, automation, quality gates |
| **[Data Scientist](data-scientist-setup.md)** | DS Toolkit, PostgreSQL, Redis, Kroki, GitHub, Filesystem | ~50-60 | EDA, feature engineering, ML pipelines |

**[Real-World Workflows](workflow-examples.md)**: 8 end-to-end scenarios combining multiple servers

---

## 🚀 Quick Start

1. **Choose your role** - Pick the guide above
2. **Copy configuration** - Use the JSON from your guide
3. **Customize** - Replace placeholders with your credentials
4. **Restart IDE** - Reload to activate servers
5. **Test** - Try example prompts from your guide

---

## 📊 Performance Limits

- **Cursor**: <80 tools optimal (6-8 servers)
- **VS Code**: <128 tools optimal (10-12 servers)

All role configs stay well under these limits!

---

## 🔄 Configuration Management

**Multiple Configs**: Keep separate files like `mcp.frontend.json`, copy as needed  
**Enable/Disable**: Use `"disabled": true/false` to toggle servers  
**Workspace-Specific**: Create `.vscode/mcp.json` per project

---

## 🔧 Customization

**Timeouts**: Increase for heavy operations (e.g., `"timeout": 300` for large datasets)  
**Auto-Approve**: Use cautiously for read-only ops: `"autoApprove": ["run_tests"]`  
**Add Servers**: See [Technical Guide](../TECHNICAL_GUIDE.md) for all 16 servers with detailed setup

---

## 🔍 Validate Setup

```bash
./scripts/health-check.sh
```

Checks: Config syntax • Dependencies • Services • Tool count • Warnings

---

## 📚 Resources

[Project Overview](../README.md) • [Technical Guide](../TECHNICAL_GUIDE.md) • [Config Template](../mcp.json.template) • [Health Check](../scripts/health-check.sh) • [MCP Official](https://modelcontextprotocol.io/)

---

**Version 1.0** | Last Updated: December 12, 2025
