APP_ROOT=$(abspath .)

.PHONY: nsqbuild clean

nsqbuild: build/nsqd-arm build/nsqlookupd-arm

build/nsqd-arm:
	echo $(APP_ROOT)
	cd nsq/apps/nsqd && GOOS=linux GOARCH=arm go build -o $(APP_ROOT)/build/nsqd-arm

build/nsqlookupd-arm:
	cd nsq/apps/nsqlookupd && GOOS=linux GOARCH=arm go build -o $(APP_ROOT)/build/nsqlookupd-arm

clean:
	rm -R build/*

