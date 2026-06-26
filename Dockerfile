# =============================================================================
# Railway Template: Stirling-PDF
# Official Docker image: https://hub.docker.com/r/stirlingtools/stirling-pdf
# GitHub: https://github.com/Stirling-Tools/Stirling-PDF
# License: MIT (core) / Open-core with paid enterprise features
# =============================================================================

# Use the official latest image for the full-featured version
# Stirling-PDF includes authentication and enterprise features by default
# in Docker images (except ultra-lite variant)
FROM docker.io/stirlingtools/stirling-pdf:2.13.2

# ---------------------------------------------------------------------------
# Railway Health Check
# Stirling-PDF exposes status at /api/v1/info/status
# ---------------------------------------------------------------------------
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:${PORT:-8080}/api/v1/info/status || exit 1

# ---------------------------------------------------------------------------
# Port Configuration — Railway V2 sets PORT; Stirling-PDF reads PORT.
# Spring Boot is configured to respect the PORT environment variable.
# Default internal port is 8080.
# ---------------------------------------------------------------------------
ENV PORT=8080 \
    TZ=UTC

# ---------------------------------------------------------------------------
# Security defaults for Railway deployment
# By default, authentication is enabled. Disable by setting:
#   SECURITY_ENABLELOGIN=false
# ---------------------------------------------------------------------------
ENV DISABLE_ADDITIONAL_FEATURES=false

# ---------------------------------------------------------------------------
# Port exposed by Stirling-PDF
# ---------------------------------------------------------------------------
EXPOSE 8080
