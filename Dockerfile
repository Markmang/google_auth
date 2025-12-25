FROM python:3.10.11

WORKDIR /app

# Prevent Python from writing pyc files and enable unbuffered output
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install system dependencies for PostgreSQL and build tools
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Copy and install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Ensure gunicorn exists even if requirements fails
RUN pip install gunicorn

# Copy project code
COPY . .

# Copy settings explicitly if needed
COPY google_auth/settings.py /app/google_auth/settings.py

# Run migrations, create superuser, and start gunicorn
CMD sh -c "python manage.py migrate && \
           python manage.py createadmin && \
           gunicorn google_auth.wsgi:application --bind 0.0.0.0:${PORT:-8000} --timeout 120"
