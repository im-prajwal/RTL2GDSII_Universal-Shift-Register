module uniReg(
    input clk, rst,
    input [3:0] din,
    input dr, dl,
    input [1:0] s,
    output [3:0] q
    );
    
wire [3:0] y;
    
mux41 M3(s[1:0], {din[3], q[2], dr, q[3]}, y[3]);
mux41 M2(s[1:0], {din[2], q[1], q[3], q[2]}, y[2]);
mux41 M1(s[1:0], {din[1], q[0], q[2], q[1]}, y[1]);
mux41 M0(s[1:0], {din[0], dl, q[1], q[0]}, y[0]);
    
d_ff DFF3(clk, rst, y[3], q[3]);    
d_ff DFF2(clk, rst, y[2], q[2]);
d_ff DFF1(clk, rst, y[1], q[1]);
d_ff DFF0(clk, rst, y[0], q[0]);

endmodule


module mux41(
    input [1:0] s,
    input [3:0] i,
    output reg y
    );
    
     
always @(*)
begin
    case(s)
        2'b00: y = i[0];
        2'b01: y = i[1];
        2'b10: y = i[2];
        2'b11: y = i[3];
        default: y = 1'bz;
    endcase
end
    
endmodule


module d_ff(
    input clk, rst, d,
    output reg q
    );
    
always @(posedge clk)
begin
    if(rst==1)
        begin
            q <= 0;
        end
    else
        begin
            q <= d;
        end
end

endmodule
