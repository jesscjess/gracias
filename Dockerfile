# STAGE 1: Build angular app
FROM node:8 as builder

COPY . /src

WORKDIR /src
RUN npm install
RUN $(npm bin)/ng build --prod

# STAGE 2: Run nginx to serve app 
FROM nginx:1.12-alpine

RUN chown -R nginx /var/cache/nginx \
    && chmod 777 /var/run \
    && chmod 777 /var/cache/nginx


ARG VERSION
ENV APP_VERSION ${VERSION}

# Run as non-root user
USER nginx

COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/default.conf /etc/nginx/conf.d/default.conf

COPY --from=builder /src/dist/* /usr/share/nginx/html/

EXPOSE 8080