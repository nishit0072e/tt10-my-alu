\m5_TLV_version 1d: tl-x.org
\m5

   // *******************************************
   // * For ChipCraft Course                    *
   // * Replace this file with your own design. *
   // *******************************************

   use(m5-1.0)
\SV
/*
 * Copyright (c) 2023 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`define default_netname none

module tt_um_nishit0072e_counter (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);
wire reset = ! rst_n;
   

logic [3:0] a, b, s, f;
    
    // 2. Connect module inputs to the logic unit signals
    // Input 'a' from switches 0-3
    assign a = ui_in[3:0];
    // Input 'b' from switches 4-7
    assign b = ui_in[7:4];
    // Function select 's' from bidirectional pins 0-3
    assign s = uio_in[3:0];

    // The logic unit implementation
    always_comb begin
        // Default assignment to prevent latches
        f = 'x; 

        case (s)
            4'h0: f = ~a;         // NOT A
            4'h1: f = ~(a | b);   // A NOR B
            4'h2: f = ~a & b;
            4'h3: f = '0;         // Logic 0
            4'h4: f = ~(a & b);   // A NAND B
            4'h5: f = ~b;         // NOT B
            4'h6: f = a ^ b;      // A XOR B
            4'h7: f = a & ~b;
            4'h8: f = ~a | b;
            4'h9: f = ~(a ^ b);   // A XNOR B
            4'hA: f = b;          // Pass B
            4'hB: f = a & b;      // A AND B
            4'hC: f = '1;         // Logic 1
            4'hD: f = a | ~b;
            4'hE: f = a | b;      // A OR B
            4'hF: f = a;          // Pass A
            default: f = 'x;
        endcase
    end
    
    // 3. Connect the logic unit's result 'f' to the module outputs
    // Result 'f' drives LEDs 0-3. LEDs 4-7 are off.
    assign uo_out = {4'b0000, f};


  // All output pins must be assigned. If not used, assign to 0.
 // assign uo_out  = ui_in;  // Example: ou_out is ui_in
  //assign uio_out = 0;
  //assign uio_oe  = 0;

endmodule
