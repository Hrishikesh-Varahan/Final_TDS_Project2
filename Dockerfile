# Use Python 3.12 slim image as base
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

RUN chmod +x entrypoint.sh

ENV PORT=8000
EXPOSE 8000

# This is important: use 'sh -c' so $PORT expands
CMD sh -c "uvicorn app:app --host 0.0.0.0 --port ${PORT:-8000}"

