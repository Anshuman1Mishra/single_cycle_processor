`timescale 1ns / 1ps

module instruction_fetch(
    input clk,
    input reset,
    output [31:0] instruction
    );
reg [31:0] PC;
instruction_memory I1 (
.read_address(PC),
.reset(reset),
.instruction(instruction)
);


always@(posedge clk, reset)
begin
if(reset == 0)
	PC <= 0;
else 
	PC <= PC +4;
end 

endmodule
