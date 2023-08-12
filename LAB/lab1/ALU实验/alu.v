module alu (a,b,aluc,s,z);
   input [31:0] a,b;
   input [3:0] aluc;
   output [31:0] s;
   output        z;
   wire z;
   wire [31:0] s;
//   wire [31:0]tmp = a>>b;
   assign  s = (aluc == 4'b0000)? a + b: 
               (aluc == 4'b1000)? a - b:
               (aluc == 4'b0111)? a & b:
               (aluc == 4'b0110)? a | b:
               (aluc == 4'b0100)? a ^ b:
               (aluc == 4'b0010)? b    :
               (aluc == 4'b0001)? a << b:
               (aluc == 4'b0101)? a >> b:
               (aluc == 4'b1101)? ( (a[31] == 1'b0) ? (a>>b): ({32{1'b1}}<<(32-b))+(a>>b)):
//                (aluc == 4'b1101)? ($signed(a))>>>b: 
               0;
  assign z = (s == 0); 

endmodule 