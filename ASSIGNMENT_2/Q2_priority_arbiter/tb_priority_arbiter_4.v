`timescale 1ns/1ps

module tb_priority_arbiter_4;
    reg        clk;
    reg        rst;
    reg  [3:0] req;
    wire [3:0] grant;
    integer pass_count = 0;
    integer fail_count = 0;

    priority_arbiter_4 uut (
        .clk(clk),
        .rst(rst),
        .req(req),
        .grant(grant)
    );

    always #5 clk = ~clk;

    task check;
        input [3:0] exp;
        begin
            @(negedge clk);
            if (grant === exp) begin
                $display("PASS: rst=%b req=%b grant=%b", rst, req, grant);
                pass_count = pass_count + 1;
            end else begin
                $display("FAIL: rst=%b req=%b grant=%b exp=%b", rst, req, grant, exp);
                fail_count = fail_count + 1;
            end
        end
    endtask

    initial begin
        clk = 0;
        rst = 1;
        req = 4'b0000;
        #12;
        rst = 0;

        req = 4'b1000; check(4'b1000);
        req = 4'b1010; check(4'b0010);
        req = 4'b1111; check(4'b0001);
        req = 4'b1100; check(4'b0100);
        req = 4'b0000; check(4'b0000);
        
        req = 4'b1111;
        #3 rst = 1; check(4'b0000);

        $display("TOTAL PASS: %0d, TOTAL FAIL: %0d", pass_count, fail_count);
        $finish;
    end
endmodule