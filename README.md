# Rust PHP Extensions Comparison

This repository contains two Rust projects, `php_ext_rs` and `phper`, which are PHP extensions implemented in Rust. This README provides an overview of the project, including instructions for building and testing the libraries, as well as the pros and cons of each approach. Additionally, a Docker setup is provided for easier setup and testing.

## Build and Test

To build and test the libraries locally, follow these steps:

1. Ensure Rust and Cargo are installed on your system.

2. Clone this repository:

   ```bash
   git clone <repository_url>
   cd <repository_directory>
   ```

3. Build the Rust projects:

    ```bash
    make build
    ```

4. Run the test commands:

    ```bash
    make run number=<value>
    ```

Replace `<value>` with the desired number to test the libraries (e.g., `make run number=20`).

## Docker

A Docker setup is provided to simplify the setup and testing process. Follow the steps below:

1. Install Docker on your system.

2. Clone this repository:

   ```bash
   git clone <repository_url>
   cd <repository_directory>
   ```

3. Build the Docker image:

    ```bash
    make docker-build
    ```

4. Run the Docker container and execute the test commands:

    ```bash
    make docker-run number=<value>
    ```

Replace `<value>` with the desired number to test the libraries (e.g., `make docker-run number=20`).

## Findings

After building and testing both libraries, the following findings were observed:

- The `php_ext_rs` library performed well and successfully computed the Fibonacci sequence up to the provided number. I can highlight how well written the library was.
- The `phper` library executed as expected and demonstrated the functionality of the `fibonacci()`. This library outstands on its testing coverage and the Zend engine API implementation.

## Pros and Cons

### php_ext_rs

**Pros:**
- Efficient execution and good performance.
- Seamless integration with PHP types validation.
- Provides additional tools compared to `phper`.

**Cons:**
- Development activity appears to be less frequent.

### phper

**Pros:**
- Easy integration with PHP.
- Relatively straightforward to use for developers familiar with PHPCPP.
- Well-documented and actively maintained.

**Cons:**
- May have a learning curve for developers unfamiliar with PHPCPP.

## Personal Thoughts

The testing of both libraries revealed interesting aspects of their performance and ease of use. `php_ext_rs` demonstrated superior readability and extra tooling, making it a strong choice for maintenance. On the other hand, `phper` offered wider Zend engine support and seems to have higher development activity.

Overall, the decision between the two libraries depends on the specific requirements and trade-offs of the project.

Please note that these thoughts are based on the findings and observations made during the testing process.
