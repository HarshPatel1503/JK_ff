module JK_ff(j,k,clk,rst,q,q_bar);
input j,k,clk,rst;
output reg q;
output wire q_bar;
assign q_bar=~q;

always @(posedge clk, posedge rst)
if (rst==1) q<=1'b0;
else
case({j,k})
	2'b00 : q<=q;
	2'b01 : q<=1'b0;
	2'b10 : q<=1'b1;
	2'b11 : q<=~q;   // in sr ff - only change q=1'bx. all code and test bench are same
endcase
endmodule

module JK_ff_tb();
reg j,k,clk,rst;
wire q,q_bar;

JK_ff uut(.q(q),.q_bar(q_bar),.j(j),.k(k),.clk(clk),.rst(rst));

initial begin
rst=1;
#10 rst=0;
clk=0; 
end

initial begin                    
forever #10 clk=~clk;
end
initial begin
{j,k}= 2'b00;
#100 {j,k}=2'b01;
#100 {j,k}=2'b10;
#100 {j,k}=2'b11;
#100 $finish();
end
endmodule