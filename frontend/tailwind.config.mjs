/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
  theme: {
    extend: {
      colors: {
        primary: {
          50:  '#fafafa',
          100: '#f0f0f0',
          200: '#d9d9d9',
          300: '#bfbfbf',
          400: '#8c8c8c',
          500: '#595959',
          600: '#333333',
          700: '#1a1a1a',
          800: '#111111',
          900: '#000000',
        },
        accent: {
          DEFAULT: '#ffde59',
          light:   '#fff8d6',
          dark:    '#e6c800',
        },
        neutral: {
          50:  '#fafafa',
          100: '#f5f5f5',
          200: '#e5e5e5',
          300: '#d4d4d4',
          400: '#a3a3a3',
          500: '#737373',
          600: '#525252',
          700: '#404040',
          800: '#262626',
          900: '#171717',
        },
      },
      fontFamily: {
        display:  ['"Bebas Neue"', 'Impact', 'sans-serif'],
        heading:  ['"Montserrat"', 'system-ui', 'sans-serif'],
        sans:     ['"Source Sans 3"', 'system-ui', 'sans-serif'],
        serif:    ['"Montserrat"', 'Georgia', 'serif'],
      },
    },
  },
  plugins: [
    require('@tailwindcss/typography'),
  ],
};
