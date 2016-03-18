

module HLSM2(input CLK, input [7:0] LED, output wire [3:0] out, output wire [4:0] out2);

reg [3:0] P1Reg; //base
reg [3:0] S1Reg; //alice
reg [3:0] S2Reg; //bob

reg [3:0] I; //input (kinda)

reg [3:0] state = 0, stateS;
reg [3:0] nextstate = 0;

reg[3:0] outreg;


always@(LED)
case(LED)
8'b01000101: I = 4'b0000; //0
8'b00010110: I = 4'b0001; //1
8'b00011110: I = 4'b0010; //2
8'b00100110: I = 4'b0011; //3
8'b00100101: I = 4'b0100; //4
8'b00101110: I = 4'b0101; //5
8'b00110110: I = 4'b0110; //6
8'b00111101: I = 4'b0111; //7
8'b00111110: I = 4'b1000; //8
8'b01000110: I = 4'b1001; //9
8'b00011100: I = 4'b1010; //A
8'b00110010: I = 4'b1011; //B base -> bob
8'b00100001: I = 4'b1100; //C  
8'b00100011: I = 4'b1101; //D
8'b00100100: I = 4'b1110; //E
8'b00101011: I = 4'b1111; //F mod
default: I = 4'bxxxx;     //default
endcase

always@(posedge CLK)
state <= nextstate;

always@(I, state)
case(state)
//reset state
5'b00000:begin
			P1Reg <= 0;
			S1Reg <= 0;
			S2Reg <= 0;
			if(I == 4'b1011)//if we are ready to take pub 1(b, 8'b00110010)
			nextstate = 5'b00001;
			else nextstate = 5'b00000;//waiting
			end
//take public 1			
5'b00001:begin


			outreg = P1Reg;
			if(I == 4'b1010) //if we are ready to take private 1(a, 8'b00011100)
			nextstate = 5'b00010;
			else nextstate = 5'b00001;
			
			if(I < 4'b1010 && I != 0)
				P1Reg <= I;
			else
				P1Reg <= P1Reg;
			end
//take private 1			
5'b00010:begin
			outreg = S1Reg;

			if(I == 4'b1011)//if we are ready to take private 2(b, 8'b00110010)
			nextstate = 5'b00011;
         else nextstate = 5'b00010;
			
			if (I < 4'b1010 && I != 0 )
			S1Reg <= I;
			else
			S1Reg <= S1Reg;
			end
//take private 2
5'b00011:begin
			outreg = S2Reg;
			if (I < 4'b1010 && I != 0 )
			S2Reg <= I;
			else
			S2Reg <= S2Reg;
			if(I == 4'b1100) //if we are ready to compute(c, 8'b00100001)
			nextstate = 5'b00100;
         else nextstate = 5'b00011;
			end
//we compute and store			
5'b00100: begin
			outreg = (S1Reg + S2Reg + P1Reg) ;
			nextstate = 5'b00101;
			end

//we show the computed value
5'b00101:if( I == 4'b1110)//if we are ready to reset ( e, 8'b00100100)
			nextstate = 5'b00000;
			else
			nextstate = 5'b00101;
default:nextstate = 5'b00000;
endcase

always @ (state)
case (state)
5'b00000: stateS = 4'b0000;
5'b00001: stateS = 4'b1101;
5'b00010: stateS = 4'b1010;
5'b00011: stateS = 4'b1011;
5'b00100: stateS = 4'b1100;
5'b00101: stateS = 4'b1110;
default: stateS = 0;
endcase

//always@(state, I) //yapildi
//case(state)
//5'b00000:
//	begin 
//		//P1Reg = 0; 
//		S1Reg = 0; 
//		S2Reg = 0; 
//		outreg = 0;
//	end 

//5'b00001://yapildi
//	begin
//		if(I < 4'b1010 && I != 0)
//			P1Reg <= I;
//		else
//			P1Reg <= P1Reg;
//	end

//5'b00010: //yapildi
//	begin
//		if (I < 4'b1010 && I != 0 )
//		S1Reg = I;
//		else
//		S1Reg = S1Reg;
//	end
//	
//5'b00011://yapildi
//	begin
//		if (I < 4'b1010 && I != 0 )
//		S2Reg = I;
//		else
//		S2Reg = S2Reg;
//	end
//	
//5'b00100:
//	outreg = (S1Reg + S2Reg + P1Reg) ;
//
//default: begin
//	outreg = 0;
//end
//
//endcase

assign out =  outreg;
assign out2 = stateS;
//assign outTest1 = I;
//assign outTest2 = 11;
endmodule

