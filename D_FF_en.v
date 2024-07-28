// rising edge D Flip Flop with enable input

module DFlipFlop_en 
  (
    i_D,
    i_clk,
	i_prn,
	i_clrn,
	i_en,
	o_Q
	);

  input  i_D;    // Data input 
  
  input  i_clk;  // clock input 
  
  input  i_prn;  // preset forces Q = 1 when it is asserted low
  
  input  i_clrn; // clear foces Q = 0 when asserted low
  
  input i_en;    // enable input
  
  output reg o_Q = 0;    // output Q 
  
always @(posedge i_clk) begin
  if (!i_prn)
    o_Q <= 1'b1;  
  else if (!i_clrn)
    o_Q <= 1'b0;
  else if (i_en == 1'b1)
    o_Q <= i_D; 
  else
    o_Q <= o_Q;
end 
endmodule 