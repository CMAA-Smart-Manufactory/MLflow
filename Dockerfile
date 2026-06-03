FROM python:3.11-slim

RUN apt-get update && apt-get install -y \
    gcc \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN pip install --no-cache-dir \
    mlflow==3.* \
    psycopg2-binary \
    boto3 \
    gunicorn

EXPOSE 5000

CMD sh -c "mlflow server \
    --backend-store-uri ${BACKEND_STORE_URI} \
    --default-artifact-root ${ARTIFACT_ROOT} \
    --host 0.0.0.0 \
    --port 5000 \
    --allowed-hosts '*'"
