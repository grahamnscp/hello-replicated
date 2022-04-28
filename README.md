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

Aside: buildx inspect tool can be used to check the image has multi-arch:
```
$ docker buildx imagetools inspect grahamh/hello-replicated:1.0

Name:      docker.io/grahamh/hello-replicated:1.0
MediaType: application/vnd.docker.distribution.manifest.list.v2+json
Digest:    sha256:eb039808b8668ba2ee7611bb81c4a15db1aa00cacde20b2fdf9e0f70371a74ee

Manifests:
  Name:      docker.io/grahamh/hello-replicated:1.0@sha256:d4878c649c9b9d981f652166c4a77766703f8e2d2f35355c38b659dd14513eac
  MediaType: application/vnd.docker.distribution.manifest.v2+json
  Platform:  linux/amd64

  Name:      docker.io/grahamh/hello-replicated:1.0@sha256:3d76163af383d6b95d00c9a57afc47a2042d18363c8e301bce482ade117c5b91
  MediaType: application/vnd.docker.distribution.manifest.v2+json
  Platform:  linux/arm64

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

