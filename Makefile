# this loads $(ENV_FILE) as both makefile variables and into shell env

THIS_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
ENV_FILE?=$(THIS_DIR)/.env
include $(ENV_FILE)
export $(shell sed 's/=.*//' $(ENV_FILE))
IMAGE=klakegg/hugo:$(HUGO_VERSION)-$(HUGO_IMAGE)

build:
	docker run -v $(THIS_DIR):/src $(IMAGE) 

serve: build
	docker run -i -p 1313:1313 -v $(THIS_DIR):/src $(IMAGE) server --disableFastRender
