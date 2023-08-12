`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/29 14:57:06
// Design Name: irom_test_top
// Module Name: irom_test_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module irom_test_top(
    input sys_rst_n,
    input sys_clk_in,
    input [4:0] sw_pin,
    input [4:0] dip_pin,
    output [7:0] seg_data_0_pin, //output A1,B1,C1,D1,E1,F1,G1,DP1,
    output [7:0] seg_data_1_pin,  //output A0,B0,C0,D0,E0,F0,G0,DP0,
    output [7:0] seg_cs_pin, //DN1_K4,DN1_K3,DN1_K2,DN1_K0,DN0_K4,DN0_K3,DN0_K2,DN0_K1
    output [0:15] led_pin
     );
wire [31:0] pc,inst, pc4;
wire clock_1s;

wire wreg,m2reg,aluimm,sext,wmem,i_lui,i_sw,shift,z;
wire [3:0] aluc;
wire [1:0] pcsource;

 
clk_div div(
.clkin(sys_clk_in),
.clkout(clock_1s)
);

assign pc4 = pc + 32'h4;


dff32 dff32(
    .clk(clock_1s),
    .clrn(sys_rst_n),
    .d(pc4),
    .q(pc)
);


irom irom(
  .clka(clock_1s),    // input wire clka
  .addra(pc[7:2]),  // input wire [5 : 0] addra
  .douta(inst)  // output wire [31 : 0] douta
);

display display(
    .clk(sys_clk_in),
    .reset(sys_rst_n),
    .s(inst),
    .seg0(seg_data_0_pin),
    .seg1(seg_data_1_pin),
    .ans(seg_cs_pin)
);


sc_cu s_cu(
    .inst(inst),
    .z(1'b1),
    .wreg(wreg),
    .m2reg(m2reg),
    .aluimm(aluimm),
    .sext(sext),
    .wmem(wmem),
    .i_lui(i_lui),
    .i_sw(i_sw),
    .shift(shift),
    .aluc(aluc),
    .pcsource(pcsource)
);

assign led_pin = {inst[3:0], z, wmem, wreg, m2reg, aluc,aluimm,pcsource[1:0],sext,i_lui,i_sw,shift};

endmodule

