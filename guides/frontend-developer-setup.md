# Frontend Developer MCP Quick Start Guide

## 🎯 Overview

This guide helps frontend developers set up MCP servers optimized for frontend development workflows including UI testing, performance audits, and browser automation.

---

## ⚡ Quick Setup (5 minutes)

### Recommended Servers for Frontend Development

Enable only these servers for optimal performance:

```json
{
  "servers": {
    "playwright": {
      "command": "npx",
      "args": ["-y", "@playwright/mcp@latest"],
      "type": "stdio"
    },
    "lighthouse": {
      "command": "npx",
      "args": ["-y", "@danielsogl/lighthouse-mcp"],
      "type": "stdio",
      "timeout": 120
    },
    "chrome-devtools": {
      "command": "npx",
      "args": ["chrome-devtools-mcp@latest"],
      "type": "stdio"
    },
    "vitest": {
      "command": "npx",
      "args": ["-y", "@djankies/vitest-mcp"],
      "type": "stdio"
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "your_github_token"
      },
      "type": "stdio"
    },
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/path/to/your/frontend/project"],
      "type": "stdio"
    }
  }
}
```

**Total Tools**: ~50-60 (well under the 80 tool limit for Cursor)

---

## 🛠️ Essential Tools & Use Cases

### 1. Playwright - Cross-Browser Testing
**What it does**: Automated browser testing across Chrome, Firefox, and Safari

**Common Tasks**:
- "Test my login form at localhost:3000 in all three browsers"
- "Take screenshots of the homepage in mobile and desktop viewports"
- "Check if the navigation menu works correctly on Safari"
- "Fill out the contact form and verify the success message appears"

**Why you need it**: Ensures UI works across all browsers before deployment.

---

### 2. Lighthouse - Performance Audits
**What it does**: Google's automated performance, accessibility, and SEO auditing tool

**Common Tasks**:
- "Run a Lighthouse audit on localhost:3000 and show performance score"
- "What are the top 3 performance improvements I should make?"
- "Check the accessibility score and list violations"
- "Analyze the SEO score and suggest improvements"

**Why you need it**: Catch performance issues before they reach production.

---

### 3. Chrome DevTools - Network & Performance
**What it does**: Programmatic access to Chrome DevTools for debugging

**Common Tasks**:
- "Show all network requests when loading the dashboard page"
- "Which API calls are taking the longest?"
- "Capture a performance profile of the page load"
- "Show me all JavaScript errors in the console"

**Why you need it**: Debug network issues and performance bottlenecks quickly.

---

### 4. Vitest - JavaScript Testing
**What it does**: Run and analyze Vitest unit and component tests

**Common Tasks**:
- "Run all tests in src/components/"
- "Why is the Button.test.tsx failing?"
- "Generate a new test for the UserCard component"
- "Show test coverage for the utils folder"

**Why you need it**: AI-assisted test debugging and generation.

---

### 5. GitHub - Version Control
**What it does**: Access GitHub repos, PRs, and issues

**Common Tasks**:
- "What's the latest issue assigned to me?"
- "Show the diff for PR #123"
- "Create a summary of merged PRs for the release notes"
- "Check the file history of Header.tsx"

**Why you need it**: Stay updated on team activity without leaving the editor.

---

### 6. Filesystem - External Projects
**What it does**: Access files outside your current project

**Common Tasks**:
- "Check the component library in /path/to/design-system"
- "Compare this file with the one in our legacy project"
- "Read the API documentation from /path/to/api-docs"

**Why you need it**: Reference external code or documentation.

---

## 🚀 Common Frontend Workflows

### Workflow 1: Pre-Deployment Checklist
```
1. "Run Lighthouse audit on staging.example.com"
2. "Run all Vitest tests and show coverage"
3. "Test the checkout flow with Playwright in Chrome and Safari"
4. "Check for console errors on the homepage with Chrome DevTools"
```

### Workflow 2: Bug Investigation
```
1. "Show network requests for /dashboard page with Chrome DevTools"
2. "Which API call is returning a 500 error?"
3. "Show the GitHub issue related to this endpoint"
4. "Check if the error appears in other browsers with Playwright"
```

### Workflow 3: Component Development
```
1. "Generate Vitest tests for this Button component"
2. "Run the tests and show results"
3. "Test the component in different viewport sizes with Playwright"
4. "Check accessibility with Lighthouse"
```

### Workflow 4: Performance Optimization
```
1. "Run Lighthouse audit and identify performance issues"
2. "Show network waterfall with Chrome DevTools"
3. "Which resources are blocking render?"
4. "After changes, re-run audit and compare scores"
```

---

## ⚠️ Servers to DISABLE for Frontend Work

Disable these to save resources and stay under tool limits:

```json
"postgres": { "disabled": true },
"postgres-diagnostics": { "disabled": true },
"redis-cache": { "disabled": true },
"supabase": { "disabled": true },
"ds-toolkit": { "disabled": true },
"awslabs.aws-diagram-mcp-server": { "disabled": true },
"MCP_DOCKER": { "disabled": true },
"sequentialThinking": { "disabled": true }
```

---

## 📊 Performance Tips

1. **Tool Count**: With recommended setup, you'll have ~50-60 tools (comfortable for Cursor)
2. **Memory Usage**: Browser tools (Playwright, Puppeteer) use ~200MB each. Close unused browsers.
3. **Timeout Settings**: Increase Lighthouse timeout to 120-180s for slow sites
4. **Auto-Approve**: Consider auto-approving test runs: `"vitest": { "autoApprove": ["run_tests"] }`

---

## 🔍 Troubleshooting

### "Browsers not installed" (Playwright)
```bash
npx playwright install
```

### "Chrome not found" (Lighthouse/DevTools)
Install Google Chrome and ensure it's in your system PATH.

### "Vitest not found"
```bash
npm install -D vitest
```

### Performance is slow
- Check tool count in IDE settings
- Disable unused servers
- Close browser instances when not testing

---

## 🎓 Learning Resources

- [Playwright Documentation](https://playwright.dev)
- [Lighthouse Guides](https://developer.chrome.com/docs/lighthouse)
- [Vitest Documentation](https://vitest.dev)
- [Chrome DevTools Protocol](https://chromedevtools.github.io/devtools-protocol/)

---

**Last Updated**: December 12, 2025  
**Optimized For**: React, Vue, Angular, Svelte, and vanilla JavaScript projects
