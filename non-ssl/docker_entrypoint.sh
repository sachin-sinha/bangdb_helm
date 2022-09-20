#!/bin/bash
set -e
./bangdb-server restart
exec "$@"
