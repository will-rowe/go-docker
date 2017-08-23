# Go Docker

This base image is based on the official [Golang Docker image](https://hub.docker.com/_/golang/).

It is intended to be used with Go projects, allowing them to be tested and built within a development/production container.

The main differences to the official Golang image:

* Based on CentOS
* Installs the Development Tools group
* Installs openMPI

Look at the example in this repo to see how to create a Go development container using this base image.
