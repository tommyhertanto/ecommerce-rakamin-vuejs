# STAGE 1: Build Vue App
FROM node:18-alpine AS build-stage

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run lint --fix || true
RUN npm run build

# STAGE 2: Nginx Serve
FROM nginx:stable-alpine

COPY --from=build-stage /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
