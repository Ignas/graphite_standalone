#!/bin/sh
virtualenv python
python/bin/python bootstrap.py
bin/buildout
GRROOT=$PWD
GRPREFIX=$PWD/graph
GRLIB=$PWD/graph/webapp
python/bin/pip install --install-option="--prefix=$GRPREFIX" --install-option="--install-lib=$GRLIB" graphite-web
python/bin/pip install --install-option="--prefix=$GRPREFIX" --install-option="--install-lib=$GRLIB" carbon
python/bin/pip install --install-option="--prefix=$GRPREFIX" --install-option="--install-lib=$GRLIB" whisper
python/bin/pip install --install-option="--prefix=$GRPREFIX" --install-option="--install-lib=$GRLIB" gunicorn
cd graph/webapp/graphite
$GRROOT/python/bin/python manage.py syncdb
cd $GRROOT
cp $GRPREFIX/conf/carbon.conf.example $GRPREFIX/conf/carbon.conf
cp $GRPREFIX/conf/storage-schemas.conf.example $GRPREFIX/conf/storage-schemas.conf
