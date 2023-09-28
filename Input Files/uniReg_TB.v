`timescale 1ns / 1ps

module uniReg_TB();

reg clk, rst;
reg [3:0] din;
reg dr, dl;
reg [1:0] s;
wire [3:0] q;

initial 
begin
    clk = 0;
    rst = 1;
    din = 4'b0000;
    s = 2'b00;
end

uniReg DUT(clk, rst, din, dr, dl, s, q);

task hold;
begin
    s = 2'b00;
    rst = 0;
end
endtask

task shiftRight;
begin
    s = 2'b01;
    dr = 1;
    rst = 0;
end
endtask

task shiftLeft;
begin
    s = 2'b10;
    dl = 1;
    rst = 0;
end
endtask

task parallelLoad;
begin
    s = 2'b11;
    din = 4'b1011;
    rst = 0;
end
endtask

always #50 clk = ~clk;

initial
begin
    rst = 1;
    #100 rst = 0;
    
    parallelLoad;
    #200;
    
    hold;
    #200;
    
    shiftRight;
    #600;
    
    parallelLoad;
    #200;
    
    shiftLeft;
    #600;
    
    parallelLoad;
    #200;
    
    hold;
    #200;
end

initial #2000 $finish;

endmodule
