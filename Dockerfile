# Build stage
FROM node:20-alpine AS builder

# Match the packageManager version in package.json for reproducible builds.
RUN corepack enable && corepack prepare pnpm@10.11.0 --activate

WORKDIR /app

COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

COPY . .
RUN pnpm build

# Static production image
FROM nginx:alpine

COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 2234
CMD ["nginx", "-g", "daemon off;"]
