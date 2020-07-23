FROM alpine:3

RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*

RUN apk add --update --no-cache tzdata && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    echo "Asia/Tokyo" > /etc/timezone && \
    apk del tzdata

COPY build/nsqd-arm /usr/local/bin/nsqd

ENV LOOKUPD_HOST nsqlookupd
ENV PORT 4160

CMD ["sh", "-c", "nsqd --lookupd-tcp-address=$LOOKUPD_HOST:$PORT"]
