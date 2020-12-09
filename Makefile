IMAGE=veins
IP = `ifconfig en0 | grep inet | awk '$$1=="inet" {print $$2}'`

.PHONY: help
help:
	@echo "Usage: make [target]"
	@echo
	@echo "Targets:"
	@echo "  help\t\tPrint this help"
	@echo "  test\t\tLookup for docker and docker-compose binaries"
	@echo "  setup\t\tBuild docker images"
	@echo "  run-bash\t\tRun bash"

.PHONY: test
test:
	@which docker
	@which docker-compose

.PHONY: setup
setup: Dockerfile
	docker image build -t $(IMAGE) .

.PHONY: run-bash
run-bash:
	xhost + ${IP}
	docker run -it --rm --name simulation \
	-e DISPLAY=${IP} \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	$(IMAGE) bash

#-u $$(id -u):$$(id -g) \
