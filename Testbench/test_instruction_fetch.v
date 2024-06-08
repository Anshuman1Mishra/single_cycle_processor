`timescale 1ns / 1ps

module test_instruction_fetch();
reg clk;
reg reset;
// Outputs
wire [31:0] Instruction_code;
// Instantiate the Unit Under Test (UUT) 
instruction_fetch uut (

.clk (clk),
.reset (reset),
.instruction (Instruction_code)
);
initial begin
forever
begin
clk = 0;
#50;
clk = 1;
#50;
end end
initial begin
// Initialize Inputs
reset = 0;
// Wait 100 ns for global reset to finish
 #50;
reset = 1;
#500;
$finish;
end
endmodule