FROM alpine:3

RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*

RUN apk add --update --no-cache tzdata && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    echo "Asia/Tokyo" > /etc/timezone && \
    apk del tzdata

COPY build/web-arm /usr/local/bin/web

ENV ADDR :8081
ENV API localhost:8080

CMD ["sh", "-c", "web -addr=$ADDR -api=$API"]
