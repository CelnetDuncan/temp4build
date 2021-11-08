FROM golang:alpine

USER root
ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN ulimit -n 63356

# Set necessary environmet variables needed for our image
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    # GOOS=windows \
    GOARCH=amd64 \
    TZ=Asia/Taipei

# Move to working directory /build
WORKDIR /app

# Copy and download dependency using go mod
COPY go.mod .
# COPY go.sum .
RUN go mod download

# Copy the code into the container
COPY . .

# # Build the application
RUN go build -o main .

# # Move to /dist directory as the place for resulting binary folder
# WORKDIR /dist

# # Copy binary from build to main folder
# RUN cp /build/main .

# Command to run when starting the container
CMD ["/app/main"]