#!/usr/bin/env bash

yum -y update

yum -y install \
    sudo \
    tar m4 bzip2 make patch perl-ExtUtils-MakeMaker python git \
    gcc gcc-c++ gcc-gfortran libgfortran \
    openssl-devel readline-devel \
    pango-devel cairo-devel \
    dejavu-sans-fonts dejavu-serif-fonts dejavu-sans-mono-fonts vlgothic-fonts \
    ImageMagick
