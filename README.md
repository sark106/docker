Docker build script for Sage
============================

Quickstart
----------

We have a prebuilt docker image at
https://registry.hub.docker.com/u/sagemath/sage/. Docker will
automatically download and use it if you ask it to run the
`sagemath/sage` image. So just running the following command will
bring up a Sage command line without having installed anything before
(except docker of course):

    docker run --rm -i -t sagemath/sage

All arguments after the `sagemath/sage` are passed to sage. If you
want to run a sage notebook server you probably want to run it
detached `-d` instead of interactively `-i`, which you can do like
this:

    docker run --rm -p 127.0.0.1:8080:8080 -d -t sagemath/sage --notebook=sagenb
    docker run --rm -p 127.0.0.1:8080:8080 -d -t sagemath/sage --notebook=ipython --ip='*' --port=8080

Note that the sage notebook server runs on port 8080 inside the
container. The above command maps it to 8080 outside of the container,
so you can connect with your usual web browser at
http://127.0.0.1:8080. But only from the computer running docker. If
you want everybody on the internet to be able to connect, use `-p
0.0.0.0:8080:8080` instead.

For Sage development you probably want a terminal at one point. You
can open it using

    docker run --rm -i -t sagemath/sage -sh

Sage is installed in `/opt/sage` inside the container. 


Restart and Keeping Files
-------------------------

Each `docker run` commant creates a new container, independent of all
other containers. In particular, there is no storage shared: Each
container is a completely independent file system. To keep files files
after you quit the dockerized Sage, you should 

* Not delete the container when exiting Sage (leave out the `--rm`
  command line option above).

* Give containers a name so you know which one is which (add the
  `--name=...` commandline option).

If you then start a container again you will get back the same files
that you had when you quit that particular container. For example, say
you run the container for the first time using:

    docker run --name=sage-cmdline -i -t sagemath/sage

Then interact with Sage, create files, etc. Then quit Sage, the
containers exits but is still stored (does not appear in `docker ps`
but does appear in `docker ps -a`). To restart the container named
`sage-cmdline` again, you would then just call

    docker start -i sage-cmdline

Only when you delete the container using `docker rm sage-cmdline` any
file modifications that you made in that container are permanently
lost, unless you explicitly save them with `docker commit`.



Installation
------------

A reasonably recent Linux distribution will have docker packaged, for
example on Fedora/Redhat/Centos run

    yum install docker

or Debian/Ubuntu:
 
    apt-get install docker.io

On OSX and Windows you first have to install the Boot2Docker helper
application, which includes a minimal virtual machine to execute
docker images.

* OSX: http://docs.docker.com/installation/mac/

* Windows: http://docs.docker.com/installation/windows/

Running Boot2Docker then brings up a command line window where you can
execute the above docker commands.

See http://docs.docker.com/installation/ for more details.


Build Instructions
------------------

To build the docker image yourself, check out the repository and add
the Sage source tarball. Adjust the tarball name in the Dockerfile
accordingly. Then run

    docker build -t yourname/sage path/to/repo/

to build the docker image.
