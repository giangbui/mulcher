FROM golang:1.10 as build-deps

WORKDIR /mulcher
ENV GOPATH=/mulcher

COPY . /mulcher

RUN go build -ldflags "-linkmode external -extldflags -static"

# Store only the resulting binary in the final image
# Resulting in significantly smaller docker image size
FROM scratch
COPY --from=build-deps /mulcher/mulcher /mulcher
CMD ["/mulcher"]
