#!/bin/sh
# Check for $CLIENT_URLS
if [ -z ${CLIENT_URLS+x} ]; then
        CLIENT_URLS="http://0.0.0.0:4001,http://0.0.0.0:2379"
        echo "Using default CLIENT_URLS ($CLIENT_URLS)"
else
        echo "Detected new CLIENT_URLS value of $CLIENT_URLS"
fi

# Check for $PEER_URLS
if [ -z ${PEER_URLS+x} ]; then
        PEER_URLS="http://0.0.0.0:2380"
        echo "Using default PEER_URLS ($PEER_URLS)"
else
        echo "Detected new PEER_URLS value of $PEER_URLS"
fi

# Check for $ADVERTISE_CLIENT_URLS
if [ -z ${ADVERTISE_CLIENT_URLS+x} ]; then
        ADVERTISE_CLIENT_URLS="http://0.0.0.0:2379"
        echo "Using default ADVERTISE_CLIENT_URLS ($ADVERTISE_CLIENT_URLS)"
else
        echo "Detected new value of $ADVERTISE_CLIENT_URLS"
fi

# Check for $INITIAL_ADVERTISE_PEER_URLS
if [ -z ${INITIAL_ADVERTISE_PEER_URLS+x} ]; then
        INITIAL_ADVERTISE_PEER_URLS="http://0.0.0.0:2380"
        echo "Using default INITIAL_ADVERTISE_PEER_URLS ($INITIAL_ADVERTISE_PEER_URLS)"
else
        echo "Detected new value of $INITIAL_ADVERTISE_PEER_URLS"
fi

# Check for $INITIAL_CLUSTER
if [ -z ${INITIAL_CLUSTER+x} ]; then
        INITIAL_CLUSTER="default=http://0.0.0.0:2380"
        echo "Using default INITIAL_CLUSTER ($INITIAL_CLUSTER)"
else
        echo "Detected new value of $INITIAL_CLUSTER"
fi

ETCD_CMD="/bin/etcd --data-dir=/var/etcd/data --initial-cluster=${INITIAL_CLUSTER} --initial-advertise-peer-urls=${INITIAL_ADVERTISE_PEER_URLS} --advertise-client-urls=${ADVERTISE_CLIENT_URLS} --listen-peer-urls=${PEER_URLS} --listen-client-urls=${CLIENT_URLS} $*"

echo -e "Running '$ETCD_CMD'\nBEGIN ETCD OUTPUT\n"

exec $ETCD_CMD
