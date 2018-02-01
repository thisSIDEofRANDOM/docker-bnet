TIMESTAMP=$(shell date +%F)

BASE=tsunamibear/bnet:$(TIMESTAMP)

image:
	make -C docker-wine $(shell grep FROM Dockerfile|cut -d: -f2)
	docker build -t $(BASE) .

test:
	./run-bnet $(BASE)

push:
	docker push $(BASE)

validate: push
	docker tag $(BASE) tsunamibear/bnet:latest
	docker push tsunamibear/bnet:latest

clean:
	docker image rm $(BASE)
	docker volume rm bnet-data
	rm -rf ~/.local/share/bnet
