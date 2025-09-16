# ---- Stage 1: Build ----
FROM python:3.11-slim AS builder

# Ensure system is up to date and install build tools (minimal)
RUN apt-get update && apt-get install -y --no-install-recommends build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set work directory
WORKDIR /app

# Install Python dependencies separately for caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy source code
COPY . .

# ---- Stage 2: Runtime ----
FROM python:3.11-slim

WORKDIR /app

# Copy only needed artifacts from builder
COPY --from=builder /usr/local/lib/python3.11 /usr/local/lib/python3.11
COPY --from=builder /usr/local/bin /usr/local/bin
COPY . .

# Drop privileges (important for security scanning)
RUN useradd --create-home appuser
USER appuser

# Expose app port (change if needed)
EXPOSE 8080

# Default start command (adjust to your app)
CMD ["python", "app.py"]
