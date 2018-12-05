#!/bin/bash
BASE_PATH="$1"

set +e
echo "BASE_URL:$BASE_URL"
docker pull testx/protractor
docker run --rm -t -v %cd%/art:/work testx/protractor conf.coffee
set -e