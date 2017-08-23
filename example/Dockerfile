################################################################################################
# This Dockerfile builds a dev container to run this project on a CentOS Linux distro
################################################################################################
# Base image
FROM wpmr/go-docker:latest

# Maintainer
MAINTAINER Will Rowe <will.rowe@stfc.ac.uk>

################################################################################################
# Dev container
################################################################################################
ARG app_env
ENV APP_ENV $app_env

COPY . /go/src/github.com/user/myProject/app
WORKDIR /go/src/github.com/user/myProject/app

RUN go get ./
RUN go build

CMD if [ ${APP_ENV} = production ]; \
	then \
	app; \
	else \
	go get github.com/pilu/fresh && \
	fresh; \
	fi

EXPOSE 8080
