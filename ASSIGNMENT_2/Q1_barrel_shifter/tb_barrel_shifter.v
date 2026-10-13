`timescale 1ns/1ps

module tb_barrel_shifter;
    reg  [3:0] din;
    reg  [1:0] amt;
    reg  [1:0] mode;
    wire [3:0] dout;
    integer pass_count = 0;
    integer fail_count = 0;

    barrel_shifter_4bit uut (
        .din(din),
        .amt(amt),
        .mode(mode),
        .dout(dout)
    );

    task check;
        input [3:0] exp;
        begin
            #1;
            if (dout === exp) begin
                $display("PASS: mode=%b amt=%d din=%b dout=%b", mode, amt, din, dout);
                pass_count = pass_count + 1;
            end else begin
                $display("FAIL: mode=%b amt=%d din=%b dout=%b exp=%b", mode, amt, din, dout, exp);
                fail_count = fail_count + 1;
            end
        end
    endtask

    initial begin
        din = 4'b1101;
        
        mode = 2'b00; amt = 2'd0; #9; check(4'b1101);
        mode = 2'b00; amt = 2'd1; #9; check(4'b1010);
        mode = 2'b00; amt = 2'd2; #9; check(4'b0100);
        
        mode = 2'b01; amt = 2'd1; #9; check(4'b0110);
        mode = 2'b01; amt = 2'd2; #9; check(4'b0011);
        
        mode = 2'b10; amt = 2'd1; #9; check(4'b1011);
        mode = 2'b10; amt = 2'd3; #9; check(4'b1110);
        
        mode = 2'b11; amt = 2'd1; #9; check(4'b1110);
        mode = 2'b11; amt = 2'd2; #9; check(4'b0111);
        
        $display("TOTAL PASS: %0d, TOTAL FAIL: %0d", pass_count, fail_count);
        $finish;
    end
endmodule