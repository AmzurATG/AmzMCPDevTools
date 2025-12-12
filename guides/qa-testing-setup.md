# QA/Testing Engineer MCP Quick Start Guide

## 🎯 Overview

This guide helps QA and testing engineers set up MCP servers optimized for automated testing, cross-browser validation, performance testing, and test analysis workflows.

---

## ⚡ Quick Setup (5 minutes)

### Recommended Servers for QA/Testing

Enable only these servers for optimal performance:

```json
{
  "servers": {
    "playwright": {
      "command": "npx",
      "args": ["-y", "@playwright/mcp@latest"],
      "type": "stdio"
    },
    "puppeteer": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-puppeteer"],
      "type": "stdio"
    },
    "lighthouse": {
      "command": "npx",
      "args": ["-y", "@danielsogl/lighthouse-mcp"],
      "type": "stdio",
      "timeout": 180
    },
    "chrome-devtools": {
      "command": "npx",
      "args": ["chrome-devtools-mcp@latest"],
      "type": "stdio"
    },
    "vitest": {
      "command": "npx",
      "args": ["-y", "@djankies/vitest-mcp"],
      "type": "stdio",
      "autoApprove": ["run_tests"]
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
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/path/to/test/reports", "/path/to/test/data"],
      "type": "stdio"
    }
  }
}
```

**Total Tools**: ~55-65 (well under the 80 tool limit for Cursor)

---

## 🛠️ Essential Tools & Use Cases

### 1. Playwright - Advanced Browser Automation
**What it does**: Cross-browser testing with Chrome, Firefox, and WebKit (Safari)

**Common Tasks**:
- "Test the login flow in all three browsers"
- "Take screenshots of the checkout page at different viewport sizes"
- "Record a test for the user registration process"
- "Verify the mobile menu works on iPhone and Android viewports"
- "Test form validation across browsers"

**Why you need it**: Comprehensive cross-browser testing with network interception and mobile emulation.

---

### 2. Puppeteer - Chrome-Focused Testing
**What it does**: Headless Chrome automation for fast, reliable testing

**Common Tasks**:
- "Scrape test data from staging environment"
- "Generate PDF reports from test results page"
- "Test file upload functionality"
- "Validate dynamic content loading"
- "Capture HAR files for performance analysis"

**Why you need it**: Fast Chrome-specific testing and data extraction.

---

### 3. Lighthouse - Performance & Accessibility Testing
**What it does**: Automated audits for performance, accessibility, best practices, and SEO

**Common Tasks**:
- "Run Lighthouse audit on staging.example.com"
- "Compare performance scores before and after optimization"
- "List all accessibility violations with severity levels"
- "Check if the site meets WCAG AA standards"
- "Generate performance budget report"
- "Test mobile performance score"

**Why you need it**: Automated quality gates for performance and accessibility.

---

### 4. Chrome DevTools - Deep Debugging
**What it does**: Programmatic access to DevTools for network, console, and performance analysis

**Common Tasks**:
- "Capture network requests during checkout flow"
- "Identify which API calls are failing"
- "Show JavaScript console errors on page load"
- "Measure page load performance metrics"
- "Inspect failed XHR requests and their payloads"

**Why you need it**: Debug test failures and investigate production issues.

---

### 5. Vitest - Unit & Component Testing
**What it does**: Run and analyze JavaScript/TypeScript tests

**Common Tasks**:
- "Run all tests in the test suite"
- "Show test coverage report"
- "Rerun only failed tests"
- "Generate test report for component library"
- "Debug why UserCard.test.tsx is failing"

**Why you need it**: Automated unit test execution and analysis.

---

### 6. GitHub - Test Management
**What it does**: Link tests to issues, PRs, and track test-related changes

**Common Tasks**:
- "Show all open bugs tagged as 'testing-required'"
- "Link test failures to GitHub issues"
- "Generate test summary for PR #456"
- "Check which tests were modified in the last commit"
- "Create bug report from test failure"

**Why you need it**: Integrated test case management with development workflow.

---

### 7. Filesystem - Test Assets Management
**What it does**: Access test data, screenshots, and reports

**Common Tasks**:
- "Compare current screenshot with baseline in /test/screenshots"
- "Read test data from /test/fixtures/users.json"
- "Save test report to /reports/test-run-2024-12-12"
- "Load mock API responses from /test/mocks"

**Why you need it**: Manage test artifacts and reference data.

---

## 🚀 Common QA Workflows

### Workflow 1: Smoke Testing After Deployment
```
1. "Test critical user flows with Playwright:"
   - Login flow
   - Checkout process
   - User registration
   - Password reset
2. "Run Lighthouse audit on all major pages"
3. "Check for console errors with Chrome DevTools"
4. "Compare performance with previous baseline"
5. "Report issues found to GitHub"
```

### Workflow 2: Cross-Browser Testing
```
1. "Test homepage in Chrome, Firefox, and Safari using Playwright"
2. "Take screenshots of form pages in all browsers at 1920x1080 and 375x667"
3. "Verify CSS rendering consistency"
4. "Test JavaScript functionality in all browsers"
5. "Document browser-specific issues"
```

### Workflow 3: Performance Testing
```
1. "Run Lighthouse audit and record baseline scores"
2. "Load test with Puppeteer: simulate 10 concurrent users"
3. "Capture network timeline with Chrome DevTools"
4. "Identify performance bottlenecks"
5. "After fixes, rerun and compare results"
```

### Workflow 4: Accessibility Testing
```
1. "Run Lighthouse accessibility audit"
2. "List all WCAG violations"
3. "Test keyboard navigation with Playwright"
4. "Verify screen reader compatibility"
5. "Test color contrast ratios"
6. "Create GitHub issues for each violation"
```

### Workflow 5: Regression Testing
```
1. "Run full Vitest test suite"
2. "Execute Playwright E2E tests"
3. "Compare screenshots with baseline"
4. "Identify visual regressions"
5. "Run Lighthouse audit and compare scores"
6. "Generate test report and save to /reports"
```

### Workflow 6: Bug Investigation
```
1. "Reproduce bug with Playwright"
2. "Capture network requests with Chrome DevTools"
3. "Identify failing API calls"
4. "Check console for JavaScript errors"
5. "Search GitHub for related issues"
6. "Create detailed bug report with evidence"
```

---

## 🎯 Test Automation Examples

### Example 1: Login Test with Playwright
Prompt:
> "Create a Playwright test that logs into app.example.com with username 'testuser' and password 'password123', verifies the dashboard loads, and takes a screenshot."

### Example 2: Performance Regression Check
Prompt:
> "Run Lighthouse audit on staging.example.com, compare the performance score with the baseline of 85. If it's below 85, list the top 3 issues causing the drop."

### Example 3: Accessibility Compliance
Prompt:
> "Run Lighthouse accessibility audit on all pages in sitemap.xml. List all WCAG AA violations grouped by severity. Create GitHub issues for each critical violation."

### Example 4: Visual Regression Testing
Prompt:
> "Take screenshots of the homepage, product page, and checkout page in Chrome, Firefox, and Safari at desktop and mobile viewports. Compare with screenshots in /test/baselines. Report any differences."

### Example 5: API Testing
Prompt:
> "Use Chrome DevTools to capture all API requests when loading the dashboard. Identify any requests that take longer than 2 seconds or return non-200 status codes."

---

## ⚠️ Servers to DISABLE for QA Work

Disable these to save resources and stay under tool limits:

```json
"postgres": { "disabled": true },
"postgres-diagnostics": { "disabled": true },
"redis-cache": { "disabled": true },
"supabase": { "disabled": true },
"ds-toolkit": { "disabled": true },
"awslabs.aws-diagram-mcp-server": { "disabled": true },
"MCP_DOCKER": { "disabled": true },
"sequentialThinking": { "disabled": true },
"kroki": { "disabled": true }
```

---

## 📊 Performance Tips

1. **Tool Count**: With recommended setup, you'll have ~55-65 tools (comfortable for Cursor)
2. **Memory Usage**: 
   - Playwright: ~300MB (stores 3 browser binaries)
   - Puppeteer: ~200MB (Chrome binary only)
   - Close browser instances after tests
3. **Timeout Settings**: 
   - Lighthouse: 180s for complex pages
   - Playwright: Default 30s per action (increase for slow sites)
4. **Parallel Testing**: Avoid running Playwright and Puppeteer simultaneously
5. **Auto-Approve**: Enable for test runs to speed up workflow:
   ```json
   "vitest": { "autoApprove": ["run_tests"] }
   ```

---

## 🔧 Prerequisites

### 1. Install Node.js
Required for all testing tools.
```bash
node --version  # Should be v16 or higher
```

### 2. Install Browser Binaries
```bash
# Playwright (installs Chrome, Firefox, WebKit)
npx playwright install

# Puppeteer (installs Chrome only)
npx puppeteer browsers install chrome
```

### 3. Install Chrome (for Lighthouse)
Download from [google.com/chrome](https://www.google.com/chrome/)

---

## 🔍 Troubleshooting

### "Browser download failed"
```bash
# Manually install browsers
npx playwright install --with-deps

# For Puppeteer
npx puppeteer browsers install chrome
```

### "Browser executable not found"
```bash
# Check browser installation
npx playwright --version
which google-chrome  # Linux/Mac
```

### "Lighthouse timeout errors"
Increase timeout in config:
```json
"lighthouse": {
  "timeout": 300  // 5 minutes for very slow sites
}
```

### "Out of memory" errors
- Close unnecessary browser instances
- Run tests sequentially instead of parallel
- Increase system memory allocation
- Use headless mode (default) instead of headed

### Test failures in CI/CD
- Ensure browser binaries are installed in CI: `npx playwright install --with-deps`
- Use Docker containers with pre-installed browsers
- Set appropriate timeouts for network latency

---

## 📋 Test Reporting

### Generate Test Reports
Prompt examples:
- "Run all tests and save results to /reports/test-run-{date}.json"
- "Generate HTML test report from last test run"
- "Compare test results from last two runs and show regression"
- "Create test summary for stakeholder presentation"

### Screenshot Management
Prompt examples:
- "Organize test screenshots by test suite in /reports/screenshots"
- "Compare all screenshots with baselines and highlight differences"
- "Create visual regression report with side-by-side comparisons"

---

## 🎓 Learning Resources

- [Playwright Testing Guide](https://playwright.dev/docs/intro)
- [Puppeteer Documentation](https://pptr.dev/)
- [Lighthouse Scoring Guide](https://developer.chrome.com/docs/lighthouse/performance/performance-scoring)
- [Web Accessibility Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)
- [Chrome DevTools Protocol](https://chromedevtools.github.io/devtools-protocol/)

---

## 🚦 Quality Gates with MCP

### Pre-Deployment Checklist
```
✅ All Vitest unit tests pass (100% coverage on critical paths)
✅ Playwright E2E tests pass in Chrome, Firefox, Safari
✅ Lighthouse Performance score ≥ 85
✅ Lighthouse Accessibility score = 100
✅ No console errors in Chrome DevTools
✅ Visual regression tests pass (0 unexpected changes)
✅ API response times < 2s (95th percentile)
```

---

**Last Updated**: December 12, 2025  
**Optimized For**: Web application testing, E2E testing, performance testing, and accessibility testing
