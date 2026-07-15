import {
  createDirectus,
  rest,
  readItems,
  readItem,
  readSingleton,
} from '@directus/sdk';

// ── Tipos de datos ────────────────────────────────────────────────────────────

export interface Noticia {
  id: string;
  titulo: string;
  slug: string;
  resumen: string;
  contenido: string;
  imagen_destacada: string | null;
  categoria: string | null;
  autor: string | null;
  estado: 'publicada' | 'borrador';
  fecha_publicacion: string;
  destacada: boolean;
  seo_title: string | null;
  seo_description: string | null;
}

export interface Edicion {
  id: string;
  numero: number;
  titulo: string;
  slug: string;
  descripcion: string;
  fecha_publicacion: string;
  anio: number;
  pdf_file: string;
  portada: string | null;
  estado: 'publicada' | 'oculta';
}

export interface PuntoVenta {
  id: string;
  nombre: string;
  direccion: string;
  latitud: number;
  longitud: number;
  tipo: 'libreria' | 'bar' | 'asociacion' | 'otro';
  horario: string | null;
  activo: boolean;
}

export interface RedSocial {
  id: string;
  plataforma: string;
  url: string;
  activa: boolean;
}

export interface ConfiguracionWeb {
  nombre_periodico: string;
  descripcion: string;
  logo: string | null;
  email: string;
  telefono: string | null;
  direccion: string | null;
}

export interface Pagina {
  id: string;
  slug: string;
  titulo: string;
  contenido: string;
  seo_title: string | null;
  seo_description: string | null;
}

interface Schema {
  noticias: Noticia[];
  ediciones: Edicion[];
  puntos_venta: PuntoVenta[];
  redes_sociales: RedSocial[];
  configuracion_web: ConfiguracionWeb;
  paginas: Pagina[];
}

// ── Cliente Directus ──────────────────────────────────────────────────────────

const DIRECTUS_URL = import.meta.env.PUBLIC_DIRECTUS_URL || 'http://directus:8055';

const client = createDirectus<Schema>(DIRECTUS_URL).with(rest());

// ── Helpers de imagen ─────────────────────────────────────────────────────────

export function getAssetUrl(fileId: string | null, params?: Record<string, string>): string | null {
  if (!fileId) return null;
  const base = `${DIRECTUS_URL}/assets/${fileId}`;
  if (!params) return base;
  const query = new URLSearchParams(params).toString();
  return `${base}?${query}`;
}

export function getImageUrl(fileId: string | null, width = 800, height?: number): string | null {
  if (!fileId) return null;
  const params: Record<string, string> = { width: String(width), format: 'webp', quality: '80' };
  if (height) params.height = String(height);
  return getAssetUrl(fileId, params);
}

// ── Funciones de consulta ─────────────────────────────────────────────────────

export async function getNoticias(limit = 10, offset = 0): Promise<Noticia[]> {
  return client.request(
    readItems('noticias', {
      filter: { estado: { _eq: 'publicada' } },
      sort: ['-fecha_publicacion'],
      limit,
      offset,
      fields: ['id', 'titulo', 'slug', 'resumen', 'imagen_destacada', 'fecha_publicacion', 'destacada', 'categoria'],
    })
  ) as Promise<Noticia[]>;
}

export async function getNoticiasDestacadas(): Promise<Noticia[]> {
  return client.request(
    readItems('noticias', {
      filter: { estado: { _eq: 'publicada' }, destacada: { _eq: true } },
      sort: ['-fecha_publicacion'],
      limit: 3,
      fields: ['id', 'titulo', 'slug', 'resumen', 'imagen_destacada', 'fecha_publicacion', 'categoria'],
    })
  ) as Promise<Noticia[]>;
}

export async function getNoticia(slug: string): Promise<Noticia | null> {
  const results = await client.request(
    readItems('noticias', {
      filter: { slug: { _eq: slug }, estado: { _eq: 'publicada' } },
      limit: 1,
      fields: ['*'],
    })
  ) as Noticia[];
  return results[0] ?? null;
}

export async function getEdiciones(anio?: number): Promise<Edicion[]> {
  const filter: Record<string, unknown> = { estado: { _eq: 'publicada' } };
  if (anio) filter.anio = { _eq: anio };
  return client.request(
    readItems('ediciones', {
      filter,
      sort: ['-fecha_publicacion'],
      fields: ['*'],
    })
  ) as Promise<Edicion[]>;
}

export async function getUltimaEdicion(): Promise<Edicion | null> {
  const results = await client.request(
    readItems('ediciones', {
      filter: { estado: { _eq: 'publicada' } },
      sort: ['-fecha_publicacion'],
      limit: 1,
      fields: ['*'],
    })
  ) as Edicion[];
  return results[0] ?? null;
}

export async function getPuntosVenta(): Promise<PuntoVenta[]> {
  return client.request(
    readItems('puntos_venta', {
      filter: { activo: { _eq: true } },
      fields: ['*'],
    })
  ) as Promise<PuntoVenta[]>;
}

export async function getRedesSociales(): Promise<RedSocial[]> {
  return client.request(
    readItems('redes_sociales', {
      filter: { activa: { _eq: true } },
      fields: ['*'],
    })
  ) as Promise<RedSocial[]>;
}

export async function getConfiguracion(): Promise<ConfiguracionWeb> {
  return client.request(readSingleton('configuracion_web', { fields: ['*'] })) as Promise<ConfiguracionWeb>;
}

export async function getPagina(slug: string): Promise<Pagina | null> {
  const results = await client.request(
    readItems('paginas', {
      filter: { slug: { _eq: slug } },
      limit: 1,
      fields: ['*'],
    })
  ) as Pagina[];
  return results[0] ?? null;
}

export async function getAniosEdiciones(): Promise<number[]> {
  const ediciones = await client.request(
    readItems('ediciones', {
      filter: { estado: { _eq: 'publicada' } },
      fields: ['anio'],
      sort: ['-anio'],
    })
  ) as { anio: number }[];
  return [...new Set(ediciones.map((e) => e.anio))];
}
