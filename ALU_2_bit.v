`timescale 1ns / 1ps

module alu_tb_32bit();

    reg  [31:0] a;
    reg  [31:0] b;
    reg  [3:0]  op;     
    wire [31:0] o;
    wire Z, C, N;         // added N: ALU_n_bit also exposes `negative`, unlike ALU_2_bit

    ALU_2_bit #(.n(31)) dut (.A(a), .B(b), .OP(op), .z(Z), .c(C), .negative(N), .out(o));

    reg [31:0] e;
    reg z1, c1, n1;

    initial begin
       $dumpfile("waveform.vcd");
       $dumpvars(0,alu_tb_32bit);

        $display("started checking");

        // ---- Group 1: A = 0xFFFFFFFF, B = 0xFFFFFFFF ----
        a = 32'hFFFFFFFF; b = 32'hFFFFFFFF;

        op=4'b0000; e=32'hFFFFFFFE; z1=1'b0; c1=1'b1; n1=1'b1; ce(); // ADD
        #5 op=4'b0001; e=32'h00000000; z1=1'b1; c1=1'b0; n1=1'b0; ce(); // SUB
        #5 op=4'b0010; e=32'hFFFFFFFF; z1=1'b0; c1=1'b0; n1=1'b1; ce(); // AND
        #5 op=4'b0011; e=32'hFFFFFFFF; z1=1'b0; c1=1'b0; n1=1'b1; ce(); // OR
        #5 op=4'b0100; e=32'h00000000; z1=1'b1; c1=1'b0; n1=1'b0; ce(); // XOR
        #5 op=4'b0101; e=32'h80000000; z1=1'b0; c1=1'b0; n1=1'b1; ce(); // SLL (shamt=B[4:0]=31)
        #5 op=4'b0110; e=32'h00000001; z1=1'b0; c1=1'b0; n1=1'b0; ce(); // SRL (shamt=31)
        #5 op=4'b0111; e=32'hFFFFFFFF; z1=1'b0; c1=1'b0; n1=1'b1; ce(); // SRA (shamt=31)
        #5 op=4'b1000; e=32'h00000000; z1=1'b1; c1=1'b0; n1=1'b0; ce(); // SLT  (-1 < -1 ? no)
        #5 op=4'b1001; e=32'h00000000; z1=1'b1; c1=1'b0; n1=1'b0; ce(); // SLTU (equal -> no)

        // ---- Group 2: A = 0x00000002, B = 0x00000001 ----
        #5 a = 32'h00000002; b = 32'h00000001;

        op=4'b0000; e=32'h00000003; z1=1'b0; c1=1'b0; n1=1'b0; ce(); // ADD
        #5 op=4'b0001; e=32'h00000001; z1=1'b0; c1=1'b0; n1=1'b0; ce(); // SUB
        #5 op=4'b0010; e=32'h00000000; z1=1'b1; c1=1'b0; n1=1'b0; ce(); // AND
        #5 op=4'b0011; e=32'h00000003; z1=1'b0; c1=1'b0; n1=1'b0; ce(); // OR
        #5 op=4'b0100; e=32'h00000003; z1=1'b0; c1=1'b0; n1=1'b0; ce(); // XOR
        #5 op=4'b0101; e=32'h00000004; z1=1'b0; c1=1'b0; n1=1'b0; ce(); // SLL (shamt=1)
        #5 op=4'b0110; e=32'h00000001; z1=1'b0; c1=1'b0; n1=1'b0; ce(); // SRL (shamt=1)
        #5 op=4'b0111; e=32'h00000001; z1=1'b0; c1=1'b0; n1=1'b0; ce(); // SRA (shamt=1)
        #5 op=4'b1000; e=32'h00000000; z1=1'b1; c1=1'b0; n1=1'b0; ce(); // SLT  (2<1? no)
        #5 op=4'b1001; e=32'h00000000; z1=1'b1; c1=1'b0; n1=1'b0; ce(); // SLTU (2<1? no)

        // ---- Group 3: A = 0x80000000 (min negative), B = 0x00000001 ----
        #5 a = 32'h80000000; b = 32'h00000001;

        op=4'b0000; e=32'h80000001; z1=1'b0; c1=1'b0; n1=1'b1; ce(); // ADD
        #5 op=4'b0001; e=32'h7FFFFFFF; z1=1'b0; c1=1'b0; n1=1'b0; ce(); // SUB (A<B? unsigned no -> c=0)
        #5 op=4'b0111; e=32'hC0000000; z1=1'b0; c1=1'b0; n1=1'b1; ce(); // SRA sign-extend
        #5 op=4'b1000; e=32'h00000001; z1=1'b0; c1=1'b0; n1=1'b0; ce(); // SLT  (min_neg < 1 signed? yes)
        #5 op=4'b1001; e=32'h00000000; z1=1'b1; c1=1'b0; n1=1'b0; ce(); // SLTU (0x80000000 < 1 unsigned? no)

        $display("stop checking!");
        $finish;
    end

    task ce;
        #1
        if (o!==e || c1!==C || z1!==Z || n1!==N)
            $display(
                "ERROR @t=%0t | A=%h B=%h OP=%b | OUT=%h Z=%b C=%b N=%b | EXP=%h Z=%b C=%b N=%b",
                $time, a, b, op, o, Z, C, N, e, z1, c1, n1);
        else
            $display("working");
    endtask

endmodule
