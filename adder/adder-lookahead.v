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


module pc_cal(
	input b1,
	input b2,
	output p,
	output g
	);
assign p = b1 ^ b2;
assign g = b1 & b2;

endmodule

module lca_4bit(
	input 	[3:0] a1,
	input 	[3:0] b1,
	input   cain,
	output 	[3:0]sum,
	output  caout
);
wire [3:0] p;
wire [3:0] g;
wire [4:0] c;
genvar i;
generate
	for(i = 0;i<4;i = i+1) begin
	  pc_cal pc_call(
		.b1		(a1[i]),
		.b2		(b1[i]),
		.p		(p[i]),
		.g		(g[i])
	  );
	end
endgenerate
assign c[0] = cain;
assign c[1] = g[0] | cain&p[0];
assign c[2] = g[1] | g[0]&p[1] | cain&p[1]&p[0];
assign c[3] = g[2] | g[1]&p[2] | g[0]&p[2]&p[1] | cain&p[2]&p[1]&p[0];
assign c[4] = g[3] | g[2]&p[3] | g[1]&p[3]&p[2] | g[0]&p[3]&p[2]&p[1] | cain&p[3]&p[2]&p[1]&p[0];
assign caout = c[4];
assign sum[0] = p[0] ^ c[0];
assign sum[1] = p[1] ^ c[1];
assign sum[2] = p[2] ^ c[2];
assign sum[3] = p[3] ^ c[3];


endmodule

module Add(
	input  [31:0] a,
	input  [31:0] b,
	output reg[31:0] sum
);

wire [32:0] carrys;
wire [31:0] s;
assign carrys[0] = 0;

genvar i;
generate
	for(i = 0;i<32;i = i+4) begin
		lca_4bit lca_4bit(
			.a1		(a[i+3:i]),
			.b1 	(b[i+3:i]),
			.cain 	(carrys[i]),
			.sum 	(s[i+3:i]),
			.caout 	(carrys[i+4])
		);
	end
	
endgenerate
always @(*) begin
		sum = s;
end


	// TODO: Implement this module here
	
endmodule
