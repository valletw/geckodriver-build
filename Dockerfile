ARG CROSS_TAG
# Build geckodriver image.
FROM dockcross/${CROSS_TAG} AS build-stage
ARG CROSS_TARGET
ARG CROSS_PREFIX
ARG GECKO_RELEASE
WORKDIR /root
# Install rust.
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
# Download source files.
RUN curl -SL https://github.com/mozilla/geckodriver/archive/refs/tags/v${GECKO_RELEASE}.tar.gz \
        -o geckodriver.tgz \
    && tar -xzf geckodriver.tgz \
    && rm geckodriver.tgz
# Prepare environment and build.
RUN cd /root/geckodriver-${GECKO_RELEASE} \
    && . ${HOME}/.cargo/env \
    && mkdir -p target/geckodriver \
    && rustup target install ${CROSS_TARGET} \
    && echo "[target.${CROSS_TARGET}]" >> .cargo/config \
    && echo "linker = \"${CROSS_PREFIX}gcc\"" >> .cargo/config \
    && cargo build --release --target ${CROSS_TARGET} \
    && mv target/${CROSS_TARGET}/release/geckodriver /root/geckodriver

FROM scratch AS export-stage
COPY --from=build-stage /root/geckodriver /
