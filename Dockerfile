FROM node:20-alpine as build
RUN mkdir -p /usr/app
WORKDIR /usr/app

COPY ./ ./
RUN npm ci
RUN npm run build

# Etapa de producción: usa NGINX para servir los archivos estáticos
FROM nginx:alpine AS production
# Copiar los archivos generados al directorio predeterminado de NGINX
COPY --from=build /usr/app/dist /usr/share/nginx/html

# Exponer el puerto 80 para tráfico HTTP
EXPOSE 80

# El CMD predeterminado de NGINX manejará el servicio de archivo
