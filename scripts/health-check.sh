#!/bin/bash

# MCP Configuration Health Check Script
# This script validates your MCP server configuration and checks dependencies

set -e

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     MCP Configuration Health Check                  ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════╝${NC}"
echo ""

# Track issues
WARNINGS=0
ERRORS=0
TOTAL_TOOLS=0

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to print status
print_status() {
    if [ "$1" == "ok" ]; then
        echo -e "${GREEN}✓${NC} $2"
    elif [ "$1" == "warn" ]; then
        echo -e "${YELLOW}⚠${NC} $2"
        ((WARNINGS++))
    elif [ "$1" == "error" ]; then
        echo -e "${RED}✗${NC} $2"
        ((ERRORS++))
    else
        echo -e "  $2"
    fi
}

# Check for mcp.json file
echo -e "${BLUE}[1/8] Checking MCP Configuration File...${NC}"
MCP_CONFIG=""

# Check common locations
if [ -f "$HOME/.cursor/mcp.json" ]; then
    MCP_CONFIG="$HOME/.cursor/mcp.json"
    print_status "ok" "Found Cursor config: $MCP_CONFIG"
elif [ -f "$HOME/.config/Code/User/mcp.json" ]; then
    MCP_CONFIG="$HOME/.config/Code/User/mcp.json"
    print_status "ok" "Found VS Code config: $MCP_CONFIG"
elif [ -f "./mcp.json" ]; then
    MCP_CONFIG="./mcp.json"
    print_status "ok" "Found local config: $MCP_CONFIG"
else
    print_status "error" "mcp.json not found in standard locations"
    echo "  Expected locations:"
    echo "    - $HOME/.cursor/mcp.json (Cursor)"
    echo "    - $HOME/.config/Code/User/mcp.json (VS Code Linux)"
    echo "    - $HOME/Library/Application Support/Code/User/mcp.json (VS Code macOS)"
    echo "    - ./mcp.json (Current directory)"
    exit 1
fi
echo ""

# Validate JSON syntax
echo -e "${BLUE}[2/8] Validating JSON Syntax...${NC}"
if command_exists python3; then
    if python3 -c "import json; json.load(open('$MCP_CONFIG'))" 2>/dev/null; then
        print_status "ok" "JSON syntax is valid"
    else
        print_status "error" "Invalid JSON syntax in $MCP_CONFIG"
        python3 -c "import json; json.load(open('$MCP_CONFIG'))"
        exit 1
    fi
elif command_exists node; then
    if node -e "require('$MCP_CONFIG')" 2>/dev/null; then
        print_status "ok" "JSON syntax is valid"
    else
        print_status "error" "Invalid JSON syntax in $MCP_CONFIG"
        exit 1
    fi
else
    print_status "warn" "Cannot validate JSON (python3 or node not found)"
fi
echo ""

# Check core dependencies
echo -e "${BLUE}[3/8] Checking Core Dependencies...${NC}"

if command_exists node; then
    NODE_VERSION=$(node --version)
    print_status "ok" "Node.js installed: $NODE_VERSION"
else
    print_status "error" "Node.js not found (required for npx commands)"
fi

if command_exists npx; then
    print_status "ok" "npx available"
else
    print_status "error" "npx not found (comes with Node.js)"
fi

if command_exists python3; then
    PYTHON_VERSION=$(python3 --version)
    print_status "ok" "Python installed: $PYTHON_VERSION"
else
    print_status "warn" "Python not found (required for uvx/uv commands)"
fi

if command_exists uv; then
    UV_VERSION=$(uv --version)
    print_status "ok" "UV package manager installed: $UV_VERSION"
elif command_exists uvx; then
    print_status "ok" "uvx command available"
else
    print_status "warn" "UV/uvx not found (required for some servers)"
    echo "  Install: pip install uv"
fi

if command_exists docker; then
    if docker ps >/dev/null 2>&1; then
        print_status "ok" "Docker is installed and running"
    else
        print_status "warn" "Docker installed but not running"
    fi
else
    print_status "warn" "Docker not found (required for MCP_DOCKER server)"
fi
echo ""

# Check optional services
echo -e "${BLUE}[4/8] Checking Optional Services...${NC}"

if command_exists psql; then
    print_status "ok" "PostgreSQL client installed"
    if pg_isready >/dev/null 2>&1; then
        print_status "ok" "PostgreSQL server is running"
    else
        print_status "warn" "PostgreSQL server not running"
    fi
else
    print_status "warn" "PostgreSQL not found (required for postgres servers)"
fi

if command_exists redis-cli; then
    print_status "ok" "Redis client installed"
    if redis-cli ping >/dev/null 2>&1; then
        print_status "ok" "Redis server is running"
    else
        print_status "warn" "Redis server not running"
    fi
else
    print_status "warn" "Redis not found (required for redis-cache server)"
fi

if command_exists google-chrome || command_exists chromium-browser || command_exists chrome; then
    print_status "ok" "Chrome/Chromium browser found"
else
    print_status "warn" "Chrome not found (required for Lighthouse, Chrome DevTools)"
fi
echo ""

# Parse mcp.json and check enabled servers
echo -e "${BLUE}[5/8] Analyzing MCP Server Configuration...${NC}"

if command_exists python3; then
    # Count servers and check status
    SERVER_INFO=$(python3 << 'EOF'
import json
import sys

try:
    with open(sys.argv[1]) as f:
        config = json.load(f)
    
    servers = config.get('servers', {})
    total = len(servers)
    enabled = sum(1 for s in servers.values() if not s.get('disabled', False))
    disabled = total - enabled
    
    print(f"{total},{enabled},{disabled}")
    
    # List servers
    for name, cfg in servers.items():
        status = "disabled" if cfg.get('disabled', False) else "enabled"
        command = cfg.get('command', 'unknown')
        print(f"{name}|{status}|{command}")
        
except Exception as e:
    print(f"0,0,0")
    sys.exit(1)
EOF
    "$MCP_CONFIG")
    
    IFS=',' read -r TOTAL_SERVERS ENABLED_SERVERS DISABLED_SERVERS <<< "$(echo "$SERVER_INFO" | head -n1)"
    
    print_status "info" "Total servers configured: $TOTAL_SERVERS"
    print_status "info" "Enabled servers: $ENABLED_SERVERS"
    print_status "info" "Disabled servers: $DISABLED_SERVERS"
    
    echo ""
    echo "  Server List:"
    echo "$SERVER_INFO" | tail -n +2 | while IFS='|' read -r name status command; do
        if [ "$status" == "enabled" ]; then
            echo -e "    ${GREEN}●${NC} $name (${command})"
            # Estimate 8-12 tools per server
            TOTAL_TOOLS=$((TOTAL_TOOLS + 10))
        else
            echo -e "    ${YELLOW}○${NC} $name (${command}) - DISABLED"
        fi
    done
    
    # Estimate total tools (rough average of 10 tools per server)
    EST_TOOLS=$((ENABLED_SERVERS * 10))
    echo ""
    echo -e "  Estimated tool count: ~${EST_TOOLS}"
    
    # Check against limits
    if [ "$EST_TOOLS" -gt 128 ]; then
        print_status "error" "Tool count exceeds VS Code limit (128 tools)"
        echo "  Recommendation: Disable some servers to stay under limit"
    elif [ "$EST_TOOLS" -gt 80 ]; then
        print_status "warn" "Tool count may affect Cursor performance (>80 tools)"
        echo "  Recommendation: Disable unused servers for better performance"
    else
        print_status "ok" "Tool count is within recommended limits"
    fi
fi
echo ""

# Check for common configuration issues
echo -e "${BLUE}[6/8] Checking Configuration Issues...${NC}"

if grep -q "<YOUR_" "$MCP_CONFIG" 2>/dev/null; then
    print_status "warn" "Found placeholder values (e.g., <YOUR_TOKEN>)"
    echo "  Replace placeholders with actual values"
fi

if grep -q "your_token\|your_password\|your username" "$MCP_CONFIG" 2>/dev/null; then
    print_status "warn" "Found generic credential values"
    echo "  Replace with actual tokens/credentials"
fi

# Check for trailing commas (common JSON error)
if grep -E ',\s*[\]}]' "$MCP_CONFIG" >/dev/null 2>&1; then
    print_status "warn" "Possible trailing commas found (may cause issues)"
fi

print_status "ok" "Configuration checks complete"
echo ""

# Check browser binaries for testing tools
echo -e "${BLUE}[7/8] Checking Browser Binaries...${NC}"

# Check Playwright browsers
if [ -d "$HOME/.cache/ms-playwright" ]; then
    if [ -d "$HOME/.cache/ms-playwright/chromium-"* ] 2>/dev/null; then
        print_status "ok" "Playwright Chromium installed"
    else
        print_status "warn" "Playwright Chromium not found. Run: npx playwright install chromium"
    fi
    
    if [ -d "$HOME/.cache/ms-playwright/firefox-"* ] 2>/dev/null; then
        print_status "ok" "Playwright Firefox installed"
    else
        print_status "warn" "Playwright Firefox not found. Run: npx playwright install firefox"
    fi
    
    if [ -d "$HOME/.cache/ms-playwright/webkit-"* ] 2>/dev/null; then
        print_status "ok" "Playwright WebKit installed"
    else
        print_status "warn" "Playwright WebKit not found. Run: npx playwright install webkit"
    fi
else
    print_status "info" "Playwright browsers not installed (optional)"
    echo "  Install if using Playwright: npx playwright install"
fi
echo ""

# Summary
echo -e "${BLUE}[8/8] Health Check Summary${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}✓ All checks passed!${NC}"
    echo "  Your MCP configuration is healthy and ready to use."
elif [ $ERRORS -eq 0 ]; then
    echo -e "${YELLOW}⚠ Configuration OK with ${WARNINGS} warning(s)${NC}"
    echo "  Your MCP configuration will work, but consider addressing warnings."
else
    echo -e "${RED}✗ Found ${ERRORS} error(s) and ${WARNINGS} warning(s)${NC}"
    echo "  Fix errors before using MCP servers."
    exit 1
fi

echo ""
echo -e "${BLUE}Next Steps:${NC}"
echo "  1. Restart your IDE (Cursor/VS Code)"
echo "  2. Check MCP status in IDE status bar"
echo "  3. Test with a simple prompt: 'Show MCP server status'"
echo ""
