/*------------------------------------------------------------------------------
--------------------------------------------------------------------------------
Copyright (c) 2016, Loongson Technology Corporation Limited.

All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this 
list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, 
this list of conditions and the following disclaimer in the documentation and/or
other materials provided with the distribution.

3. Neither the name of Loongson Technology Corporation Limited nor the names of 
its contributors may be used to endorse or promote products derived from this 
software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
DISCLAIMED. IN NO EVENT SHALL LOONGSON TECHNOLOGY CORPORATION LIMITED BE LIABLE
TO ANY PARTY FOR DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE 
GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT 
LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--------------------------------------------------------------------------------
------------------------------------------------------------------------------*/

module mycpu_top(
    input  wire        aclk,
    input  wire        aresetn,            //low active

    output  wire    [3:0]   awid,
    output wire [31:0]      awaddr,
    output  wire    [7:0]   awlen,
    output wire [2:0] awsize,
    output  wire    [1:0]   awburst,
    output  wire    [1:0]   awlock,
    output  wire    [3:0]   awcache,
    output  wire    [2:0]   awprot,
    output wire awvalid,
    input  wire awready,

    output   wire    [3:0]   wid,
    output wire [31:0]      wdata,
    output wire [3:0]    wstrb,
    output  wire    wlast,
    output wire wvalid,
    input  wire wready,

    input   wire    [3:0]   bid,
    input   wire    [1:0]   bresp,
    input  wire bvalid,
    output wire bready,

    output wire [3:0] arid,
    output wire [31:0]      araddr,
    output  wire    [7:0]   arlen,
    output wire [2:0] arsize,
    output  wire    [1:0]   arburst,
    output  wire    [1:0]   arlock,
    output  wire    [3:0]   arcache,
    output  wire    [2:0]   arprot,
    output wire arvalid,
    input  wire arready,

    input wire [3:0] rid,
    input  wire [31:0]      rdata,
    input   wire    [1:0]   rresp,
    input   wire    rlast,
    input  wire rvalid,
    output wire rready,

    output wire [31:0] debug_wb_pc,
    output wire [ 3:0] debug_wb_rf_wen,
    output wire [ 4:0] debug_wb_rf_wnum,
    output wire [31:0] debug_wb_rf_wdata,
    
    input   wire    [7:0]   int
);

assign  awid = 'd0;
assign  awlen = 'd0;
assign  awburst = 2'b01;
assign  awlock = 'd0;
assign  awcache = 'd0;
assign  awprot = 'd0;

assign  wlast = wvalid;
assign  wid = 'd0;

assign  arlen = 'd0;
assign  arburst = 2'b01;
assign  arlock = 'd0;
assign  arcache = 'd0;
assign  arprot = 'd0;

/****************** axi_slate *****************/
cache_wrapper 
#(
    .C_M_AXI_DATA_WIDTH     (32)
)cache_wrapper
(
    .M_AXI_ACLK(aclk),
    .M_AXI_ARESETN(aresetn),

    .M_AXI_AWADDR(awaddr),
    .M_AXI_AWSIZE(awsize),
    .M_AXI_AWVALID(awvalid),
    .M_AXI_AWREADY(awready),

    .M_AXI_WDATA(wdata),
    .M_AXI_WSTRB(wstrb),
    .M_AXI_WVALID(wvalid),
    .M_AXI_WREADY(wready),

    .M_AXI_BVALID(bvalid),
    .M_AXI_BREADY(bready),

    .M_AXI_ARID(arid),
    .M_AXI_ARADDR(araddr),
    .M_AXI_ARSIZE(arsize),
    .M_AXI_ARVALID(arvalid),
    .M_AXI_ARREADY(arready),

    .M_AXI_RID(rid),
    .M_AXI_RDATA(rdata),
    .M_AXI_RVALID(rvalid),
    .M_AXI_RREADY(rready),
    .M_AXI_RLAST(rlast),

    .PC                             (),
    .Inst_Req_Valid                 (),
    .Inst_Req_Ack                   (),  
    .Inst_Ack                       (),
    .instruction                    (),
    .pc_req                         (),
    .Inst_Valid                     (),

    .Flush                          ( ),

    .Address                        (),
    .MemWrite                       (),
    .Write_data                     (),
    .Write_strb                     (),
    .MemRead                        (),
    .Mem_Req_Ack                    (),
    .Read_data                      (),
    .Read_data_Valid                (),
    .Read_data_Ack                  ()
);

/**************** end *******************/
endmodule //mycpu_top