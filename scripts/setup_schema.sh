#!/bin/bash
set -e
BASE="http://localhost:8055"

echo "Obteniendo token..."
TOKEN=$(curl -s -X POST "$BASE/auth/login" \
  -H "Content-Type: application/json" \
  -d '{"email":"lasaldeelpuerto@gmail.com","password":"Lasaldeelpuerto2026*"}' \
  | python3 -c 'import sys,json; print(json.load(sys.stdin)["data"]["access_token"])')
echo "Token OK"

col() {
  curl -s -X POST "$BASE/collections" \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $TOKEN" \
    -d "$1" > /dev/null
}

field() {
  curl -s -X POST "$BASE/fields/$1" \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $TOKEN" \
    -d "$2" > /dev/null
}

# ── noticias ──────────────────────────────────────────────────────────────────
echo "Creando: noticias"
col '{"collection":"noticias","schema":{},"meta":{"icon":"article"}}'
field "noticias" '{"field":"titulo","type":"string","schema":{"is_nullable":false},"meta":{"interface":"input","required":true}}'
field "noticias" '{"field":"slug","type":"string","schema":{"is_nullable":false},"meta":{"interface":"input","required":true}}'
field "noticias" '{"field":"resumen","type":"text","schema":{},"meta":{"interface":"input-multiline"}}'
field "noticias" '{"field":"contenido","type":"text","schema":{},"meta":{"interface":"input-rich-text-html"}}'
field "noticias" '{"field":"imagen_destacada","type":"uuid","schema":{},"meta":{"interface":"file-image","special":["file"]}}'
field "noticias" '{"field":"categoria","type":"string","schema":{},"meta":{"interface":"input"}}'
field "noticias" '{"field":"autor","type":"string","schema":{},"meta":{"interface":"input"}}'
field "noticias" '{"field":"estado","type":"string","schema":{"is_nullable":false,"default_value":"borrador"},"meta":{"interface":"select-dropdown","options":{"choices":[{"text":"Publicada","value":"publicada"},{"text":"Borrador","value":"borrador"}]},"required":true}}'
field "noticias" '{"field":"fecha_publicacion","type":"timestamp","schema":{},"meta":{"interface":"datetime"}}'
field "noticias" '{"field":"destacada","type":"boolean","schema":{"default_value":false},"meta":{"interface":"boolean"}}'
field "noticias" '{"field":"seo_title","type":"string","schema":{},"meta":{"interface":"input"}}'
field "noticias" '{"field":"seo_description","type":"text","schema":{},"meta":{"interface":"input-multiline"}}'

# ── ediciones ─────────────────────────────────────────────────────────────────
echo "Creando: ediciones"
col '{"collection":"ediciones","schema":{},"meta":{"icon":"newspaper"}}'
field "ediciones" '{"field":"numero","type":"integer","schema":{"is_nullable":false},"meta":{"interface":"input","required":true}}'
field "ediciones" '{"field":"titulo","type":"string","schema":{"is_nullable":false},"meta":{"interface":"input","required":true}}'
field "ediciones" '{"field":"slug","type":"string","schema":{"is_nullable":false},"meta":{"interface":"input","required":true}}'
field "ediciones" '{"field":"descripcion","type":"text","schema":{},"meta":{"interface":"input-multiline"}}'
field "ediciones" '{"field":"fecha_publicacion","type":"timestamp","schema":{},"meta":{"interface":"datetime"}}'
field "ediciones" '{"field":"anio","type":"integer","schema":{},"meta":{"interface":"input"}}'
field "ediciones" '{"field":"pdf_file","type":"uuid","schema":{},"meta":{"interface":"file","special":["file"]}}'
field "ediciones" '{"field":"portada","type":"uuid","schema":{},"meta":{"interface":"file-image","special":["file"]}}'
field "ediciones" '{"field":"estado","type":"string","schema":{"default_value":"publicada"},"meta":{"interface":"select-dropdown","options":{"choices":[{"text":"Publicada","value":"publicada"},{"text":"Oculta","value":"oculta"}]}}}'
field "ediciones" '{"field":"destacada","type":"boolean","schema":{"default_value":false},"meta":{"interface":"boolean"}}'

# ── puntos_venta ──────────────────────────────────────────────────────────────
echo "Creando: puntos_venta"
col '{"collection":"puntos_venta","schema":{},"meta":{"icon":"place"}}'
field "puntos_venta" '{"field":"nombre","type":"string","schema":{"is_nullable":false},"meta":{"interface":"input","required":true}}'
field "puntos_venta" '{"field":"direccion","type":"string","schema":{},"meta":{"interface":"input"}}'
field "puntos_venta" '{"field":"latitud","type":"float","schema":{},"meta":{"interface":"input"}}'
field "puntos_venta" '{"field":"longitud","type":"float","schema":{},"meta":{"interface":"input"}}'
field "puntos_venta" '{"field":"tipo","type":"string","schema":{},"meta":{"interface":"select-dropdown","options":{"choices":[{"text":"Librería","value":"libreria"},{"text":"Bar","value":"bar"},{"text":"Asociación","value":"asociacion"},{"text":"Otro","value":"otro"}]}}}'
field "puntos_venta" '{"field":"horario","type":"string","schema":{},"meta":{"interface":"input"}}'
field "puntos_venta" '{"field":"activo","type":"boolean","schema":{"default_value":true},"meta":{"interface":"boolean"}}'

# ── redes_sociales ────────────────────────────────────────────────────────────
echo "Creando: redes_sociales"
col '{"collection":"redes_sociales","schema":{},"meta":{"icon":"share"}}'
field "redes_sociales" '{"field":"plataforma","type":"string","schema":{"is_nullable":false},"meta":{"interface":"input","required":true}}'
field "redes_sociales" '{"field":"url","type":"string","schema":{"is_nullable":false},"meta":{"interface":"input","required":true}}'
field "redes_sociales" '{"field":"activa","type":"boolean","schema":{"default_value":true},"meta":{"interface":"boolean"}}'

# ── configuracion_web (singleton) ─────────────────────────────────────────────
echo "Creando: configuracion_web (singleton)"
col '{"collection":"configuracion_web","schema":{},"meta":{"icon":"settings","singleton":true}}'
field "configuracion_web" '{"field":"nombre_periodico","type":"string","schema":{},"meta":{"interface":"input"}}'
field "configuracion_web" '{"field":"descripcion","type":"text","schema":{},"meta":{"interface":"input-multiline"}}'
field "configuracion_web" '{"field":"logo","type":"uuid","schema":{},"meta":{"interface":"file-image","special":["file"]}}'
field "configuracion_web" '{"field":"email","type":"string","schema":{},"meta":{"interface":"input"}}'
field "configuracion_web" '{"field":"telefono","type":"string","schema":{},"meta":{"interface":"input"}}'
field "configuracion_web" '{"field":"direccion","type":"string","schema":{},"meta":{"interface":"input"}}'
field "configuracion_web" '{"field":"url_formulario_socio","type":"string","schema":{},"meta":{"interface":"input"}}'

# ── paginas ───────────────────────────────────────────────────────────────────
echo "Creando: paginas"
col '{"collection":"paginas","schema":{},"meta":{"icon":"page-layout-body"}}'
field "paginas" '{"field":"slug","type":"string","schema":{"is_nullable":false},"meta":{"interface":"input","required":true}}'
field "paginas" '{"field":"titulo","type":"string","schema":{"is_nullable":false},"meta":{"interface":"input","required":true}}'
field "paginas" '{"field":"contenido","type":"text","schema":{},"meta":{"interface":"input-rich-text-html"}}'
field "paginas" '{"field":"seo_title","type":"string","schema":{},"meta":{"interface":"input"}}'
field "paginas" '{"field":"seo_description","type":"text","schema":{},"meta":{"interface":"input-multiline"}}'

# ── Permisos públicos ─────────────────────────────────────────────────────────
echo "Buscando política pública..."
POLICY=$(curl -s "$BASE/policies?filter[name][_eq]=Public&fields=id" \
  -H "Authorization: Bearer $TOKEN" \
  | python3 -c 'import sys,json; d=json.load(sys.stdin); print(d["data"][0]["id"])')
echo "Policy ID: $POLICY"

for collection in noticias ediciones puntos_venta redes_sociales configuracion_web paginas; do
  curl -s -X POST "$BASE/permissions" \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $TOKEN" \
    -d "{\"policy\":\"$POLICY\",\"collection\":\"$collection\",\"action\":\"read\",\"fields\":[\"*\"],\"permissions\":{}}" > /dev/null
  echo "Permiso público: $collection"
done

echo ""
echo "¡Schema creado correctamente!"
