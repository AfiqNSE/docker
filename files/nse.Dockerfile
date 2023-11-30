# Stage 1: Build the application
FROM golang:latest AS builder

WORKDIR /app

COPY ../nse-driver-golang-backend .

# Install Go dependencies and build the application
RUN go mod download && \
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o nse-driver-golang-backend ./src/main.go

# Stage 2: Create a minimal runtime image
FROM alpine:latest

#Set the working directory inside the container
WORKDIR /app

# Copy the built binary from the builder stage
COPY --from=builder /app/nse-driver-golang-backend /app/nse-driver-golang-backend

# Copy the .env file if needed
COPY ../nse-driver-golang-backend/.env /app/.env

EXPOSE 8080

CMD ["./nse-driver-golang-backend"]
