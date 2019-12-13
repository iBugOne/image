#!/bin/bash

REMOTE=iBug/image
BRANCH=master

# Prepare SSH stuff
if [ -z "$SSH_KEY_E" ]; then
  echo "SSH key not found!" >&2
  exit 1
fi
base64 -d <<< "$SSH_KEY_E" | gunzip -c > ~/.ssh/id_rsa
chmod 400 ~/.ssh/id_rsa
export SSH_AUTH_SOCK=none GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa"

set -e

git clone --depth=1 --branch="$BRANCH" "git@github.com:$REMOTE.git" work
cd work
git checkout --orphan temp
git add -A
git -c user.name=iBug -c user.email=git@ibugone.com \
  commit -m "Auto squash from GitHub Actions"
git branch -M "$BRANCH"
git push origin +HEAD:master
git push git@git.dev.tencent.com:iBugOne/image.git +HEAD:master || true
