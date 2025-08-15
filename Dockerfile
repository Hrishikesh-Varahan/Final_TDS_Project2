FROM python:3.12-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Railway will set PORT automatically
EXPOSE 8000

# Use sh -c so ${PORT} gets expanded before uvicorn runs
CMD sh -c "uvicorn api.index:app --host 0.0.0.0 --port ${PORT:-8000}"
