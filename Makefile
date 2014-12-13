# Makefile for docker-ghost

# ghost settings
GMAIL ?= '<gmail_account>' # required. 
GMAIL_PASSWORD ?= '<gmail_pass>' # required. 
HOSTNAME ?= '<hostname>'	# required. just hostname leave off http://


# docker settings
REGISTRY ?= '<docker_username>/'	# required. notice the trailing slash
ENVS = -e GMAIL=$(GMAIL) -e GMAIL_PASSWORD=$(GMAIL_PASSWORD) -e HOSTNAME=$(HOSTNAME)
PORTS = -p 80:2368 -p 5432:5432
CONTAINER = ghost
VOLUMES = -v /data:/data -v /ghost-content:/ghost-content


.PHONY: container run

container :
	docker build -t $(REGISTRY)$(CONTAINER) .

run :
	docker run --name $(CONTAINER) -i -d $(PORTS) $(ENVS) $(VOLUMES) -t $(REGISTRY)$(CONTAINER)
stop :
	docker stop $(CONTAINER)
	docker rm $(CONTAINER)
kill :
	docker kill $(CONTAINER)
	docker rm $(CONTAINER)

attach:
	docker attach $(CONTAINER)

tail:
	docker logs -f $(CONTAINER)	