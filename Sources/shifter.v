`timescale 1ns / 1ps


module shifter(
    input [31:0] A,
    output reg [31:0] Out
    );

always@(*)
begin
Out = A<<2;
end
endmodule

