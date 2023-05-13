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

build:
	@echo "Building php_ext_rs..."
	@cd php_ext_rs && cargo build --release
	@echo "Building phper..."
	@cd phper && cargo build --release

clean:
	@echo "Cleaning php_ext_rs..."
	@cd php_ext_rs && cargo clean
	@echo "Cleaning phper..."
	@cd phper && cargo clean

run:
ifeq ($(number),)
	@echo "Please provide a value for the 'number' variable. Example: make run number=20"
else
	@echo "Running php_ext_rs 👉 libfibonacci.$(LIB_EXT)..."
	@time php -d "extension=php_ext_rs/target/release/libfibonacci.$(LIB_EXT)" -r "fibonacci($(number));"
	@echo "Running phper 👉 libfibonacci.$(LIB_EXT)..."
	@time php -d "extension=phper/target/release/libfibonacci.$(LIB_EXT)" -r "fibonacci($(number));"
endif

docker-build:
	@docker build -t php_extensions .

docker-run: docker-build
	@docker run --rm -it php_extensions make run number=$(number)
