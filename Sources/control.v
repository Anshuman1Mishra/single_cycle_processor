`timescale 1ns / 1ps

module control(
    input [5:0] opcode,
    output reg RegDst,
    output reg Jump,
    output reg Branch,
    output reg MemRead,
    output reg MemtoReg,
    output reg [1:0] ALUOp,
    output reg MemWrite,
    output reg ALUSrc,
    output reg RegWrite
    );
always@(*)
begin
case(opcode)
	6'b000000 : begin       //	R - type
						RegDst = 1;
						ALUSrc = 0;
						MemtoReg = 0;
						RegWrite = 1;
						MemRead = 0;
						MemWrite = 0;
						Branch = 0;
						ALUOp[1] = 1;
						ALUOp[0] = 0;
						end
	6'b100011 : begin			//LW
						RegDst = 0;
						ALUSrc = 1;
						MemtoReg = 1;
						RegWrite = 1;
						MemRead = 1;
						MemWrite = 0;
						Branch = 0;
						ALUOp[1] = 0;
						ALUOp[0] = 0;
						end
	6'b101011 : begin			//SW
						RegDst = 0;
						ALUSrc = 1;
						MemtoReg = 0;
						RegWrite = 0;
						MemRead = 0;
						MemWrite = 1;
						Branch = 0;
						ALUOp[1] = 0;
						ALUOp[0] = 0;
						end
	6'b000100 : begin			//beq
						RegDst = 0;
						ALUSrc = 0;
						MemtoReg = 0;
						RegWrite = 0;
						MemRead = 0;
						MemWrite = 0;
						Branch = 1;
						ALUOp[1] = 0;
						ALUOp[0] = 1;
						end
	default : begin			
						RegDst = 0;
						ALUSrc = 0;
						MemtoReg = 0;
						RegWrite = 0;
						MemRead = 0;
						MemWrite = 0;
						Branch = 0;
						ALUOp[1] = 0;
						ALUOp[0] = 0;
						end
endcase

end


endmodule
