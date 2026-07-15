#!/bin/sh
# ============================================================
# Script de backup del periódico local
# Hace copia de la base de datos PostgreSQL y de los uploads
# ============================================================

set -e

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR="/backups"
DB_BACKUP_DIR="$BACKUP_DIR/database"
UPLOADS_BACKUP_DIR="$BACKUP_DIR/uploads"
RETENTION_DAYS="${BACKUP_RETENTION_DAYS:-30}"

mkdir -p "$DB_BACKUP_DIR" "$UPLOADS_BACKUP_DIR"

echo "[$(date)] Iniciando backup..."

# --- Backup de base de datos ---
DB_FILE="$DB_BACKUP_DIR/periodico_${TIMESTAMP}.sql.gz"
PGPASSWORD="$POSTGRES_PASSWORD" pg_dump \
  -h database \
  -U "$POSTGRES_USER" \
  -d "$POSTGRES_DB" \
  --no-owner \
  --no-acl \
  | gzip > "$DB_FILE"

echo "[$(date)] Base de datos guardada: $DB_FILE"

# --- Backup de uploads (PDFs e imágenes) ---
UPLOADS_FILE="$UPLOADS_BACKUP_DIR/uploads_${TIMESTAMP}.tar.gz"
if [ -d "/uploads" ] && [ "$(ls -A /uploads 2>/dev/null)" ]; then
  tar -czf "$UPLOADS_FILE" -C /uploads .
  echo "[$(date)] Uploads guardados: $UPLOADS_FILE"
else
  echo "[$(date)] No hay uploads para respaldar."
fi

# --- Eliminar backups antiguos ---
find "$DB_BACKUP_DIR" -name "*.sql.gz" -mtime +${RETENTION_DAYS} -delete
find "$UPLOADS_BACKUP_DIR" -name "*.tar.gz" -mtime +${RETENTION_DAYS} -delete
echo "[$(date)] Backups de más de ${RETENTION_DAYS} días eliminados."

echo "[$(date)] Backup completado correctamente."
