module wptr_full #(parameter add_size = 4)

(
output reg full,
output [add_size-1:0] wr_addr,
output reg [add_size :0] wr_ptr,
input [add_size :0] rd_ptr_sync,
input wr_inc, wr_clk, wr_rst
);

reg  [add_size:0] wbin;
wire [add_size:0] wgraynext, wbinnext;


// Memory write-address pointer (okay to use binary to address memory)
assign wr_addr = wbin[add_size-1:0];
assign wbinnext = wbin + (wr_inc & ~full);
assign wgraynext = (wbinnext>>1) ^ wbinnext;

// GRAYSTYLE2 pointer
always @(posedge wr_clk or negedge wr_rst)
begin
if (wr_rst) 
    {wbin, wr_ptr} <= 0;
else 
    {wbin, wr_ptr} <= {wbinnext, wgraynext};
end
assign wfull_val=((wgraynext[add_size] !=rd_ptr_sync[add_size] ) &&
                  (wgraynext[add_size-1] !=rd_ptr_sync[add_size-1]) &&
                  (wgraynext[add_size-2:0]==rd_ptr_sync[add_size-2:0]));
//------------------------------------------------------------------
//assign wfull_val = (wgraynext=={~rd_ptr_sync[add_size:add_size-1],
//rd_ptr_sync[add_size-2:0]});
       
always @(posedge wr_clk or negedge wr_rst)
begin
if (wr_rst) 
    full <= 1'b0;
else 
    full <= wfull_val;
end
endmodule
