//Bora Bardük, Ekin Uyumaz
//Version 1
//This module outputs multiple seven segment columns with the required information

module display_controller (
		input clk, clear,
		input [1:4] enables, 
		input [3:0] digit4, digit3, digit2, digit1,
		output [0:3] AN,
		output [6:0] C,
		output       DP
		);

		reg [3:0] current_digit, cur_dig_AN;
		reg [6:0] segments;
		
      assign AN = ~(enables & cur_dig_AN);// AN signals are active low,
                                // and must be enabled to display digit
      assign C = ~segments;     // since the CA values are active low
      assign DP = 1;            // the dot point is always off 
                                // (0 = on, since it is active low)

// the 18-bit counter, runs at 50 MHz, so bit16 changes each 1.3 millisecond
	   localparam N=18;
	   reg [N-1:0] count;
	always @(posedge clk, posedge clear)
		if(clear) count <= 0;
		else count <= count + 1;	

// the upper-2 bits of count cycle through the digits and the AN patterns			
	always @ (count[N-1:N-2], digit1, digit2, digit3, digit4)
	   case (count[N-1:N-2])
                // left most, AN1  
		2'b00: begin current_digit = digit4; cur_dig_AN = 4'b0001; end  
		2'b01: begin current_digit = digit3; cur_dig_AN = 4'b0010; end
		2'b10: begin current_digit = digit2; cur_dig_AN = 4'b0100; end
		2'b11: begin current_digit = digit1; cur_dig_AN = 4'b1000; end
                // right most, AN4
		default: begin current_digit = 4'bxxxx; cur_dig_AN = 4'bxxxx; end
	   endcase

// the hex-to-7-segment decoder
	always @ (current_digit)
		case (current_digit)
		4'b0000: segments = 7'b111_1110;  // 0
		4'b0001: segments = 7'b011_0000;  // 1
		4'b0010: segments = 7'b110_1101;  // 2
		4'b0011: segments = 7'b111_1001;  // 3
		4'b0100: segments = 7'b011_0011;  // 4
		4'b0101: segments = 7'b101_1011;  // 5
		4'b0110: segments = 7'b101_1111;  // 6
		4'b0111: segments = 7'b111_0000;  // 7
		4'b1000: segments = 7'b111_1111;  // 8
		4'b1001: segments = 7'b111_0011;  // 9
		4'b1010: segments = 7'b111_0111;  // A
		4'b1011: segments = 7'b001_1111;  // b
		4'b1100: segments = 7'b000_1101;  // c
		4'b1101: segments = 7'b011_1101;  // d
		4'b1110: segments = 7'b100_1111;  // E
		4'b1111: segments = 7'b100_0111;  // F
		default: segments = 7'bxxx_xxxx;
		endcase		
endmodule