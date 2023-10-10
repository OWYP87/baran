#!/bin/bash
flask db init --directory db
flask db migrate --directory /app/db
flask db upgrade --directory /app/db
python3 app.py
