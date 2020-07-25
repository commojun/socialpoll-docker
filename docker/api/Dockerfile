FROM alpine:3

RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*

RUN apk add --update --no-cache tzdata && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    echo "Asia/Tokyo" > /etc/timezone && \
    apk del tzdata

COPY build/api /usr/local/bin/api

ENV ADDR :8080
ENV MONGO localhost

CMD ["sh", "-c", "api -addr=$ADDR -mongo=$MONGO"]
