`timescale 1ns / 1ps

module associative_memory(clk,wr,Address,Data_in,Data_out,Hit);
	input [3:0] Address,Data_in;
 	input wr,clk;
   	output [3:0] Data_out;
   	output Hit;
	
	//out-put temporal register for Cache
	reg [3:0] _tmpDout;
	reg hit;

		 
	 //cache Addressess
	 reg [3:0] Addressess [3:0];
	 //cache data
	 reg [3:0] data [3:0];
	 
	//validation check for write data
	reg [3:0] valid;
	
	// setup a counter to check wirte data in proper place (1 line -> 2nd line -> 3rd line -> 4th line)
	reg[3:0] rowN1_en;
	reg[3:0] rowN2_en;
	reg[3:0] rowN3_en;
	reg[3:0] rowN4_en;
	
	
	assign Data_out = _tmpDout;
	assign Hit = hit;
	
	 always @(posedge clk) begin
		// READ
		if (wr == 1'b0) begin
			if (Address == Addressess[0])begin
				_tmpDout <= data[0];
				hit <= 1'b1;
				rowN1_en <=rowN1_en+1;

			end
			else if (Address == Addressess[1])begin
				_tmpDout <= data[1];
				hit <= 1'b1;
				rowN2_en <=rowN2_en+1;
			end
			else if (Address == Addressess[2])begin
				_tmpDout <= data[2];
				hit <= 1'b1;
				rowN3_en <=rowN3_en+1;
			end
			else if (Address == Addressess[3])begin
				_tmpDout <= data[3];
				hit <= 1'b1;
				rowN4_en <=rowN4_en+1;
			end
			else
				hit <= 1'b0;
		end
		// WRITE
		else begin
			if (valid[0] !== 1'b1 && rowN1_en<rowN2_en && rowN1_en<rowN3_en && rowN1_en<rowN4_en)begin
				data[0] <= Data_in;
				Addressess[0] <= Address;
				valid[0] = 1'b1;
				rowN1_en<= 4'b0000;
				
			end
			else if (valid[1] !==  1'b1 && rowN2_en<rowN1_en && rowN2_en<rowN3_en && rowN2_en<rowN4_en)begin
				data[1] <= Data_in;
				Addressess[1] <= Address;
				valid[1] = 1'b1;
				rowN2_en<= 4'b0000;
				
			end
			else if (valid[2] !==  1'b1 && rowN3_en<rowN2_en && rowN3_en<rowN1_en && rowN3_en<rowN4_en)begin
				data[2] <= Data_in;
				Addressess[2] <= Address;
				valid[2] = 1'b1;	
				rowN3_en<= 4'b0000;			
			end
			else if (valid[3] !== 1'b1 && rowN4_en < rowN2_en && rowN4_en<rowN3_en && rowN4_en<rowN1_en)begin
				data[3] <= Data_in;
				Addressess[3] <= Address;
				valid[3] = 1'b1;	
				rowN4_en<= 4'b0000;			
			end

		end
			
		 
			
	 end

	 		
endmodule

