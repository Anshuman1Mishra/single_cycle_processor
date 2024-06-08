`timescale 1ns / 1ps
module top(
    input clk,
    input reset,
    output [31:0] aluout,
    output [31:0] instr,
    output [31:0] alua,
    output [31:0] ALU_B
    );    
wire [31:0] instruction;
    
instruction_fetch if1(
.clk(clk),
.reset(reset),
.instruction(instruction)
);



//Labelling a bunch of wires
wire [31:0] PC_plus_4;
wire [31:0] PC;
wire Jump;
wire Branch;
wire MemRead;
wire MemtoReg;
wire [1:0] ALUOp;
wire MemWrite;
wire ALSrc;
wire RegDst;
wire [31:0] write_data;
wire RegWrite;
wire [4:0] write_reg;
wire [31:0]read_reg_data_1;
wire [31:0]read_reg_data_2;
wire [31:0] extended;
wire zero;
wire [31:0] ALU_out;
wire [2:0] ALU_control;
wire [31:0] read_data;
wire [31:0] shifted;
wire [31:0] adder2_result;
wire [31:0] mux4_result;
wire [27:0] Out;



//ALU control unit instantiated 
control c1(                  
    .opcode(instruction[31:26]),
    .RegDst(RegDst),
    .Jump(Jump),
    .Branch(Branch),
    .MemRead(MemRead),
    .MemtoReg(MemtoReg),
    .ALUOp(ALUOp),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite)
);


//adder for incrementing PC
 
adder a1(
.clk(clk),
.A(PC),
.B(4),
.sum(PC_plus_4)
);


//mux m1 - output goes to initialize required registers 

mux m1(
    .A(instruction[20:16]),
    .B(instruction[15:11]),
    .sel(RegDst),
    .Out(write_reg)   
);


//Here onwards the requisite modules are instantiated and the 
//inputs and outputs are connected accordingly.


mux m3(
    .A(read_reg_data_1),
    .B(ALU_out),
    .sel(MemtoReg),
    .Out(write_data)
);



//Register file to initialize the required registers.

register_file r1(
    .read_reg_1(instruction[25:21]),
    .read_reg_2(instruction[20:16]),
    .write_reg(write_reg),
    .write_data(write_data),
    .read_reg_data_1(read_reg_data_1),
    .read_reg_data_2(read_reg_data_2),
    .RegWrite(RegWrite) 
);


//sign extension

sign_extender ex1(
    .A(instruction[15:0]),
    .OUT(extended)
);


mux m2(
    .A(read_reg_data_2),
    .B(extended),
    .sel(ALUSrc),
    .Out(ALU_B) 
);

//ALU control - provides basic fiunctionalities to the ALU
ALU_control ALUc(
    .ALUOp(ALUOp),
    .funct(instruction[5:0]),
    .ALU_control(ALU_control)
);

//ALU - performs operations as per the instructions given by ALU control
ALU alu1(

    .ALU_src_1(read_reg_data_1),
    .ALU_src_2(ALU_B),
    .ALU_control(ALU_control),
    .clk(clk),
    .ALU_out(ALU_out),
    .zero(zero)
);

//reading from and writing to data memory
data_memory d1(
    .address(ALU_out),
    .write_data(read_reg_data_2),
    .read_data(read_data),
    .mem_read(MemRead),
    .mem_write(MemWrite)
);


//ouput from sign extender is fed here
shifter s1(
    .A(extended),
    .Out(shifted)   
);

//output from sign extension is fed as input to this adder
adder a2(
.clk(clk),
.A(PC_plus_4),
.B(shifted),
.sum(adder2_result)
);


//One input is PC+4 and other is (PC+4)+shifted instruction
mux m4(
    .A(PC_plus_4),
    .B(adder2_result),
    .sel(Branch & zero),
    .Out(mux4_result)    
);



shifter s2(
    .A(instruction[25:0]),
    .Out(Out)  
);


mux m5(
    .A(mux4_result),
    .B({PC_plus_4, Out}),
    .sel(Jump),
    .Out(PC)    
);

assign aluout = ALU_out;    //output from ALU

assign instr = instruction; //instruction

assign alua = read_reg_data_1; //data


endmodule