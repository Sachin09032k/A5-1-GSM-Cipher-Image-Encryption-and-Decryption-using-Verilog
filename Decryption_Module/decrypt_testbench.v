`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.04.2022 03:02:56
// Design Name: 
// Module Name: decrypt_testbench
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


module decrypt_testbench();
    reg clk,in_k,in_c;
    reg [0:7] encrypt[0:65535];
    reg [0:7] decrypt[0:65535];
    reg keystream[0:524287];
    wire out;
    
    integer i,r,j,k;
    integer file;
    
    initial
    begin
        clk=1'b0;
        in_k=1'b0;
        in_c=1'b0;
        i=0;r=0;j=0;k=0;
    end
    
    always
    #0.005 clk=~clk;

    initial
    $readmemb("encrypt.txt",encrypt,0,65535);
   
    initial
    $readmemb("keystream.txt",keystream,0,524287);
    
    initial
    begin
    repeat(524288)@(posedge clk)
        begin
        in_k=keystream[i];
        if(j==8)
        begin
            j=0;
            k=k+1;
        end
        in_c=encrypt[k][j];
        #0.001 
        decrypt[k][j]=out;
        i=i+1;
        j=j+1;
        end
    end
    
    
    initial 
    begin
        file=$fopen("decrypt.txt");    
    end
    
    initial
    #5500
    begin
        repeat(65536) 
        begin
            $fwrite(file,"%b\n",decrypt[r]);
            r=r+1;
        end
    end
    
    
    initial 
    #5700 $fclose(file);
    
    
    
    decrypt_design uut(.out(out),.clk(clk),.in_k(in_k),.in_c(in_c));
    
    initial #6000 $finish;
endmodule
