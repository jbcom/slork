FROM grycap/elixir

WORKDIR /opt/slork
COPY . ./

RUN install_packages build-essential git && \
    cd zork && \
    make && \
    make install && \
    cd .. && \
    mix deps.get --force && \
    mix escript.build && \
    ./slork !map && \
    rm -rf zork /tmp/* /var/tmp/*

ENTRYPOINT ["/opt/slork/slork"]