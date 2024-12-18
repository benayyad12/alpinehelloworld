# Use a Python-specific Alpine base image
FROM python:3.10-alpine

# Install dependencies and required build tools
RUN apk add --no-cache --update \
    bash \
    gcc \
    musl-dev \
    libffi-dev \
    python3-dev \
    py3-pip

# Add requirements.txt and install Python dependencies
ADD ./webapp/requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt

# Add the application code
ADD ./webapp /opt/webapp/
WORKDIR /opt/webapp

# Create and switch to a non-root user
RUN adduser -D myuser
USER myuser

# Run the application
CMD gunicorn --bind 0.0.0.0:$PORT app:app
