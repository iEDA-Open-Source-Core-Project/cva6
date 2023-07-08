
module ysyx_cva6_verilog_wrap(

    /* from ieda */
    input                       clock,
    input                       reset,

    /* AXI4 */
    input                       io_master_arready,
    output                      io_master_arvalid,
    output               [31:0] io_master_araddr,
    output               [ 3:0] io_master_arid,
    output               [ 7:0] io_master_arlen,
    output               [ 2:0] io_master_arsize,
    output               [ 1:0] io_master_arburst,
    output                      io_master_rready,
    input                       io_master_rvalid,
    input                [ 1:0] io_master_rresp,
    input                [63:0] io_master_rdata,
    input                       io_master_rlast,
    input                [ 3:0] io_master_rid,
    input                       io_master_awready,
    output                      io_master_awvalid,
    output               [31:0] io_master_awaddr,
    output               [ 3:0] io_master_awid,
    output               [ 7:0] io_master_awlen,
    output               [ 2:0] io_master_awsize,
    output               [ 1:0] io_master_awburst,
    input                       io_master_wready,
    output                      io_master_wvalid,
    output               [63:0] io_master_wdata,
    output               [ 7:0] io_master_wstrb,
    output                      io_master_wlast,
    output                      io_master_bready,
    input                       io_master_bvalid,
    input                [ 1:0] io_master_bresp,
    input                [ 3:0] io_master_bid
);

wire clk_i;
wire rst_ni;
wire exit_o;




// leesum: rtc clock must slower than core clk 
logic rtc_i;
always_ff @(posedge clock) begin
    rtc_i <= ~rtc_i;
end

assign clk_i = clock;
assign rst_ni = ~reset;

ariane_testharness #(
    .AXI_ADDRESS_WIDTH    (64),
    .AXI_DATA_WIDTH       (64),
    .InclSimDTM           (1'b0),
    // leesum
    .NUM_WORDS            (0),
    // memory size
    .StallRandomOutput    (1'b0),
    .StallRandomInput     (1'b0)
) u_ariane_testharness (
    .clk_i                (clk_i),
    .rtc_i                (rtc_i),
    .rst_ni               (rst_ni),
    /* AXI4 */
    .io_master_arready    (io_master_arready),
    .io_master_arvalid    (io_master_arvalid),
    .io_master_araddr     (io_master_araddr),
    .io_master_arid       (io_master_arid),
    .io_master_arlen      (io_master_arlen),
    .io_master_arsize     (io_master_arsize),
    .io_master_arburst    (io_master_arburst),
    .io_master_rready     (io_master_rready),
    .io_master_rvalid     (io_master_rvalid),
    .io_master_rresp      (io_master_rresp),
    .io_master_rdata      (io_master_rdata),
    .io_master_rlast      (io_master_rlast),
    .io_master_rid        (io_master_rid),
    .io_master_awready    (io_master_awready),
    .io_master_awvalid    (io_master_awvalid),
    .io_master_awaddr     (io_master_awaddr),
    .io_master_awid       (io_master_awid),
    .io_master_awlen      (io_master_awlen),
    .io_master_awsize     (io_master_awsize),
    .io_master_awburst    (io_master_awburst),
    .io_master_wready     (io_master_wready),
    .io_master_wvalid     (io_master_wvalid),
    .io_master_wdata      (io_master_wdata),
    .io_master_wstrb      (io_master_wstrb),
    .io_master_wlast      (io_master_wlast),
    .io_master_bready     (io_master_bready),
    .io_master_bvalid     (io_master_bvalid),
    .io_master_bresp      (io_master_bresp),
    .io_master_bid        (io_master_bid),
    .exit_o               (exit_o)
);

endmodule


