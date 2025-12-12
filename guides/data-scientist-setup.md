# Data Scientist MCP Quick Start Guide

## 🎯 Overview

This guide helps data scientists set up MCP servers optimized for data analysis, statistical computing, database queries, and collaborative data science workflows.

---

## ⚡ Quick Setup (5 minutes)

### Recommended Servers for Data Science

Enable only these servers for optimal performance:

```json
{
  "servers": {
    "ds-toolkit": {
      "command": "uvx",
      "args": ["mcp-ds-toolkit-server"],
      "type": "stdio",
      "timeout": 300
    },
    "postgres": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres", "postgresql://user:password@localhost:5432/data_warehouse"],
      "type": "stdio",
      "timeout": 120
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
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/path/to/datasets",
        "/path/to/notebooks",
        "/path/to/models"
      ],
      "type": "stdio"
    },
    "kroki": {
      "command": "npx",
      "args": ["-y", "@tkoba1974/mcp-kroki"],
      "type": "stdio"
    }
  }
}
```

**Total Tools**: ~50-60 (well under the 80 tool limit for Cursor)

---

## 🛠️ Essential Tools & Use Cases

### 1. DS Toolkit - Data Science Operations
**What it does**: AI-assisted data analysis, statistical operations, pandas/numpy integration

**Common Tasks**:
- "Analyze this CSV file and provide summary statistics"
- "Calculate correlation matrix for all numeric columns"
- "Perform hypothesis testing: is the mean significantly different?"
- "Generate box plots for outlier detection"
- "Clean missing values using mean imputation"
- "Perform feature engineering on this dataset"

**Why you need it**: Streamlined data analysis without context switching.

---

### 2. PostgreSQL - Data Warehouse Access
**What it does**: Query large datasets, perform complex aggregations, inspect schemas

**Common Tasks**:
- "Query sales data for Q4 2024 grouped by region"
- "Calculate moving average of user signups over 30 days"
- "Join customer and transaction tables to analyze purchase patterns"
- "Identify data quality issues in the products table"
- "Export query results to CSV for analysis"
- "Optimize slow-running analytics queries"

**Why you need it**: Direct access to data warehouses and production databases.

---

### 3. Redis - Data Caching & Real-time Data
**What it does**: Access cached datasets, real-time metrics, and temporary computations

**Common Tasks**:
- "Retrieve cached model predictions from Redis"
- "Store intermediate computation results for later use"
- "Access real-time streaming data from Redis"
- "Check cache hit rates for model serving"
- "Manage feature store data in Redis"

**Why you need it**: Fast access to cached and real-time data.

---

### 4. Filesystem - Dataset & Model Management
**What it does**: Access datasets, notebooks, trained models, and research papers

**Common Tasks**:
- "Load training data from /datasets/customer_churn.csv"
- "Compare model performance metrics from different experiment runs"
- "Read preprocessing pipeline from /notebooks/data_prep.ipynb"
- "Access pre-trained model weights from /models/bert-base"
- "Review feature engineering code from previous projects"

**Why you need it**: Manage multiple datasets and model artifacts.

---

### 5. Kroki - Diagram Generation
**What it does**: Create visualizations for data pipelines, workflows, and architectures

**Common Tasks**:
- "Generate flowchart for data preprocessing pipeline"
- "Create ER diagram for data warehouse schema"
- "Visualize ML pipeline from data ingestion to deployment"
- "Generate state diagram for A/B test workflow"
- "Create Sankey diagram for data flow analysis"

**Why you need it**: Document data workflows and architectures visually.

---

### 6. GitHub - Version Control & Collaboration
**What it does**: Manage notebooks, code, and collaborate with team

**Common Tasks**:
- "Show recent commits to the ML models repository"
- "Review PR for new feature engineering pipeline"
- "Search for similar data preprocessing code in organization repos"
- "Track changes to model training scripts"
- "Link experiment results to GitHub issues"

**Why you need it**: Version control for data science projects.

---

## 🚀 Common Data Science Workflows

### Workflow 1: Exploratory Data Analysis (EDA)
```
1. "Load dataset from /datasets/sales_data.csv using Filesystem"
2. "Perform EDA with DS Toolkit:"
   - Summary statistics
   - Missing value analysis
   - Distribution plots
   - Correlation matrix
3. "Identify outliers and anomalies"
4. "Generate insights report"
5. "Create data quality documentation with Kroki diagrams"
```

### Workflow 2: Feature Engineering
```
1. "Query raw data from PostgreSQL"
2. "Analyze feature distributions with DS Toolkit"
3. "Create new features:"
   - Aggregations
   - Time-based features
   - Interaction terms
4. "Store processed features in Redis for quick access"
5. "Save feature engineering code to GitHub"
```

### Workflow 3: Model Training Pipeline
```
1. "Load training data from PostgreSQL"
2. "Perform train-test split with DS Toolkit"
3. "Check if preprocessed features exist in Redis cache"
4. "Train model and evaluate metrics"
5. "Save model to /models/ via Filesystem"
6. "Document pipeline with Kroki diagram"
7. "Commit training code to GitHub"
```

### Workflow 4: Production Data Analysis
```
1. "Query production metrics from PostgreSQL"
2. "Analyze prediction distributions with DS Toolkit"
3. "Compare with baseline statistics"
4. "Identify data drift or anomalies"
5. "Check model prediction cache in Redis"
6. "Generate alert report"
```

### Workflow 5: Experiment Comparison
```
1. "Load experiment results from Filesystem"
2. "Calculate statistical significance with DS Toolkit"
3. "Compare model performance metrics"
4. "Visualize results (ROC curves, confusion matrices)"
5. "Document findings in GitHub issue"
6. "Create comparison report with Kroki diagrams"
```

### Workflow 6: Data Pipeline Documentation
```
1. "Map data flow from source to model with Kroki"
2. "Document database schema with ER diagrams"
3. "Create pipeline architecture diagram"
4. "Add documentation to GitHub repository"
5. "Link diagrams to technical specifications"
```

---

## 🎯 Analysis Examples

### Example 1: Statistical Analysis
Prompt:
> "Load /datasets/ab_test_results.csv, perform t-test to compare conversion rates between control and treatment groups. Calculate effect size and confidence intervals. Generate visualization."

### Example 2: Data Quality Check
Prompt:
> "Query the user_events table from PostgreSQL. Analyze missing values, check for duplicates, identify outliers in the timestamp column, and suggest data cleaning steps."

### Example 3: Correlation Analysis
Prompt:
> "Load sales data from PostgreSQL, calculate Pearson correlation between all numeric features and the target variable 'revenue'. Identify top 5 most correlated features and create a heatmap."

### Example 4: Time Series Analysis
Prompt:
> "Query daily active users from PostgreSQL for the last 90 days. Calculate moving averages (7-day and 30-day), detect anomalies, and forecast the next 7 days using simple exponential smoothing."

### Example 5: Feature Distribution
Prompt:
> "Analyze the distribution of the 'age' column in /datasets/customers.csv. Generate histogram, box plot, and Q-Q plot. Test for normality. Suggest appropriate transformation if needed."

---

## ⚠️ Servers to DISABLE for Data Science Work

Disable these to save resources and stay under tool limits:

```json
"playwright": { "disabled": true },
"puppeteer": { "disabled": true },
"lighthouse": { "disabled": true },
"chrome-devtools": { "disabled": true },
"vitest": { "disabled": true },
"supabase": { "disabled": true },
"awslabs.aws-diagram-mcp-server": { "disabled": true },
"MCP_DOCKER": { "disabled": true },
"sequentialThinking": { "disabled": true }
```

---

## 📊 Performance Tips

1. **Tool Count**: With recommended setup, you'll have ~50-60 tools (comfortable for Cursor)
2. **Timeout Settings**: 
   - DS Toolkit: 300s (5 min) for large dataset operations
   - PostgreSQL: 120s (2 min) for complex queries
   - Redis: 60s (default is fine)
3. **Memory Usage**:
   - DS Toolkit can use significant memory for large datasets
   - Cache preprocessed data in Redis for faster iterations
   - Use database queries to filter data before loading into memory
4. **Data Size Limits**:
   - Load samples for exploration, full data for training
   - Use pagination for large query results
   - Stream large files instead of loading entirely

---

## 🔧 Prerequisites

### 1. Python & Data Science Libraries
```bash
# Check Python version (3.8+ required)
python --version

# Install UV package manager
pip install uv

# DS Toolkit will auto-install pandas, numpy, matplotlib, seaborn, scipy
# But you can pre-install:
pip install pandas numpy matplotlib seaborn scipy scikit-learn
```

### 2. PostgreSQL
```bash
# Ubuntu/Debian
sudo apt install postgresql postgresql-contrib

# macOS
brew install postgresql

# Start service
sudo service postgresql start  # Linux
brew services start postgresql  # macOS
```

### 3. Redis
```bash
# Ubuntu/Debian
sudo apt install redis-server

# macOS
brew install redis

# Start service
sudo service redis-server start  # Linux
brew services start redis        # macOS
```

### 4. Node.js (for GitHub and Kroki)
```bash
# Check version
node --version  # Should be v16+

# Install if needed
# Ubuntu: sudo apt install nodejs npm
# macOS: brew install node
```

---

## 🔍 Troubleshooting

### "uvx not found"
```bash
# Install UV
pip install uv
# or
curl -LsSf https://astral.sh/uv/install.sh | sh
```

### "Module not found" (pandas, numpy, etc.)
```bash
# Install manually
pip install pandas numpy matplotlib seaborn scipy scikit-learn statsmodels
```

### "Connection refused" (PostgreSQL)
```bash
# Check if PostgreSQL is running
sudo service postgresql status

# Verify connection string
postgresql://username:password@localhost:5432/database
```

### "Out of memory" with large datasets
- Use pandas chunks: `pd.read_csv('file.csv', chunksize=10000)`
- Query only needed columns from PostgreSQL
- Use sampling for exploration
- Increase system swap space

### Slow query performance
```
1. "Analyze query execution plan in PostgreSQL"
2. "Check if indexes exist on filtered columns"
3. "Optimize joins and aggregations"
4. "Consider materializing intermediate results"
```

---

## 📚 Common Data Science Operations

### Statistical Tests
- **T-test**: "Perform independent t-test comparing groups A and B"
- **Chi-square**: "Test independence between categorical variables X and Y"
- **ANOVA**: "Compare means across multiple groups with one-way ANOVA"
- **Normality test**: "Test if this distribution is normal using Shapiro-Wilk"

### Data Transformations
- **Scaling**: "Standardize all numeric columns using z-score normalization"
- **Encoding**: "One-hot encode categorical variables"
- **Imputation**: "Fill missing values with median for numeric, mode for categorical"
- **Binning**: "Create age groups: 0-18, 19-35, 36-50, 51+"

### Visualization
- **Distribution**: "Create histogram and KDE plot for revenue distribution"
- **Relationships**: "Generate scatter plot matrix for all numeric features"
- **Time series**: "Plot daily sales with trend line and confidence intervals"
- **Categorical**: "Create bar chart showing count by category with percentages"

---

## 🎓 Learning Resources

- [Pandas Documentation](https://pandas.pydata.org/docs/)
- [NumPy Documentation](https://numpy.org/doc/)
- [Scikit-learn User Guide](https://scikit-learn.org/stable/user_guide.html)
- [Statistical Methods in Python](https://docs.scipy.org/doc/scipy/tutorial/stats.html)
- [PostgreSQL Performance Tips](https://wiki.postgresql.org/wiki/Performance_Optimization)

---

## 🔐 Security Best Practices

1. **Never commit credentials**:
   ```bash
   # .env file
   DATABASE_URL=postgresql://user:pass@localhost:5432/warehouse
   REDIS_URL=redis://localhost:6379
   ```

2. **Use read-only database users** for analysis:
   ```sql
   CREATE USER analyst WITH PASSWORD 'secure_password';
   GRANT CONNECT ON DATABASE warehouse TO analyst;
   GRANT SELECT ON ALL TABLES IN SCHEMA public TO analyst;
   ```

3. **Anonymize sensitive data** before analysis
4. **Don't store API keys** in notebooks - use environment variables

---

**Last Updated**: December 12, 2025  
**Optimized For**: Python data science, SQL analytics, statistical computing, and ML workflows
