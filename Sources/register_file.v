`timescale 1ns / 1ps
module register_file(
    input [4:0] read_reg_1,
    input [4:0] read_reg_2,
    input [4:0] write_reg,
    input [31:0] write_data,
    output [31:0] read_reg_data_1,
    output [31:0] read_reg_data_2,
    input RegWrite
    );
	 
reg [31:0] regMem [31:0];
initial begin
	$readmemb("register_mem.mem", regMem);
	end
	
	
always@(*)
begin
	if(RegWrite)
	begin
		regMem[write_reg] = write_data;
	end
		
	end
assign read_reg_data_1 = regMem[read_reg_1];
assign read_reg_data_2 = regMem[read_reg_2];
	

endmodule
