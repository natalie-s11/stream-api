# Slim Python 3.13 base image
FROM python:3.13-slim

# Don't write .pyc files; flush stdout/stderr immediately so logs show up in `docker logs`
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Install dependencies first so this layer is cached between code changes
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the producer script
COPY wikipedia-producer.py .

# Override at runtime, e.g. -e KAFKA_BROKER=kafka1:9092
ENV KAFKA_BROKER="127.0.0.1:19092,127.0.0.1:29092,127.0.0.1:39092"

ENTRYPOINT ["python", "wikipedia-producer.py"]
