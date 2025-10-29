#!/usr/bin/env bash
set -euo pipefail

API="${API:-https://<id>.execute-api.<region>.amazonaws.com/prod}"
IMG="${IMG:-./foto.jpg}"

echo "[1] Solicitar URL prefirmado..."
RESP=$(curl -s -X POST "$API/upload")
URL=$(echo "$RESP" | python -c 'import sys,json; print(json.load(sys.stdin)["upload_url"])')
KEY=$(echo "$RESP" | python -c 'import sys,json; print(json.load(sys.stdin)["object_key"])')
echo "  KEY=$KEY"

echo "[2] Subir imagen via PUT..."
curl -s -X PUT -H "Content-Type: image/jpeg" --upload-file "$IMG" "$URL" >/dev/null
echo "  Subida OK"

echo "[3] Listar /metadata"
curl -s "$API/metadata" | jq . | head -n 40

echo "[4] Detalle /metadata/$KEY"
curl -s "$API/metadata/$KEY" | jq .

echo "[5] Eliminar /metadata/$KEY"
curl -i -X DELETE "$API/metadata/$KEY" | head -n 1
