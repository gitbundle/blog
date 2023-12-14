#!/bin/sh

make release

docker buildx build --rm -f docker/Dockerfile.linux.amd64 -t gitbundle.com/bundle/gitbundle-blog:linux-amd64 --push --provenance=false .
docker buildx build --rm -f docker/Dockerfile.linux.arm64 -t gitbundle.com/bundle/gitbundle-blog:linux-arm64 --push --provenance=false .

# https://github.com/estesp/manifest-tool/issues/199
# https://github.com/docker/buildx/issues/1509
manifest-tool push from-spec docker/manifest.yml