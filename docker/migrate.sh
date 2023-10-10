#!/bin/bash

MIGRATION_DIR="/opt/swissborg/migrations"

if [ -d "${MIGRATION_DIR=}" ]; then
  echo "Running migrations..."
  flask db upgrade
  echo "Migrations done."
fi
