FROM alpine:3

RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*

RUN apk add --update --no-cache tzdata && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    echo "Asia/Tokyo" > /etc/timezone && \
    apk del tzdata

COPY build/counter-arm /usr/local/bin/counter

ENV MONGO localhost
ENV NSQLOOKUPD localhost:4161

CMD ["sh", "-c", "counter -mongo=$MONGO -nsqlookupd=$NSQLOOKUPD"]

