# Grab the latest alpine image
FROM python:3.13.0a2-alpine

# Install python and pip
RUN apk add --no-cache --update python3 py3-pip bash

# Add requirements file
ADD ./webapp/requirements.txt /tmp/requirements.txt

# Install dependencies
RUN pip3 install -r /tmp/requirements.txt

# Add application code
ADD ./webapp /opt/webapp/

# Set working directory
WORKDIR /opt/webapp

# Run the image as a non-root user
RUN adduser -D myuser
USER my
