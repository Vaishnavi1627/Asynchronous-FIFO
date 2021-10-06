module sync_r2w #(parameter add_size = 4)
(
output reg [add_size:0] rd_ptr_sync,
input [add_size:0] rd_ptr,
input wr_clk, wr_rst
);

reg [add_size:0] rd1_rptr;

always @(posedge wr_clk or negedge wr_rst)
begin
if (wr_rst) 
{rd_ptr_sync,rd1_rptr} <= 0;
else 
{rd_ptr_sync,rd1_rptr} <= {rd1_rptr,rd_ptr};
end
endmodule
