package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

func main() {
	path := os.Getenv("PING_PATH")
	if path == "" {
		path = "/ping"
	}

	port := os.Getenv("PING_PORT")
	if port == "" {
		port = "8080"
	}

	fmt.Printf("Ping running on port %s at %s\n", port, path)

	http.HandleFunc(path, func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "ping")
		fmt.Printf("ping\n")
	})

	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%s", port), nil))
}
