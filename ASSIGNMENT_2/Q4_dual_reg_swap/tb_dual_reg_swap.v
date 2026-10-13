`timescale 1ns/1ps

module tb_dual_reg_swap;
    reg        clk;
    reg        rst_n;
    reg        freeze;
    reg        swap;
    reg  [7:0] din;
    wire [7:0] A;
    wire [7:0] B;
    integer pass_count = 0;
    integer fail_count = 0;

    dual_reg_swap uut (
        .clk(clk),
        .rst_n(rst_n),
        .freeze(freeze),
        .swap(swap),
        .din(din),
        .A(A),
        .B(B)
    );

    always #5 clk = ~clk;

    task check;
        input [7:0] exp_A;
        input [7:0] exp_B;
        begin
            @(negedge clk);
            if (A === exp_A && B === exp_B) begin
                $display("PASS: freeze=%b swap=%b din=%h A=%h B=%h", freeze, swap, din, A, B);
                pass_count = pass_count + 1;
            end else begin
                $display("FAIL: freeze=%b swap=%b din=%h A=%h B=%h exp_A=%h exp_B=%h", freeze, swap, din, A, B, exp_A, exp_B);
                fail_count = fail_count + 1;
            end
        end
    endtask

    initial begin
        clk = 0;
        rst_n = 0;
        freeze = 0;
        swap = 0;
        din = 8'h00;

        #12 rst_n = 1;

        din = 8'hAA; check(8'hAA, 8'h00);
        din = 8'hBB; check(8'hBB, 8'hAA);
        
        freeze = 1; din = 8'hCC; check(8'hBB, 8'hAA);
        
        freeze = 0; swap = 1; check(8'hAA, 8'hBB);
        
        freeze = 1; swap = 1; check(8'hAA, 8'hBB);
        
        freeze = 0; swap = 0; din = 8'hDD; check(8'hDD, 8'hAA);

        $display("TOTAL PASS: %0d, TOTAL FAIL: %0d", pass_count, fail_count);
        $finish;
    end
endmodule