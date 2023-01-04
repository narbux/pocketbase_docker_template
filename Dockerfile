FROM alpine:latest as builder

ARG PB_VERSION=0.10.4

RUN apk add --no-cache \
    unzip \
    ca-certificates

# download and unzip PocketBase
ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/

FROM nginx:stable

WORKDIR /app

COPY --from=builder /pb/ /app/

COPY ./nginx.conf /etc/nginx/nginx.conf

COPY ./docker-entrypoint.sh /app/

EXPOSE 80

VOLUME [ "/app/pb_data", "/app/pb_migrations" ]

CMD ["sh", "./docker-entrypoint.sh"]