use phper::{echo, functions::Argument, modules::Module, php_get_module, values::ZVal, sys::{zend_ast_process, zend_ast}};

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

    // Register the fibonacci function
    module
        .add_function("fibonacci", print_fibonacci)
        .argument(Argument::by_val("input"));
    
    // Override the zend_ast_process function
    module.on_module_init(|| unsafe {
        ORIGINAL_ZEND_AST_PROCESS = zend_ast_process;
        zend_ast_process = Some(new_zend_ast_process);
    });

    // Restore the original zend_ast_process function
    module.on_module_shutdown(|| unsafe {
        zend_ast_process = ORIGINAL_ZEND_AST_PROCESS;
    });
    module
}

// We will store the original zend_ast_process function here
static mut ORIGINAL_ZEND_AST_PROCESS: Option<unsafe extern "C" fn(*mut zend_ast)> = None;

// This is the function that will be called instead of zend_ast_process
pub unsafe extern "C" fn new_zend_ast_process(ast: *mut zend_ast) {
    if let Some(original_process) = ORIGINAL_ZEND_AST_PROCESS {
        original_process(ast);
    }
    echo!("Hello from the hook!\n")
}
