cat > Dockerfile <<'EOF'
FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates wget unzip gettext-base procps \
    && rm -rf /var/lib/apt/lists/*

RUN wget -qO /tmp/v2ray.zip "https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip" \
    && unzip /tmp/v2ray.zip -d /tmp/v2ray \
    && mkdir -p /usr/local/bin/v2ray /etc/v2ray \
    && mv /tmp/v2ray/* /usr/local/bin/v2ray/ || true \
    && chmod +x /usr/local/bin/v2ray/v2ray /usr/local/bin/v2ray/v2ctl

COPY bazar-artin.json.tpl /etc/v2ray/bazar-artin.json.tpl
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENV PORT=10000
EXPOSE 10000

ENTRYPOINT ["/entrypoint.sh"]
EOF
