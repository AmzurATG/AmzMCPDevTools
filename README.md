# AmzMCPDevTools
# MCP Server Configuration Guide

This guide details how to configure Model Context Protocol (MCP) servers for Cursor and VS Code. It covers file locations, configuration steps, and specific setup details for essential MCP tools.

---

## � What is MCP?

**Model Context Protocol (MCP)** is a standardized protocol that enables AI assistants and development tools to interact with external services, tools, and APIs in a consistent manner. Think of it as a bridge that allows AI models to access and utilize various functionalities provided by different tools and services.

### Key Benefits

- **Standardized Interface**: Common protocol for all integrations
- **Seamless Integration**: Easy connection between AI tools and external services
- **Enhanced Capabilities**: Extends AI functionality beyond basic interactions
- **Tool Discovery**: Enables AI to discover and use available tools dynamically

---

## �📂 1. Opening the Configuration File (mcp.json)

### For Cursor Users
Cursor uses a global configuration file usually located in your home directory.

#### Windows:
- **GUI**: Go to **Settings** (Gear Icon) → **Features** → **MCP** → Click "**Open config file**".
- **Manual**: Open `%USERPROFILE%\.cursor\mcp.json` in any editor.

#### macOS / Linux:
- **GUI**: Go to **Cursor Settings** → **General** → **MCP** → Click "**Open config file**".
- **Manual**: Open `~/.cursor/mcp.json` in the terminal or editor.

### For VS Code Users
VS Code typically manages MCP servers via the "VS Code MCP" extension or a workspace-specific file.

#### Global Config (All OS):
1. Press `Cmd+Shift+P` (Mac) or `Ctrl+Shift+P` (Win/Linux).
2. Type "**MCP: Open User Configuration**".

#### Workspace Config:
- Create a file inside your project folder: `.vscode/mcp.json`.

#### Alternative: Direct File Access

If the above methods don't work or you prefer manual configuration, you can directly access the MCP configuration file:

**Windows:**
- Open: `C:\Users\[Your_Username]\AppData\Roaming\Code\User\mcp.json`
- If the file doesn't exist, create a new file named `mcp.json` at: `C:\Users\[Your_Username]\AppData\Roaming\Code\User\`

**macOS:**
- Open: `~/Library/Application Support/Code/User/mcp.json`
- If the file doesn't exist, create a new file named `mcp.json` at: `~/Library/Application Support/Code/User/`

**Linux:**
- Open: `~/.config/Code/User/mcp.json`
- If the file doesn't exist, create a new file named `mcp.json` at: `~/.config/Code/User/`

**💡 Tip for Windows Users:**
- To access the `AppData` folder, press `Win + R`, type `%APPDATA%`, and press Enter. This will open `C:\Users\[Your_Username]\AppData\Roaming\`.
- Navigate to `Code\User\` folder from there.
- If you don't see the `AppData` folder in File Explorer, enable "Show hidden files" in View options.

#### Troubleshooting: Can't Find mcp.json?

**Issue: File doesn't exist**
- **Solution**: MCP configuration is optional and won't exist until you create it. Simply create a new file named `mcp.json` in the appropriate location listed above, then add the basic JSON structure from Section 2.

**Issue: AppData folder is hidden (Windows)**
- **Solution**: 
  1. Open File Explorer
  2. Click **View** → **Show** → Check "**Hidden items**"
  3. Or use the direct path by pressing `Win + R`, typing `%APPDATA%\Code\User`, and pressing Enter

**Issue: Command Palette doesn't show "MCP: Open User Configuration"**
- **Solution**: This means the MCP extension or integration may not be installed/enabled. You have two options:
  1. **Install the MCP extension**: Press `Ctrl+Shift+X`, search for "MCP" or "Model Context Protocol", and install the official extension
  2. **Manual configuration**: Create the `mcp.json` file manually using the direct file access method above

**Issue: VS Code version too old**
- **Solution**: 
  - MCP support requires VS Code version **1.85.0 or higher**
  - Check your version: Help → About
  - Update VS Code: Help → Check for Updates
  - Or download the latest version from [code.visualstudio.com](https://code.visualstudio.com/)

**Issue: Settings not taking effect**
- **Solution**: 
  1. Ensure the JSON syntax is valid (no trailing commas, proper quotes)
  2. Restart VS Code completely after creating or modifying `mcp.json`
  3. Use `Ctrl+Shift+P` → "Reload Window" to reload without closing VS Code
  4. Check the Output panel (`Ctrl+Shift+U`) → Select "MCP" from the dropdown to see error messages

**Issue: Multiple VS Code installations (Stable vs Insiders)**
- **Solution**: Each VS Code version has its own config location:
  - **Stable**: `...\Code\User\mcp.json`
  - **Insiders**: `...\Code - Insiders\User\mcp.json`
  - Make sure you're editing the correct one for your VS Code version

---

## ⚙️ 2. Basic Configuration Structure

Add the following JSON structure to your `mcp.json` file. The `servers` object will contain the definitions for each tool you want to connect.

```json
{
  "servers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/path/to/allowed/folder"],
      "type": "stdio"
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "your_token_here"
      },
      "type": "stdio"
    }
  }
}
```

## ⚠️ Important Notice

**Tool Availability Disclaimer**: The tools listed in this documentation are representative examples based on typical MCP server implementations. Each server may have **more or fewer tools** than documented here, and tool names/functionality may vary depending on the server version.

### How to View Available Tools

After connecting an MCP server, you can view its actual tool list:

**In Cursor:**
1. Click on the **Settings** icon (gear icon) in the bottom left
2. Navigate to **Cursor Settings** → **Tools & MCP** → you'll see all connected servers with no.of available tools.
3. Click on a server name to view its available tools and descriptions

**In VS Code:**
1. **Quick Access (Easiest)**: Click the **Configure Tools icon** (wrench icon) in the GitHub Copilot chat interface where you type prompts
   - This will show all connected MCP servers and their available tools
   - You can enable/disable specific servers and tools from this interface
2. **Command Palette**: Open **Command Palette** (`Ctrl+Shift+P` or `Cmd+Shift+P`)
   - Type and select **"MCP: Show Available Tools"**
   - Select the server to view its tool list
3. **Status Bar**: Check the **MCP Status** in the status bar (bottom right) for connection status

### ⚠️ Performance Warning

**Tool Selection Limits:**
- **Cursor**: Performance may degrade if you enable more than **80 tools** across all servers
- **VS Code**: Performance may degrade if you enable more than **128 tools** across all servers

**Recommendation**: Only enable the MCP servers and tools you actively need for your current workflow. Disable unused servers to maintain optimal performance.

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

#### 1. What is it?
Connects your AI to a PostgreSQL database to query data, inspect schemas, and perform database operations directly from your editor.

#### 2. Why use it?
To analyze database performance, debug queries, inspect table structures, or generate reports without switching to a database client.

**💡 Pro Tip**: You can also use PostgreSQL MCP to connect to **Supabase databases**. Simply use your Supabase database connection string (found in Project Settings → Database → Connection String → URI) instead of a local PostgreSQL URL.

#### 3. Configuration Example
```json
"postgres": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-postgres", "postgresql://username:password@host:5432/database"],
  "type": "stdio"
}
```

Or with separate host configuration:
```json
"postgres-diagnostics": {
  "command": "npx",
  "args": ["-y", "@henkey/postgres-mcp-server"],
  "env": {
    "DATABASE_URL": "postgresql://postgres:password@localhost:5432/amzurbot"
  },
  "type": "stdio"
}
```

#### 4. Credentials & Setup
- **Command**: `npx`
- **Args**: `-y`, `@modelcontextprotocol/server-postgres`, `[connection_string]`
- **Credentials**: PostgreSQL connection string with format:
  - `postgresql://[username]:[password]@[host]:[port]/[database]`
- **Alternative**: Use `DATABASE_URL` environment variable instead of inline connection string.

#### 5. Troubleshooting
**Issue**: "Connection refused" or "ECONNREFUSED".
- **Solution**: Ensure PostgreSQL is running. Check if the host and port are correct (default: `localhost:5432`).

**Issue**: "Authentication failed".
- **Solution**: Verify username and password. Ensure the user has appropriate permissions on the database.

**Issue**: "Database does not exist".
- **Solution**: Create the database first using `createdb [database_name]` or verify the database name in your connection string.

**Issue**: SSL/TLS errors.
- **Solution**: Add `?sslmode=disable` to the connection string for local development: `postgresql://user:pass@localhost:5432/db?sslmode=disable`

#### 6. Use Case Example
> "Show me all tables in my amzurbot database and explain the schema of the 'users' table. Then write a query to find all inactive users."

---

### D. Supabase MCP

#### 1. What is it?
Connects your AI to Supabase projects, enabling database queries, authentication management, and API operations through the Supabase platform.

#### 2. Why use it?
To manage Supabase projects, query your database, inspect auth users, and manage storage buckets without leaving your editor.

#### 3. Configuration Example
```json
"supabase": {
  "command": "npx",
  "args": ["-y", "@supabase/mcp-server-supabase@latest"],
  "env": {
    "SUPABASE_ACCESS_TOKEN": "sbp_your_token_here"
  },
  "type": "stdio"
}
```

#### 4. Credentials & Setup
- **Command**: `npx`
- **Args**: `-y`, `@supabase/mcp-server-supabase@latest`
- **Credentials**: `SUPABASE_ACCESS_TOKEN`
- **How to get it**:
  1. Go to [Supabase Dashboard](https://app.supabase.com)
  2. Click on your profile → **Account Preferences** → **Access Tokens**
  3. Click "**Generate new token**"
  4. Give it a name and copy the token immediately

#### 5. Troubleshooting
**Issue**: "Invalid access token".
- **Solution**: Regenerate the token and ensure it's correctly pasted in the `env` section. Tokens start with `sbp_`.

**Issue**: "Project not found".
- **Solution**: Ensure you're using the correct project reference. The token must have access to the project you're querying.

#### 6. Use Case Example
> "List all tables in my Supabase project and show me the row count for the 'profiles' table."

---

### E. Puppeteer MCP (Web Automation)

#### 1. What is it?
Provides headless browser automation capabilities, allowing the AI to navigate websites, take screenshots, and extract content.

#### 2. Why use it?
To scrape web data, test web applications, capture screenshots for documentation, or automate repetitive browser tasks. **Particularly useful for smoke testing** - quickly verify critical user flows (login, checkout, form submission) are working after deployments.

#### 3. Configuration Example
```json
"puppeteer": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-puppeteer"],
  "type": "stdio"
}
```

#### 4. Credentials & Setup
- **Command**: `npx`
- **Args**: `-y`, `@modelcontextprotocol/server-puppeteer`
- **Credentials**: None required.
- **Dependencies**: Node.js must be installed.

#### 5. Troubleshooting
**Issue**: "Browser download failed".
- **Solution**: Run `npx puppeteer browsers install chrome` manually to download Chromium.

**Issue**: "Page timeout".
- **Solution**: Slow websites may timeout. The AI can adjust timeout settings in the automation script.

#### 6. Use Case Example
> "Navigate to example.com, take a screenshot of the homepage, and extract all the h1 headings."

---

### F. Playwright MCP (Advanced Web Automation)

#### 1. What is it?
Similar to Puppeteer but with multi-browser support (Chromium, Firefox, WebKit) and advanced testing capabilities.

#### 2. Why use it?
For cross-browser testing, more reliable web scraping, or when you need WebKit (Safari) engine support.

#### 3. Configuration Example
```json
"playwright": {
  "command": "npx",
  "args": ["-y", "@playwright/mcp@latest"],
  "type": "stdio"
}
```

#### 4. Credentials & Setup
- **Command**: `npx`
- **Args**: `-y`, `@playwright/mcp@latest`
- **Credentials**: None required.

#### 5. Troubleshooting
**Issue**: "Browsers not installed".
- **Solution**: Run `npx playwright install` to download browser binaries.

**Issue**: "Browser executable not found".
- **Solution**: Ensure sufficient disk space and permissions. Try `npx playwright install --with-deps` on Linux.

#### 6. Use Case Example
> "Test my login form at localhost:3000/login in both Chrome and Firefox, and report any differences."

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

- [Model Context Protocol Documentation](https://modelcontextprotocol.io/)
- [MCP Server Registry](https://github.com/modelcontextprotocol/servers)
- [Cursor MCP Guide](https://docs.cursor.com/advanced/mcp)
- [VS Code MCP Extension](https://marketplace.visualstudio.com/items?itemName=modelcontextprotocol.mcp)

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

**Last Updated**: December 11, 2025  
**Version**: 1.0

