module async_fifo_tb( );
    
    parameter add_size = 4, data_size = 8;
        
    reg [data_size-1:0]data_in;
    reg  wr_inc, rd_inc, wr_clk, rd_clk, rd_rst, wr_rst;
    
    wire [data_size-1:0]data_out;
    wire full, empty;
    
    fifo1  DUT(.data_in(data_in),.wr_inc(wr_inc), .rd_inc( rd_inc), .wr_clk(wr_clk), .rd_clk(rd_clk), .rd_rst(rd_rst), .wr_rst(wr_rst),.data_out(data_out),.full(full),.empty(empty));
    
    initial 
    begin
    rd_clk = 1'b0;
    wr_clk = 1'b0;
    rd_rst = 1'b1;
    wr_rst = 1'b1;
    wr_inc = 1'b0;
    rd_inc = 1'b0;
    #20;
    rd_rst = 1'b0;
    wr_rst = 1'b0;
    end
    
    always #7 rd_clk = ~rd_clk;
    always #5 wr_clk = ~wr_clk;
    
    integer i;
    
    initial 
    begin
    #10;
    wr_inc = 1'b1;
    rd_inc = 1'b1;
    for(i = 0; i < (1<<(add_size + 1)); i = i +1)
    begin
    #10 data_in = i;
    end
    #300 $finish;
    end
    
    
endmodule
