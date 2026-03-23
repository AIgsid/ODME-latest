#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
TARGET_JAR="${REPO_ROOT}/target/SESEditor-1.0-SNAPSHOT.jar"
STAGE_DIR="${REPO_ROOT}/build/jpackage-input"
MAVEN_REPO_DIR="${REPO_ROOT}/build/.m2/repository"
DIST_DIR="${REPO_ROOT}/dist"
PACKAGE_TYPE="${1:-deb}"

if [[ "$(uname -s)" != "Linux" ]]; then
  echo "This script must be run on Linux."
  exit 1
fi

if [[ "${PACKAGE_TYPE}" != "deb" && "${PACKAGE_TYPE}" != "rpm" ]]; then
  echo "Usage: ./launcher/build-linux-installer.sh [deb|rpm]"
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

echo "Creating Linux ${PACKAGE_TYPE} installer..."
jpackage \
  --type "${PACKAGE_TYPE}" \
  --name ODME \
  --app-version 1.0.0 \
  --input "${STAGE_DIR}" \
  --main-jar SESEditor-1.0-SNAPSHOT.jar \
  --main-class odme.odmeeditor.Main \
  --dest "${DIST_DIR}" \
  --vendor "DLR SES" \
  --description "Operation Domain Modeling Environment" \
  --install-dir /opt/odme

echo
echo "Linux installer created in:"
echo "  ${DIST_DIR}"
echo
echo "Example:"
if [[ "${PACKAGE_TYPE}" == "deb" ]]; then
  echo "  sudo dpkg -i ${DIST_DIR}/odme_1.0.0-1_amd64.deb"
else
  echo "  sudo rpm -i ${DIST_DIR}/odme-1.0.0-1.x86_64.rpm"
fi
