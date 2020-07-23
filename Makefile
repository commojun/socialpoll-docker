VERSION := 0.1.2
APP_ROOT=$(abspath .)

.PHONY: nsqbuild clean image-build-all image-build-nsqd image-build-nsqlookupd

nsqbuild: clean build/nsqd-arm build/nsqlookupd-arm

build/nsqd-arm:
	echo $(APP_ROOT)
	cd nsq/apps/nsqd && GOOS=linux GOARCH=arm go build -o $(APP_ROOT)/build/nsqd-arm

build/nsqlookupd-arm:
	cd nsq/apps/nsqlookupd && GOOS=linux GOARCH=arm go build -o $(APP_ROOT)/build/nsqlookupd-arm

image-build-all: image-build-nsqd image-build-nsqlookupd

image-build-nsqd:
	docker buildx build -t commojun/nsqd:$(VERSION) --platform linux/amd64,linux/arm/v7 --push -f docker/nsqd/Dockerfile .

image-build-nsqlookupd:
	docker buildx build -t commojun/nsqlookupd:$(VERSION) --platform linux/amd64,linux/arm/v7 --push -f docker/nsqlookupd/Dockerfile .

clean:
	rm -R build/*

