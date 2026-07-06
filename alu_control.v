module alu_control(
    input [6:0] opcode,
    input [1:0] ALUOp,
    input [2:0] funct3,
    input [6:0] funct7,

    output reg [2:0] ALUControl
);

always @(*) begin

    case(ALUOp)

        2'b00: ALUControl = 3'b000; // ADD (lw/sw/addi)

        2'b01: ALUControl = 3'b001; // SUB (beq)

        2'b10:
        begin
            case(funct3)

                3'b000:
                begin
                    if ({opcode[5],funct7[5]} == 2'b11)
                        ALUControl = 3'b001; // SUB
                    else
                        ALUControl = 3'b000; // ADD
                end

                3'b111: ALUControl = 3'b010; // AND

                3'b110: ALUControl = 3'b011; // OR

                3'b100: ALUControl = 3'b100; // XOR

                3'b010: ALUControl = 3'b101; // SLT

                3'b001: ALUControl = 3'b110; // SLL

                3'b101: ALUControl = 3'b111; // SRL

                default: ALUControl = 3'b000;
            endcase
        end

        default:
            ALUControl = 3'b000;

    endcase

end

endmodule