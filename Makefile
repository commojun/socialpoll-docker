VERSION := 0.1.2
APP_ROOT=$(abspath .)

.PHONY: gobuild clean image-all image-nsqd image-nsqlookupd image-twittervotes image-counter image-api image-web

gobuild: clean build/nsqd-arm build/nsqlookupd-arm build/twittervotes-arm build/counter-arm build/api-arm build/web-arm

build/nsqd-arm:
	echo $(APP_ROOT)
	cd nsq/apps/nsqd && GOOS=linux GOARCH=arm go build -o $(APP_ROOT)/build/nsqd-arm

build/nsqlookupd-arm:
	cd nsq/apps/nsqlookupd && GOOS=linux GOARCH=arm go build -o $(APP_ROOT)/build/nsqlookupd-arm

build/twittervotes-arm:
	cd go-web/socialpoll/twittervotes && GOOS=linux GOARCH=arm go build -o $(APP_ROOT)/build/twittervotes-arm

build/counter-arm:
	cd go-web/socialpoll/counter && GOOS=linux GOARCH=arm go build -o $(APP_ROOT)/build/counter-arm

build/api-arm:
	cd go-web/socialpoll/api && GOOS=linux GOARCH=arm go build -o $(APP_ROOT)/build/api-arm

build/web-arm:
	cd go-web/socialpoll/web && GOOS=linux GOARCH=arm go build -o $(APP_ROOT)/build/web-arm

image-all: image-nsqd image-nsqlookupd image-twittervotes image-counter image-api image-web

image-nsqd:
	docker buildx build -t commojun/nsqd:$(VERSION) --platform linux/amd64,linux/arm/v7 --push -f docker/nsqd/Dockerfile .

image-nsqlookupd:
	docker buildx build -t commojun/nsqlookupd:$(VERSION) --platform linux/amd64,linux/arm/v7 --push -f docker/nsqlookupd/Dockerfile .

image-twittervotes:
	docker buildx build -t commojun/socialpoll-twittervotes:$(VERSION) --platform linux/amd64,linux/arm/v7 --push -f docker/twittervotes/Dockerfile .

image-counter:
	docker buildx build -t commojun/socialpoll-counter:$(VERSION) --platform linux/amd64,linux/arm/v7 --push -f docker/counter/Dockerfile .

image-api:
	docker buildx build -t commojun/socialpoll-api:$(VERSION) --platform linux/amd64,linux/arm/v7 --push -f docker/api/Dockerfile .

image-web:
	docker buildx build -t commojun/socialpoll-web:$(VERSION) --platform linux/amd64,linux/arm/v7 --push -f docker/web/Dockerfile .

clean:
	rm -R build/*

secret:
	kubectl delete secret socialpoll
	kubectl create secret generic \
		--save-config socialpoll \
		--from-env-file ./envfile
