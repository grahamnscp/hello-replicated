FROM golang:1.8-alpine AS compile
COPY hello-replicated.go /go
RUN go build hello-replicated.go

FROM alpine:latest
COPY --from=compile /go/hello-replicated /
USER nobody:nobody
EXPOSE 8080
ENTRYPOINT ["/hello-replicated"]
