# N-Bit Parameterized ALU with Automated Testbench #

This project features a parameterized N-bit Arithmetic Logic Unit (ALU) implemented in Verilog.
The design is highly flexible, allowing the bit-width to be adjusted at instantiation, and includes a comprehensive self-checking testbench to verify functionality across various operations.

## 1. Parametric Design ##
The ALU is designed with a default bit-width of 32 bits (parameter n=31), but can be easily scaled for any application (e.g., 4-bit, 8-bit, 64-bit) during instantiation.

## 2. Supported Operations ##
The ALU supports 8 distinct operations controlled by a 3-bit Operation Code (OP):
1.ADD
2.SUB
3.MUL
4.DIV
5.AND
6.OR
7.XOR
8.NOT

## 3. Status Flags ##
Zero Flag (z): Asserts high (1'b1) if the result of the operation is zero.Carry Flag (c): Asserts high during addition if an overflow occurs, or during subtraction if $A < B$ (borrow).
