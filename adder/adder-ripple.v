/* ACM Class System (I) Fall Assignment 1 
 *
 *
 * Implement your naive adder here
 * 
 * GUIDE:
 *   1. Create a RTL project in Vivado
 *   2. Put this file into `Sources'
 *   3. Put `test_adder.v' into `Simulation Sources'
 *   4. Run Behavioral Simulation
 *   5. Make sure to run at least 100 steps during the simulation (usually 100ns)
 *   6. You can see the results in `Tcl console'
 *
 */


module full_adder(
	input b1,
	input b2,
	input cain,
	output sum,
	output caout
	);
assign sum = b1 ^ b2 ^ cain;
assign caout = (b1 & b2)|(cain & (b1 ^ b2));

endmodule

module Add(
	input  [31:0] a,
	input  [31:0] b,
	output [31:0] sum
);

wire [32:0] tmpcarry;
assign tmpcarry[0] = 'd0;

genvar i;
generate
	for(i = 0;i<32;i = i+1) begin
	  full_adder adderi(
		.b1		(a[i]),
		.b2		(b[i]),
		.cain	(tmpcarry[i]),
		.caout	(tmpcarry[i+1]),
		.sum	(sum[i])
	  );
	end
endgenerate


	// TODO: Implement this module here
	
endmodule
