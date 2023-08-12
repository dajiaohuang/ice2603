module io_output(resetn,
	addr,datain,write_io_enable,io_clk,PAN,out_port1,out_port2 
);
	input 	[31:0] 	addr,datain;
	input 			write_io_enable,io_clk,resetn;
	output 	[31:0]	PAN,out_port1,out_port2;
	
	reg [31:0]	PAN;
	reg	[31:0]	out_port1;
	reg	[31:0]	out_port2;
	
	always @ (posedge io_clk or negedge resetn)
	begin
		if (resetn == 0)
		begin
		PAN = 0;out_port1 = 0;out_port2 = 0;
		end
		else if (write_io_enable == 1)
			case (addr[7:2])
				6'b101000: PAN = datain; //outport0 byte address oxA0
				6'b101001: out_port1 = datain; //outport1 byte address oxA4 , you can change the address
				6'b101010: out_port2 = datain; //outport2 byte address oxA8 
			endcase
	end
endmodule