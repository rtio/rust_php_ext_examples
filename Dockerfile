# Use a PHP 8.2 base image
FROM php:8.2-cli

# Install libclang
RUN apt-get update \
    && apt-get install -y libclang-9-dev time \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Copy the project files into the container
COPY . .

# Build the Rust projects
RUN make build
