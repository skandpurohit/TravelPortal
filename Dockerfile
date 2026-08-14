FROM golang:1.25-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

# Install C build dependencies required by mattn/go-sqlite3
RUN apk add --no-cache gcc musl-dev linux-headers sqlite-dev

# Build with CGO enabled for sqlite3 support
ENV CGO_ENABLED=1
RUN go build -ldflags "-s -w" -o /app/main .

FROM alpine:3.18

RUN apk add --no-cache ca-certificates

WORKDIR /app

COPY --from=builder /app/main .
COPY --from=builder /app/web ./web

RUN chmod +x /app/main

ENV TODO_PORT=7540
ENV TODO_DBFILE=scheduler.db
ENV TODO_PASSWORD=test12345

EXPOSE 7540

CMD ["/app/main"]