FROM elixir:alpine

ENV BUILD_ARGS="LIBS=-lcurses dungeon LIBDIR=/usr/local/lib BINDIR=/usr/local/bin"
WORKDIR /tmp/slork/zork
COPY . ../

RUN apk add --update --no-cache \
      gcc \
      git \
      g++ \
      make \
      ncurses-dev \
      --virtual .builddeps && \
    make $BUILD_ARGS && \
    mkdir -p /usr/games/lib && \
    make $BUILD_ARGS install && \
    cd .. && \
    yes | mix deps.get && \
    yes | mix escript.build && \
    mv slork /usr/local/bin && \
    apk del .builddeps && \
    rm -rf /tmp/* /var/tmp/* /root/.mix


ENTRYPOINT ["/usr/local/bin/slork", "--zork-dir", "/usr/local/bin"]
