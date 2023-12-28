#!/usr/bin/env bash
podman build -t new-computer .
podman run -it new-computer
