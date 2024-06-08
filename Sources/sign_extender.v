`timescale 1ns / 1ps


module sign_extender(
    input [15:0] A,
    output reg [31:0] OUT
    );
always@(*)
 
begin
OUT[15:0] = A;
OUT[31:16] = {16{A[15]}};
end 

endmodule
