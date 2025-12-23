FROM python:3.10-slim

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y \
    build-essential \
    default-libmysqlclient-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first
COPY requirements.txt .

# Install dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Ensure gunicorn exists even if requirements fails
RUN pip install gunicorn

COPY . .

COPY google_auth/settings.py /app/google_auth/settings.py

CMD ["gunicorn", "google_auth.wsgi:application", "--bind", "0.0.0.0:${PORT}", "--timeout", "120"]