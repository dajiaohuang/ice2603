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
wire [31:0] pc,inst;
wire clock_1s;


//产生 1s clock
clk_div div(
.clkin(sys_clk_in),
.clkout(clock_1s)
);


//例化dff32 （pc指针寄存器pcdff） & 产生 npc （pc+4）
 



 
// 例化 irom
irom irom (
  .clka(  ),    // input wire clka
  .ena(   ),      // input wire ena
  .addra(    ),  // input wire [5 : 0] addra
  .douta(   )  // output wire [31 : 0] douta
);

//例化display 





//例化sc_cu控制器模块




//显示读取的指令inst最后4bit和控制器的输出显示在led_pin
assign led_pin = {inst[3:0], z, wmem, wreg, m2reg, aluc,aluimm,pcsource[1:0],sext,i_lui,i_sw,shift};

endmodule

