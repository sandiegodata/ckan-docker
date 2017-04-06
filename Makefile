
INSTANCE = default
DOCKER ?= docker

NS = sandiegodata
VERSION = latest

REPO = ckan
NAME = ckan-sdrdl

DOCKER ?= docker


PORTS =  -p 80  # -p 22

#SITE_URL=data.sandiegodata.org
#ADMIN_USER_KEY=admin
#ADMIN_USER_PASS=adminpw
#ADMIN_USER_EMAIL=bob@example.com
#VIRTUAL_HOST=$(SITE_URL)

include Makefile.local


#VOLUMES= -v host:container
ENV = -e SITE_URL=$(SITE_URL) -eADMIN_USER_KEY=$(ADMIN_USER_KEY) -eADMIN_USER_PASS=$(ADMIN_USER_PASS) \
-eADMIN_USER_EMAIL=$(ADMIN_USER_EMAIL) -eVIRTUAL_HOST=$(ADMIN_USER_EMAIL) # -eSSH=sshpass


.PHONY: build push shell run start stop restart reload rm rmf release backup

build:
	$(DOCKER) build -t $(NS)/$(REPO):$(VERSION) .

push:
	$(DOCKER) push $(NS)/$(REPO):$(VERSION)

shell:
	$(DOCKER) run --rm  -i -t $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(REPO):$(VERSION) /bin/bash

attach:
	$(DOCKER) exec  -ti $(NAME) /bin/bash

run:
	$(DOCKER) run --rm --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(REPO):$(VERSION)

logs:
	$(DOCKER) logs -f $(NAME) 

start:
	$(DOCKER) run -d --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(NS)/$(REPO):$(VERSION)

stop:
	$(DOCKER) stop $(NAME)
	
restart: stop 
	$(DOCKER) start $(NAME) 
    
reload: build rmf start

rmf:
	$(DOCKER) rm -f $(NAME)

rm:
	$(DOCKER) rm $(NAME)

backup:
	$(DOCKER) exec $(NAME) /bin/bash -c '/usr/local/bin/paster --plugin=ckan db dump  -c /etc/ckan/default/development.ini /tmp/database-dump.sql; cat /tmp/database-dump.sql ' > "dump-"$$(date +'%Y%m%d')".sql"

release: build
	make push -e VERSION=$(VERSION)

default: build