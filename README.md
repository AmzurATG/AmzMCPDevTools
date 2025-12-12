# 🚀 AmzMCPDevTools

> **Comprehensive MCP (Model Context Protocol) Configuration Toolkit for AI-Powered Development**

A curated collection of MCP server configurations, role-specific guides, and workflow examples to supercharge your AI coding assistant (Cursor, VS Code Copilot) with powerful external tool integrations.

[![Version](https://img.shields.io/badge/version-2.0.0-blue.svg)](./CHANGELOG.md)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](./LICENSE)
[![Last Updated](https://img.shields.io/badge/updated-Dec%202025-orange.svg)](./CHANGELOG.md)

---

## 📋 Table of Contents

- [What is MCP?](#-what-is-mcp)
- [What's Included](#-whats-included)
- [Quick Start](#-quick-start)
- [Role-Specific Guides](#-role-specific-guides)
- [MCP Servers Included](#-mcp-servers-included)
- [Project Structure](#-project-structure)
- [Tools & Scripts](#-tools--scripts)
- [Contributing](#-contributing)
- [Resources](#-resources)

---

## 🎯 What is MCP?

**Model Context Protocol (MCP)** is a standardized protocol that enables AI assistants like Cursor and GitHub Copilot to interact with external services, databases, APIs, and tools. Think of it as giving your AI superpowers!

### Key Benefits

- 🔌 **Extended Capabilities**: Access databases, browsers, containers, and more
- 🎯 **Workflow Integration**: Combine multiple tools for complex tasks
- 🚀 **Productivity Boost**: Automate repetitive tasks and streamline development
- 🔍 **Context Awareness**: AI understands your entire development environment

---

## 📦 What's Included

### 📚 Comprehensive Documentation

- **Technical Guide** ([TECHNICAL_GUIDE.md](TECHNICAL_GUIDE.md)): 1000+ lines covering all 16 MCP servers
- **Role-Specific Guides**: Optimized configurations for different developer roles
- **Workflow Examples**: 8 real-world end-to-end scenarios
- **FAQ**: 40+ common questions answered

### ⚙️ Configuration Files

- **mcp.json**: Production-ready configuration with all 16 servers
- **mcp.json.template**: Template with placeholders for team sharing

### 🛠️ Tools & Scripts

- **health-check.sh**: Validate your MCP setup and dependencies
- Automated checks for configuration, dependencies, and performance

### 🎓 Learning Resources

- Step-by-step setup for Windows, macOS, and Linux
- Troubleshooting guides for each MCP server
- Security best practices and performance optimization tips

---

## ⚡ Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/AmzurATG/AmzMCPDevTools.git
cd AmzMCPDevTools
```

### 2. Choose Your Path

**Option A: Copy Complete Configuration**
```bash
# For Cursor
cp mcp.json ~/.cursor/mcp.json

# For VS Code (Linux)
cp mcp.json ~/.config/Code/User/mcp.json

# For VS Code (macOS)
cp mcp.json ~/Library/Application\ Support/Code/User/mcp.json
```

**Option B: Use Role-Specific Configuration**

Choose the guide that matches your role:
- 🎨 [Frontend Developer](guides/frontend-developer-setup.md)
- ⚙️ [Backend Developer](guides/backend-developer-setup.md)
- 🧪 [QA/Testing Engineer](guides/qa-testing-setup.md)
- 📊 [Data Scientist](guides/data-scientist-setup.md)

### 3. Customize Configuration

Edit your `mcp.json` and replace placeholders:
- `<YOUR_GITHUB_TOKEN>` → Your GitHub personal access token
- `<YOUR_POSTGRES_URL>` → Your PostgreSQL connection string
- `<ABSOLUTE_PATH>` → Actual directory paths
- Other credential placeholders

### 4. Install Dependencies

```bash
# Core dependencies
node --version  # Ensure Node.js v16+ is installed
npm install -g npm@latest

# Optional: Python tools (for uvx/DS Toolkit)
pip install uv

# Optional: Browser binaries
npx playwright install
```

### 5. Validate Setup

```bash
./scripts/health-check.sh
```

### 6. Restart Your IDE

- **VS Code/Cursor**: `Ctrl+Shift+P` → "Reload Window"
- Or fully restart your IDE

### 7. Test It Out

Try these prompts in your AI assistant:
- "List all connected MCP servers"
- "Show me the files in [your configured path]"
- "What's the latest issue in [your GitHub repo]?"

---

## 👥 Role-Specific Guides

Each guide includes:
- ✅ Recommended MCP servers for your role
- 📊 Tool count estimates (all under performance limits)
- 🎯 Common use cases and workflows
- 🔧 Role-specific troubleshooting
- 💡 Pro tips and best practices

### 🎨 Frontend Developer
**Servers**: Playwright, Lighthouse, Chrome DevTools, Vitest, GitHub, Filesystem  
**Focus**: UI testing, performance audits, browser automation  
**Tools**: ~50-60 (well under 80 limit)

[📖 Read Guide →](guides/frontend-developer-setup.md)

---

### ⚙️ Backend Developer
**Servers**: PostgreSQL, Redis, Supabase, Docker, GitHub, Filesystem, Sequential Thinking  
**Focus**: Database ops, caching, API development, containers  
**Tools**: ~60-70 (well under 80 limit)

[📖 Read Guide →](guides/backend-developer-setup.md)

---

### 🧪 QA/Testing Engineer
**Servers**: Playwright, Puppeteer, Lighthouse, Chrome DevTools, Vitest, GitHub  
**Focus**: Cross-browser testing, performance testing, automation  
**Tools**: ~55-65 (well under 80 limit)

[📖 Read Guide →](guides/qa-testing-setup.md)

---

### 📊 Data Scientist
**Servers**: DS Toolkit, PostgreSQL, Redis, Kroki, GitHub, Filesystem  
**Focus**: Data analysis, statistical computing, ML workflows  
**Tools**: ~50-60 (well under 80 limit)

[📖 Read Guide →](guides/data-scientist-setup.md)

---

## 🔧 MCP Servers Included

| Server | Purpose | Command | When to Use |
|--------|---------|---------|-------------|
| **Filesystem** | Access external directories | `npx` | Reference code/docs outside project |
| **GitHub** | Repository, PR, issue management | `npx` | Code reviews, release notes |
| **PostgreSQL** | Database queries & analysis | `npx` | Data analysis, debugging queries |
| **Redis** | Cache inspection & management | `uvx` | Cache debugging, performance |
| **Supabase** | Backend-as-a-service operations | `npx` | Supabase project management |
| **Playwright** | Cross-browser automation | `npx` | Multi-browser testing |
| **Puppeteer** | Chrome automation | `npx` | Fast Chrome-only testing |
| **Lighthouse** | Performance & accessibility audits | `npx` | Pre-deployment validation |
| **Chrome DevTools** | Network & performance debugging | `npx` | API debugging, performance |
| **Vitest** | JavaScript/TypeScript testing | `npx` | Unit/component test analysis |
| **Sequential Thinking** | Workflow & state modeling | `uvx` | Complex process design |
| **Kroki** | Diagram generation | `npx` | Architecture diagrams |
| **AWS Diagram** | AWS architecture visualization | `uv` | Cloud infrastructure docs |
| **Docker MCP** | Container management | `docker` | Container debugging |
| **DS Toolkit** | Data science operations | `uvx` | Statistical analysis, ML |

**Total**: 16 MCP servers, 150+ tools available

---

## 📁 Project Structure

```
AmzMCPDevTools/
├── README.md                    # Project overview and quick start
├── TECHNICAL_GUIDE.md           # Complete technical reference (1000+ lines)
├── CHANGELOG.md                 # Version history and updates
├── mcp.json                     # Production configuration (all 16 servers)
├── mcp.json.template            # Template with placeholders
├── guides/
│   ├── README.md                # Guides overview
│   ├── frontend-developer-setup.md
│   ├── backend-developer-setup.md
│   ├── qa-testing-setup.md
│   ├── data-scientist-setup.md
│   └── workflow-examples.md     # 8 end-to-end scenarios
└── scripts/
    └── health-check.sh          # Configuration validator
```

---

## 🛠️ Tools & Scripts

### Health Check Script

Validates your MCP configuration:

```bash
./scripts/health-check.sh
```

**Checks**:
- ✅ Configuration file existence and syntax
- ✅ Node.js, Python, Docker installation
- ✅ PostgreSQL, Redis service status
- ✅ Browser binaries (Playwright, Puppeteer)
- ✅ Tool count vs. performance limits
- ⚠️ Configuration warnings and issues

**Output Example**:
```
╔══════════════════════════════════════════════════════╗
║     MCP Configuration Health Check                   ║
╚══════════════════════════════════════════════════════╝

[1/8] Checking MCP Configuration File...
✓ Found Cursor config: /home/user/.cursor/mcp.json

[2/8] Validating JSON Syntax...
✓ JSON syntax is valid

[3/8] Checking Core Dependencies...
✓ Node.js installed: v20.10.0
✓ npx available
✓ Python installed: Python 3.11.5

...

✓ All checks passed!
Your MCP configuration is healthy and ready to use.
```

---

## 🚀 Workflow Examples

[**See guides/workflow-examples.md**](guides/workflow-examples.md) for 8 complete scenarios:

1. **Debug Production Issue** - Trace slow API with DevTools, PostgreSQL, Redis
2. **Pre-Deployment Validation** - Test suite, performance audits, DB checks
3. **API Development** - Design, test, document new endpoints
4. **Data Pipeline Analysis** - Debug data quality issues
5. **Performance Optimization** - Improve page load from 4s to <2s
6. **Security Audit** - Comprehensive security review
7. **A/B Test Analysis** - Statistical analysis and visualization
8. **Incident Response** - Handle production emergencies

---

## 📊 Performance Guidelines

### Tool Limits
- **Cursor**: Best with <80 tools (6-8 servers)
- **VS Code**: Best with <128 tools (10-12 servers)

### All role-specific configurations are optimized to stay under these limits!

### Tips
- ✅ Only enable servers you actively use
- ✅ Use `disabled: true` to temporarily turn off servers
- ✅ Monitor tool count in IDE settings
- ✅ Close unused browser instances
- ✅ Run health check to validate setup

---

## 🤝 Contributing

We welcome contributions! Here's how:

1. **Fork** the repository
2. **Create** a feature branch: `git checkout -b feature/new-guide`
3. **Add** your contribution:
   - New MCP server documentation
   - Role-specific guides
   - Workflow examples
   - Bug fixes or improvements
4. **Test** your changes with the health check script
5. **Commit**: `git commit -m "Add: New DevOps guide"`
6. **Push**: `git push origin feature/new-guide`
7. **Submit** a Pull Request

### Contribution Ideas
- 🎯 New role-specific guides (DevOps, Mobile, etc.)
- 📝 Additional workflow examples
- 🔧 New MCP server configurations
- 🐛 Bug fixes and documentation improvements
- 🌍 Translations

---

## 📚 Resources

### Official Documentation
- [Model Context Protocol](https://modelcontextprotocol.io/)
- [MCP Server Registry](https://github.com/modelcontextprotocol/servers)
- [Cursor Documentation](https://docs.cursor.com/advanced/mcp)
- [VS Code MCP Extension](https://marketplace.visualstudio.com/items?itemName=modelcontextprotocol.mcp)

### Community
- [Awesome MCP Servers](https://github.com/punkpeye/awesome-mcp-servers)
- [MCP Discord Community](https://discord.gg/modelcontextprotocol) (check official site for link)

### Learning
- [Creating MCP Servers](https://modelcontextprotocol.io/docs/creating-servers)
- [MCP Best Practices](https://modelcontextprotocol.io/docs/best-practices)

---

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- Model Context Protocol team for the amazing protocol
- Cursor and VS Code teams for AI integration
- All MCP server maintainers
- Community contributors

---

## 📧 Support

- **Issues**: [GitHub Issues](https://github.com/AmzurATG/AmzMCPDevTools/issues)
- **Discussions**: [GitHub Discussions](https://github.com/AmzurATG/AmzMCPDevTools/discussions)
- **Email**: support@amzuratg.com (if applicable)

---

## 🌟 Star History

If this project helped you, please ⭐️ star it on GitHub!

---

**Last Updated**: December 12, 2025  
**Version**: 2.0.0  
**Maintained by**: [AmzurATG](https://github.com/AmzurATG)

