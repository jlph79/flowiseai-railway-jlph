FROM node:18-alpine

USER root

RUN apk add --no-cache git
RUN apk add --no-cache python3 py3-pip make g++
# needed for pdfjs-dist
RUN apk add --no-cache build-base cairo-dev pango-dev

# Install Chromium
RUN apk add --no-cache chromium

ENV PUPPETEER_SKIP_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Create necessary directories and set permissions
RUN mkdir -p /data/.flowise/logs && \
    chmod -R 777 /data/.flowise

# You can install a specific version like: flowise@1.0.0
RUN npm install -g flowise

WORKDIR /data

# Set environment variables
ENV PORT=80
ENV DATABASE_PATH=/data/.flowise
ENV APIKEY_PATH=/data/.flowise
ENV SECRETKEY_PATH=/data/.flowise
ENV LOG_PATH=/data/.flowise/logs

# Expose the specified port
EXPOSE ${PORT}

# Start the application with a delay
CMD /bin/sh -c "sleep 3; flowise start"
