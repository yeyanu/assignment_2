`timescale 1ns/1ps

module tb_clock_gater;
    reg  clk;
    reg  en;
    wire gclk;
    integer pass_count = 0;
    integer fail_count = 0;

    clock_gater uut (
        .clk(clk),
        .en(en),
        .gclk(gclk)
    );

    always #5 clk = ~clk;

    task check;
        input exp;
        begin
            #1;
            if (gclk === exp) begin
                $display("PASS: clk=%b en=%b gclk=%b", clk, en, gclk);
                pass_count = pass_count + 1;
            end else begin
                $display("FAIL: clk=%b en=%b gclk=%b exp=%b", clk, en, gclk, exp);
                fail_count = fail_count + 1;
            end
        end
    endtask

    initial begin
        clk = 0;
        en  = 0;

        #12; check(0);

        @(negedge clk);
        #2 en = 1; check(0);
        
        @(posedge clk); check(1);
        #10; check(1);

        @(posedge clk);
        #2 en = 0; check(1);
        
        @(negedge clk);
        #1; check(0);

        $display("TOTAL PASS: %0d, TOTAL FAIL: %0d", pass_count, fail_count);
        $finish;
    end
endmodule