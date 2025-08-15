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

# Railway will assign $PORT automatically
EXPOSE 8000

# Expand ${PORT} before running uvicorn
CMD sh -c "uvicorn app:app --host 0.0.0.0 --port ${PORT:-8000}"
