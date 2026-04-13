FROM jc21/nginx-proxy-manager:latest

USER root

# Copy custom certs into the system trust store path.
COPY certs/ /usr/local/share/ca-certificates/custom/

# Support both Debian/Ubuntu and RHEL-style cert update commands.
RUN if command -v update-ca-certificates >/dev/null 2>&1; then \
      update-ca-certificates; \
    elif command -v update-ca-trust >/dev/null 2>&1; then \
      update-ca-trust; \
    else \
      echo "No CA update tool found; certs copied but trust store not updated."; \
    fi

USER root
