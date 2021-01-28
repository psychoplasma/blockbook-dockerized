# blockbook-dockerized

Containerization of trezor/blockbook for bitcoin with Docker

## Building docker images

```shell
$ docker-compose build bitcoin
$ docker-compose build blockbook
```

## Running blockbook and its backend

* `bitcoin.conf` file should be located under `NODE_CONFIG` directory before starting bitcoin service
* If you want to change bitcoind's RPC credentials, you need to do it in `Dockerfile.blockbook` because the configuration file for blockbook is generated with blockbook's config generation tool [here](https://github.com/psychoplasma/blockbook-docker/blob/main/Dockerfile.blockbook#L99). However, due to the fact that RPC/zeromq ports are only exposed internally (not published, only docker services on the same machine can access), you actually don't need to worry about that your bitcoind's RPC is exposed to outside world.
* As mentioned [here](https://github.com/trezor/blockbook#common-issues-when-running-blockbook-or-implementing-additional-coins), if you are running the containers in a system with less than 32G memory, set `-worker=1 -dbcache=0` on [line 99](https://github.com/psychoplasma/blockbook-docker/blob/main/docker-compose.yml#L42) in `Dockerfile.blockbook`. I haven't tested if the memory requirement goes up linearly with the number of workers set in blockbook options. However I achieved to sync blockbook with resources 12GB memory and 4GB swap on docker with a machine installed 16GB memory and `-worker=2 -dbcache=0` options.
* Also solid-state(high-speed) storage is highly recommended. Even though with the configuration aforementioned, full sync for bitcoin takes two weeks.

### Run with `docker-compose`

```shell
$ USER_ID=$UID NODE_DATA=/path/to/bitcoin/data/dir/of/your/convenience \
  NODE_CONFIG=/path/to/bitcoin/config/dir/of/your/convenience \
  BLOCKBOOK_DATA=/path/to/blockbook/data/dir/of/your/convenience \ 
  docker-compose up -d

# To see the logs separately
$ docker-compose logs blockbook
$ docker-compose logs bitcoin
```

## Todos

* Add build variables to blockbook service in order to set bitcoind's RPC credentials to anything other than the defualt
