#!/usr/bin/env sh

set -eu

if [ -z "${TELEGRAM_BOT_TOKEN:-}" ]; then
  echo "TELEGRAM_BOT_TOKEN is required" >&2
  exit 1
fi

if [ -z "${TELEGRAM_CHAT_ID:-}" ]; then
  echo "TELEGRAM_CHAT_ID is required" >&2
  exit 1
fi

message=$(cat <<EOF
hashcat crack notification
session: ${HASHCAT_HOOK_SESSION:-unknown}
hash: ${HASHCAT_HOOK_HASH:-}
plain: ${HASHCAT_HOOK_PLAIN:-}
plain_hex: ${HASHCAT_HOOK_PLAIN_HEX:-}
crackpos: ${HASHCAT_HOOK_CRACKPOS:-0}
output: ${HASHCAT_HOOK_OUTPUT:-}
EOF
)

curl -fsS \
  -X POST \
  "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
  --data-urlencode "chat_id=${TELEGRAM_CHAT_ID}" \
  --data-urlencode "text=${message}" \
  >/dev/null