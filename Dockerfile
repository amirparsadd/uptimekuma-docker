# --------------------------------------------------------
# Stage 1: Build healthcheck (Go)
# --------------------------------------------------------
FROM louislam/uptime-kuma:builder-go AS build_healthcheck

# --------------------------------------------------------
# Stage 2: Build main app (Node.js)
# --------------------------------------------------------
FROM louislam/uptime-kuma:base2 AS build
USER node
WORKDIR /app

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=1

# Install dependencies
COPY --chown=node:node package*.json ./
RUN npm ci --omit=dev --legacy-peer-deps

# Copy app source and healthcheck
COPY --chown=node:node . .
COPY --from=build_healthcheck /app/extra/healthcheck /app/extra/healthcheck

RUN mkdir ./data

# --------------------------------------------------------
# Stage 3: Final runtime image
# --------------------------------------------------------
FROM louislam/uptime-kuma:base2 AS release
WORKDIR /app
USER node

LABEL org.opencontainers.image.source="https://github.com/amirparsadd/uptimekuma-docker"
ENV UPTIME_KUMA_IS_CONTAINER=1

# Copy built app
COPY --from=build /app /app

EXPOSE 3001
HEALTHCHECK --interval=60s --timeout=30s --start-period=180s --retries=5 CMD extra/healthcheck
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["node", "server/server.js"]