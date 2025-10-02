# Minimal Alpine image with curl and MinIO Client (mc)
FROM alpine:latest

# Install curl, ca-certificates and remove cache to keep image small
RUN apk add --no-cache curl ca-certificates \
  && update-ca-certificates

# Download MinIO Client (mc) and make it executable
RUN curl -fsSL https://dl.min.io/client/mc/release/linux-amd64/mc -o /usr/local/bin/mc \
  && chmod +x /usr/local/bin/mc

# Verify tools (optional at build time)
RUN mc --version && curl --version

# Use a non-root user for runtime (optional but recommended)
RUN addgroup -S app && adduser -S -G app app
USER app
WORKDIR /home/app

ENTRYPOINT ["sh"]

