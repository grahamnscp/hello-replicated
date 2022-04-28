# Simple Golang web server image with different output for uris

Build the image:
(example with M1 mac!)
```
# first time to set up the multi-arch builder:

$ docker buildx create --name mybuilder
$ docker buildx use mybuilder
$ docker buildx ls
$ docker buildx inspect --bootstrap

# build image and push multi-arch at same time:

$ docker buildx build --platform linux/amd64,linux/arm64 --push -t grahamh/hello-replicated:1.0 .
```

Start a local container instance to test:
```
$ docker run -d --rm -p 8080:8080 grahamh/hello-replicated:1.0
```

Test:
Note: includes hostname so can test replica sets hit different instances
```
$ curl localhost:8080

 _          _ _                        _ _           _           _
| |__   ___| | | ___    _ __ ___ _ __ | (_) ___ __ _| |_ ___  __| |
| '_ \ / _ \ | |/ _ \  | '__/ _ \ '_ \| | |/ __/ _` | __/ _ \/ _` |
| | | |  __/ | | (_) | | | |  __/ |_) | | | (_| (_| | ||  __/ (_| |
|_| |_|\___|_|_|\___/  |_|  \___| .__/|_|_|\___\__,_|\__\___|\__,_|
                                |_|

[04-28-2022 09:46:16.49] Container hostname: b5c935d605cc
```

There are some uris in the image too to test layer 7 context routing:
```
$ curl localhost:8080/hello/ignoredtextafteruri
 _           _    _
| |     ___ | |  | |    ___
| |___ / _ \| |  | |   / _ \
|  _  |  __/| |__| |__| (_) |
|_| |_|\___/ \___|\___|\___/

[04-28-2022 09:46:16.49] Container hostname: b5c935d605cc
```

