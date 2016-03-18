`timescale 1ns / 1ps
//Bora Bardük, Ekin Uyumaz
//Version 1
//This module outputs keyboard data, taken by a state machine
module wrapper(
	input CLK,		
	input PS2_CLK,		
	input PS2_DATA,		
	output [7:0] keyOut,
	output [0:3] seg,
	output [6:0] dig,
	output DP,
	input takeP, input takeS1, input takeS2, input computeA, input computeB, input showAlice, input showBob
	
    );

	 wire [3:0] segOut, state1, state2;
	 
keyboardController inputdata(
							.CLK(CLK),
							.PS2_CLK(PS2_CLK), 
							.PS2_DATA(PS2_DATA),
							.keyOut(keyOut)
							);
display_controller abc(CLK,0, 4'b1101, segOut, 0,state2,state1,seg,dig, DP);//the zeros and 4'b1101 were in the original design,
																									//they are ignored for our design but left there
controller control( CLK, keyOut, takeP, takeS1, takeS2, computeA, computeB, 
showAlice, showBob,state1, state2,segOut);//we combined out exp and control in a single file
														//thats why there is no exp connections, they are inside


endmodule


