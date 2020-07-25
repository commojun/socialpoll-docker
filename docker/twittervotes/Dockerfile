FROM alpine:3

RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*

RUN apk add --update --no-cache tzdata && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    echo "Asia/Tokyo" > /etc/timezone && \
    apk del tzdata

COPY build/twittervotes /usr/local/bin/twittervotes

ENV MONGO localhost
ENV NSQD_HOST localhost:4150

CMD ["sh", "-c", "twittervotes -mongo=$MONGO -nsqd=$NSQD_HOST"]

