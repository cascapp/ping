BINARY_NAME=ping
DOCKER_REGISTRY=cascapp
VERSION=`cat CURRENT_VERSION`


all: build

version:
	@./semver.py

clean:
	rm -fr ./bin
	rm -fr ./out
	rm -fr ./docs/*.json ./docs/*.yaml ./docs/docs.go


build: version
	docker buildx build --platform linux/amd64,linux/arm64 --push -t $(DOCKER_REGISTRY)/$(BINARY_NAME):$(VERSION) -t $(DOCKER_REGISTRY)/$(BINARY_NAME):latest .
	git tag "release_v$(VERSION)"
	git push origin "release_v$(VERSION)"

