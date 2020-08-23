llvm_version="8.0.1"

# Build an image that contains an LLVM distribution
docker build --build-arg LLVM_VERSION=$llvm_version -t ubuntu-llvm:$llvm_version .

# Spin up the image and copy the tarbal it creates
id=$(docker create ubuntu-llvm:$llvm_version)
docker cp $id:llvm-$llvm_version-ubuntu-bionic.tar.xz llvm-$llvm_version-ubuntu-bionic.tar.xz
docker rm -v $id
