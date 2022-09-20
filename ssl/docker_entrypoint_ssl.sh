#!/bin/bash
set -e
./bangdb-server-ssl restart
exec "$@"
