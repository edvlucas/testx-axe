#!/bin/bash
BASE_PATH="$1"

export \
  DIR="${BASE_PATH}/art/testresults/junit" \
  URL="http://trr.reporting.${PROJECT}.ictu:4567/upload" \
  APP_NAME="$APPLICATION_NAME" \
  APP_VERSION="$VERSION" \
  TEST_DESCRIPTION="ART AppStarter" \
  TEST_USER="Jenkins" \
  TEST_VERSION="$VERSION" \
  TEST_TARGET="ChromeHeadless" \
  TEST_PLATFORM="Docker" \
  TEST_RUN="$INSTANCE_NAME" \

echo "Sending reports in ${DIR}" 
echo "${APP_NAME}"

for file in $DIR/*.xml; do
  [ -f $file ] || continue
  echo $file
done | xargs -I{} --max-procs 0 bash -c '
  curl ${URL} \
    -s \
    -F "junit=@{}" \
    -F "application_name=${APP_NAME}" \
    -F "application_version=${APP_VERSION}" \
    -F "testrun_description=${TEST_DESCRIPTION}" \
    -F "testrun_user=${TEST_USER}" \
    -F "testrun_version=${TEST_VERSION}" \
    -F "test_target=${TEST_TARGET}" \
    -F "test_platform=${TEST_PLATFORM}" \
    -F "testrun=${TEST_RUN}"
' 

export JACOCO_RG_VERSION="1.1.2"
export INCL_PACKAGE_FILTER="nl.overheid.ictu"
export EXCL_PACKAGE_FILTER="_"
export REPORT_NAME="ART Coverage Rapport"

docker run -u `id -u`:`id -g` --rm -t \
    -v $BASE_PATH/src/backend/java:/usr/src/jacoco/ \
    -v $BASE_PATH/src/backend/java:/src \
    -w /usr/src/jacoco \
    java:8 \
    java -jar target/jacoco-rg-$JACOCO_RG_VERSION.jar \
        /usr/src/jacoco/jacoco /usr/src/jacoco/target /src/packaging/target "$REPORT_NAME" /src  $INCL_PACKAGE_FILTER $EXCL_PACKAGE_FILTER