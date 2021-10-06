//course code
module fifo1 #(parameter data_size = 8,parameter add_size = 4)
(
output [data_size-1:0] data_out,
output full,
output empty,
input [data_size-1:0] data_in,
input wr_inc, wr_clk, wr_rst,
input rd_inc, rd_clk, rd_rst
);

wire [add_size-1:0] wr_addr, rd_addr;
wire [add_size:0] wr_ptr, rd_ptr, rd_ptr_sync, wr_ptr_sync;

sync_r2w #(.add_size(add_size)) sync_r2w 
 (
 .rd_ptr_sync(rd_ptr_sync),
 .rd_ptr(rd_ptr),
 .wr_clk(wr_clk),
 .wr_rst(wr_rst)
 );

sync_w2r #(.add_size(add_size)) sync_w2r 
(
.wr_ptr_sync(wr_ptr_sync),
.wr_ptr(wr_ptr),
.rd_clk(rd_clk),
.rd_rst(rd_rst)
);

fifomem #(.data_size(data_size),.add_size(add_size)) fifomem
(
.data_out(data_out),
.data_in(data_in),
.wr_addr(wr_addr),
.rd_addr(rd_addr),
.wr_clken(wr_inc),
.full(full),
.wr_clk(wr_clk),
.rd_clk(rd_clk)
);

rptr_empty #(.add_size(add_size)) rptr_empty
(
.empty(empty),
.rd_addr(rd_addr),
.rd_ptr(rd_ptr), 
.wr_ptr_sync(wr_ptr_sync),
.rd_inc(rd_inc), 
.rd_clk(rd_clk),
.rd_rst(rd_rst)
);

wptr_full #(.add_size(add_size)) wptr_full
(
.full(full), 
.wr_addr(wr_addr),
.wr_ptr(wr_ptr), 
.rd_ptr_sync(rd_ptr_sync),
.wr_inc(wr_inc), 
.wr_clk(wr_clk),
.wr_rst(wr_rst)
);
