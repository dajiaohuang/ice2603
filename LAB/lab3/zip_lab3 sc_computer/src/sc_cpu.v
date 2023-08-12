module sc_cpu (clock,resetn,inst,mem,pc,wmem,aluout,data);
   input [31:0] inst,mem;
   input clock,resetn;
   output [31:0] pc,aluout,data;
   output wmem;
  
   wire [31:0]   p4,branchpc,jalrpc,npc,immediate;
   wire [31:0]   ra,rb,regf_din;//regfile output a,b, input data
   wire [31:0]   alua,alub,alu_mem;
   wire [3:0]    aluc;
   wire [1:0]    pcsource;// 00 normal; 01 beq,bne;10 jalr;11 jal
   wire          zero,wmem,wreg,m2reg,aluimm,sext,i_lui,i_sw,shift;
  

  //pc register unit ,dff32
   dff32 ip (npc,clock,resetn,pc);  // define a D-register for PC
  

  //immedate data extent unit ,   immext
   immext ImmGen(inst,pcsource,sext,i_lui,i_sw,shift,immediate);// generate ext immediate,
    
  //register file,   mux2x32 , regfile
   regfile rf(
     .clk(clock),
     .clrn(resetn),
     .rna(inst[19:15]),
     .rnb(inst[24:20]),
     .qa(ra),
     .qb(data),
     .wn(inst[11:7]),
     .we(wreg),
     .d(regf_din)
   );
  
//  assign data = rb;


  //control unit ,sc_cu
   sc_cu cu (inst,zero,wmem,wreg,m2reg,aluc,aluimm,pcsource,sext,i_lui,i_sw,shift);


  //alu unit   , mux2x32,alu
   alu al_unit(
     .a(ra),
     .b(alub),
     .aluc(aluc),
     .s(aluout),
     .z(zero)
   );

  //next pc generate ,   cla32 ,mux4x32
   mux4x32 nextpc(
     .s(pcsource),
     .a0(p4),
     .a1(branchpc),
     .a2(jalrpc),
     .a3(branchpc),
     .y(npc)
   );

   wire [31:0]tmp;
  //write back register file,   mux2x32 
   mux2x32 result(
     .s(m2reg),
     .a1(mem),
     .a0(aluout),
     .y(tmp)
   );

   mux2x32 link(
     .s(pcsource[1]),
     .a0(tmp),
     .a1(p4),
     .y(regf_din)
   );

   mux2x32 alu_b(
     .s(aluimm),
     .a1(immediate),
     .a0(data),
     .y(alub)
   );

   cla32 pcplus4(
     .pc(pc),
     .x1(32'h4),
     .p4(p4)
   );

   cla32 branch_adr(
     .pc(pc),
     .x1(immediate),
     .p4(branchpc)
   );

   cla32 genjalrpc(
     .pc(ra),
     .x1(immediate),
     .p4(jalrpc)
   );
    
endmodule