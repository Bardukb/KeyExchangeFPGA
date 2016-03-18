//Bora Bardük, Ekin Uyumaz
//Version 1
//This module outputs keyboard data, taken by a state machine

module keyboardController(	input CLK,	 input PS2_CLK,	input PS2_DATA,  output reg [7:0] keyOut	 );

	reg [11:0] datapack;		//this is used to detect how much time passed since it received the previous codeword
	reg prev;			//used to check the previous state of the keyboard clock signal to know if it changed
	reg [10:0] scan;			//this stores 11 received serially in parallel form
	reg [3:0]count;				//counts the number of received bits
	reg slowcount = 0;			//This acts the sentinel value of the slow clock. 
	reg move;				//check is we have any more bits to read left
		reg move2;				//look at code
	reg [7:0]countd = 0;		//
	//Set initial values
	initial begin
		prev = 1;			
		scan = 0;
		count = 0;			
		keyOut = 0;
		move = 0;
		datapack = 0;
	end

	always @(posedge CLK) begin	//Slow counter for keyboard input safety purposses
		if (countd < 249) begin			
			countd <= countd + 1;
			slowcount <= 0;
		end
		else begin
			countd <= 0;
			slowcount <= 1;
		end
	end
	
	always @(posedge CLK) begin	
		if (slowcount) begin
			if (move)				//if we need to read the next bit 
				datapack <= datapack + 1;	//adds the serial value to the datapack
			else 						//if we shouldn't move but read anyway
				datapack <= 0;			//error value
		end
	end


	always @(posedge CLK) begin		
	if (slowcount) begin						//If out slow clock is triggered
		if (PS2_CLK != prev) begin			//if we have keyboard's clock changing
			if (!PS2_CLK) begin				//keyboard outptus data in the falling edge
				move <= 1;				//move to the next bit
				scan[10:0] <= {PS2_DATA, scan[10:1]};	//Parallelly construct an output 
				count <= count + 1;			//
			end
		end
		else if (count == 11) begin				//If we received all the bits
			count <= 0;
			move <= 0;					//Stop moving
			move2 <= 1;	

		end	
		else  begin						//If we have more bits to go
			move2 <= 0;					//dont move until we received all the bits
			if (count < 11 && datapack >= 4000) begin	//if no bits are received
				count <= 0;				//reset the number of bits received
				move <= 0;				
			end
		end
	prev <= PS2_CLK;					//record the previous clock
	end
	end

	
	always @(posedge CLK) begin
	if (slowcount) begin
		if (move2) begin
		keyOut<=scan[8:1];//output the required information 

		end
	end
	end

endmodule

