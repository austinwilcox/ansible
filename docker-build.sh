#!/usr/bin/env bash
# Build the test image and run the playbook inside it. With no arguments this
# runs everything a container can satisfy; the tags it cannot are listed in
# CONTAINER_SKIP_TAGS in the Dockerfile.
#
# Pass extra ansible-playbook arguments to scope the run:
#   ./docker-build.sh --tags rust,node
set -euo pipefail

docker build -t new-computer .

if [ "$#" -eq 0 ]; then
    exec docker run --rm -it new-computer
fi

exec docker run --rm -it new-computer sh -c \
    'ansible-playbook local.yml --skip-tags "$CONTAINER_SKIP_TAGS" "$@"' _ "$@"
