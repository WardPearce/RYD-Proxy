FROM golang:alpine AS build

WORKDIR /app/

COPY . .

RUN --mount=type=cache,target=/root/.cache/go-build \
    go build -ldflags "-s -w" main.go

FROM alpine

RUN apk --no-cache add --no-check-certificate ca-certificates \
    && update-ca-certificates


COPY --from=build /app/main /ryd-proxy

EXPOSE 3000
CMD [ "/ryd-proxy" ]
