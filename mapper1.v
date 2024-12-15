`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.11.2024 02:24:08
// Design Name: 
// Module Name: mapper1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mapper1 (
    input wire clk,                   // Clock signal
    input wire reset_n,               // Active-low reset signal
    input wire data_from_slave,       // 1-bit data received from SPI slave
    output reg [31:0] prdata,         // Output to hardware
    output reg [31:0] haddr,          // Output to hardware
    output reg [31:0] hwdata,         // Output to hardware
    output reg [1:0] htrans,          // Output to hardware
    output reg hreadyin,              // Output to hardware
    output reg hwrite                 // Output to hardware
);

    reg [99:0] bit_register;          // 100-bit internal register to store received data
    reg [6:0] bit_count;              // Counter to track received bits (0-99)

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            // Reset all outputs and registers
            bit_register <= 100'b0;
            bit_count <= 0;
            prdata <= 32'b0;
            haddr <= 32'b0;
            hwdata <= 32'b0;
            htrans <= 2'b0;
            hreadyin <= 1'b0;
            hwrite <= 1'b0;
        end else begin
            // Shift in 1-bit data from SPI slave
            bit_register <= {bit_register[98:0], data_from_slave};
            bit_count <= bit_count + 1;

            // Once all 100 bits are received, map to outputs
            if (bit_count == 101) begin
                prdata <= bit_register[31:0];    // Bits 31:0
                haddr <= bit_register[63:32];   // Bits 63:32
                hwdata <= bit_register[95:64]; // Bits 95:64
                htrans <= bit_register[97:96]; // Bits 97:96
                hreadyin <= bit_register[98];  // Bit 98
                hwrite <= bit_register[99];    // Bit 99

                bit_count <= 0; // Reset bit count for next transaction
            end
        end
    end
endmodule

