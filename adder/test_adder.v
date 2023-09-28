`include "adder.v"

module test_adder;
	wire [31:0] answer;
	wire 		carry;
	reg  [31:0] a, b;
	reg	 [32:0] res;

	Add adder (a, b, answer);
	
	integer i;
	initial begin
		for(i=1; i<=100; i=i+1) begin
			a[31:0] = $random;
			b[31:0] = $random;
			res		= a + b;
			
			#1;
			$display("TESTCASE %d: %d + %d = %d carry: %d", i, a, b, answer, carry);

			if (answer !== res[31:0] || carry != res[32]) begin
				$display("Wrong Answer!");
			end
		end
		$display("Congratulations! You have passed all of the tests.");
		$finish;
	end
endmodule
