
module clk_div(clkin,clkout);
input clkin;
output clkout;
reg [26:0] count;
always@ (posedge clkin)
 begin
    count = count + 1;
 end
assign clkout = count[26];
endmodule
  
