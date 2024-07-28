// RS_232 test bench
// Will test the values of various key presses
// Will mimic baud rate of 115200 bits/second using delays
// 1 bit every 8.68 us, about 8,680 ns delays
`include "RS_232_Decoder.v"
`timescale 1ns/1ns
module RS_232_tb;

  reg r_clk;
  
  reg r_rs_232 = 1'b1;   // idles on high
  
  wire [7:0] w_q;
  
  wire w_data_ready;
   
  reg r_chng;  // easier visibility on waveforms
// Will conduct test using a few different key press values
// Will use value of <U>, <A>, <l>, <a>, <n> 

   parameter [9:0] p_U = 10'b1_01010101_0;
   
   parameter [9:0] p_A = 10'b1_01000001_0;
   
   parameter [9:0] p_l = 10'b1_01101100_0;
   
   parameter [9:0] p_a = 10'b1_01100001_0;
   
   parameter [9:0] p_n = 10'b1_01101110_0;
   
   integer i;            // for loop value
//clock generation-----------------------------------------------------
initial r_clk = 0;
always  #10 r_clk = ~r_clk;

RS_232_main RSuut0
  (
    .clk(r_clk),
	.rs_232(r_rs_232),
	.q(w_q),
	.data_ready(w_data_ready)
	);
	
initial begin
  
  r_chng <= 1'b0;
  #10000 
  for (i=0; i<10; i=i+1) begin
    r_rs_232 <= p_U[i];
	#8680;            // delay to match baud of design
  end 
  
  r_chng <= 1'b1;
  
  #10000   // wait before next set
  
  r_chng <= 1'b0;
  
  for (i=0; i<10; i=i+1) begin
    r_rs_232 <= p_A[i];
	#8680;            // delay to match baud of design
  end 
  
  r_chng <= 1'b1;
  
  #10000   // wait before next set
  
  r_chng <= 1'b0;
  
  for (i=0; i<10; i=i+1) begin
    r_rs_232 <= p_l[i];
	#8680;            // delay to match baud of design
  end 

  r_chng <= 1'b1;
  
  #10000   // wait before next set
  
  r_chng <= 1'b0;
  
  for (i=0; i<10; i=i+1) begin
    r_rs_232 <= p_a[i];
	#8680;            // delay to match baud of design
  end 

  r_chng <= 1'b1;
  
  #10000   // wait before next set
  
  r_chng <= 1'b0;
  
  for (i=0; i<10; i=i+1) begin
    r_rs_232 <= p_n[i];
	#8680;            // delay to match baud of design
  end
   
  #1000
  
  $display("Test is Complete");
  $finish;
end
  
initial begin
  $dumpfile("rs_232.vcd");
  $dumpvars();
end 
endmodule 	