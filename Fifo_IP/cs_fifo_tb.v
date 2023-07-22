`timescale 1 ns / 1 ps

module cs_fifo_tb;
    
    reg aclr;
    reg [31:0] data;
    reg rdclk;
    reg rdreq;
    reg wrclk;
    reg wrreq;
    wire [31:0] q;
    wire rdempty;
    
    // Instantiate the cs_fifo module
    cs_fifo dut (
        .aclr(aclr),
        .data(data),
        .rdclk(rdclk),
        .rdreq(rdreq),
        .wrclk(wrclk),
        .wrreq(wrreq),
        .q(q),
        .rdempty(rdempty)
    );
    
    // Initialize signals
    initial begin
        aclr = 1;
        data = 0;
        rdclk = 1;
        rdreq = 0;
        wrclk = 1;
        wrreq = 0;
        
        #10;  // Wait for some time
        
        // De-assert reset
        aclr = 0;
        
        // Write data to the fifo
        wrreq = 1;
        //#5;
        data = 32'h1;
        #10;
        data = 32'h2;
        #10;
        data = 32'h3;
        #15;
   	wrreq = 0; 
	#30;
        // Read data from the fifo
        rdreq = 1;
        #40;
        rdreq = 0;
        
        // Finish simulation
        #10;
        $finish;  // End the simulation
    end
    
    always #5 wrclk = ~wrclk;
    always #5 rdclk = ~rdclk;
    
endmodule
