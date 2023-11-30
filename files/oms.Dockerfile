#Use the offical golang base image
FROM golang:latest AS Builder

#Set the working directory inside the container
WORKDIR /app

#Copy the entire directory into the container
COPY ../order_management_system_backend . 

# Install Go dependencies and build the application
RUN go mod download && \
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o order_management_system_backend .

# Stage 2: Create a minimal runtime image
FROM alpine:latest

#Set the working directory inside the container
WORKDIR /app

# Copy the built binary from the builder stage
COPY --from=builder /app/order_management_system_backend /app/order_management_system_backend

# Copy the .env file if needed
COPY ../order_management_system_backend/.env /app/.env

#Expose the port your application listens on
EXPOSE 8000

#Command to run the application when the container starts
CMD [ "./order_management_system_backend" ]