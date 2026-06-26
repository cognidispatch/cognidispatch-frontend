FROM node:20-alpine AS builder

WORKDIR /app

# Copy dependency manifests.
COPY package*.json ./

RUN npm install --legacy-peer-deps

COPY . .

ARG NEXT_PUBLIC_SERVER_IP
ENV NEXT_PUBLIC_SERVER_IP=$NEXT_PUBLIC_SERVER_IP

ARG NEXT_PUBLIC_SOCKET_IP
ENV NEXT_PUBLIC_SOCKET_IP=$NEXT_PUBLIC_SOCKET_IP

RUN npm run build

FROM node:20-alpine AS runner

WORKDIR /app

RUN apk update && apk upgrade --no-cache

ENV NODE_ENV=production
ENV PORT=3000

COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static

RUN rm -rf /usr/local/lib/node_modules/npm /usr/local/bin/npm /usr/local/bin/npx

EXPOSE 3000

CMD ["node", "server.js"]
