# Real-World MCP Workflow Examples

## 🎯 Overview

This guide provides practical, end-to-end workflow examples demonstrating how to use multiple MCP servers together to solve real-world development challenges.

---

## Workflow 1: Debug Production Issue

**Scenario**: Users report slow checkout process in production

**MCP Servers Used**: Chrome DevTools, PostgreSQL, Redis, GitHub

**Steps**:

1. **Capture Network Activity**
   ```
   Prompt: "Use Chrome DevTools to capture all network requests on checkout.example.com during the checkout flow"
   ```
   Result: Identifies API calls taking >5 seconds

2. **Investigate Database**
   ```
   Prompt: "Query PostgreSQL for the checkout_transactions table. Show average query time for checkout operations in the last hour"
   ```
   Result: Finds slow queries on orders table

3. **Check Cache**
   ```
   Prompt: "Show Redis cache hit rate for 'product:*' keys. Are product details being cached properly?"
   ```
   Result: Discovers cache misses at 85% (should be <10%)

4. **Find Related Issues**
   ```
   Prompt: "Search GitHub issues for 'slow checkout' or 'performance' in the last 2 weeks"
   ```
   Result: Finds similar issue reported 3 days ago with potential fix

5. **Root Cause**: Cache invalidation bug causing product lookups to hit database instead of Redis

6. **Verification After Fix**
   ```
   Prompt: "Re-test checkout flow with Chrome DevTools. Compare network timing with previous baseline"
   ```

---

## Workflow 2: Pre-Deployment Validation

**Scenario**: Validate release candidate before production deployment

**MCP Servers Used**: Lighthouse, Playwright, Vitest, GitHub, PostgreSQL

**Steps**:

1. **Run Automated Tests**
   ```
   Prompt: "Run full Vitest test suite and show coverage report. Flag any tests with <80% coverage"
   ```

2. **Cross-Browser E2E Testing**
   ```
   Prompt: "Use Playwright to test critical user flows in Chrome, Firefox, and Safari:
   - User login
   - Product search and filter
   - Add to cart and checkout
   - Account settings update"
   ```

3. **Performance Audit**
   ```
   Prompt: "Run Lighthouse audit on staging.example.com for homepage, product page, and checkout. Performance must be ≥85"
   ```

4. **Database Migration Check**
   ```
   Prompt: "Query PostgreSQL schema_migrations table. Verify all pending migrations have run successfully"
   ```

5. **Release Notes Generation**
   ```
   Prompt: "Generate release notes from GitHub PRs merged since last release (tag v2.4.0). Group by feature, bugfix, and breaking changes"
   ```

6. **Final Checklist**
   - ✅ All tests pass
   - ✅ E2E tests pass in all browsers
   - ✅ Performance score ≥85
   - ✅ DB migrations successful
   - ✅ Release notes generated

---

## Workflow 3: API Development & Testing

**Scenario**: Build and test new REST API endpoint

**MCP Servers Used**: PostgreSQL, Sequential Thinking, GitHub, Puppeteer

**Steps**:

1. **Design Data Flow**
   ```
   Prompt: "Use Sequential Thinking to model the data flow for POST /api/orders endpoint:
   - Validate input
   - Check inventory
   - Create transaction
   - Update stock
   - Send confirmation
   Identify potential race conditions"
   ```

2. **Database Schema Check**
   ```
   Prompt: "Show PostgreSQL schema for orders, inventory, and transactions tables. Verify foreign key constraints are properly defined"
   ```

3. **Implementation & Testing**
   ```
   Prompt: "Test the /api/orders endpoint with Puppeteer:
   - Valid order: should return 201
   - Insufficient stock: should return 400
   - Invalid payment: should return 402
   - Concurrent orders: test race condition handling"
   ```

4. **Performance Testing**
   ```
   Prompt: "Use Puppeteer to simulate 10 concurrent POST requests to /api/orders. Measure response times and identify any slowdowns"
   ```

5. **Documentation**
   ```
   Prompt: "Generate API documentation based on the test cases. Create PR on GitHub with API spec and test results"
   ```

---

## Workflow 4: Data Pipeline Analysis

**Scenario**: Investigate data quality issues in analytics pipeline

**MCP Servers Used**: PostgreSQL, DS Toolkit, Kroki, Filesystem, GitHub

**Steps**:

1. **Query Raw Data**
   ```
   Prompt: "Query PostgreSQL user_events table for the last 7 days. Show row counts by event_type and identify any anomalies"
   ```
   Result: Finds spike in 'page_view' events on Dec 10

2. **Statistical Analysis**
   ```
   Prompt: "Use DS Toolkit to analyze the event distribution:
   - Calculate daily event counts
   - Identify outliers (>3 standard deviations)
   - Compare with 30-day baseline"
   ```
   Result: Dec 10 has 5x normal traffic

3. **Data Quality Check**
   ```
   Prompt: "Analyze user_events data quality with DS Toolkit:
   - Missing values per column
   - Duplicate events
   - Invalid timestamps
   - Null user_ids"
   ```
   Result: Finds 15% duplicate events on Dec 10

4. **Visualize Pipeline**
   ```
   Prompt: "Use Kroki to create a flowchart of the data pipeline from event capture to warehouse. Highlight the deduplication step"
   ```

5. **Check Pipeline Code**
   ```
   Prompt: "Search GitHub for changes to the event ingestion code between Dec 9-10. Look for deduplication logic changes"
   ```
   Result: Finds PR that accidentally disabled deduplication

6. **Document Root Cause**
   ```
   Prompt: "Create GitHub issue documenting:
   - Data quality problem (duplicate events)
   - Root cause (disabled deduplication)
   - Impact (inflated metrics)
   - Fix (revert PR #456)
   Include data analysis and pipeline diagram"
   ```

---

## Workflow 5: Frontend Performance Optimization

**Scenario**: Improve page load performance from 4s to <2s

**MCP Servers Used**: Lighthouse, Chrome DevTools, GitHub, Filesystem

**Steps**:

1. **Baseline Audit**
   ```
   Prompt: "Run Lighthouse audit on product-page.example.com. Show performance score and top 5 opportunities for improvement"
   ```
   Result: Score 62/100, main issues: large JavaScript bundles, render-blocking CSS

2. **Deep Dive with DevTools**
   ```
   Prompt: "Use Chrome DevTools to analyze page load:
   - Show network waterfall
   - Identify largest resources
   - Check for render-blocking resources
   - Measure Time to Interactive (TTI)"
   ```
   Result: 2.5MB JavaScript bundle, 800KB CSS

3. **Code Analysis**
   ```
   Prompt: "Use Filesystem to check webpack.config.js in /config. Is code splitting enabled? Are there any bundle optimization plugins?"
   ```
   Result: Code splitting not configured

4. **Research Best Practices**
   ```
   Prompt: "Search GitHub for webpack optimization examples in similar React projects. Find implementations of code splitting and lazy loading"
   ```

5. **Implement Optimizations**
   - Enable code splitting
   - Implement lazy loading for routes
   - Add compression plugins
   - Optimize images

6. **Verify Improvements**
   ```
   Prompt: "Re-run Lighthouse audit. Compare new score with baseline (62). Show improvement breakdown by metric"
   ```
   Result: Score improved to 89/100, load time <2s ✅

7. **Document Changes**
   ```
   Prompt: "Create GitHub PR with:
   - Before/after Lighthouse scores
   - Code changes summary
   - Bundle size reduction metrics
   - Performance testing results"
   ```

---

## Workflow 6: Security Audit & Remediation

**Scenario**: Conduct security review after vulnerability report

**MCP Servers Used**: GitHub, PostgreSQL, Chrome DevTools, Filesystem

**Steps**:

1. **Gather Intelligence**
   ```
   Prompt: "Search GitHub issues for 'security' or 'vulnerability' tags. Show all open security issues and their severity"
   ```

2. **Check Dependency Vulnerabilities**
   ```
   Prompt: "Read package.json from Filesystem. List all dependencies with known vulnerabilities"
   ```

3. **Database Security Check**
   ```
   Prompt: "Query PostgreSQL to check:
   - Users with SUPERUSER privileges
   - Tables without row-level security
   - Connections from unexpected IP addresses
   Show results grouped by risk level"
   ```

4. **Frontend Security Analysis**
   ```
   Prompt: "Use Chrome DevTools to check security headers on app.example.com:
   - Content-Security-Policy
   - X-Frame-Options
   - Strict-Transport-Security
   - X-Content-Type-Options"
   ```

5. **Code Review**
   ```
   Prompt: "Search GitHub code for common security issues:
   - Hardcoded secrets or API keys
   - SQL injection vulnerabilities
   - XSS vulnerabilities
   - Insecure authentication"
   ```

6. **Remediation Plan**
   - Update vulnerable dependencies
   - Add security headers
   - Implement row-level security
   - Remove hardcoded secrets

7. **Verification**
   ```
   Prompt: "After fixes, re-run security checks and create security audit report in GitHub"
   ```

---

## Workflow 7: A/B Test Analysis

**Scenario**: Analyze A/B test results for new checkout flow

**MCP Servers Used**: PostgreSQL, DS Toolkit, Kroki, GitHub

**Steps**:

1. **Extract Test Data**
   ```
   Prompt: "Query PostgreSQL ab_test_results table:
   - Control group: variant_id = 'checkout_v1'
   - Treatment group: variant_id = 'checkout_v2'
   - Metric: conversion_rate
   - Time period: last 14 days
   Show sample size and conversion rate for each group"
   ```

2. **Statistical Analysis**
   ```
   Prompt: "Use DS Toolkit to analyze A/B test results:
   - Perform two-sample t-test
   - Calculate confidence intervals (95%)
   - Compute effect size (Cohen's d)
   - Check for statistical significance (p < 0.05)
   - Assess statistical power"
   ```
   Result: Treatment improved conversion by 12% (p=0.003, significant)

3. **Secondary Metrics**
   ```
   Prompt: "Analyze secondary metrics:
   - Average order value
   - Time to checkout
   - Cart abandonment rate
   Check if treatment had negative effects"
   ```

4. **Segment Analysis**
   ```
   Prompt: "Break down results by user segment:
   - New vs returning users
   - Mobile vs desktop
   - Geographic region
   Identify which segments benefited most"
   ```

5. **Visualization**
   ```
   Prompt: "Use Kroki to create:
   - Funnel diagram showing control vs treatment
   - Box plots comparing distributions
   - Time series showing daily conversion rates"
   ```

6. **Decision Documentation**
   ```
   Prompt: "Create GitHub issue documenting:
   - Test hypothesis
   - Statistical results
   - Business impact (revenue increase)
   - Recommendation (ship treatment)
   - Rollout plan
   Include all visualizations and statistical evidence"
   ```

---

## Workflow 8: Incident Response

**Scenario**: Production API is returning 500 errors at 15% rate

**MCP Servers Used**: Chrome DevTools, PostgreSQL, Redis, Docker, GitHub

**Steps**:

1. **Immediate Triage** (First 5 minutes)
   ```
   Prompt: "Use Chrome DevTools to capture failed API requests:
   - Which endpoints are failing?
   - What are the error messages?
   - When did failures start?"
   ```

2. **Check Infrastructure** (Minutes 5-10)
   ```
   Prompt: "Use Docker MCP to check:
   - Container health status
   - CPU and memory usage
   - Recent container restarts
   - Error logs from last 30 minutes"
   ```

3. **Database Investigation** (Minutes 10-15)
   ```
   Prompt: "Query PostgreSQL:
   - Active connection count
   - Long-running queries (>10s)
   - Deadlocks in the last hour
   - Disk space usage"
   ```
   Result: Finds deadlock between orders and inventory tables

4. **Check Recent Changes** (Minutes 15-20)
   ```
   Prompt: "Search GitHub for:
   - Deployments in the last 2 hours
   - Merged PRs touching order/inventory code
   - Recent config changes"
   ```
   Result: Finds deployment 45 minutes ago that changed transaction isolation level

5. **Validate Fix**
   ```
   Prompt: "After rollback:
   - Monitor error rate with Chrome DevTools
   - Check database locks in PostgreSQL
   - Verify container stability with Docker
   Should see error rate drop to <1%"
   ```

6. **Post-Incident Report**
   ```
   Prompt: "Create GitHub incident report:
   - Timeline of events
   - Root cause (deadlock from isolation level change)
   - Impact (15% error rate for 45 minutes)
   - Resolution (rollback deployment)
   - Prevention (add deadlock monitoring alerts)"
   ```

---

## Quick Reference: MCP Server Combinations

| Workflow Type | MCP Servers |
|--------------|-------------|
| Frontend Development | Playwright, Lighthouse, Chrome DevTools, Vitest, GitHub |
| Backend Development | PostgreSQL, Redis, Supabase, GitHub, Docker |
| Data Analysis | DS Toolkit, PostgreSQL, Redis, Filesystem, Kroki |
| Testing & QA | Playwright, Puppeteer, Lighthouse, Vitest, GitHub |
| DevOps | Docker, PostgreSQL, Redis, GitHub, Filesystem |
| Security Audit | GitHub, PostgreSQL, Chrome DevTools, Filesystem |
| Performance Optimization | Lighthouse, Chrome DevTools, PostgreSQL, Redis |
| Incident Response | Chrome DevTools, Docker, PostgreSQL, Redis, GitHub |

---

**Last Updated**: December 12, 2025  
**Version**: 1.0
