#!/bin/bash

tag=3.3.1

set -e

tmp=$(mktemp -d)

trap cleanup EXIT
cleanup() {
    set +e
    [ -z "$tmp" -o ! -d "$tmp" ] || rm -rf "$tmp"
}

unset CDPATH
pwd=$(pwd)

pushd "$tmp"
git clone git@github.com:jakearchibald/es6-promise.git
cd es6-promise
git archive --prefix="test/" --format=tar tags/v${tag}:test/ \
    | bzip2 > "$pwd"/tests-${tag}.tar.bz2
popd
