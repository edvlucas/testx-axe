#!/bin/bash
BASE_PATH="$1"


JACOCO_RG_VERSION="1.1.2"
INCL_PACKAGE_FILTER="nl.overheid.ictu"
EXCL_PACKAGE_FILTER="_"
REPORT_NAME="ART Coverage Rapport"

cd ${BASE_PATH}/src
mvn -pl backend/java --also-make-dependents --also-make -amd install -Djacoco.host=java-backend.${INSTANCE_NAME}.$PROJECT.ictu -Pcode-coverage,dump-data -DskipTests -Djacoco.rg.version=$JACOCO_RG_VERSION
