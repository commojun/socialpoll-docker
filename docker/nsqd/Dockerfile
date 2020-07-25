FROM alpine:3

RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*

RUN apk add --update --no-cache tzdata && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    echo "Asia/Tokyo" > /etc/timezone && \
    apk del tzdata

COPY build/nsqd /usr/local/bin/nsqd

ENV NSQLOOKUPD_HOST localhost

CMD ["sh", "-c", "nsqd --lookupd-tcp-address=$NSQLOOKUPD_HOST"]
