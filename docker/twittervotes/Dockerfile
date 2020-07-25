FROM alpine:3

RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*

RUN apk add --update --no-cache tzdata && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    echo "Asia/Tokyo" > /etc/timezone && \
    apk del tzdata

COPY build/twittervotes-arm /usr/local/bin/twittervotes

ENV MONGO localhost
ENV NSQD_HOST localhost:4160

CMD ["sh", "-c", "twittervotes -mongo=$MONGO -nsqd_host=$NSQD_HOST"]

