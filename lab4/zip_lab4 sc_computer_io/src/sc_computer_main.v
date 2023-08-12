/////////////////////////////////////////////////////////////
//                                                         //
// School of SEIEE of SJTU                              //
//                                                         //
/////////////////////////////////////////////////////////////

module sc_computer_main (
	resetn,clock,imem_clock,dmem_clock,pc,inst,aluout,memout,
	out_port0,out_port1,out_port2,in_port0,in_port1);
   
   input resetn,clock,imem_clock,dmem_clock;
	input [31:0] in_port0,in_port1;
   output [31:0] pc,inst,aluout,memout;
   output [31:0] out_port0,out_port1,out_port2;
   wire   [31:0] data;
   wire          wmem; // all these "wire"s are used to connect or interface the cpu,dmem,imem and so on.
   
   //sc_cpu , CPU module. add here



   //sc_instmem  , instruction memory.add here




   //sc_datamem   data memory and IO module.add here




endmodule



