module sync_w2r #(parameter add_size = 4)

(
output reg [add_size:0] wr_ptr_sync,
input [add_size:0] wr_ptr,
input rd_clk, rd_rst
);

reg [add_size:0] wr1_wptr;

always @(posedge rd_clk or negedge rd_rst)
begin
if (rd_rst) 
    {wr_ptr_sync,wr1_wptr} <= 0;
else
    {wr_ptr_sync,wr1_wptr} <= {wr1_wptr,wr_ptr};
end
endmodule
