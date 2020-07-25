VERSION := 0.1.5
APP_ROOT=$(abspath .)

.PHONY: gobuild clean image-all image-nsqd image-nsqlookupd image-twittervotes image-counter image-api image-web mongo apply

gobuild: clean build/nsqd build/nsqlookupd build/twittervotes build/counter build/api build/web

build/nsqd:
	echo $(APP_ROOT)
	cd nsq/apps/nsqd && GOOS=linux GOARCH=arm go build -o $(APP_ROOT)/build/nsqd

build/nsqlookupd:
	cd nsq/apps/nsqlookupd && GOOS=linux GOARCH=arm go build -o $(APP_ROOT)/build/nsqlookupd

build/twittervotes:
	cd go-web/socialpoll/twittervotes && GOOS=linux GOARCH=arm go build -o $(APP_ROOT)/build/twittervotes

build/counter:
	cd go-web/socialpoll/counter && GOOS=linux GOARCH=arm go build -o $(APP_ROOT)/build/counter

build/api:
	cd go-web/socialpoll/api && GOOS=linux GOARCH=arm go build -o $(APP_ROOT)/build/api

build/web:
	cd go-web/socialpoll/web && GOOS=linux GOARCH=arm go build -o $(APP_ROOT)/build/web

clean:
	rm -R build/*

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

mongo:
	-kubectl delete -f ./kube-stateful
	kubectl apply -f ./kube-stateful

backup:
	kubectl exec -it mongo-0 -- mongodump -d ballots -c polls
	kubectl cp mongo-0:/root/dump dump

apply:
	-kubectl delete -f ./kube
	kubectl apply -f ./kube

secret:
	-kubectl delete secret socialpoll
	kubectl create secret generic \
		--save-config socialpoll \
		--from-env-file ./envfile
