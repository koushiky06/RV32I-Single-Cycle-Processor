

module tb_single_cycle();

    // 1. Declare inputs to the processor as registers (reg)
    reg clk;
    reg rst;

    // 2. Instantiate your top-level processor design
    single_cycle_top uut (
        .clk(clk),
        .rst(rst)
    );

    // 3. Generate a clock signal that toggles every 5ns (100 MHz clock)
    always #5 clk = ~clk;

    // 4. Initialize signals and handle reset sequence
    initial begin
        // Initialize signals to 0 at time = 0
        clk = 0;
        rst = 1;        // Assert reset (hold processor in reset state)
        
        #20;            // Wait 20ns
        rst = 0;        // Deassert reset (let the processor start running!)
        
        #1000;          // Let the simulation run for 1000ns
        $finish;        // Stop the simulation
    end

endmodule

