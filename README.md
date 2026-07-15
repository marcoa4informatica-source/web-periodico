# Periódico Local — Web oficial

Stack: **Astro** + **Directus CMS** + **PostgreSQL** + **Caddy** + **Docker Compose**

---

## Estructura del proyecto

```
periodico-local/
├── docker-compose.yml        Orquestación de servicios
├── .env.example              Plantilla de variables de entorno
├── frontend/                 Web pública (Astro + Tailwind)
│   ├── src/
│   │   ├── pages/            Rutas de la web
│   │   ├── components/       Header, Footer, NewsCard, EditionCard, Map
│   │   ├── layouts/          BaseLayout (SEO, fuentes, header/footer)
│   │   ├── lib/directus.ts   Cliente API + tipos TypeScript
│   │   └── styles/           CSS global
│   └── Dockerfile
├── cms/directus/             Extensiones de Directus (vacío inicial)
├── database/init/            SQL ejecutado al crear la BD por primera vez
├── backups/scripts/          backup.sh, restore.sh, cron-backup.sh
└── proxy/Caddyfile           Proxy inverso + HTTPS automático
```

---

## Puesta en marcha

### 1. Requisitos

- Docker Desktop (o Docker Engine + Docker Compose v2)
- Un dominio apuntando a la IP del servidor (para HTTPS en producción)

### 2. Configurar variables de entorno

```bash
cp .env.example .env
```

Edita `.env` y rellena:

| Variable | Descripción |
|---|---|
| `POSTGRES_PASSWORD` | Contraseña de la base de datos |
| `DIRECTUS_SECRET` | String largo aleatorio (genera con `openssl rand -base64 32`) |
| `DIRECTUS_ADMIN_EMAIL` | Email del administrador de Directus |
| `DIRECTUS_ADMIN_PASSWORD` | Contraseña del administrador de Directus |
| `PUBLIC_DIRECTUS_URL` | URL pública del CMS (ej. `https://cms.tudominio.es`) |
| `FRONTEND_URL` | URL pública de la web (ej. `https://tudominio.es`) |
| `DOMAIN` | Dominio principal (ej. `tudominio.es`) |
| `CMS_DOMAIN` | Subdominio del CMS (ej. `cms.tudominio.es`) |

### 3. Arrancar

```bash
docker compose up -d
```

La primera vez tarda unos minutos porque:
- Se construye el frontend de Astro
- Directus inicializa su schema en PostgreSQL

### 4. Acceder al panel admin

Abre en el navegador: `https://cms.tudominio.es`

Usa las credenciales que configuraste en `.env`.

---

## Configurar Directus (primera vez)

Una vez dentro del panel de Directus, crea estas colecciones:

### Colecciones necesarias

| Colección | Tipo |
|---|---|
| `noticias` | Normal |
| `ediciones` | Normal |
| `puntos_venta` | Normal |
| `redes_sociales` | Normal |
| `paginas` | Normal |
| `configuracion_web` | Singleton |

### Campos de `noticias`

| Campo | Tipo |
|---|---|
| `titulo` | String |
| `slug` | String (único) |
| `resumen` | Text |
| `contenido` | WYSIWYG |
| `imagen_destacada` | Imagen |
| `categoria` | String |
| `autor` | String |
| `estado` | Dropdown (`publicada`, `borrador`) |
| `fecha_publicacion` | DateTime |
| `destacada` | Boolean |
| `seo_title` | String |
| `seo_description` | String |

### Campos de `ediciones`

| Campo | Tipo |
|---|---|
| `numero` | Integer |
| `titulo` | String |
| `slug` | String (único) |
| `descripcion` | Text |
| `fecha_publicacion` | Date |
| `anio` | Integer |
| `pdf_file` | Archivo |
| `portada` | Imagen |
| `estado` | Dropdown (`publicada`, `oculta`) |

### Campos de `puntos_venta`

| Campo | Tipo |
|---|---|
| `nombre` | String |
| `direccion` | String |
| `latitud` | Decimal |
| `longitud` | Decimal |
| `descripcion` | Text |
| `horario` | String |
| `activo` | Boolean |

### Permisos de rol público

En **Settings → Roles → Public**, dar permiso de lectura (solo `read`) a:
- `noticias` (solo donde `estado = publicada`)
- `ediciones` (solo donde `estado = publicada`)
- `puntos_venta` (solo donde `activo = true`)
- `redes_sociales` (solo donde `activa = true`)
- `configuracion_web`
- `paginas`
- `directus_files` (para que los assets sean accesibles)

---

## Comandos útiles

```bash
# Ver logs de todos los servicios
docker compose logs -f

# Ver logs solo del frontend
docker compose logs -f frontend

# Ver logs solo del CMS
docker compose logs -f directus

# Reiniciar un servicio
docker compose restart frontend

# Parar todo
docker compose down

# Parar y eliminar volúmenes (¡borra los datos!)
docker compose down -v

# Hacer backup manual
docker compose exec backup sh /scripts/backup.sh

# Ver backups disponibles
docker compose exec backup ls /backups/database/

# Restaurar un backup
docker compose exec backup sh /scripts/restore.sh /backups/database/periodico_20260101_030000.sql.gz
```

---

## Actualizar Directus

```bash
# Actualiza la imagen de Directus a la última versión
docker compose pull directus
docker compose up -d directus
```

---

## Seguridad en producción

- [ ] `.env` con contraseñas fuertes y únicas
- [ ] HTTPS activo (Caddy lo gestiona automáticamente)
- [ ] Panel admin solo accesible por subdiminio propio
- [ ] Backups verificados (prueba una restauración)
- [ ] Firewall: solo puertos 80 y 443 expuestos
- [ ] `POSTGRES_PASSWORD` nunca en el repositorio
- [ ] Actualizaciones periódicas de imágenes Docker

---

## Secciones de la web

| Ruta | Descripción |
|---|---|
| `/` | Portada con últimas noticias y última edición |
| `/noticias` | Listado de noticias con paginación |
| `/noticias/:slug` | Detalle de noticia |
| `/archivo` | Archivo de ediciones PDF (con filtro por año) |
| `/acerca` | Página editable desde el CMS |
| `/hazte-socio` | Página editable desde el CMS |
| `/encuentranos` | Mapa interactivo con puntos de venta |
| `/aviso-legal` | Página editable desde el CMS |
| `/privacidad` | Página editable desde el CMS |
