Docker build script for Sage
============================

Quickstart
----------

We have a prebuilt docker image at
https://registry.hub.docker.com/u/sagemath/sage/. Docker will
automatically download and use it if you ask it to run the
`sagemath/sage` image. There are two ways to use the image. First, if
you start it interactively then it will bring up a Sage command line:

    docker run -i -t sagmath/sage

The other way to use the image is non-interactively, in which case it
will run the notebook server:

    docker run -d -p 127.0.0.1:8080:8080 sagemath/sage

Note that the sage notebook server runs on port 8080 inside the
container. The above command maps it to 8080 outside of the container,
so you can connect with your usual web browser at
http://127.0.0.1:8080.

Also note that any changes to the file system inside the container are
discarded when you stop the container unless you explicitly save them
(with `docker commit`).


Build Instructions
------------------

To build the docker image yourself, check out the repository and add
the Sage source tarball. Adjust the tarball name in the Dockerfile
accordingly. Then run

    docker build -t yourname/sage path/to/repo/

to build the docker image.