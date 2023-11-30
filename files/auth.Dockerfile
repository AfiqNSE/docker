# Stage 1: Build the application
FROM golang:latest AS builder

#Set the working directory inside the container
WORKDIR /app

#Copy the entire directory into the container
COPY ../golang_jwe_authentication .

# Install Go dependencies and build the application
RUN go mod download && \
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o golang_jwe_authentication .

# Stage 2: Create a minimal runtime image
FROM alpine:latest

#Set the working directory inside the container
WORKDIR /app

# Copy the built binary from the builder stage
COPY --from=builder /app/golang_jwe_authentication /app/golang_jwe_authentication

# Copy the .env file if needed
COPY ../golang_jwe_authentication/.env /app/.env

#Expose the port your application listens on
EXPOSE 2000

#Command to run the application when the container starts
CMD ["./golang_jwe_authentication"]
