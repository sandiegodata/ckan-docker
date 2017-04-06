# docker-ckan

Docker build directory for a single-machine instance of CKAN

## Dump the database

``make backup`` then move the resulting file to `database.sql` to load it on the next rebuild. 