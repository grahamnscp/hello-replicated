FROM golang:latest AS compile
COPY hello-replicated.go /go
RUN go build hello-replicated.go
USER nobody:nogroup
EXPOSE 8080
ENTRYPOINT ["/go/hello-replicated"]
