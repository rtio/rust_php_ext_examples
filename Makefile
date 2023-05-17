UNAME_S := $(shell uname -s)
LIB_EXT :=

ifeq ($(UNAME_S),Linux)
	LIB_EXT = so
endif
ifeq ($(UNAME_S),Darwin)
	LIB_EXT = dylib
endif

.PHONY: all build clean run docker-build docker-run

all: build run

build-php_ext_rs:
	@echo "Building php_ext_rs..."
	@cd php_ext_rs && cargo build --release

build-phper:
	@echo "Building phper..."
	@cd phper && cargo build --release

build-phper_hook_ast_process:
	@echo "Building phper_hook_ast_process..."
	@cd phper_hook_ast_process && cargo build --release

build: build-php_ext_rs build-phper build-phper_hook_ast_process

clean-php_ext_rs:
	@echo "Cleaning php_ext_rs..."
	@cd php_ext_rs && cargo clean

clean-phper:
	@echo "Cleaning phper..."
	@cd phper && cargo clean

clean-phper_hook_ast_process:
	@echo "Cleaning phper_hook_ast_process..."
	@cd phper_hook_ast_process && cargo clean

clean: clean-php_ext_rs clean-phper clean-phper_hook_ast_process

run-php_ext_rs:
ifeq ($(number),)
	@echo "Please provide a value for the 'number' variable. Example: make run number=20"
else
	@echo "Running php_ext_rs 👉 libfibonacci.$(LIB_EXT)..."
	@time php -d "extension=php_ext_rs/target/release/libfibonacci.$(LIB_EXT)" -r "fibonacci($(number));"
endif

run-phper:
ifeq ($(number),)
	@echo "Please provide a value for the 'number' variable. Example: make run number=20"
else
	@echo "Running phper 👉 libfibonacci.$(LIB_EXT)..."
	@time php -d "extension=phper/target/release/libfibonacci.$(LIB_EXT)" -r "fibonacci($(number));"
endif

run-phper_hook_ast_process:
ifeq ($(number),)
	@echo "Please provide a value for the 'number' variable. Example: make run number=20"
else
	@echo "Running phper_hook_ast_process 👉 libfibonacci.$(LIB_EXT)..."
	@time php -d "extension=phper_hook_ast_process/target/release/libfibonacci.$(LIB_EXT)" -r "fibonacci($(number));"
endif

run: run-php_ext_rs run-phper run-phper_hook_ast_process

docker-build:
	@docker build -t php_extensions .

docker-run: docker-build
	@docker run --rm -it php_extensions make run number=$(number)
