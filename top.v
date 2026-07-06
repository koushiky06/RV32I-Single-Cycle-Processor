module single_cycle_top(
    input clk,
    input rst
);

wire [31:0] PC_Top;
wire [31:0] RD_Instr;
wire [31:0] RD1_Top;
wire [31:0] RD2_Top;
wire [31:0] Imm_Ext_Top;
wire [31:0] SrcB;
wire [31:0] ALUResult;
wire [31:0] ReadData;
wire [31:0] Result;
wire [31:0] PCPlus4;

wire RegWrite;
wire MemWrite;
wire ALUSrc;
wire ResultSrc;

wire [1:0] ImmSrc;
wire [2:0] ALUControl_Top;


//====================
// Program Counter
//====================
pc PC0 (
    .clk(clk),
    .reset(rst),
    .pc_next(PCPlus4),
    .pc(PC_Top)
);


//====================
// PC + 4
//====================
PC_Adder ADD0 (
    .a(PC_Top),
    .b(32'd4),
    .c(PCPlus4)
);


//====================
// Instruction Memory
//====================
instr_mem IMEM (
    .A(PC_Top),
    .RD(RD_Instr)
);


//====================
// Register File
//====================
regfile RF (
    .clk(clk),
    .WE3(RegWrite),
    .A1(RD_Instr[19:15]),
    .A2(RD_Instr[24:20]),
    .A3(RD_Instr[11:7]),
    .WD3(Result),
    .RD1(RD1_Top),
    .RD2(RD2_Top)
);


//====================
// Immediate Generator
//====================
imm_gen IMM (
    .instr(RD_Instr),
    .ImmSrc(ImmSrc),
    .imm_out(Imm_Ext_Top)
);


//====================
// ALU Source Mux
//====================
Mux MUX1 (
    .a(RD2_Top),
    .b(Imm_Ext_Top),
    .s(ALUSrc),
    .c(SrcB)
);


//====================
// Control Unit
//====================
Control_Unit_Top CU (
    .Op(RD_Instr[6:0]),
    .RegWrite(RegWrite),
    .ImmSrc(ImmSrc),
    .ALUSrc(ALUSrc),
    .MemWrite(MemWrite),
    .ResultSrc(ResultSrc),
    .Branch(),
    .funct3(RD_Instr[14:12]),
    .funct7(RD_Instr[31:25]),
    .ALUControl(ALUControl_Top)
);


//====================
// ALU
//====================
alu ALU0 (
    .A(RD1_Top),
    .B(SrcB),
    .ALUcontrol(ALUControl_Top),
    .zero(),
    .Result(ALUResult)
);


//====================
// Data Memory
//====================
data_mem DMEM (
    .clk(clk),
    .MemWrite(MemWrite),
    .WD(RD2_Top),
    .A(ALUResult),
    .RD(ReadData)
);


//====================
// Write Back Mux
//====================
Mux MUX2 (
    .a(ALUResult),
    .b(ReadData),
    .s(ResultSrc),
    .c(Result)
);

endmodule

 
 
 
 
 
 
 
 
 
 
 
 
 
 
