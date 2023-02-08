// created by : Meher Krishna Patel
// date : 22-Dec-2016
// Modified by : Riccardo Cantoro (last change: 18-Nov-2020)


module lfsr
#(
    parameter N = 286,
    parameter SEED = 1
)

(
// seed 286 vector connected to controller to change the seed
    input wire clk, reset_lfsr, 
    output wire [N:0] q
);

reg [N:0] r_reg;
wire [N:0] r_next;
wire feedback_value;
                        
always @(posedge clk ,posedge reset_lfsr)
begin 
    if (reset_lfsr)
        r_reg <= SEED;  // use this or uncomment below two line
	else if (clk == 1'b1)  // remove clk in synthesis stage
        r_reg <= r_next;
end

generate
case (N)
3:
	//// Feedback polynomial : x^3 + x^2 + 1
	////total sequences (maximum) : 2^3 - 1 = 7
	assign feedback_value = r_reg[3] ~^ r_reg[2] ~^ r_reg[0];

4:	assign feedback_value = r_reg[4] ~^ r_reg[3] ~^ r_reg[0];

5:  //maximum length = 28 (not 31)
	assign feedback_value = r_reg[5] ~^ r_reg[3] ~^ r_reg[0];

7:      assign feedback_value = r_reg[7] ~^ r_reg[6] ~^ r_reg[0];      

9:	assign feedback_value = r_reg[9] ~^ r_reg[5] ~^ r_reg[0];

10: 	assign feedback_value = r_reg[10] ~^ r_reg[7] ~^ r_reg[0];

16: 	assign feedback_value = r_reg[16] ~^ r_reg[15] ~^ r_reg[13] ~^ r_reg[4] ~^ r_reg[0];

30:     assign feedback_value = r_reg[30] ~^ r_reg[29] ~^ r_reg[26] ~^ r_reg[24] ~^ r_reg[0];

286:     assign feedback_value = r_reg[286] ~^ r_reg[285] ~^ r_reg[276] ~^ r_reg[271] ~^ r_reg[0];

291:     assign feedback_value = r_reg[291] ~^ r_reg[286] ~^ r_reg[280] ~^ r_reg[279] ~^ r_reg[0];
default: 
	begin
		 initial
			$display("Missing N=%d in the LFSR code, please implement it!", N);
		//illegal missing_case("please implement");
	end		
endcase
endgenerate


assign r_next = {feedback_value, r_reg[N:1]};
assign q = r_reg;
endmodule
