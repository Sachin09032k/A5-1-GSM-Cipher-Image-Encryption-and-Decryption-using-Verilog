`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.04.2022 03:02:25
// Design Name: 
// Module Name: decrypt_design
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


module decrypt_design(out,clk,in_k,in_c);

input clk,in_k,in_c;
output reg out=0;
integer i=0;

initial
begin
    repeat(524288)@(posedge clk)
    begin
    out=in_k^in_c;
    end
end

endmodule

