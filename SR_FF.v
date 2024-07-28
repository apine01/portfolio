// sr flip flop module

module sr_FF 
  (
    i_clk,
	i_S,
	i_R,
	i_prn,
	i_clrn,
	o_Q
	);
	 
  input  i_clk;  // clock input 
  
  input  i_S;    // set input
  
  input  i_R;    // reset input
  
  input  i_prn;  // preset forces Q = 1 when it is asserted low
  
  input  i_clrn; // clear foces Q = 0 when asserted low
  
  output reg o_Q = 0; // final output

always @(posedge i_clk) begin
  if (!i_prn)
    o_Q <= 1'b1;  
  else if (!i_clrn)
    o_Q <= 1'b0;
  else begin 
    case({i_S, i_R})
      2'b00 : o_Q <=  o_Q;
	  2'b01 : o_Q <= 1'b0;
	  2'b10 : o_Q <= 1'b1;
	  2'b11 : o_Q <= 1'bx;
      endcase
  end 
end 

endmodule 