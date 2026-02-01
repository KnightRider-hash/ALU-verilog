`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.01.2026 22:30:39
// Design Name: 
// Module Name: ALU_2_bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU_2_bit(
   input [1:0] A,
input [1:0] B,
input [2:0] OP,
output reg z,c,
output reg [1:0] out
    );
    always@(*)begin
c=1'b0;
case(OP)
3'b000: begin
        out= A+B;
        c = (A[1]&B[1]) | (A[0]&B[0]&(A[1] | B[1]));
        end
3'b001: begin
        out= A-B;
        c=(A<B)?1'b1:1'b0;
        end
3'b010: out= A*B;
3'b011: out= (A==0||B==0)?2'b00:A/B;
3'b100: out= A&B;
3'b101: out= A|B;
3'b110: out= A^B;
3'b111: out= ~A;
default:out=2'bxx;
endcase 
z=1'b0;
z=(out==2'b00)?1'b1:1'b0;
end
endmodule
