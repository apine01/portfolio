// RS-232 Decoder
`include "Rising_D_FF.v"     // rising edge D Flip Flop
`include "D_FF_en.v"         // D Flip Flop with enable input
`include "SR_FF.v"           // SR Flip Flop
`include "updown_counter.v"  // up counter
`include "comparator.v"      // comparator for A = B


//---------------------------------------------------------------------------------------------------------
// Serial input, reset, and timing for decoder
//---------------------------------------------------------------------------------------------------------
module RS_232_timing
  ( 
    i_clk,
	i_rs_232,
	i_reset,
	o_s_in,
	o_time
	);

  input i_clk;
  
  input i_rs_232;        // input rs-232 bits
  
  input i_reset;         // resets SR ff to clear counter
  
  output o_s_in;         // output serial value after rs-232 input
  
  output [12:0] o_time;  // output from counter that will set off comparators at proper time
  
// Value to ensure the flip flops function

  wire Vcc;
  assign Vcc = 1'b1;
  
// D FlipFlop --------------------------------------------------------- 
DFlipFlop dff0
  (
    .i_D(i_rs_232),
    .i_clk(i_clk),
	.i_prn(Vcc),
	.i_clrn(Vcc),
	.o_Q(o_s_in)     // will be inverted and taken as input to SR ff
	);

// wires needed for connection
  wire dff0_Qb;               // Q bar
  assign dff0_Qb = ~o_s_in;   // invert serial input for SR ff
  
  wire srff0_Q;               // SR ff output wire

// SR FlipFlop --------------------------------------------------------- 
sr_FF srff0
  (
    .i_clk(i_clk),
	.i_S(dff0_Qb),
	.i_R(i_reset),
	.i_prn(Vcc),
	.i_clrn(Vcc),
	.o_Q(srff0_Q)    // will be inverted and taken as sclr input for timing counter
	);

// wires needed for connection
  wire srff0_Qb;
  assign srff0_Qb = ~srff0_Q;  // invert SR ff output for counter clear

// Timing counter --------------------------------------------------------- 
updown_counter #(.BUS_WIDTH(13)) upd0
  ( 
    .i_clk(i_clk),
    .i_sclr(srff0_Qb),  
    .i_en(Vcc),         // always enabled  
    .o_cnt(o_time)      // final timing output
	);
endmodule 


//---------------------------------------------------------------------------------------------------------
// DFFs set at baud rate with comparators 
//---------------------------------------------------------------------------------------------------------
module RS_232_DFFs
  (
    i_clk,
	i_s_in,
	i_time,
	o_q,
	o_data_ready,
	o_reset
	);
	
  input i_clk;
  
  input i_s_in;          // input that is fed from serial output of timing section, will feed into D input of flip flops
  
  input [12:0] i_time;   // input that is fed from counter output of timing section, sets off comparators which will enable DFFs
  
  output [7:0] o_q;      // decoded output from RS_232
  
  output o_reset;        // resets when all bits have been decoded
  
  output o_data_ready;   // output that is sent out every reset
  
// Value to ensure the flip flops function

  wire Vcc;
  assign Vcc = 1'b1;
  
//--------------------------------------------------------------------------------------------------------
// q[0], Time 651 --------------------------------------------------------- 
  wire q0_aeb;  // agb and alb ports will be left unused
  wire    q_0;  // output bit q[0]  
  
comparator #(.data_B(651)) comp0
  (
    .i_data_A(i_time),
	.o_aeb(q0_aeb),
	.o_agb(), 
	.o_alb()
	);

DFlipFlop_en dff_en0
  (
    .i_D(i_s_in),
    .i_clk(i_clk),
	.i_prn(Vcc),
	.i_clrn(Vcc),
	.i_en(q0_aeb),
	.o_Q(q_0)
	);

	
// q[1], Time 1085 --------------------------------------------------------- 
  wire q1_aeb;  // agb and alb ports will be left unused
  wire    q_1;  // output bit q[1]  
  
comparator #(.data_B(1085)) comp1
  (
    .i_data_A(i_time),
	.o_aeb(q1_aeb),
	.o_agb(), 
	.o_alb()
	);

DFlipFlop_en dff_en1
  (
    .i_D(i_s_in),
    .i_clk(i_clk),
	.i_prn(Vcc),
	.i_clrn(Vcc),
	.i_en(q1_aeb),
	.o_Q(q_1)
	);
	

// q[2], Time 1519 --------------------------------------------------------- 
  wire q2_aeb;  // agb and alb ports will be left unused
  wire    q_2;  // output bit q[2]  
  
comparator #(.data_B(1519)) comp2
  (
    .i_data_A(i_time),
	.o_aeb(q2_aeb),
	.o_agb(), 
	.o_alb()
	);

DFlipFlop_en dff_en2
  (
    .i_D(i_s_in),
    .i_clk(i_clk),
	.i_prn(Vcc),
	.i_clrn(Vcc),
	.i_en(q2_aeb),
	.o_Q(q_2)
	);
	

// q[3], Time 1953 --------------------------------------------------------- 
  wire q3_aeb;  // agb and alb ports will be left unused
  wire    q_3;  // output bit q[3]  
  
comparator #(.data_B(1953)) comp3
  (
    .i_data_A(i_time),
	.o_aeb(q3_aeb),
	.o_agb(), 
	.o_alb()
	);

DFlipFlop_en dff_en3
  (
    .i_D(i_s_in),
    .i_clk(i_clk),
	.i_prn(Vcc),
	.i_clrn(Vcc),
	.i_en(q3_aeb),
	.o_Q(q_3)
	);
	

// q[4], Time 2387 --------------------------------------------------------- 
  wire q4_aeb;  // agb and alb ports will be left unused
  wire    q_4;  // output bit q[4]  
  
comparator #(.data_B(2387)) comp4
  (
    .i_data_A(i_time),
	.o_aeb(q4_aeb),
	.o_agb(), 
	.o_alb()
	);

DFlipFlop_en dff_en4
  (
    .i_D(i_s_in),
    .i_clk(i_clk),
	.i_prn(Vcc),
	.i_clrn(Vcc),
	.i_en(q4_aeb),
	.o_Q(q_4)
	);
	
	
// q[5], Time 2821 --------------------------------------------------------- 
  wire q5_aeb;  // agb and alb ports will be left unused
  wire    q_5;  // output bit q[5]  
  
comparator #(.data_B(2821)) comp5
  (
    .i_data_A(i_time),
	.o_aeb(q5_aeb),
	.o_agb(), 
	.o_alb()
	);

DFlipFlop_en dff_en5
  (
    .i_D(i_s_in),
    .i_clk(i_clk),
	.i_prn(Vcc),
	.i_clrn(Vcc),
	.i_en(q5_aeb),
	.o_Q(q_5)
	);


// q[6], Time 3255 --------------------------------------------------------- 
  wire q6_aeb;  // agb and alb ports will be left unused
  wire    q_6;  // output bit q[6]  
  
comparator #(.data_B(3255)) comp6
  (
    .i_data_A(i_time),
	.o_aeb(q6_aeb),
	.o_agb(), 
	.o_alb()
	);

DFlipFlop_en dff_en6
  (
    .i_D(i_s_in),
    .i_clk(i_clk),
	.i_prn(Vcc),
	.i_clrn(Vcc),
	.i_en(q6_aeb),
	.o_Q(q_6)
	);
	

// q[7], Time 3689 --------------------------------------------------------- 
  wire q7_aeb;  // agb and alb ports will be left unused
  wire    q_7;  // output bit q[7]  
  
comparator #(.data_B(3689)) comp7
  (
    .i_data_A(i_time),
	.o_aeb(q7_aeb),
	.o_agb(), 
	.o_alb()
	);

DFlipFlop_en dff_en7
  (
    .i_D(i_s_in),
    .i_clk(i_clk),
	.i_prn(Vcc),
	.i_clrn(Vcc),
	.i_en(q7_aeb),
	.o_Q(q_7)
	);
	

// data ready and reset, Time 4123 --------------------------------------------------------- 
// comparator outputs reset
// flip flop outputs data_ready line
 
comparator #(.data_B(4123)) comp8
  (
    .i_data_A(i_time),
	.o_aeb(o_reset),
	.o_agb(), 
	.o_alb()
	);

  wire w_reset;
  assign w_reset = o_reset; // will be input to last d flip flop
  
DFlipFlop dff_d_r             //  regular D flip flop, no enable input like the others
  (
    .i_D(w_reset),
    .i_clk(i_clk),
	.i_prn(Vcc),
	.i_clrn(Vcc),
	.o_Q(o_data_ready)
	);

// put together data bus from outputs	


assign o_q = {q_7, q_6, q_5, q_4, q_3, q_2, q_1, q_0};

endmodule 
 
 
 
 //---------------------------------------------------------------------------------------------------------
// Main module that connects both prior ones // main_(input/output_signal
//---------------------------------------------------------------------------------------------------------

module RS_232_main
  (
    clk,
	rs_232,
	q,
	data_ready
	);

  input clk;
  
  input rs_232;
  
  output [7:0] q;
  
  output data_ready;
  
 
  wire w_s_in;
  wire [12:0] w_time;

RS_232_timing time0
  ( 
    .i_clk(clk),
	.i_rs_232(rs_232),
	.i_reset(reset),
	.o_s_in(w_s_in),
	.o_time(w_time)
	);

 wire reset; 
 
RS_232_DFFs baud0
  (
    .i_clk(clk),
	.i_s_in(w_s_in),
	.i_time(w_time),
	.o_q(q),
	.o_data_ready(data_ready),
	.o_reset(reset)
	);
	
endmodule 