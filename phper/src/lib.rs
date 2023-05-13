use phper::{echo, functions::Argument, modules::Module, php_get_module, values::ZVal};

pub fn print_fibonacci(arguments: &mut [ZVal]) -> phper::Result<()> {
    let arg = arguments[0].expect_long()?;
    let fib_number = calc_fibonacci(arg as u64);
    echo!("The fibonacci number is, {}!\n", fib_number);
    Ok(())
}

fn calc_fibonacci(n: u64) -> u64 {
    match n {
        0 => 0,
        1 => 1,
        n => calc_fibonacci(n - 1) + calc_fibonacci(n - 2),
    }
}

#[php_get_module]
pub fn get_module() -> Module {
    let mut module = Module::new(
        env!("CARGO_CRATE_NAME"),
        env!("CARGO_PKG_VERSION"),
        env!("CARGO_PKG_AUTHORS"),
    );

    module
        .add_function("fibonacci", print_fibonacci)
        .argument(Argument::by_val("input"));

    module
}
