module data_mem (
    input clk,
    input MemWrite,
    input MemRead,
    input [31:0] A,
    input [31:0] WD,
    output [31:0] RD
);

reg [31:0] data_mem [1023:0];

integer i;

initial begin
    for(i = 0; i < 1024; i = i + 1)
        data_mem[i] = 32'b0;
end

// WRITE
always @(posedge clk)
begin
    if(MemWrite)
    begin
        data_mem[A[11:2]] <= WD;
    end
end

// READ
assign RD = (MemRead) ? data_mem[A[11:2]] : 32'b0;

endmodule 