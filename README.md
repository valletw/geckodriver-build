# Unofficial Geckodriver build

Build Mozilla Geckodriver binairies.

## Build binairies

To cross compile the binairies, the docker image is based on
[dockcross](https://github.com/dockcross/dockcross) images.

Specify the following variables to build:

- `GECKO_RELEASE`: Geckodriver release to build,
- `CROSS_TAG`: dockcross tag name,
- `CROSS_TARGET`: Rust cargo target name,
- `CROSS_PREFIX`: GCC toolchain prefix.

Build directly with docker commande as follow:

```bash
export DOCKER_BUILDKIT=1
docker build \
    --build-arg GECKO_RELEASE="" \
    --build-arg CROSS_TAG="" \
    --build-arg CROSS_TARGET="" \
    --build-arg CROSS_PREFIX="" \
    -t gecko-build -o build .
```

Build using abstraction script from preconfigured arguments:

```bash
./build.sh <name>
```

## Geckodriver source code and license

Based on Mozilla geckodriver source code available at
[mozilla/geckodriver](https://github.com/mozilla/geckodriver)
under [Mozilla Public License](https://www.mozilla.org/en-US/MPL/2.0/).

**This repository is not affiliated with Mozilla. It is only used for building
geckodriver binaries.**
