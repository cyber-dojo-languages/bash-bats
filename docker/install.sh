#!/bin/bash -Eeu

# Appends one test framework to the test_frameworks list the base image
# wrote in /versions.json, keeping any entry an earlier image added. Stops
# the build if the list is not found, rather than record nothing. Short grep
# flags because busybox grep has no long ones.
add_test_framework()
{
  local -r name="${1}"
  local -r version="${2}"
  local -r entry="{\"name\": \"${name}\", \"version\": \"${version}\"}"
  if grep -q '"test_frameworks": \[\]' /versions.json; then
    sed -i "s|\"test_frameworks\": \[\]|\"test_frameworks\": [${entry}]|" /versions.json
  else
    sed -i "/\"test_frameworks\": \[/s|}\]|}, ${entry}]|" /versions.json
  fi
  if ! grep -q -F "${entry}" /versions.json; then
    echo "Could not add ${name} to /versions.json" >&2
    cat /versions.json >&2
    exit 1
  fi
}

apk add curl git

# Install the newest bats release. GitHub redirects releases/latest to the
# newest release's tag, which is resolved here at build time so a rebuild
# picks up the next release by itself.
readonly BATS_LATEST_URL=$(curl --silent --fail --output /dev/null --write-out '%{redirect_url}' \
  https://github.com/bats-core/bats-core/releases/latest)
readonly BATS_TAG="${BATS_LATEST_URL##*/}"

# An empty tag means the redirect could not be read or has changed shape,
# not that bats stopped releasing, so stop rather than install nothing.
if [ -z "${BATS_TAG}" ]; then
  echo 'Found no bats release tag at github.com/bats-core/bats-core' >&2
  exit 1
fi

git clone --branch "${BATS_TAG}" https://github.com/bats-core/bats-core.git
cd bats-core
./install.sh /usr/local
cd ..
rm -rf bats-core
apk del curl git

add_test_framework bats "${BATS_TAG#v}"
cat /versions.json
