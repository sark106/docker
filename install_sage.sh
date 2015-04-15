#!/usr/bin/env bash

set -e
set -v

echo "Building Sage-${SAGE_VERSION}" 

cd /opt
TARBALL="sage-${SAGE_VERSION}.tar.gz"
tar xf $TARBALL
rm $TARBALL

ln -s "sage-${SAGE_VERSION}" sage
cd sage

export SAGE_FAT_BINARY="yes"
export MAKE='make -j8'

make
# make ptest
./sage <<EOFSAGE
    from sage.misc.misc import DOT_SAGE
    from sagenb.notebook import notebook
    directory = DOT_SAGE+'sage_notebook'
    nb = notebook.load_notebook(directory)
    nb.user_manager().add_user('admin', 'sage', '', force=True)
    nb.save()
    quit
EOFSAGE

./sage -pip install terminado

