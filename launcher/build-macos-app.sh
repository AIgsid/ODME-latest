#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
TARGET_JAR="${REPO_ROOT}/target/SESEditor-1.0-SNAPSHOT.jar"
STAGE_DIR="${REPO_ROOT}/build/jpackage-input"
MAVEN_REPO_DIR="${REPO_ROOT}/build/.m2/repository"
DIST_DIR="${REPO_ROOT}/dist"
APP_BUNDLE="${DIST_DIR}/ODME.app"

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "This script must be run on macOS."
  exit 1
fi

mkdir -p "${MAVEN_REPO_DIR}"

echo "Building application jar..."
(
  cd "${REPO_ROOT}"
  mvn -q "-Dmaven.repo.local=${MAVEN_REPO_DIR}" -DskipTests package
)

if [[ ! -f "${TARGET_JAR}" ]]; then
  echo "Expected packaged jar not found: ${TARGET_JAR}"
  exit 1
fi

echo "Preparing jpackage input..."
rm -rf "${STAGE_DIR}"
mkdir -p "${STAGE_DIR}"
cp "${TARGET_JAR}" "${STAGE_DIR}/"

rm -rf "${APP_BUNDLE}"
mkdir -p "${DIST_DIR}"

echo "Creating macOS app bundle..."
jpackage \
  --type app-image \
  --name ODME \
  --app-version 1.0.0 \
  --input "${STAGE_DIR}" \
  --main-jar SESEditor-1.0-SNAPSHOT.jar \
  --main-class odme.odmeeditor.Main \
  --dest "${DIST_DIR}" \
  --vendor "DLR SES" \
  --description "Operation Domain Modeling Environment"

if [[ ! -d "${APP_BUNDLE}" ]]; then
  echo "App bundle was not created: ${APP_BUNDLE}"
  exit 1
fi

echo
echo "macOS app bundle created:"
echo "  ${APP_BUNDLE}"
echo
echo "Launch it by opening ODME.app. Keep the whole app bundle intact."
