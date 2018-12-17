# DOCKER_BUILD=docker build --rm --tag
# Hmmm...I think "--rm" is the default behavior, let's remove
.RECIPEPREFIX +=
DOCKER_BUILD=docker build --tag
NGINX=msavage/centos7-nginx

#TARGETS
all:
        $(DOCKER_BUILD) $(NGINX) -f Dockerfile .

