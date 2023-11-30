# Stage 1: Build the application
FROM golang:latest AS builder

#Set the working directory inside the container
WORKDIR /app

#Copy the entire directory into the container
COPY ../notification .

# Install Go dependencies and build the application
RUN go mod download && \
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o notification .

# Stage 2: Create a minimal runtime image
FROM alpine:latest

#Set the working directory inside the container
WORKDIR /app

# Copy the built binary from the builder stage
COPY --from=builder /app/notification /app/notification

# Copy the .env file if needed
COPY ../notification/.env /app/.env


#Expose the port your application listens on
EXPOSE 4000

CMD ["./notification"]