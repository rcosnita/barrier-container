# barrier-container

Provides a docker container which can be used for synchronising containers based on service availability. It can be used in scenarios when syncing with other services is required (e.g: kafka, cassandra).

## Usage

## Configuration format

Below you can find an example of how to configure the services we want to wait for:

### configuration.json

```json
[
    {
        "host": "google.com",
        "port": 443,
        "type": "http"
    },
    {
        "host": "ebay.com",
        "port": 443,
        "type": "http"
    },
    {
        "host": "msn.com",
        "port": 443,
        "type": "http"
    }
]
```

### Start barrier

```bash
docker build -t rcosnita/barrier-container:latest -f Dockerfile .
docker run -it --rm -v $(pwd)/files/configuration.json:/configuration.json rcosnita/barrier-container:latest
```

In kubernetes, you should define a **ConfigMap** and mount it under the **/configuration.json** path.
