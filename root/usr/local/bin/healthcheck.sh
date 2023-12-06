#!/bin/bash -e

# The location of the config file can be overcontrolled via the environment
# variable CONFIG_FILE.
CONFIG_FILE=${CONFIG_FILE:-"/config/config/config.yaml"}

# Extract config parameters to query status via API.
API_KEY=$(yq -r '.auth.apikey' "${CONFIG_FILE}")
PORT=$(yq -r '.general.port' "${CONFIG_FILE}")

curl --silent --insecure --fail --output /dev/null "http://localhost:${PORT}/api/system/status?apikey=${API_KEY}"
