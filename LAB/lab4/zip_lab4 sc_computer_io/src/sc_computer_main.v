/////////////////////////////////////////////////////////////
//                                                         //
// School of SEIEE of SJTU                              //
//                                                         //
/////////////////////////////////////////////////////////////

module sc_computer_main (
	resetn,clock,imem_clock,dmem_clock,pc,inst,aluout,memout,
	PAN,out_port1,out_port2,in_port0,in_port1);
   
   input resetn,clock,imem_clock,dmem_clock;
   input [31:0] in_port0,in_port1;
   output [31:0] pc,inst,aluout,memout;
   output [31:0] PAN,out_port1,out_port2;
   wire   [31:0] data;
   wire          wmem; // all these "wire"s are used to connect or interface the cpu,dmem,imem and so on.
   
   //sc_cpu , CPU module. add here
   sc_cpu cpu(
   .clock(clock),
   .resetn(resetn),
   .inst(inst),
   .mem(memout),
   .pc(pc),
   .wmem(wmem),
   .aluout(aluout),
   .data(data)
   );

   //sc_instmem  , instruction memory.add here
    sc_instmem imem(
    .addr(pc),
    .inst(inst),
    .clock(clock),
    .imem_clock(imem_clock)
    );

   //sc_datamem   data memory and IO module.add here
    sc_datamem dmem (
    .resetn(resetn),
	.addr(aluout),
	.datain(data),
	.we(wmem),
	.dataout(memout),
	.clock(clock),
	.dmem_clock(dmem_clock),	
	.PAN(PAN),
	.out_port1(out_port1),
	.out_port2(out_port2),
	.in_port0(in_port0),
	.in_port1(in_port1)
    );


endmodule