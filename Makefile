.PHONY:	all build container push

REGISTRY=freehandocker
IMAGE=hey
TAG=v1

all: build

build:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -o hey

container:
	docker build -t $(REGISTRY)/$(IMAGE):$(TAG) ./

push: build
	docker push $(REGISTRY)/$(IMAGE):$(TAG)
	docker tag $(REGISTRY)/$(IMAGE):$(TAG) $(REGISTRY)/$(IMAGE):latest
	docker push $(REGISTRY)/$(IMAGE):latest
	docker rmi $(REGISTRY)/$(IMAGE):latest

all: push
