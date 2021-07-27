# This is an example for Dmitry

image_build:

	podman build --format docker -f Containerfile -t $(IMAGE_REF):$(HASH) .
  
# Image values

REGISTRY := "us.gcr.io"

PROJECT := "my-project-name"

IMAGE := "some-image-name"

IMAGE_REF := $(REGISTRY)/$(PROJECT)/$(IMAGE)

# Git commit hash

HASH := $(shell git rev-parse --short HEAD)

image_tag:

	podman tag $(IMAGE_REF):$(HASH) $(IMAGE_REF):latest
	

# Push after testing with "gcloud run deploy"

push:

	podman push --remove-signatures $(IMAGE_REF):$(HASH)

	podman push --remove-signatures $(IMAGE_REF):latest


# Rollout after pushing

rollout:

	gcloud run deploy $(PROJECT) --image $(IMAGE_REF):$(HASH) --platform $(PLATFORM) --region $(REGION)
