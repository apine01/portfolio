// up or down counter

module updown_counter 
  #(parameter up_down = "up", BUS_WIDTH = 4)
  ( 
    i_clk,
    i_sclr,
    i_en,
    o_cnt
	);
  
  reg      dir; // direction of counter 
  
  reg      max; // max value to reset at when the counter is down
  
  input  i_clk; // clock that drives counter
  
  input i_sclr; // clears counter when 1
  
  input   i_en; // input that enables counter 
  
  output reg [BUS_WIDTH-1:0] o_cnt = 0;  // counter output
  
  
// case statement for up and down selection and sets max value

initial begin
  case(up_down)
    "up"   : dir = 1;
	"down" : dir = 0;
  endcase
  
  max = 2**(BUS_WIDTH) - 1; // value that counter resets at when it is 0 
end 

// ----------------------------------------------------------------------------------------------------------
// Counter triggered at every rising edge of the input clock speed
// ----------------------------------------------------------------------------------------------------------
  
always @(posedge i_clk) begin 

  if (i_sclr == 1'b1 && dir)         // up counter clear, clears if sclr is 1
    o_cnt <= 0;
  else if (i_sclr == 1'b1 && !dir)   // down counter clear, clears if sclr is 1
    o_cnt <= max; 
  else if (i_en && dir)              // up counter, only enables circuit if en input is enabled
    o_cnt <= o_cnt + 1;         
  else if (i_en && !dir)
    o_cnt <= o_cnt - 1;  
  else 
    o_cnt <= o_cnt;                  // only purpose of else statement is to prevent latches from being created
  end 
 
endmodule