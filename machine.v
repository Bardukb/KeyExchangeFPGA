`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:51:45 12/19/2015 
// Design Name: 
// Module Name:    machine 
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
module machine( 	input CLK,		//board clock signal
	input PS2_CLK,		//keyboard clock signal
	input PS2_DATA,		//keyboard data signal
	output [7:0] LED,	//8 output LEDs
	output [0:3] seg,
	output [6:0] dig, input next1, input next2, input reset);
	reg [1:0] state = 0, nstate = 0;
	reg [7:0] out;
	reg [7:0] areg;
	reg [7:0] breg;
	
	wrapper wrap( CLK, PS2_CLK, PS2_DATA, LED); //seg dig degistir?
	keyboarddecoder abc( out, seg , dig);
	
	always @( posedge CLK) 
		state <= nstate;
	always @ (state)
		case( state)
		2'b00://initial
		nstate = 3'b001;
		2'b01: nstate = next1 ? 2'b10: 2'b01;
		2'b10: nstate = next2 ? 2'b11: 2'b10;
		2'b11: nstate = reset ? 2'b00: 2'b11;
		endcase
	always @ (state)
	case( state)
	
	2'b00:
	begin
		out = 0;
		areg = 0;
		breg = 0;
	end


	2'b01:
	begin
	areg = LED;
	out = areg;
	end
	
	2'b10:
	begin
	breg = LED;
	out = breg;
	end
	
	2'b11:
	out = areg + breg;
	endcase

endmodule

