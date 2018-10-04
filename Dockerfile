## Build stage
FROM golang:1.9.4 as builder

# Set the working directory to the app directory
WORKDIR /go/src/fulfillorderack

# Install godeps
RUN go get -u -v github.com/astaxie/beego
RUN go get -u -v github.com/beego/bee
RUN go get -d github.com/Microsoft/ApplicationInsights-Go/appinsights
RUN go get -u -v gopkg.in/mgo.v2
RUN go get gopkg.in/matryer/try.v1

# Copy the application files
COPY . .

# Build
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o fulfillorderack .

## App stage
FROM alpine:latest  
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /go/src/fulfillorderack .

# Define environment variables
# Application Insights
ENV APPINSIGHTS_KEY="d746cb5a-364a-4923-8747-31eecc5d8201"
ENV CHALLENGEAPPINSIGHTS_KEY="d746cb5a-364a-4923-8747-31eecc5d8201"

# Challenge Logging
ENV TEAMNAME="ducker"

# Mongo/Cosmos
ENV MONGOURL="mongodb://root:4ORoKBh4cZDr9xJDL6Ks4bUz9biSsHenMZIBa9GSMtIUZ6Qok209CAlYmNvLKTr1mKN3JNlOipdsF46nDKeMvg==@root.documents.azure.com:10255/?ssl=true&replicaSet=globaldb"

# Expose the application on port 8080
EXPOSE 8080

# Set the entry point of the container to the bee command that runs the
# application and watches for changes
CMD ["./fulfillorderack", "run"]
