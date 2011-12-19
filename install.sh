#!/bin/sh
virtualenv --no-site-packages python
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
$GRROOT/python/bin/python manage.py syncdb --noinput
cd $GRROOT
cp $GRROOT/etc/carbon.conf $GRPREFIX/conf/carbon.conf
cp $GRROOT/etc/storage-schemas.conf.example $GRPREFIX/conf/storage-schemas.conf
