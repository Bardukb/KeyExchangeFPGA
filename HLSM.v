module exp(output reg [29:0] c, input [3:0] a, input [3:0] b);
always@( c, a, b )
begin
        case(b)
        4'b0000:
                case(a)
                        1: c = 1**0; //6
                        2: c = 2**0; //6
                        3: c = 3**0; //6
                        4: c = 4**0; //6
                        5: c = 5**0; //6
                        6: c = 6**0; //6
                        7: c = 7**0; //6
                        8: c = 8**0; //6
                        9: c = 9**0; //6
                        default: c = 0;
                endcase
        4'b0001:
                case(a)
                        1: c = 1**1; //6
                        2: c = 2**1; //6
                        3: c = 3**1; //6
                        4: c = 4**1; //6
                        5: c = 5**1; //6
                        6: c = 6**1; //6
                        7: c = 7**1; //6
                        8: c = 8**1; //6
                        9: c = 9**1; //6
                        default: c = 0;
                endcase
                4'b0010:
                case(a)
                        1: c = 1**2; //6
                        2: c = 2**2; //6
                        3: c = 3**2; //6
                        4: c = 4**2; //6
                        5: c = 5**2; //6
                        6: c = 6**2; //6
                        7: c = 7**2; //6
                        8: c = 8**2; //6
                        9: c = 9**2; //6
                        default: c = 0;
                endcase
                4'b0011:
                case(a)
                        1: c = 1**0; //6
                        2: c = 2**3; //6
                        3: c = 3**3; //6
                        4: c = 4**3; //6
                        5: c = 5**3; //6
                        6: c = 6**3; //6
                        7: c = 7**3; //6
                        8: c = 8**3; //6
                        9: c = 9**3; //6
                        default: c = 0;
                endcase
                4'b0100:
                case(a)
                        1: c = 1**0; //6
                        2: c = 2**4; //6
                        3: c = 3**4; //6
                        4: c = 4**4; //6
                        5: c = 5**4; //6
                        6: c = 6**4; //6
                        7: c = 7**4; //6
                        8: c = 8**4; //6
                        9: c = 9**4; //6
                        default: c = 0;
                endcase
                4'b0101:
                case(a)
                        1: c = 1**5; //6
                        2: c = 2**5; //6
                        3: c = 3**5; //6
                        4: c = 4**5; //6
                        5: c = 5**5; //6
                        6: c = 6**5; //6
                        7: c = 7**5; //6
                        8: c = 8**5; //6
                        9: c = 9**5; //6
                        default: c = 0;
                endcase
                4'b0110:
                case(a)
                        1: c = 1**6; //6
                        2: c = 2**6; //6
                        3: c = 3**6; //6
                        4: c = 4**6; //6
                        5: c = 5**6; //6
                        6: c = 6**6; //6
                        7: c = 7**6; //6
                        8: c = 8**6; //6
                        9: c = 9**6; //6
                        default: c = 0;
                endcase
                4'b0111:
                case(a)
                        1: c = 1**7; //6
                        2: c = 2**7; //6
                        3: c = 3**7; //6
                        4: c = 4**7; //6
                        5: c = 5**7; //6
                        6: c = 6**7; //6
                        7: c = 7**7; //6
                        8: c = 8**7; //6
                        9: c = 9**7; //6
                        default: c = 0;
                endcase
                4'b1000:
                case(a)
                        1: c = 1**8; //6
                        2: c = 2**8; //6
                        3: c = 3**8; //6
                        4: c = 4**8; //6
                        5: c = 5**8; //6
                        6: c = 6**8; //6
                        7: c = 7**8; //6
                        8: c = 8**8; //6
                        9: c = 9**8; //6
                        default: c = 0;
                endcase
                4'b1001:
                case(a)
                        1: c = 1**9; //6
                        2: c = 2**9; //6
                        3: c = 3**9; //6
                        4: c = 4**9; //6
                        5: c = 5**9; //6
                        6: c = 6**9; //6
                        7: c = 7**9; //6
                        8: c = 8**9; //6
                        9: c = 9**9; //6
                        default: c = 0;
                endcase
                                default: c = 0;
        endcase
end
endmodule

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////

module HLSM(input CLK, input [7:0] LED, output wire [3:0] out, output wire [4:0] out2);

reg [3:0] P1Reg; //base
reg [3:0] S1Reg; //alice
reg [3:0] S2Reg; //bob

reg [3:0] I; //input (kinda)

reg [28:0] Reg1; // powered
reg [28:0] Reg2; // powered

reg [3:0] outreg;

reg [3:0] inex1;
reg [3:0] inex2;

reg [3:0] finalSec1;
reg [3:0] finalSec2;

reg [3:0] state = 0;
reg [3:0] nextstate = 0;

wire [3:0] exp1out;

exp exp1(exp1out, inex1, inex2);

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
5'b00000:nextstate = 5'b00001;

5'b00001:if(I == 4'b1011) nextstate = 5'b00010;
			else nextstate = 5'b00001;//waiting
			
5'b00010:if(I == 4'b1111) nextstate = 5'b00011;//takepub1
			else nextstate = 5'b00010;
			
5'b00011:if(I == 4'b1010) nextstate = 5'b00100;//take mod but pass
         else nextstate = 5'b00011;
			
5'b00100:if(I == 4'b1011) nextstate = 5'b00101;//take s1reg
         else nextstate = 5'b00100;

//5'b00101:if(I == 4'b1011) nextstate = 5'b00101;//take s2reg
//         else nextstate = 5'b00101;

			
5'b00101:nextstate = 5'b00110;
5'b00110:nextstate = 5'b00111;
5'b00111:nextstate = 5'b01000;
5'b01000:nextstate = 5'b01001;
5'b01001:nextstate = 5'b01010; //mod2 calc
5'b01010:nextstate = 5'b01011; //computation starts(for secret 1's exp)
5'b01011:nextstate = 5'b01100; //computation starts(for secret 1's mod)
5'b01100:nextstate = 5'b01101; //computation starts(for secret 2's exp)
5'b01101:nextstate = 5'b01111; //computation starts(for secret 2's mod)
//5'b01110 is empty for nice reasons 
5'b01111:if(I == 4'b1011) nextstate = 5'b10000; //show a
         else nextstate = 5'b01111;
5'b10000:if(I == 4'b1010) nextstate = 5'b01111; //show b
         else nextstate = 5'b10000;
default:nextstate = 5'b00000;
endcase

always@(state, I)
case(state)
5'b00000:
	begin 
		P1Reg = 0; 
		S1Reg = 0; 
		S2Reg = 0;  
		Reg1 = 0; 
		Reg2 = 0; 
		inex1 = 0; 
		inex2 = 0; 
		finalSec1 = 0; 
		finalSec2 = 0;
	end 

5'b00010:
	begin
		if(I < 4'b1010 && I != 0)//kesin mi
			P1Reg = I;
		else
			P1Reg = P1Reg;
	end
5'b00100: 
	begin
		if (I < 4'b1010 && I != 0 )
		S1Reg = I;
		else
		S1Reg = S1Reg;
	end
	
5'b00101:
	begin
		if (I < 4'b1010 && I != 0 )
		S2Reg = I;
		else
		S2Reg = S2Reg;
	end
	
5'b00110:
	begin
		inex1 = P1Reg;
		inex2 = S1Reg;
		Reg1 = exp1out;
	end	
5'b00111: Reg1 = Reg1 % 8;

5'b01000:
	begin
		inex1 = P1Reg;
		inex2 = S2Reg;
		Reg2 = exp1out;
	end 		       

5'b01001: Reg2 = Reg2 % 8;
        
5'b01010: begin
		inex1 = Reg2;
		inex2 = S1Reg;
		finalSec1 = exp1out;
	end
											  
5'b01011: finalSec1 = finalSec1 % 8;

5'b01100: begin
		inex1 = Reg1;
		inex2 = S1Reg;
		finalSec2 = exp1out;
	end
        
5'b01101: finalSec2 = finalSec2 % 8;
        
5'b01111: outreg = finalSec1;

5'b10000: outreg = finalSec2;
default: ;

endcase

assign out =  S1Reg;
assign out2 = state;
//assign outTest1 = I;
//assign outTest2 = 11;
endmodule
