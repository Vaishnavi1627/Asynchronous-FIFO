module rptr_empty #(parameter add_size = 4)
(
output reg empty,
output [add_size-1:0] rd_addr,
output reg [add_size :0] rd_ptr,
input [add_size :0] wr_ptr_sync,
input rd_inc, rd_clk, rd_rst
);

reg [add_size:0] rbin;
wire [add_size:0] rgraynext, rbinnext;

// Memory read-address pointer (okay to use binary to address memory)

assign rd_addr = rbin[add_size-1:0];
assign rbinnext = rbin + (rd_inc & ~empty);
assign rgraynext = (rbinnext>>1) ^ rbinnext;

// GRAYSTYLE2 pointer
//-------------------
always @(posedge rd_clk or negedge rd_rst)
begin
if (rd_rst) 
    {rbin, rd_ptr} <= 0;
else 
    {rbin, rd_ptr} <= {rbinnext, rgraynext};
end  
//---------------------------------------------------------------
// FIFO empty when the next rptr == synchronized wptr or on reset
//---------------------------------------------------------------
assign rempty_val = (rgraynext == wr_ptr_sync);

always @(posedge rd_clk or negedge rd_rst)
begin
if (rd_rst)
    empty <= 1'b1;
else 
    empty <= rempty_val;
end
endmodule
