-- ============================================================
-- Schema inicial del periódico local
-- Directus gestiona su propio schema automáticamente.
-- Este archivo pre-crea extensiones útiles y configura la BD.
-- ============================================================

-- Habilitar extensión para UUIDs (útil aunque Directus lo gestiona)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Configuración de zona horaria
SET timezone = 'Europe/Madrid';

-- Crear esquema adicional para utilidades si fuera necesario
-- (Directus usa el esquema public por defecto)

-- Mensaje de confirmación
DO $$
BEGIN
  RAISE NOTICE 'Base de datos del periódico inicializada correctamente.';
END $$;
