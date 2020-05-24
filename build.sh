#!/bin/bash

me=$(basename "$0")
msg() {
    echo >&2 "$me:" "$@"
}

gofmt -s -w ./*.go ./example
go tool fix ./*.go ./example
go vet . ./example
go install

#hash gosimple 2>/dev/null    && gosimple    ./*.go
hash golint 2>/dev/null      && golint      ./*.go
#hash staticcheck 2>/dev/null && staticcheck ./*.go

#hash gosimple 2>/dev/null    && gosimple    ./example/*.go
hash golint 2>/dev/null      && golint      ./example/*.go
#hash staticcheck 2>/dev/null && staticcheck ./example/*.go

go test
go test -bench=.

go mod tidy ;# remove non-required modules from dependencies
