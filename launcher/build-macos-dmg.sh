#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
TARGET_JAR="${REPO_ROOT}/target/SESEditor-1.0-SNAPSHOT.jar"
STAGE_DIR="${REPO_ROOT}/build/jpackage-input"
MAVEN_REPO_DIR="${REPO_ROOT}/build/.m2/repository"
DIST_DIR="${REPO_ROOT}/dist"

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

echo "Creating macOS dmg installer..."
jpackage \
  --type dmg \
  --name ODME \
  --app-version 1.0.0 \
  --input "${STAGE_DIR}" \
  --main-jar SESEditor-1.0-SNAPSHOT.jar \
  --main-class odme.odmeeditor.Main \
  --dest "${DIST_DIR}" \
  --vendor "DLR SES" \
  --description "Operation Domain Modeling Environment"

echo
echo "macOS installer created in:"
echo "  ${DIST_DIR}"
echo
echo "Open the generated .dmg and drag ODME.app into Applications."
