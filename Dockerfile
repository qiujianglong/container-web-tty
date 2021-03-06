FROM golang:1.9-alpine
RUN apk add --update make git curl && \
    curl https://glide.sh/get | sh

ENV BIN=container-web-tty
ENV SRC=/go/src/github.com/wrfly/${BIN}
COPY . ${SRC}
RUN cd ${SRC} && \
    make prepare && \
    make build && \
    mv bin/${BIN} /root

FROM alpine
COPY --from=0 /root/container-web-tty /bin/
CMD [ "container-web-tty" ]
