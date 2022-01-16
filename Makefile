.PHONY: all

all: slv

slv.pb.go: slv.proto
	@protoc -I. \
    -I/usr/local/include \
	--go_out=. \
	--go_opt=paths=source_relative \
    --go-grpc_out=. \
    --go-grpc_opt=paths=source_relative \
    slv.proto

dep: ## Get the dependencies
	@go get -v -d ./...

slv: slv.pb.go

clean: ## cleanup all generated go files
	@rm slv.pb.go slv_grpc.pb.go

help: ## help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
