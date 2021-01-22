# blockbook-docker

Containerization of trezor/blockbook with Docker

## Building docker images

```shell
docker-compose build bitcoin
docker-compose build blockbook
```

## Running blockbook and its backend

* `bitcoin.conf` files should be located to `NODE_CONFIG` directory before starting services

### Run with `docker-compose`

```shell
USER_ID=$UID NODE_DATA=/path/to/bitcoin/data/dir/of/your/convenience NODE_CONFIG=/path/to/bitcoin/config/dir/of/your/convenience BLOCKBOOK_DATA=/path/to/blockbook/data/dir/of/your/convenience docker-compose up -d

# To see the logs separately
docker-compose logs blockbook
docker-compose logs bitcoin
```
