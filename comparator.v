// comparator 

module comparator 
  #(parameter data_B = 10, DATA_WIDTH = 13)
  (
    i_data_A,
	o_aeb,
	o_agb,
	o_alb
	);
	
  input [DATA_WIDTH-1:0] i_data_A;       // data input
  
  output reg o_aeb;                      // output when the input data is equal to desired number
  
  output reg o_agb;                      // output when the input data is greater than desired number
  
  output reg o_alb;                      // output when the input data is less than desired number
  
  
always @(*) begin
  if (i_data_A == data_B) begin 
    o_aeb = 1'b1;
	o_agb = 1'b0;
	o_alb = 1'b0;
  end 
  
  else if (i_data_A > data_B) begin 
    o_agb = 1'b1;
    o_aeb = 1'b0;
	o_alb = 1'b0;
  end
  
  else if (i_data_A < data_B) begin 
    o_alb = 1'b1;
    o_aeb = 1'b0;
	o_agb = 1'b0;
  end
  else begin
    o_aeb = 1'b0;
	o_agb = 1'b0;
	o_alb = 1'b0;
  end 
end 

endmodule 