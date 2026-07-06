module Control_Unit_Top(
    input  [6:0] Op,
    input  [2:0] funct3,
    input  [6:0] funct7,

    output RegWrite,
    output ALUSrc,
    output MemWrite,
    output ResultSrc,
    output Branch,
    output [1:0] ImmSrc,
    output [2:0] ALUControl
);

wire [1:0] ALUOp;

Main_Decoder decoder (
    .Op(Op),
    .RegWrite(RegWrite),
    .ImmSrc(ImmSrc),
    .MemWrite(MemWrite),
    .ResultSrc(ResultSrc),
    .Branch(Branch),
    .ALUSrc(ALUSrc),
    .ALUOp(ALUOp)
);

alu_control ALUCTRL (
    .ALUOp(ALUOp),
    .funct3(funct3),
    .funct7(funct7),
    .opcode(Op),
    .ALUControl(ALUControl)
);

endmodule