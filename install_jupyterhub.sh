

yum install \
    python3-zmq python3-jinja2 python3-pytest python3-devel \
    python3-sphinx python3-pygments python3-mistune \
    python3-tornado python3-sqlalchemy python3-simplepam \
    python3-requests \
    nodejs npm

pip3 install terminado
pip3 install "ipython[notebook]"

npm install -g configurable-http-proxy


python3 setup.py build
