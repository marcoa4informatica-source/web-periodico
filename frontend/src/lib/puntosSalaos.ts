export interface PuntoSalao {
  nombre: string;
  direccion: string;
  latitud: number;
  longitud: number;
  tipo: 'libreria' | 'bar' | 'asociacion' | 'otro';
  horario?: string;
}

export const PUNTOS_SALAOS: PuntoSalao[] = [
  // — Bares y Cafeterías —
  {
    nombre: 'Bar Ca Ana (En Ká Ana)',
    direccion: 'C/ Serafín Álvarez Campana, 5 (El Juncal)',
    latitud: 36.6053724,
    longitud: -6.2326241,
    tipo: 'bar',
  },
  {
    nombre: 'Bar Gonzalo',
    direccion: 'Av. Micaela Aramburu de Mora, 26',
    latitud: 36.5954260,
    longitud: -6.2265610,
    tipo: 'bar',
  },
  {
    nombre: 'Bar La Herrería',
    direccion: 'Plaza de la Herrería, 2',
    latitud: 36.5989065,
    longitud: -6.2240865,
    tipo: 'bar',
  },
  {
    nombre: 'Bar La Manduca',
    direccion: 'Av. de la Libertad, s/n (CC Carrefour Market)',
    latitud: 36.5946605,
    longitud: -6.2456811,
    tipo: 'bar',
  },
  {
    nombre: 'Niñas de Gonzalo',
    direccion: 'C/ Rodrigo de Bastidas esq. C/ Jorge Juan, 19',
    latitud: 36.5951371,
    longitud: -6.2453078,
    tipo: 'bar',
  },

  // — Librerías y Papelerías —
  {
    nombre: 'Librería Amadeus',
    direccion: 'C/ Pintor Juan Miguel Sánchez Fernández, 1Acc',
    latitud: 36.5934593,
    longitud: -6.2399838,
    tipo: 'libreria',
  },
  {
    nombre: 'Librería Arion',
    direccion: 'C/ Arión, 1, Local 7',
    latitud: 36.5931783,
    longitud: -6.2418720,
    tipo: 'libreria',
  },
  {
    nombre: 'Librería Cassiopea',
    direccion: 'Av. de la Libertad, 26, Local 13',
    latitud: 36.5949589,
    longitud: -6.2444950,
    tipo: 'libreria',
  },
  {
    nombre: 'Librería Ferla',
    direccion: 'C/ San Bartolomé, 21',
    latitud: 36.5970781,
    longitud: -6.2299247,
    tipo: 'libreria',
  },
  {
    nombre: 'Librería María Zambrano',
    direccion: 'Av. de la Paz, 36',
    latitud: 36.5828718,
    longitud: -6.2201411,
    tipo: 'libreria',
  },
  {
    nombre: 'Librería Zorba',
    direccion: 'C/ Virgen de los Milagros, 84',
    latitud: 36.5973730,
    longitud: -6.2270599,
    tipo: 'libreria',
  },
  {
    nombre: 'Librería Papelería El Tejar',
    direccion: 'Av. El Tejar, 22',
    latitud: 36.6098012,
    longitud: -6.2152322,
    tipo: 'libreria',
  },
  {
    nombre: 'Papelería El Plumier',
    direccion: 'C/ Luis Suárez Rodríguez, Local 3 (Residencial Bahía Golf)',
    latitud: 36.6055243,
    longitud: -6.2329312,
    tipo: 'libreria',
  },

  // — Asociaciones y Sedes —
  {
    nombre: 'Asociación Vecinal Altos de la Bahía',
    direccion: 'C/ Trilla, 20',
    latitud: 36.6259238,
    longitud: -6.2112767,
    tipo: 'asociacion',
  },
  {
    nombre: 'Sede Ecologistas en Acción',
    direccion: 'C/ Misericordia, 31 (Edif. San Agustín)',
    latitud: 36.5986698,
    longitud: -6.2246945,
    tipo: 'asociacion',
  },
  {
    nombre: 'Sede de la FLAVE',
    direccion: 'Plaza Dr. Jaime San Narciso, s/n',
    latitud: 36.5944650,
    longitud: -6.2428303,
    tipo: 'asociacion',
  },

  // — Otros —
  {
    nombre: 'Suinbasa',
    direccion: 'C/ Los Toreros, 12-14-16',
    latitud: 36.5968,
    longitud: -6.2375,
    tipo: 'otro',
  },
];
