`timescale 1ns / 1ps

module testbench();
reg clk;
reg reset;

wire [31:0] aluout;
wire [31:0] instr;
wire [31:0] alua;
wire [31:0] ALU_B;

top uut (
.clk (clk),
.reset (reset),
.aluout (aluout),
.instr(instr),
.alua(alua),
.ALU_B(ALU_B)
);

initial begin
forever
begin
    clk = 0;
#50;
    clk = 1;
#50;
end 
end
initial begin

reset = 0;
#150;
reset = 1;
#5000;
$finish;
end
endmodule