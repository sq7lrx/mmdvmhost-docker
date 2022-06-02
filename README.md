# MMDVMHost OCI Container

This builds an OCI compliant container image running the G4KLX's
[MMDVMHost](https://github.com/g4klx/MMDVMHost).

## Tools (required to build)

- [Buildah](https://buildah.io/)
- [qemu-user-static](https://github.com/multiarch/qemu-user-static) (for
  multi-arch builds)

## Building
To build and push a multi-arch image to Docker Hub at `sq7lrx/mmdvmhost`:

```sh
git clone https://github.com/sq7lrx/mmdvmhost-docker.git
cd mmdvmhost-docker
export IMAGE=docker.io/sq7lrx/mmdvmhost
./build.sh
```