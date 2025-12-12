# MCP Server Configuration - Technical Guide

Complete technical reference for configuring Model Context Protocol (MCP) servers in Cursor and VS Code.

> **💡 New to MCP?** Start with the [main README.md](README.md) for a quick overview and getting started guide.

---

## 🎯 What is MCP?

**Model Context Protocol (MCP)** enables AI assistants to interact with external services, tools, and APIs through a standardized interface. It bridges AI models with databases, browsers, containers, and more.

**Benefits**: Standardized integration • Extended AI capabilities • Dynamic tool discovery

---

## 📂 1. Configuration File Location

### Cursor
- **Windows**: `%USERPROFILE%\.cursor\mcp.json`
- **macOS/Linux**: `~/.cursor/mcp.json`
- **GUI**: Settings → Features → MCP → "Open config file"

### VS Code
- **Windows**: `C:\Users\[Username]\AppData\Roaming\Code\User\mcp.json`
- **macOS**: `~/Library/Application Support/Code/User/mcp.json`
- **Linux**: `~/.config/Code/User/mcp.json`
- **GUI**: `Ctrl+Shift+P` → "MCP: Open User Configuration"
- **Workspace**: `.vscode/mcp.json` (project-specific)

**Troubleshooting**:
- File doesn't exist? Create it manually
- Windows: Press `Win+R` → type `%APPDATA%\Code\User`
- Hidden AppData? Enable "Show hidden files"
- VS Code too old? Requires v1.85.0+
- Not working? Restart IDE completely

---

## ⚙️ 2. Basic Configuration Structure

```json
{
  "servers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/path/to/folder"],
      "type": "stdio"
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": { "GITHUB_PERSONAL_ACCESS_TOKEN": "your_token" },
      "type": "stdio"
    }
  }
}
```

**View Connected Tools**: 
- **Cursor**: Settings → Tools & MCP
- **VS Code**: Configure Tools icon (wrench) in Copilot chat, or `Ctrl+Shift+P` → "MCP: Show Available Tools"

**⚠️ Performance**: Cursor optimal <80 tools • VS Code optimal <128 tools • Only enable servers you need

---

## 🛠️ 3. Essential MCP Server Details

### A. Filesystem MCP

#### 1. What is it?
Allows the AI to read, write, and list files and directories on your local computer that are outside of the currently open project window.

#### 2. Why use it?
Standard AI editors can only see the current project. Use this if you need the AI to reference docs, logs, or code from another project folder without opening it.

#### 3. Configuration Example
```json
"filesystem": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-filesystem", "D:\\Itrackermcptest\\PM-Tool"],
  "type": "stdio"
}
```

#### 4. Credentials & Setup
- **Command**: `npx`
- **Args**: `-y`, `@modelcontextprotocol/server-filesystem`, `[path1]`, `[path2]`
- **Credentials**: None required.
- **Note**: You must explicitly list every folder path you want the AI to access in the args list.

#### 5. Troubleshooting
**Issue**: "Access Denied" or AI says it cannot see the file.
- **Solution**: Ensure the absolute path is correctly added to the `args` array in `mcp.json`. Restart the IDE after changing paths.

**Issue**: Windows Path errors.
- **Solution**: Use double backslashes `\\` or forward slashes `/` in JSON (e.g., `"C:/Users/Name/Projects"` or `"C:\\Users\\Name\\Projects"`).

#### 6. Use Case Example
> "Check the logs.txt file in my D:/server-logs folder and tell me if there are any error timestamps matching the bug in my current project."

---

### B. GitHub MCP

#### 1. What is it?
Connects your AI directly to GitHub API to search repositories, read issues, inspect pull requests, and view file history remotely.

#### 2. Why use it?
To perform code reviews, generate release notes from PRs, or check an issue status without leaving your editor.

#### 3. Configuration Example
```json
"github": {
  "disabled": false,
  "timeout": 60,
  "type": "stdio",
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-github"],
  "env": {
    "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_YOUR_TOKEN_HERE"
  }
}
```

#### 4. Credentials & Setup
- **Command**: `npx`
- **Args**: `-y`, `@modelcontextprotocol/server-github`
- **Credentials**: `GITHUB_PERSONAL_ACCESS_TOKEN`
- **How to get it**: 
  1. Go to GitHub → **Settings** → **Developer Settings** → **Personal Access Tokens (Classic)**.
  2. Click "**Generate new token (classic)**".
  3. **Scopes needed**: `repo`, `user`, `read:org`.
  4. Copy the token immediately (it won't be shown again).

#### 5. Troubleshooting
**Issue**: "Bad Credentials" or 401 Unauthorized.
- **Solution**: The token may have expired or permissions are too strict. Regenerate the token and ensure `repo` scope is checked.

**Issue**: Rate Limiting.
- **Solution**: The GitHub API has limits. If you make too many requests rapidly, wait an hour or use a token with higher limits.

**Issue**: Token not recognized.
- **Solution**: Ensure there are no extra spaces before/after the token in the JSON. Restart your IDE after adding the token.

#### 6. Use Case Example
> "Find the last 3 Pull Requests merged into the AmzurATG/PM-Tool repo and generate a summary of changes for the release notes."

---

### C. PostgreSQL MCP

**Purpose**: Query data, inspect schemas, perform DB operations  
**Use When**: Analyze performance, debug queries, generate reports without DB client  
**💡 Tip**: Also works with Supabase databases (use Supabase connection string)

**Configuration**:
```json
"postgres": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-postgres", "postgresql://user:pass@host:5432/db"],
  "type": "stdio"
}
```

**Setup**: Connection string format: `postgresql://[user]:[pass]@[host]:[port]/[db]` • Or use `DATABASE_URL` env var

**Troubleshooting**: 
- Connection refused? Check PostgreSQL is running, verify host/port (default: localhost:5432)
- Auth failed? Verify credentials and permissions
- DB not exist? Run `createdb [name]`
- SSL errors? Add `?sslmode=disable` for local dev

**Example**: _"Show all tables in amzurbot DB, explain 'users' schema, find all inactive users"_

---

### D. Supabase MCP

**Purpose**: Manage Supabase projects, query DB, inspect auth, manage storage  
**Use When**: Supabase project management without leaving IDE

**Configuration**:
```json
"supabase": {
  "command": "npx",
  "args": ["-y", "@supabase/mcp-server-supabase@latest"],
  "env": { "SUPABASE_ACCESS_TOKEN": "sbp_your_token" },
  "type": "stdio"
}
```

**Setup**: Supabase Dashboard → Profile → Account Preferences → Access Tokens → Generate (starts with `sbp_`)

**Troubleshooting**: 
- Invalid token? Regenerate, check `sbp_` prefix
- Project not found? Verify token has project access

**Example**: _"List all tables in Supabase project, show row count for 'profiles' table"_

---

### E. Puppeteer MCP (Chrome Automation)

**Purpose**: Headless Chrome automation—navigate, screenshot, scrape  
**Use When**: Smoke testing (verify login/checkout/forms), web scraping, quick browser tasks

**Configuration**:
```json
"puppeteer": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-puppeteer"],
  "type": "stdio"
}
```

**Setup**: No credentials • Requires Node.js

**Troubleshooting**: Browser download failed? Run `npx puppeteer browsers install chrome` • Timeout? Adjust script timeout

**Example**: _"Navigate to example.com, screenshot homepage, extract all h1 headings"_

---

### F. Playwright MCP (Multi-Browser Automation)

**Purpose**: Cross-browser automation (Chromium, Firefox, WebKit)  
**Use When**: Cross-browser testing, need Safari/WebKit support, advanced testing

**Configuration**:
```json
"playwright": {
  "command": "npx",
  "args": ["-y", "@playwright/mcp@latest"],
  "type": "stdio"
}
```

**Setup**: No credentials • Run `npx playwright install` to download browsers

**Troubleshooting**: Browsers not installed? Run `npx playwright install` • Linux? Try `npx playwright install --with-deps`

**Example**: _"Test login form at localhost:3000/login in Chrome and Firefox, report differences"_

---



### H. Redis Cache MCP

#### 1. What is it?
Connects your AI to a Redis instance for cache inspection, key management, and performance monitoring.

#### 2. Why use it?
To debug caching issues, inspect cached data, monitor Redis memory usage, or manage cache invalidation.

#### 3. Configuration Example
```json
"redis-cache": {
  "command": "uvx",
  "args": ["redis-mcp-server", "--url", "redis://localhost:6379"],
  "env": {
    "REDIS_HOST": "localhost",
    "REDIS_PORT": "6379"
  },
  "type": "stdio"
}
```

#### 4. Credentials & Setup
- **Command**: `uvx`
- **Args**: `redis-mcp-server`, `--url`, `redis://[host]:[port]`
- **Credentials**: If Redis requires authentication, use format: `redis://:password@host:port`
- **Environment Variables**:
  - `REDIS_HOST`: Redis server hostname
  - `REDIS_PORT`: Redis server port (default: 6379)

#### 5. Troubleshooting
**Issue**: "Connection refused".
- **Solution**: Ensure Redis is running. Start it with `redis-server` on Linux/Mac or via Windows service.

**Issue**: "Authentication required".
- **Solution**: Include password in URL: `redis://:your_password@localhost:6379`

**Issue**: "uvx not found".
- **Solution**: Install `uv` package manager: `pip install uv`

#### 6. Use Case Example
> "Show me all keys in my Redis cache that start with 'user_session' and check the TTL for each one."

---



### J. Lighthouse MCP (Web Performance)

#### 1. What is it?
Runs Google Lighthouse audits to analyze web performance, accessibility, SEO, and best practices.

#### 2. Why use it?
To get automated performance reports, identify optimization opportunities, or validate web standards compliance.

#### 3. Configuration Example
```json
"lighthouse": {
  "command": "npx",
  "args": ["-y", "@danielsogl/lighthouse-mcp"],
  "type": "stdio"
}
```

#### 4. Credentials & Setup
- **Command**: `npx`
- **Args**: `-y`, `@danielsogl/lighthouse-mcp`
- **Credentials**: None required.

#### 5. Troubleshooting
**Issue**: "Chrome not found".
- **Solution**: Lighthouse requires Chrome/Chromium. Install Google Chrome or set `CHROME_PATH` environment variable.

**Issue**: "Audit timeout".
- **Solution**: Ensure the target URL is accessible and responsive. Local development servers must be running.

#### 6. Use Case Example
> "Run a Lighthouse audit on http://localhost:3000 and give me the top 3 performance improvements I should make."

---

### K. Kroki MCP (Diagram Generation)

#### 1. What is it?
Generates diagrams from text descriptions using various formats (PlantUML, Mermaid, GraphViz, etc.) via the Kroki API.

#### 2. Why use it?
To create architecture diagrams, flowcharts, sequence diagrams, or ERD diagrams without leaving your editor.

#### 3. Configuration Example
```json
"kroki": {
  "command": "npx",
  "args": ["-y", "@tkoba1974/mcp-kroki"],
  "env": {},
  "type": "stdio"
}
```

#### 4. Credentials & Setup
- **Command**: `npx`
- **Args**: `-y`, `@tkoba1974/mcp-kroki`
- **Credentials**: None required (uses public Kroki service).
- **Optional**: Set `KROKI_URL` environment variable to use a self-hosted Kroki instance.

#### 5. Troubleshooting
**Issue**: "Service unavailable".
- **Solution**: The public Kroki service may be temporarily down. Try again later or set up a local Kroki instance.

**Issue**: "Invalid diagram syntax".
- **Solution**: The AI will help fix syntax errors. Ensure you're using the correct diagram format (e.g., PlantUML, Mermaid).

#### 6. Use Case Example
> "Create a sequence diagram showing the authentication flow in my application: User → Frontend → API → Database. Use download_diagram tool."

---

### L. Sequential Thinking MCP

#### 1. What is it?
Provides structured process flow and sequence modeling for complex state management and event tracing.

#### 2. Why use it?
To model complex workflows, trace event sequences, or debug state management issues in your application.

#### 3. Configuration Example
```json
"sequentialThinking": {
  "command": "uvx",
  "args": ["sequential-thinking-mcp"],
  "description": "Process flow and sequence modeling server for state management and event tracing.",
  "env": {},
  "type": "stdio"
}
```

#### 4. Credentials & Setup
- **Command**: `uvx`
- **Args**: `sequential-thinking-mcp`
- **Credentials**: None required.
- **Prerequisites**: Install `uv` package manager.

#### 5. Troubleshooting
**Issue**: "uvx not found".
- **Solution**: Install `uv`: `pip install uv` or download from [astral.sh](https://astral.sh).

#### 6. Use Case Example
> "Model the state transitions in my shopping cart feature from 'empty' to 'checked out' and identify potential edge cases."

---

### M. Vitest MCP (JavaScript Testing)

#### 1. What is it?
Integrates Vitest testing framework with your AI for running tests, analyzing coverage, and debugging test failures.

#### 2. Why use it?
To run specific tests, analyze test failures, generate new test cases, or improve test coverage.

#### 3. Configuration Example
```json
"vitest": {
  "command": "npx",
  "args": ["-y", "@djankies/vitest-mcp"],
  "disabled": false,
  "autoApprove": [],
  "type": "stdio"
}
```

#### 4. Credentials & Setup
- **Command**: `npx`
- **Args**: `-y`, `@djankies/vitest-mcp`
- **Credentials**: None required.
- **Prerequisites**: Project must have Vitest installed and configured.

#### 5. Troubleshooting
**Issue**: "Vitest not found in project".
- **Solution**: Install Vitest: `npm install -D vitest` or ensure it's in your package.json.

**Issue**: "No tests found".
- **Solution**: Ensure test files follow Vitest naming conventions (*.test.js, *.spec.js) and are in the correct directory.

#### 6. Use Case Example
> "Run all tests in my src/components/ folder and explain why the Button.test.tsx is failing."

---

### N. AWS Diagram MCP

#### 1. What is it?
Generates AWS architecture diagrams from text descriptions or existing infrastructure code.

#### 2. Why use it?
To visualize AWS infrastructure, document cloud architecture, or plan new deployments.

#### 3. Configuration Example
```json
"awslabs.aws-diagram-mcp-server": {
  "disabled": false,
  "timeout": 60,
  "type": "stdio",
  "command": "uv",
  "args": [
    "tool",
    "run",
    "--from",
    "awslabs.aws-diagram-mcp-server",
    "awslabs-aws-diagram-mcp-server"
  ],
  "env": {
    "FASTMCP_LOG_LEVEL": "ERROR"
  }
}
```

#### 4. Credentials & Setup
- **Command**: `uv`
- **Args**: `tool`, `run`, `--from`, `awslabs.aws-diagram-mcp-server`, `awslabs-aws-diagram-mcp-server`
- **Credentials**: None required for diagram generation.
- **Prerequisites**: Install `uv` package manager.

#### 5. Troubleshooting
**Issue**: "Command not found".
- **Solution**: Install `uv` package manager: `pip install uv` or from [astral.sh](https://astral.sh).

**Issue**: "Timeout errors".
- **Solution**: Increase the `timeout` value in the config (default shown is 60 seconds).

#### 6. Use Case Example
> "Create an AWS architecture diagram for a three-tier web application with EC2, RDS, and S3."

---

### O. Chrome DevTools MCP

#### 1. What is it?
Provides Chrome DevTools integration for debugging, profiling, and inspecting web applications.

#### 2. Why use it?
To capture network requests, analyze performance metrics, debug JavaScript, or inspect DOM elements programmatically.

#### 3. Configuration Example
```json
"chrome-devtools": {
  "command": "npx",
  "args": ["chrome-devtools-mcp@latest"],
  "type": "stdio"
}
```

**Note**: This server doesn't use the `-y` flag as it's designed to prompt for updates when needed.

#### 4. Credentials & Setup
- **Command**: `npx`
- **Args**: `chrome-devtools-mcp@latest`
- **Credentials**: None required.

#### 5. Troubleshooting
**Issue**: "Chrome not found".
- **Solution**: Install Google Chrome and ensure it's in your system PATH.

**Issue**: "Cannot connect to browser".
- **Solution**: Ensure no other processes are using Chrome's debugging port (default: 9222).

#### 6. Use Case Example
> "Analyze the network requests when I load localhost:3000 and identify which API calls are slowest."

---

### P. Docker MCP (Container Management)

#### 1. What is it?
Provides Docker container management capabilities through MCP Gateway, allowing the AI to interact with Docker containers, images, and volumes.

#### 2. Why use it?
To manage Docker containers, inspect running services, view logs, analyze container resource usage, or automate Docker operations without leaving your editor.

#### 3. Configuration Example
```json
"MCP_DOCKER": {
  "disabled": false,
  "timeout": 60,
  "type": "stdio",
  "command": "docker",
  "args": [
    "mcp",
    "gateway",
    "run"
  ],
  "env": {
    "LOCALAPPDATA": "C:\\Users\\your username\\AppData\\Local",
    "ProgramData": "C:\\ProgramData",
    "ProgramFiles": "C:\\Program Files"
  }
}
```

#### 4. Credentials & Setup
- **Command**: `docker`
- **Args**: `mcp`, `gateway`, `run`
- **Credentials**: None required, but Docker must be installed and running.
- **Prerequisites**: 
  - Docker Desktop or Docker Engine installed
  - Docker daemon running
  - Docker MCP Gateway plugin installed: `docker plugin install mcp-gateway`
- **Note**: The environment variables shown are Windows-specific. For Linux/Mac, these are not typically needed.

#### 5. Troubleshooting
**Issue**: "docker: 'mcp' is not a docker command".
- **Solution**: Install Docker MCP Gateway plugin: `docker plugin install mcp-gateway` or check Docker documentation for the latest installation method.

**Issue**: "Cannot connect to Docker daemon".
- **Solution**: Ensure Docker Desktop is running (Windows/Mac) or Docker daemon is active (Linux): `sudo systemctl start docker`.

**Issue**: "Permission denied" (Linux).
- **Solution**: Add your user to the docker group: `sudo usermod -aG docker $USER`, then log out and back in.

**Issue**: Windows path errors.
- **Solution**: Update the environment variables to match your actual Windows username and paths. Use double backslashes in JSON.

#### 6. Use Case Example
> "Show me all running Docker containers and their resource usage. Then inspect the logs of the web-app container for any errors in the last hour."

---

### Q. DS Toolkit (Data Science Tools)

#### 1. What is it?
A comprehensive data science toolkit that provides AI-assisted data analysis, statistical operations, and integration with popular data science libraries.

#### 2. Why use it?
To perform data analysis, statistical computations, data visualization generation, pandas/numpy operations, or exploratory data analysis without switching contexts.

#### 3. Configuration Example
```json
"ds-toolkit": {
  "disabled": false,
  "timeout": 60,
  "type": "stdio",
  "command": "uvx",
  "args": [
    "mcp-ds-toolkit-server"
  ],
  "env": {}
}
```

#### 4. Credentials & Setup
- **Command**: `uvx`
- **Args**: `mcp-ds-toolkit-server`
- **Credentials**: None required.
- **Prerequisites**: 
  - Python 3.8 or higher
  - `uv` package manager installed: `pip install uv`
  - Common data science libraries (pandas, numpy, matplotlib) will be installed automatically

#### 5. Troubleshooting
**Issue**: "uvx not found".
- **Solution**: Install `uv` package manager: `pip install uv` or `curl -LsSf https://astral.sh/uv/install.sh | sh`.

**Issue**: "Module not found" errors for data science libraries.
- **Solution**: The server should auto-install dependencies, but you can manually install: `pip install pandas numpy matplotlib seaborn scipy`.

**Issue**: "Timeout during analysis".
- **Solution**: Increase the `timeout` value for large dataset operations (e.g., `"timeout": 120` for 2 minutes).

**Issue**: Memory errors with large datasets.
- **Solution**: Pre-process data to reduce size, use data sampling, or increase available system memory.

#### 6. Use Case Example
> "Analyze this CSV file and provide summary statistics for all numeric columns. Then create a correlation matrix and suggest which features are most related to the target variable."

---

## 🔧 4. General Troubleshooting Guide

### Common Issues Across All MCP Servers

#### Issue: "Server failed to start" or "Process exited with code 1"
**Solutions**:
1. Verify the command (`npx`, `uvx`, etc.) is installed and in your system PATH
2. Check that Node.js is installed (for `npx` commands): `node --version`
3. For `uvx` commands, install `uv`: `pip install uv`
4. Restart your IDE after installing dependencies
5. Check the IDE's output panel for detailed error messages

#### Issue: "PATH not found" (Windows)
**Solutions**:
1. Add Node.js to system PATH:
   - Right-click **This PC** → **Properties** → **Advanced system settings**
   - Click **Environment Variables**
   - Under **System variables**, select **Path** → **Edit**
   - Add: `C:\Program Files\nodejs\`
2. Restart your computer after modifying PATH
3. Verify in Command Prompt: `node --version` and `npx --version`

#### Issue: Port Conflicts
**Solutions**:
1. Check if the port is already in use:
   - Windows: `netstat -ano | findstr :[PORT]`
   - Linux/Mac: `lsof -i :[PORT]`
2. Kill the process or change the port in your MCP config
3. Common ports: Redis (6379), PostgreSQL (5432), Prometheus (9090)

#### Issue: Permission Denied (Linux/Mac)
**Solutions**:
1. Avoid using `sudo` with MCP servers
2. Install Node.js using a version manager like `nvm` (gives user-level permissions)
3. Fix npm permissions: `npm config set prefix ~/.npm-global`
4. Add to PATH: `export PATH=~/.npm-global/bin:$PATH`

---

## ⚙️ 4.1. Enabling/Disabling MCP Servers

Manage which MCP servers are active to optimize performance and reduce resource usage.

### Understanding the `disabled` Flag

Each server in your `mcp.json` can have a `disabled` property:

```json
"github": {
  "disabled": false,  // Server is ACTIVE
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-github"],
  "env": {
    "GITHUB_PERSONAL_ACCESS_TOKEN": "your_token"
  }
}
```

- **`"disabled": false`** or **omitted**: Server is **enabled** and will start with your IDE
- **`"disabled": true`**: Server is **disabled** and will not start

### When to Disable Servers

**Performance Optimization**:
- **Cursor**: Keep total tools under 80 for optimal performance
- **VS Code**: Keep total tools under 128 for optimal performance
- Disable servers you don't use for your current project

**Resource Management**:
- Servers requiring external services (Redis, PostgreSQL) consume memory even when idle
- Browser automation tools (Playwright, Puppeteer) use significant memory (~200MB+ per browser)
- Disable resource-intensive servers when working on simple tasks

**Project-Specific Configurations**:
- Frontend projects: Enable Playwright, Lighthouse, Chrome DevTools; Disable PostgreSQL, Redis
- Backend projects: Enable PostgreSQL, Redis, Supabase; Disable browser automation tools
- Documentation work: Enable Kroki, GitHub, Filesystem; Disable testing and database tools

### How to Enable/Disable Servers

#### Method 1: Edit mcp.json Directly

1. Open your `mcp.json` file
2. Add or change the `disabled` property:
   ```json
   "puppeteer": {
     "disabled": true,  // Add this line to disable
     "command": "npx",
     "args": ["-y", "@modelcontextprotocol/server-puppeteer"],
     "type": "stdio"
   }
   ```
3. Save the file
4. Restart your IDE or reload window: `Ctrl+Shift+P` → "Reload Window"

#### Method 2: Using IDE Interface (VS Code)

1. Click the **Configure Tools** icon (wrench) in Copilot chat interface
2. Toggle servers on/off from the list
3. Changes apply automatically

#### Method 3: Using IDE Interface (Cursor)

1. Go to **Settings** → **Features** → **MCP**
2. View connected servers
3. Toggle individual servers on/off

### Configuration Management Strategies

#### Strategy 1: Role-Based Configuration

Create different configurations for different roles:

**Frontend Developer** (`mcp.frontend.json`):
```json
{
  "servers": {
    "playwright": { "disabled": false },
    "lighthouse": { "disabled": false },
    "chrome-devtools": { "disabled": false },
    "vitest": { "disabled": false },
    "postgres": { "disabled": true },
    "redis-cache": { "disabled": true }
  }
}
```

**Backend Developer** (`mcp.backend.json`):
```json
{
  "servers": {
    "postgres": { "disabled": false },
    "redis-cache": { "disabled": false },
    "supabase": { "disabled": false },
    "github": { "disabled": false },
    "playwright": { "disabled": true },
    "lighthouse": { "disabled": true }
  }
}
```

#### Strategy 2: Environment-Based Configuration

Switch configurations based on the project:

- **Development**: All relevant tools enabled for active work
- **Code Review**: Only GitHub, Filesystem enabled
- **Performance Testing**: Only Lighthouse, Chrome DevTools, Playwright enabled

#### Strategy 3: Minimal Configuration

Start with minimal servers enabled, add more as needed:

```json
{
  "servers": {
    "filesystem": { "disabled": false },
    "github": { "disabled": false }
    // Add more servers only when you need them
  }
}
```

### Timeout Configuration

Some operations need more time to complete. Adjust timeout values for resource-intensive operations:

```json
"lighthouse": {
  "timeout": 120,  // 2 minutes for performance audits
  "command": "npx",
  "args": ["-y", "@danielsogl/lighthouse-mcp"]
}
```

**Default timeout**: 60 seconds
**When to increase**:
- Lighthouse audits on slow sites: 120-180 seconds
- Large database queries (PostgreSQL): 90-120 seconds
- AWS diagram generation: 90-120 seconds
- Complex data science operations (DS Toolkit): 120-300 seconds

### Auto-Approve Configuration

Some servers support auto-approving certain operations:

```json
"vitest": {
  "autoApprove": [],  // Empty = prompt for all actions
  "command": "npx",
  "args": ["-y", "@djankies/vitest-mcp"]
}
```

**⚠️ Security Warning**: Only use auto-approve for read-only operations or in trusted environments.

**Examples**:
```json
"autoApprove": ["run_tests"]  // Auto-approve test execution
"autoApprove": ["*"]  // Auto-approve ALL operations (risky!)
```

### Monitoring Tool Count

To check how many tools you have enabled:

1. **Cursor**: Settings → Tools & MCP → View tool count per server
2. **VS Code**: Click Configure Tools icon → See tool count
3. **Manual**: Each server typically provides 5-15 tools

**Quick Calculation**:
- 16 servers × ~10 tools average = ~160 tools (exceeds recommended limits)
- Recommended: Enable 6-8 servers for Cursor, 10-12 for VS Code

---

## 📝 5. Complete Configuration Example

Here's a full example combining multiple MCP servers:

```json
{
  "servers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "D:/Projects"],
      "type": "stdio"
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_your_token_here"
      },
      "type": "stdio"
    },
    "postgres": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres", "postgresql://user:pass@localhost:5432/mydb"],
      "type": "stdio"
    },
    "puppeteer": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-puppeteer"],
      "type": "stdio"
    },
    "redis-cache": {
      "command": "uvx",
      "args": ["redis-mcp-server", "--url", "redis://localhost:6379"],
      "type": "stdio"
    }
  }
}
```

**💡 Pro Tip**: Check `mcp.json.template` in this repository for a complete template with all servers and helpful comments.

---

## ❓ 5.1. Frequently Asked Questions (FAQ)

### General Questions

**Q: How many MCP servers should I enable?**  
A: Depends on your IDE:
- **Cursor**: Keep total tools under 80 (typically 6-8 servers)
- **VS Code**: Keep total tools under 128 (typically 10-12 servers)
- Only enable servers you actively use for your current work

**Q: Can I use different configurations for different projects?**  
A: Yes! You can:
1. Use workspace-specific config: `.vscode/mcp.json` in your project
2. Maintain multiple config files (e.g., `mcp.frontend.json`, `mcp.backend.json`) and swap them
3. Use the `disabled` flag to toggle servers on/off per project

**Q: Do I need to restart my IDE after changing mcp.json?**  
A: Yes, either:
- Full restart: Close and reopen your IDE
- Quick reload: `Ctrl+Shift+P` → "Reload Window" (faster)

**Q: Where can I find more MCP servers?**  
A: Check these resources:
- [Official MCP Server Registry](https://github.com/modelcontextprotocol/servers)
- [Awesome MCP Servers](https://github.com/punkpeye/awesome-mcp-servers)
- Community Discord and forums

**Q: Can I create my own MCP server?**  
A: Yes! Follow the [MCP Server Development Guide](https://modelcontextprotocol.io/docs/creating-servers)

### Configuration Questions

**Q: What's the difference between `disabled: false` and omitting it?**  
A: They're the same. If `disabled` is omitted, the server is enabled by default.

**Q: When should I increase the timeout value?**  
A:
- Lighthouse audits on slow sites: 120-180s
- Large database queries: 90-120s
- Data science operations on big datasets: 180-300s
- Default (60s) is fine for most operations

**Q: What's the `autoApprove` field for?**  
A: It automatically approves certain operations without prompting. Use cautiously:
```json
"vitest": {
  "autoApprove": ["run_tests"]  // Auto-approve test runs
}
```
⚠️ **Security**: Only auto-approve read-only or safe operations.

**Q: How do I know which command to use: npx, uvx, or docker?**  
A:
- **npx**: For Node.js-based servers (most common)
- **uvx/uv**: For Python-based servers (DS Toolkit, Redis, Sequential Thinking)
- **docker**: For Docker MCP Gateway

### Troubleshooting Questions

**Q: Why isn't my MCP server starting?**  
A: Run the health check script:
```bash
./scripts/health-check.sh
```
It will identify missing dependencies and configuration issues.

**Q: How do I know if my MCP servers are working?**  
A:
1. Check IDE status bar for MCP indicator
2. Look for server count in MCP settings/tools interface
3. Try a simple prompt: "List all connected MCP servers"
4. Check IDE output panel for error messages

**Q: My IDE is slow after enabling MCP servers. What should I do?**  
A:
1. Check tool count (Cursor: <80, VS Code: <128)
2. Disable unused servers
3. Close browser instances from testing tools
4. Check system resources (RAM, CPU)
5. Consider role-specific configuration (see guides/)

**Q: Can I use environment variables instead of hardcoding credentials?**  
A: Not directly in `mcp.json`, but you can:
1. Use a separate `.env` file (keep out of version control)
2. Replace values manually before committing
3. Use `mcp.json.template` with placeholders for team sharing

**Q: Error: "command not found: npx"**  
A: Install Node.js:
- **Ubuntu/Debian**: `sudo apt install nodejs npm`
- **macOS**: `brew install node`
- **Windows**: Download from [nodejs.org](https://nodejs.org)

**Q: Error: "uvx not found"**  
A: Install UV package manager:
```bash
pip install uv
# or
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### Security Questions

**Q: Is it safe to commit mcp.json to Git?**  
A: **NO** if it contains:
- API tokens (GitHub, Supabase)
- Database passwords
- Any sensitive credentials

Use `mcp.json.template` with placeholders instead.

**Q: How should I manage tokens across a team?**  
A:
1. Use `mcp.json.template` with placeholders
2. Add `mcp.json` to `.gitignore`
3. Document where to get each token (README)
4. Consider team secret manager (1Password, AWS Secrets)
5. Each developer uses their own personal tokens

**Q: What permissions should I grant to GitHub tokens?**  
A: Minimal necessary scopes:
- **repo**: For private repository access
- **user**: For user information
- **read:org**: For organization repository access (if needed)

Avoid granting write permissions unless absolutely necessary.

### Performance Questions

**Q: How much memory do MCP servers use?**  
A: Approximate memory per server:
- Playwright: ~300MB (3 browser binaries)
- Puppeteer: ~200MB (1 browser binary)
- PostgreSQL: ~50MB
- Redis: ~30MB
- GitHub: ~20MB
- Most others: ~20-40MB each

**Q: Can I run MCP servers in parallel?**  
A: Yes, multiple servers run simultaneously. However:
- Don't run Playwright AND Puppeteer tests at the same time
- Limit concurrent database connections
- Monitor system resources

**Q: Do MCP servers consume resources when idle?**  
A: Minimal resources when idle, but:
- Database connections remain open
- Browser processes may stay in memory
- Disable servers you're not actively using

### Tool-Specific Questions

**Q: Playwright vs Puppeteer - which should I use?**  
A:
- **Playwright**: Cross-browser (Chrome, Firefox, Safari), more features, better for comprehensive testing
- **Puppeteer**: Chrome-only, faster, lighter, better for simple automation
- Most users should start with Playwright

**Q: Can I use PostgreSQL MCP with Supabase?**  
A: Yes! Use your Supabase connection string:
```json
"postgres": {
  "args": ["-y", "@modelcontextprotocol/server-postgres", 
           "postgresql://postgres:[password]@[project-ref].supabase.co:5432/postgres"]
}
```

**Q: Do I need both postgres and postgres-diagnostics servers?**  
A: No, choose one:
- **postgres**: General-purpose database operations
- **postgres-diagnostics**: Focused on performance analysis and diagnostics

**Q: Why are there two GitHub configurations in the template?**  
A: The repository's `mcp.json` shows different configuration styles. You only need one GitHub server. The template shows the recommended format with `disabled` and `timeout` fields.

---

## 🚀 6. Testing Your Configuration

After setting up your MCP servers:

1. **Restart your IDE** (Cursor or VS Code): ctrl+shift+P → Reload Window
2. **Check the status**: Look for MCP indicators in the status bar
3. **Test with a simple prompt**:
   - For Filesystem: "List all files in [your configured path]"
   - For GitHub: "What's the latest issue in [your repo]?"
   - For PostgreSQL: "Show me all tables in my database"

4. **View logs**: If something fails, check:
   - **Cursor**: Settings → Features → MCP → View logs
   - **VS Code**: Output panel → Select "MCP" from dropdown

---

## 📚 7. Additional Resources

### Official Documentation
- [Model Context Protocol Documentation](https://modelcontextprotocol.io/)
- [MCP Server Registry](https://github.com/modelcontextprotocol/servers)
- [Cursor MCP Guide](https://docs.cursor.com/advanced/mcp)
- [VS Code MCP Extension](https://marketplace.visualstudio.com/items?itemName=modelcontextprotocol.mcp)

### AmzMCPDevTools Guides

**Role-Specific Quick Start Guides:**
- [Frontend Developer Setup](guides/frontend-developer-setup.md) - Playwright, Lighthouse, Chrome DevTools, Vitest
- [Backend Developer Setup](guides/backend-developer-setup.md) - PostgreSQL, Redis, Supabase, Docker
- [QA/Testing Engineer Setup](guides/qa-testing-setup.md) - Comprehensive testing toolkit
- [Data Scientist Setup](guides/data-scientist-setup.md) - DS Toolkit, PostgreSQL, data analysis

**Workflow Documentation:**
- [Real-World Workflow Examples](guides/workflow-examples.md) - 8 end-to-end workflow scenarios

**Configuration Files:**
- `mcp.json` - Complete working configuration with all 16 servers
- `mcp.json.template` - Template with placeholders and comments for team use

**Tools:**
- `scripts/health-check.sh` - Validate your MCP configuration and dependencies
  ```bash
  ./scripts/health-check.sh
  ```

---

## 🤝 8. Contributing

If you find issues with this guide or want to add more MCP servers, please contribute to the documentation!

---

## ⚠️ 9. Security Best Practices

1. **Never commit tokens**: Add `mcp.json` to `.gitignore` if it contains credentials
2. **Use environment variables**: Store sensitive data outside of config files
3. **Rotate tokens regularly**: Especially for GitHub and database credentials
4. **Limit scope**: Only grant minimal required permissions to API tokens
5. **Use readonly paths**: For filesystem MCP, only expose necessary directories

---

**Last Updated**: December 12, 2025  
**Version**: 2.0

**Repository**: [AmzurATG/AmzMCPDevTools](https://github.com/AmzurATG/AmzMCPDevTools)
