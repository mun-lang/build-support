ARG LLVM_VERSION=8.0.1

# Locations for produced tools and libraries.
ARG LIBS_PREFIX=/opt/libs

# Libs
FROM ubuntu:bionic

# Get all sources at first, so that changes in arguments
# flags would not redownload them.
RUN apt-get update && apt-get -y install curl xz-utils

ARG LLVM_VERSION
RUN curl --proto '=https' --tlsv1.2 -sSfL \
  https://github.com/llvm/llvm-project/archive/llvmorg-$LLVM_VERSION.tar.gz | \
  tar xzf -
ENV LLVM_DIR $SRC_DIR/llvm-project-llvmorg-$LLVM_VERSION

# Install build dependencies.
RUN apt-get update && apt-get -y install rsync ninja-build cmake python3-distutils clang llvm lld

ARG LIBS_PREFIX

# Build llvm
WORKDIR $LLVM_DIR/llvm
RUN mkdir build && \
  cd build && \
  cmake \
  -DCMAKE_BUILD_TYPE=release \
  -DLLVM_ENABLE_PROJECTS="lld;clang" \
  -DCMAKE_INSTALL_PREFIX=$LIBS_PREFIX \
  -DLLVM_ENABLE_LIBXML2=OFF \
  -DLLVM_ENABLE_TERMINFO=OFF \
  -G Ninja \
  .. && \
  cmake --build . --target install

RUN ln -s $LIBS_PREFIX/bin/clang $LIBS_PREFIX/bin/cc
RUN ln -s $LIBS_PREFIX/bin/clang $LIBS_PREFIX/bin/gcc
RUN ln -s $LIBS_PREFIX/bin/clang++ $LIBS_PREFIX/bin/c++
RUN ln -s $LIBS_PREFIX/bin/clang++ $LIBS_PREFIX/bin/g++
RUN ln -s $LIBS_PREFIX/bin/llvm-ar $LIBS_PREFIX/bin/ar
RUN ln -s $LIBS_PREFIX/bin/llvm-strip $LIBS_PREFIX/bin/strip
RUN ln -s $LIBS_PREFIX/bin/ld.lld $LIBS_PREFIX/bin/ld

# Create an archive of the installed binaries
RUN tar -vcJf /llvm-$LLVM_VERSION-ubuntu-bionic.tar.xz /opt/libs/
