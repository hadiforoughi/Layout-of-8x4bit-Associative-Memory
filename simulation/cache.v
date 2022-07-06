`timescale 1ns / 1ps

module associative_memory(addr,din,clk,wr,dout,hit);

	input [3:0] addr;
	input [3:0] din;
   input clk;
   input wr;
   output [3:0] dout;
   output hit;
	reg [3:0] dout;
	reg hit;

		 
	 //cache 0:3 => address, 7:4 => data, 8 => valid
	 reg [3:0] cache [8:0];
	
	
	 always @(posedge clk) begin
		// READ
		if (wr == 1'b0) begin
			if (addr == cache[0][3:0])begin
				dout <= cache[0][7:4];
				hit <= 1'b1;
			end
			else if (addr == cache[1][3:0])begin
				dout <= cache[1][7:4];
				hit <= 1'b1;
			end
			else if (addr == cache[2][3:0])begin
				dout <= cache[2][7:4];
				hit <= 1'b1;
			end
			else if (addr == cache[3][3:0])begin
				dout <= cache[3][7:4];
				hit <= 1'b1;
			end
			else
				hit <= 1'b0;
		end
		// WRITE
		else begin
			if (cache[0][8] !== 1'b1)begin
				cache[0][7:4] <= din;
				cache[0][3:0] <= addr;
				cache[0][8] <= 1'b1;
			end
			else if (cache[1][8] !== 1'b1)begin
				cache[1][7:4] <= din;
				cache[1][3:0] <= addr;
				cache[1][8] <= 1'b1;
			end
			else if (cache[2][8] !== 1'b1)begin
				cache[2][7:4] <= din;
				cache[2][3:0] <= addr;
				cache[2][8] <= 1'b1;
			end
			else if (cache[3][8] !== 1'b1)begin
				cache[3][7:4] <= din;
				cache[3][3:0] <= addr;
				cache[3][8] <= 1'b1;
			end
		end
			
	 end

	 		
endmodule

