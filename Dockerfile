# Use a Python image instead of base Alpine
FROM python:3.10-slim

# Install necessary system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    libffi-dev \
    python3-dev \
    build-essential \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Add the requirements file and install Python dependencies
ADD ./webapp/requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt

# Add the application code
ADD ./webapp /opt/webapp/
WORKDIR /opt/webapp

# Create and switch to a non-root user
RUN useradd -m myuser
USER myuser

# Run the application
CMD gunicorn --bind 0.0.0.0:$PORT app:app
