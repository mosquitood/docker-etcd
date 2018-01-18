##Etcd container
The `-data-dir` is a volume mounted to `/var/etcd/data`, and the default ports are bound to Etcd and exposed.

Recently added a run script so that http is not hard-coded into the Dockerfile (for running over SSL).  Just overwrite `$CLIENT_URLS` and `$PEER_URLS` at runtime (these are the **listening** URLs).  You'll still need to set the `-advertise-client-urls` and `-initial-advertise-peer-urls` flags if the container will be part of a cluster.

Since the image uses an `ENTRYPOINT` it accepts passthrough arguments to etcd.

```sh
docker run \
  -d \
  -p 2379:2379 \
  -p 2380:2380 \
  -p 4001:4001 \
  -v /var/etcd/data:/var/etcd/data \
	-v /etc/etcd/ssl:/etc/etcd/ssl \
	-v /etc/ca/ssl:/etc/ca/ssl \
	--name some-name \ 
  mosquitood/etcd:v3.1.6 \
	--name=default
  --discovery=https://discovery.etcd.io/xxxxxxxxxxxxxxxxxxxxx \
  --initial-advertise-peer-urls=https://192.168.18.223:2380
  --listen-peer-urls=https://192.168.18.223:2380
  --listen-client-urls=https://192.168.18.223:2379,http://127.0.0.1:2379   
  --advertise-client-urls=https://192.168.18.223:2379   
  --data-dir=/var/etcd/data
  --discovery=https://discovery.etcd.io/e55fb583b14a7e8be18a78e5be8f8788 
  --cert-file=/etc/etcd/ssl/etcd.pem
  --key-file=/etc/etcd/ssl/etcd-key.pem
  --peer-cert-file=/etc/etcd/ssl/etcd.pem
  --peer-key-file=/etc/etcd/ssl/etcd-key.pem
  --trusted-ca-file=/etc/ca/ssl/ca.pem 
  --peer-trusted-ca-file=/etc/ca/ssl/ca.pem

```

