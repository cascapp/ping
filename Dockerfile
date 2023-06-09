
FROM golang:alpine

WORKDIR /app

# Copy the requirements files and then go get the modules
COPY go.mod ./
COPY *.go ./

RUN go build -o ping ./main.go

CMD [ "./ping" ]
