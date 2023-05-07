FROM golang:1.19 as build
# docker run -e POSTGRES_USER="balman" -e POSTGRES_PASSWORD="admin1234" -e POSTGRES_DB="todos" -e POSTGRES_HOST="host.docker.internal" todolist 
WORKDIR /app
COPY . .
RUN go mod download
RUN GOOS=linux go build -o server .

FROM golang:1.19

WORKDIR /app
COPY --from=build /app/ .
EXPOSE 3000
CMD [ "/app/server" ]