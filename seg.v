`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:13:21 12/19/2015 
// Design Name: 
// Module Name:    seg 
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
module segment( A, seg , dig);

input [7:0] A;

output reg [6:0]dig;

output reg [3:0]seg;

always@ ( A)

begin

seg = 4'b1110;

		case (A)
		8'b01000101: segments = 7'b111_1110;  // 0
		8'b00010110: segments = 7'b011_0000;  // 1
		8'b00011110: segments = 7'b110_1101;  // 2
		8'b00100110: segments = 7'b111_1001;  // 3
		8'b00100101: segments = 7'b011_0011;  // 4
		8'b00101110: segments = 7'b101_1011;  // 5
		8'b00110110: segments = 7'b101_1111;  // 6
		8'b00111101: segments = 7'b111_0000;  // 7
		8'b00111110: segments = 7'b111_1111;  // 8
		8'b01000110: segments = 7'b111_0011;  // 9
		8'b00011100: segments = 7'b111_0111;  // A
		8'b00110010: segments = 7'b001_1111;  // b
		8'b00100001: segments = 7'b000_1101;  // c
		8'b00100011: segments = 7'b011_1101;  // d
		8'b00100100: segments = 7'b100_1111;  // E
		8'b00101011: segments = 7'b100_0111;  // F
		default: segments = 7'bxxx_xxxx;
		endcase		

end

