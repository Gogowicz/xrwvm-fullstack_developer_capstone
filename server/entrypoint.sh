#!/bin/sh

echo "Making migrations and migrating the database."
python manage.py makemigrations --noinput
python manage.py migrate --noinput
python manage.py collectstatic --noinput

echo "Populating database with CarMakes and CarModels..."
python manage.py shell <<EOF
from djangoapp.populate import initiate
initiate()
EOF

echo "Starting Django server..."
exec "$@"
