# =============================================================================
# stage 1
# =============================================================================

FROM golang:1.23 AS builder
COPY go.mod main.go /app/
COPY templates/ /app/templates
WORKDIR /app
RUN CGO_ENABLED=0 go build -o app.bin .

# =============================================================================
# stage 2
# =============================================================================

FROM scratch
WORKDIR /app
COPY --from=builder /app/app.bin /app/app.bin
COPY --from=builder /app/templates /app/templates
CMD ["./app.bin"]
