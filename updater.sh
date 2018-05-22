#!/bin/bash

REMOTE=iBug/image
BRANCH=master

if [ -z "$GH_TOKEN" ]; then
  echo "\$GH_TOKEN not set!" >&2
  exit 1
fi

set -e

git clone --depth=1 --branch=$BRANCH "https://$GH_TOKEN@github.com/$REMOTE.git" work
cd work
rm -rf .git
git init
git config user.name "iBug"
git config user.email "7273074+iBug@users.noreply.github.com"
git add -A
git commit -m "Auto squash from Travis CI"
git push -f
