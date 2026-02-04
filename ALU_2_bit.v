`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.01.2026 22:30:39
// Design Name: 
// Module Name: ALU_n_bit
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


module ALU_n_bit
#(parameter n=31)
(input [n:0] A,
input [n:0] B,
input [2:0] OP,
output reg z,c,
output reg [n:0] out
);
always@(*)begin
c=1'b0;
case(OP)
3'b000:{c,out}=A+B;
        
3'b001: begin
        out= A-B;
        c=(A<B);
        end
3'b010: out= A*B;
3'b011: out= (A==0||B==0)?0:A/B;
3'b100: out= A&B;
3'b101: out= A|B;
3'b110: out= A^B;
3'b111: out= ~A;
default:out=0;
endcase 
z=1'b0;
z=(out==0)?1'b1:1'b0;
end
endmodule
