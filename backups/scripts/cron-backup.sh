#!/bin/sh
# ============================================================
# Entrypoint del contenedor de backup
# Ejecuta backup diario a las 3:00 AM usando un bucle con sleep
# ============================================================

echo "[$(date)] Servicio de backup iniciado."

# Ejecutar backup inicial al arrancar (para verificar que funciona)
sleep 30
sh /scripts/backup.sh

# Bucle: backup cada 24 horas
while true; do
  sleep 86400
  sh /scripts/backup.sh
done
