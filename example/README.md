# Example development container

The example shown here is based on [this](https://medium.com/statuscode/golang-docker-for-development-and-production-ce3ad4e69673) blog post.

***

## Overview

The Dockerfile in this example uses a Go Docker base image to build a development container for a Go application. This container will reload as changes are made to the code in this project.

As noted in the blog, this is achieved by using volumes, pilu/fresh and build arguments.

## Running the example

Clone the repo and cd to the example:
```
git clone https://github.com/will-rowe/go-docker && cd go-docker/example
```

Build the Docker image:
```
docker build -t 'wpmr:golang-app-dev' ./
```

Run the container and allow app to run on localhost:8080:
```
docker run -it --rm -p 8080:8080 -v $PWD:/go/src/github.com/user/myProject/app wpmr:golang-app-dev
```

To build and run the production container:
```
docker build  -t 'wpmr:golang-app-dev' ./ --build-arg app_env=production
docker run -it --rm -p 8080:8080 wpmr:golang-app-dev
```

## Using this Docker image for cross-compiling Go programs

```
docker run --rm -v "$PWD":/go/src/github.com/user/myProject/app -w /go/src/github.com/user/myProject/app -e GOOS=linux -e GOARCH=amd64 -e CGO_ENABLED=1 wpmr:golang-app-dev go build -v
```

## Explanation of the Dockerfile

The following explanation has been adapted from the blog post:

```
# Specify the base image (containing Go install and Go paths)
FROM wpmr/go-docker:latest

# allow app_env to be set during build (defaults to empty string)
ARG app_env

# set an environment variable to app_env argument, this way the variable will persist in the container for use in code
ENV APP_ENV $app_env

# copy the local project code into a directory in the container’s GOPATH
COPY . /go/src/github.com/user/myProject/app

# set this to the working directory so all subsequent commands will run from this directory
WORKDIR /go/src/github.com/user/myProject/app

# install the dependencies and build the binary
RUN go get ./
RUN go build

# if arg_env was set to production run the binary otherwise use pilu/fresh to hot reload the code when it changes
CMD if [ ${APP_ENV} = production ]; \
	then \
	app; \
	else \
	go get github.com/pilu/fresh && \
	fresh; \
	fi

# set the port to serve the program on
EXPOSE 8080
```


## Tips

* Copy this example Dockerfile and keep it in the root directory of your Golang project
* If cross-compiling for other architectures, the Dockerfile may need updating to add the correct compilers (like i386)
