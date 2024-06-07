`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2024 02:12:22 PM
// Design Name: 
// Module Name: UART
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module UART(
input               clk     , // Top level system clock input.
input               rst,
input               uart_rx_en,
input   wire        uart_rxd, // UART Recieve pin.
input wire [PAYLOAD_BITS-1:0]  uart_tx_data,
input wire        uart_tx_en,
output wire [PAYLOAD_BITS-1:0]  uart_rx_data,
output wire        uart_tx_busy,
output wire        uart_rx_valid,
output  wire        uart_txd, // UART transmit pin.
output  wire [7:0]  led
    );
    
// Clock frequency in hertz.
parameter CLK_HZ = 10000000;
parameter BIT_RATE =   115200;
parameter PAYLOAD_BITS = 8;

//wire        uart_rx_break;
reg [7:0] led_reg;
assign led = led_reg;

// ------------------------------------------------------------------------- 



always @(posedge clk) begin
    if(!rst) begin
        led_reg <= 8'hF0;
    end else if(uart_rx_valid) begin
        led_reg <= uart_rx_data[7:0];
    end
end


// ------------------------------------------------------------------------- 

//
// UART RX
uart_rx #(
.BIT_RATE(BIT_RATE),
.PAYLOAD_BITS(PAYLOAD_BITS),
.CLK_HZ  (CLK_HZ  )
) i_uart_rx(
.clk          (clk          ), // Top level system clock input.
.resetn       (rst         ), // Asynchronous active low reset.
.uart_rxd     (uart_rxd     ), // UART Recieve pin.
.uart_rx_en   (uart_rx_en   ), // Recieve enable
//.uart_rx_break(uart_rx_break), // Did we get a BREAK message?
.uart_rx_valid(uart_rx_valid), // Valid data recieved and available.
.uart_rx_data (uart_rx_data )  // The recieved data.
);

//
// UART Transmitter module.
//
uart_tx #(
.BIT_RATE(BIT_RATE),
.PAYLOAD_BITS(PAYLOAD_BITS),
.CLK_HZ  (CLK_HZ  )
) i_uart_tx(
.clk          (clk          ),
.resetn       (rst         ),
.uart_txd     (uart_txd     ),
.uart_tx_en   (uart_tx_en   ),
.uart_tx_busy (uart_tx_busy ),
.uart_tx_data (uart_tx_data ) 
);
endmodule
