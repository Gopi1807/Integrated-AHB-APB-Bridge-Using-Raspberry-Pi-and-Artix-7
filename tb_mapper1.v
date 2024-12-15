/*`timescale 1ns / 1ps

module tb_mapper1;

    // Inputs
    reg clk;
    reg reset_n;
    reg data_from_slave;

    // Outputs
    wire [31:0] prdata;
    wire [31:0] haddr;
    wire [31:0] hwdata;
    wire [1:0] htrans;
    wire hreadyin;
    wire hwrite;

    // Instantiate the Unit Under Test (UUT)
    mapper1 uut (
        .clk(clk),
        .reset_n(reset_n),
        .data_from_slave(data_from_slave),
        .prdata(prdata),
        .haddr(haddr),
        .hwdata(hwdata),
        .htrans(htrans),
        .hreadyin(hreadyin),
        .hwrite(hwrite)
    );

    // Clock generation
    initial clk = 0;
    always #1 clk = ~clk;  // Generate a clock with a 10ns period

    // Reset logic
    initial begin
        reset_n = 0;
        #5 reset_n = 1;  // Release reset after 20ns
    end

   // Data generation for `data_from_slave`
initial begin
    data_from_slave = 0;
    #20;  // Wait for reset

    // Generate 100 bits of data for `data_from_slave`
    repeat (10) begin
        #5 data_from_slave = 20'b11111111111111111111;  // Toggle data deterministically
    end

    // Wait for additional time to ensure processing completes
    #500;
    $stop;  // End simulation
end


    // Monitor the outputs
    initial begin
        $monitor("Time=%0t | prdata=%h | haddr=%h | hwdata=%h | htrans=%b | hreadyin=%b | hwrite=%b",
                 $time, prdata, haddr, hwdata, htrans, hreadyin, hwrite);
    end

endmodule */


`timescale 1ns / 1ps

module tb_mapper1;

    // Inputs
    reg clk;
    reg reset_n;
    reg data_from_slave;

    // Outputs
    wire [31:0] prdata;
    wire [31:0] haddr;
    wire [31:0] hwdata;
    wire [1:0] htrans;
    wire hreadyin;
    wire hwrite;

    // Instantiate the Unit Under Test (UUT)
    mapper1 uut (
        .clk(clk),
        .reset_n(reset_n),
        .data_from_slave(data_from_slave),
        .prdata(prdata),
        .haddr(haddr),
        .hwdata(hwdata),
        .htrans(htrans),
        .hreadyin(hreadyin),
        .hwrite(hwrite)
    );

    // Clock generation
  // Clock generation
       initial begin
        clk = 0;
        forever #1 clk = ~clk; // 10ns clock period
    end

    // SPI Clock generation
  

    // Test sequence
    reg [99:0] test_data; // Test data to send
    integer i;

    initial begin
        // Initialize inputs
        clk = 0;
        reset_n = 1;

        //test_data = 100'b000100100011010001010110011110001000110000000000000000000000000010000111011001010100001100100001;
        
       // test_data = 100'b0101011001111000000100100011010010000000000000000000000000001100111111111111111111111111111111110010;
        
      // test_data = 100'b0100100000_0000000000_0000000000_1100111111_1111111111_1111111111_1111010101_1001111000_0001001000_110100;
      
      test_data = 100'b0_1_00_10000000000000000000000000001100_11111111111111111111111111111111_01010110011110000001001000110100;








        // Apply reset
        #5 reset_n = 0;
        #5 reset_n = 1;

        // Start SPI transaction

        // Send the 100 bits one by one through MOSI
        for (i = 0; i <= 99; i = i + 1) begin
           
            data_from_slave = test_data[99-i];
            #2;
        end

        // End SPI transaction

        // Wait for outputs to stabilize
        #1000;

        // End simulation
        $finish;
    end
    // Monitor the outputs
    initial begin
        $monitor("Time=%0t | data_from_slave=%b| prdata=%h | haddr=%h | hwdata=%h | htrans=%b | hreadyin=%b | hwrite=%b",
                 $time,data_from_slave, prdata, haddr, hwdata, htrans, hreadyin, hwrite);
                 
        
    end

endmodule
