# Backend Developer MCP Quick Start Guide

## 🎯 Overview

This guide helps backend developers set up MCP servers optimized for backend development workflows including database management, API testing, caching, and infrastructure work.

---

## ⚡ Quick Setup (5 minutes)

### Recommended Servers for Backend Development

Enable only these servers for optimal performance:

```json
{
  "servers": {
    "postgres": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres", "postgresql://user:password@localhost:5432/mydb"],
      "type": "stdio"
    },
    "redis-cache": {
      "command": "uvx",
      "args": ["redis-mcp-server", "--url", "redis://localhost:6379"],
      "env": {
        "REDIS_HOST": "localhost",
        "REDIS_PORT": "6379"
      },
      "type": "stdio"
    },
    "supabase": {
      "command": "npx",
      "args": ["-y", "@supabase/mcp-server-supabase@latest"],
      "env": {
        "SUPABASE_ACCESS_TOKEN": "your_supabase_token"
      },
      "type": "stdio"
    },
    "sequentialThinking": {
      "command": "uvx",
      "args": ["sequential-thinking-mcp"],
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
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/path/to/backend/project", "/path/to/api/docs"],
      "type": "stdio"
    },
    "MCP_DOCKER": {
      "command": "docker",
      "args": ["mcp", "gateway", "run"],
      "type": "stdio",
      "timeout": 60
    }
  }
}
```

**Total Tools**: ~60-70 (well under the 80 tool limit for Cursor)

---

## 🛠️ Essential Tools & Use Cases

### 1. PostgreSQL - Database Operations
**What it does**: Direct database access for queries, schema inspection, and data analysis

**Common Tasks**:
- "Show all tables in my database"
- "Explain the schema of the users table"
- "Write a query to find all inactive users from last month"
- "Check indexes on the orders table"
- "Analyze query performance for this SELECT statement"

**Why you need it**: Database debugging and optimization without switching tools.

---

### 2. Redis - Cache Management
**What it does**: Inspect cache contents, manage keys, monitor performance

**Common Tasks**:
- "Show all keys matching 'user_session:*'"
- "What's the TTL for key 'cache:homepage'?"
- "Get the value stored in 'api:rate_limit:192.168.1.1'"
- "Delete all keys matching 'temp:*'"
- "Show Redis memory usage stats"

**Why you need it**: Debug caching issues and optimize cache strategies.

---

### 3. Supabase - Backend-as-a-Service
**What it does**: Manage Supabase projects, auth, database, and storage

**Common Tasks**:
- "List all tables in my Supabase project"
- "Show row count for the profiles table"
- "Check authentication users created today"
- "List storage buckets and their sizes"
- "Query edge function logs for errors"

**Why you need it**: Unified Supabase management from your editor.

---

### 4. Sequential Thinking - Workflow Modeling
**What it does**: Model complex state machines and event flows

**Common Tasks**:
- "Model the order processing workflow from cart to delivery"
- "Trace the authentication state transitions"
- "Identify potential race conditions in the payment flow"
- "Generate a state diagram for the booking system"

**Why you need it**: Design and debug complex backend workflows.

---

### 5. GitHub - Repository Management
**What it does**: Access repos, PRs, issues, and file history

**Common Tasks**:
- "Show open PRs for the backend repository"
- "What issues are tagged as 'bug' and 'high-priority'?"
- "Generate release notes from merged PRs this week"
- "Check who modified the AuthService.ts file recently"

**Why you need it**: Track code changes and collaborate effectively.

---

### 6. Filesystem - External Resources
**What it does**: Access files outside current project

**Common Tasks**:
- "Read the API documentation from /docs/api-spec.yaml"
- "Compare config files between staging and production"
- "Check migration scripts in /database/migrations"
- "Access shared libraries in /common/utils"

**Why you need it**: Reference related projects and documentation.

---

### 7. Docker MCP - Container Management
**What it does**: Manage Docker containers, images, and resources

**Common Tasks**:
- "Show all running containers"
- "Check logs for the api-service container"
- "What's the resource usage of the database container?"
- "Restart the redis container"
- "List all Docker volumes and their sizes"

**Why you need it**: Manage local development environment containers.

---

## 🚀 Common Backend Workflows

### Workflow 1: API Debugging
```
1. "Show the schema of the users table in PostgreSQL"
2. "Query for user ID 12345 and show their data"
3. "Check if this user has a session in Redis"
4. "Show GitHub issues mentioning this user ID"
```

### Workflow 2: Performance Investigation
```
1. "Analyze this slow query in PostgreSQL"
2. "Show query execution plan"
3. "Check if results are cached in Redis"
4. "What indexes exist on this table?"
5. "Suggest query optimizations"
```

### Workflow 3: Cache Debugging
```
1. "Show all Redis keys for user sessions"
2. "Check TTL values for these keys"
3. "Get cached value for key 'api:user:12345'"
4. "Why is the cache miss rate high?"
```

### Workflow 4: Deployment Validation
```
1. "Check Docker container status"
2. "View logs from the last 10 minutes"
3. "Query database for migration status"
4. "Test Redis connection and memory usage"
5. "Verify Supabase edge functions are running"
```

### Workflow 5: State Machine Design
```
1. "Model the order processing flow with Sequential Thinking"
2. "Identify all state transitions"
3. "What edge cases could cause issues?"
4. "Generate database schema for state storage"
```

---

## ⚠️ Servers to DISABLE for Backend Work

Disable these to save resources and stay under tool limits:

```json
"playwright": { "disabled": true },
"puppeteer": { "disabled": true },
"lighthouse": { "disabled": true },
"chrome-devtools": { "disabled": true },
"vitest": { "disabled": true },
"kroki": { "disabled": true },
"awslabs.aws-diagram-mcp-server": { "disabled": true },
"ds-toolkit": { "disabled": true }
```

---

## 📊 Performance Tips

1. **Tool Count**: With recommended setup, you'll have ~60-70 tools (comfortable for Cursor)
2. **Database Connections**: PostgreSQL and Redis maintain persistent connections. Close when not needed.
3. **Timeout Settings**: 
   - Database queries: 60-90s for complex queries
   - Docker operations: 60s (default is fine)
   - Supabase API calls: 60s (default is fine)
4. **Resource Usage**: 
   - PostgreSQL MCP: ~50MB memory
   - Redis MCP: ~30MB memory
   - Docker MCP: ~40MB memory

---

## 🔧 Prerequisites

### 1. PostgreSQL
```bash
# Install PostgreSQL (if not already installed)
# Ubuntu/Debian
sudo apt install postgresql postgresql-contrib

# macOS
brew install postgresql

# Start service
sudo service postgresql start  # Linux
brew services start postgresql  # macOS
```

### 2. Redis
```bash
# Install Redis
# Ubuntu/Debian
sudo apt install redis-server

# macOS
brew install redis

# Start service
sudo service redis-server start  # Linux
brew services start redis        # macOS
```

### 3. Docker
Download from [docker.com](https://www.docker.com/products/docker-desktop)

### 4. UV Package Manager
```bash
# For Redis and Sequential Thinking servers
pip install uv
# or
curl -LsSf https://astral.sh/uv/install.sh | sh
```

---

## 🔍 Troubleshooting

### "Connection refused" (PostgreSQL)
```bash
# Check if PostgreSQL is running
sudo service postgresql status

# Start if stopped
sudo service postgresql start

# Verify connection string format
postgresql://username:password@localhost:5432/database_name
```

### "Connection refused" (Redis)
```bash
# Check if Redis is running
sudo service redis-server status

# Start if stopped
sudo service redis-server start

# Test connection
redis-cli ping
```

### "uvx not found"
```bash
# Install UV package manager
pip install uv
```

### "Docker command not found"
Install Docker Desktop or Docker Engine for your platform.

### Database authentication errors
- Verify username and password in connection string
- Check PostgreSQL `pg_hba.conf` for allowed connections
- Ensure database exists: `createdb your_database_name`

---

## 🔐 Security Best Practices

1. **Never commit credentials**: Use environment variables
   ```bash
   # .env file
   DATABASE_URL=postgresql://user:pass@localhost:5432/mydb
   REDIS_URL=redis://localhost:6379
   SUPABASE_TOKEN=sbp_your_token
   GITHUB_TOKEN=ghp_your_token
   ```

2. **Use read-only credentials** when possible:
   ```sql
   -- Create read-only PostgreSQL user
   CREATE USER readonly_user WITH PASSWORD 'secure_password';
   GRANT CONNECT ON DATABASE mydb TO readonly_user;
   GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly_user;
   ```

3. **Rotate tokens regularly**: Especially for production access

4. **Limit Redis commands**: Configure Redis ACL for safety

---

## 🎓 Learning Resources

- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Redis Documentation](https://redis.io/docs/)
- [Supabase Documentation](https://supabase.com/docs)
- [Docker Documentation](https://docs.docker.com/)
- [Sequential Thinking Patterns](https://github.com/modelcontextprotocol/servers)

---

**Last Updated**: December 12, 2025  
**Optimized For**: Node.js, Python, Go, Java, and .NET backend projects
