FROM node:22-alpine AS builder

WORKDIR /app
COPY package.json ./
RUN npm install --frozen-lockfile 2>/dev/null || npm install

ARG PUBLIC_DIRECTUS_PUBLIC_URL
ARG PUBLIC_DIRECTUS_URL=http://directus:8055
ARG PUBLIC_UMAMI_URL
ARG PUBLIC_UMAMI_WEBSITE_ID
ENV PUBLIC_DIRECTUS_PUBLIC_URL=$PUBLIC_DIRECTUS_PUBLIC_URL
ENV PUBLIC_DIRECTUS_URL=$PUBLIC_DIRECTUS_URL
ENV PUBLIC_UMAMI_URL=$PUBLIC_UMAMI_URL
ENV PUBLIC_UMAMI_WEBSITE_ID=$PUBLIC_UMAMI_WEBSITE_ID

COPY . .
RUN npm run build

FROM node:22-alpine AS runner
WORKDIR /app

ENV NODE_ENV=production
ENV HOST=0.0.0.0
ENV PORT=4321

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json

EXPOSE 4321
CMD ["node", "./dist/server/entry.mjs"]
