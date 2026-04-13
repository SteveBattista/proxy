FROM nginx:alpine

ARG SITE_NAME=example.local
ARG SITE_TYPE=generic

# Install system CA tools and trust any certificates provided in ./certs.
RUN apk add --no-cache ca-certificates
COPY certs/ /usr/local/share/ca-certificates/custom/
RUN update-ca-certificates || true

# Generate a themed landing page based on SITE_TYPE.
COPY docker/website/generate-index.sh /usr/local/bin/generate-index.sh
RUN chmod +x /usr/local/bin/generate-index.sh && \
    SITE_NAME="$SITE_NAME" SITE_TYPE="$SITE_TYPE" /usr/local/bin/generate-index.sh
