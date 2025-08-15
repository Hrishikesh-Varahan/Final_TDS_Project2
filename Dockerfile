# Use Python 3.12 slim image as base
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements file
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy all application files
COPY . .

# Make entrypoint script executable
RUN chmod +x entrypoint.sh

# Use the port provided by Railway (default to 8000 locally)
ENV PORT=8000

# Expose port (optional for Railway, but good for local dev)
EXPOSE $PORT

# Command to run the application
CMD ["./entrypoint.sh"]
