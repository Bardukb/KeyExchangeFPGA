`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:49:33 12/22/2015 
// Design Name: 
// Module Name:    Register 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Register( a1, out1, clk , din );
input clk;
input we;
input [1:0] a1, a2, a3;
output wire [3:0] out1, out2;
input din;
reg [3:0] mem [2:0]; //4bit ram with 3 addresses

always@(posedge clk)
	if ( we)
	begin
		mem[a3] <= din; //writing data in writing is enabled
	end
		
assign out1 = mem[a1];//assigning the addressed memory to output


endmodule

   