#!/bin/sh
# ============================================================
# Script de RESTAURACIÓN de backup
# Uso: sh restore.sh <archivo_backup.sql.gz>
# ============================================================

set -e

if [ -z "$1" ]; then
  echo "Uso: sh restore.sh <archivo_backup.sql.gz>"
  echo "Backups disponibles:"
  ls /backups/database/*.sql.gz 2>/dev/null || echo "  (ninguno)"
  exit 1
fi

BACKUP_FILE="$1"

if [ ! -f "$BACKUP_FILE" ]; then
  echo "Error: archivo no encontrado: $BACKUP_FILE"
  exit 1
fi

echo "[$(date)] Restaurando desde: $BACKUP_FILE"
echo "ATENCIÓN: Esto sobreescribirá la base de datos actual. Pulsa Ctrl+C para cancelar (5 segundos)..."
sleep 5

gunzip -c "$BACKUP_FILE" | PGPASSWORD="$POSTGRES_PASSWORD" psql \
  -h database \
  -U "$POSTGRES_USER" \
  -d "$POSTGRES_DB"

echo "[$(date)] Restauración completada."
