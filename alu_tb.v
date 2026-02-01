`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.02.2026 10:52:08
// Design Name: 
// Module Name: alu_tb
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


module alu_tb();
 reg [1:0] a;
   reg [1:0] b;
   reg [2:0] op;
   wire [1:0] o;
   wire Z,C;
   ALU_2_bit dut(.A(a),.B(b),.OP(op),.z(Z),.c(C),.out(o));
   reg [1:0] e;
   reg z1,c1; 
   initial begin
    $display("started checking");
    a=2'b11;
    b=2'b11;
    op=3'b000;
    e=2'b10;
    z1=1'b0;
    c1=1'b1; 
    ce();
    #5 op=3'b001;
       e=2'b00;
       z1=1'b1;
       c1=1'b0;
       ce();
    #5 op=3'b010;
       e=2'b01;
       z1=1'b0;
       c1=1'b0;
        ce();
    #5 op=3'b011;
       e=2'b01;
       z1=1'b0;
       c1=1'b0;
       ce();
       
    #5 op=3'b100;
       e=2'b11;
       z1=1'b0;
       c1=1'b0;
       ce();

    #5 op=3'b101;
       e=2'b11;
       z1=1'b0;
       c1=1'b0;
       ce();
    #5 op=3'b110;
       e=2'b00;
       z1=1'b1;
       c1=1'b0;
       ce();
    #5 op=3'b111;
       e=2'b00;
       z1=1'b1;
       c1=1'b0;
       ce();
    #5 
    a=2'b10;
    b=2'b01;
    op=3'b000;
    e=2'b11;
    z1=1'b0;
    c1=1'b0;
    ce();
    #5 op=3'b001;
       e=2'b01;
       z1=1'b0;
       c1=1'b0;
       ce();
    #5 op=3'b010;
       e=2'b10;
       z1=1'b0;
       c1=1'b0;
       ce();
    #5 op=3'b011;
       e=2'b10;
       z1=1'b0;
       c1=1'b0;
       ce();
    #5 op=3'b100;
       e=2'b00;
       z1=1'b1;
       c1=1'b0;
       ce();
    #5 op=3'b101;
       e=2'b11;
       z1=1'b0;
       c1=1'b0;
       ce();
    #5 op=3'b110;
       e=2'b11;
       z1=1'b0;
       c1=1'b0;
       ce();
    #5 op=3'b111;
       e=2'b01;
       z1=1'b0;
       c1=1'b0;
       ce();
 $display("stop checking!");
 end
task ce;
  #1
  if(o!=e || c1!=C || z1!=Z)
   $display(
      "ERROR @t=%0t | A=%b B=%b OP=%b | OUT=%b Z=%b C=%b | EXP=%b Z=%b C=%b",
      $time, a, b, op, o, Z, C, e, z1, c1);
  else
  $display("working");
endtask
endmodule
