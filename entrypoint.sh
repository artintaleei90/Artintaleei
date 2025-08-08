cat > entrypoint.sh <<'EOF'
#!/usr/bin/env bash
set -e

: ${PORT:=10000}
export PORT

echo "[entrypoint] using PORT=$PORT"

envsubst < /etc/v2ray/bazar-artin.json.tpl > /etc/v2ray/config.json

exec /usr/local/bin/v2ray/v2ray -config /etc/v2ray/config.json
EOF

chmod +x entrypoint.sh
