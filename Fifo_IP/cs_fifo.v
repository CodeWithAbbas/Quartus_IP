`timescale 1 ps / 1 ps

module cs_fifo (
    aclr,
    data,
    rdclk,
    rdreq,
    wrclk,
    wrreq,
    q,
    rdempty
);

    input aclr;
    input [31:0] data;
    input rdclk;
    input rdreq;
    input wrclk;
    input wrreq;
    output [31:0] q;
    output rdempty;

    reg [31:0] sub_wire1;
    wire [31:0] q_pregate;

    fifo_ip fifo_0 (
        .data(data),
        .wrreq(wrreq),
        .rdreq(rdreq),
        .wrclk(wrclk),
        .rdclk(rdclk),
        .aclr(aclr),
        .q(q_pregate),
        .rdempty(rdempty)
    );

    always @(posedge rdclk or posedge aclr) begin
        if (aclr == 1)
            sub_wire1 <= 0;
        else if (~rdempty && rdreq)
            sub_wire1 <= q_pregate;
    end

    assign q = sub_wire1;

endmodule
