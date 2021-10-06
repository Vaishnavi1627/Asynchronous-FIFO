module fifomem #(parameter data_size = 8, // Memory data word width
parameter add_size = 4) // Number of mem address bits + MSB

(
output reg [data_size-1:0] data_out,
input [data_size-1:0] data_in,
input [add_size-1:0] wr_addr, rd_addr,
input wr_clken, full, wr_clk, rd_clk
);

localparam DEPTH = 1<< add_size;
reg [data_size-1:0] mem [0:DEPTH-1];

always @(posedge rd_clk)
begin
     data_out <= mem[rd_addr];
end
always @(posedge wr_clk)
begin
if (wr_clken && !full)
     mem[wr_addr] <= data_in;
end

endmodule
