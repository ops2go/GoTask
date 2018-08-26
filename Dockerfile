FROM golang:alpine3.7
RUN apk add --update \
        sqlite       \
        git         \
        build-base
RUN go get -u \
        github.com/Masterminds/glide 
WORKDIR /go/src/github.com/ops2go/gotask
ENV PATH=$PATH:/go/src/github.com/ops2go/gotask
COPY . .
EXPOSE 8081
RUN glide install
RUN go build -o gotask
RUN cat schema.sql | sqlite3 tasks.db
ENTRYPOINT [ "gotask" ]

