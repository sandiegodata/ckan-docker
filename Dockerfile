##
## Docker configuration for CKAN 2.3a, with both Postgres and Solr in the same container. 
## With the DEBUG env var set, it will run in development mode, and it exports both the data
## directory and the source directory, for developing extensions. 
##

## Mostly from the Package install instructions at: 
## http://docs.ckan.org/en/latest/maintaining/installing/install-from-package.html

## Env Vars:
##  ADMIN_USER_PASS
##  ADMIN_USER_EMAIL
##  ADMIN_USER_KEY

FROM civicknowledge/ckan-onbuild:latest

MAINTAINER Eric Busboom <eric@sandiegodata.org>

CMD sh start-ckan.sh
