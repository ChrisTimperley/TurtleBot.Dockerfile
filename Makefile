all: base binary source

base:
	docker build -t christimperley/turtlebot:base base

binary: base
	docker build -t christimperley/turtlebot:binary binary

source: base
	docker build -t christimperley/turtlebot:source source

push: base binary source
	docker push christimperley/turtlebot

.PHONY: base binary source
