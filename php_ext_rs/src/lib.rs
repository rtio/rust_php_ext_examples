use ext_php_rs::prelude::*;

#[php_function]
pub fn fibonacci(input: u64) {
    let fib_number = calc_fibonacci(input);
    php_println!("The fibonacci number is, {}!", &fib_number);
}

fn calc_fibonacci(n: u64) -> u64 {
    match n {
        0 => 0,
        1 => 1,
        n => calc_fibonacci(n - 1) + calc_fibonacci(n - 2),
    }
}

#[php_module]
pub fn get_module(module: ModuleBuilder) -> ModuleBuilder {
    module
}
