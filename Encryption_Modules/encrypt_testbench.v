`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.04.2022 02:52:34
// Design Name: 
// Module Name: encrypt_testbench
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


module encrypt_testbench;
    reg clk;
    reg in=1'b0;
    wire [0:18]q1;
    wire [0:21]q2;
    wire [0:22]q3;
    wire key,ct;
    reg ip_img=0;
    reg [0:21]public_key=22'b1101001110000110010001;
    reg secret_key[0:63];
    reg a=0,b=0,c=0,major=0;
    reg keystream[0:524287],img[0:524287];
    reg [0:7] encrypt[0:65535];
    integer file_key,file_ct;
    integer i1,i2,j1,j2,k1,k2,k3;
    
    encrypt_design uut(
    .clk(clk),
    .in(in),
    .key(key),
    .ip_img(ip_img),
    .ct(ct),
    .q1(q1),
    .q2(q2),
    .q3(q3)
    );
    
    initial
    begin
        clk=1'b0;
    end
    
    localparam T = 0.005;
    always
    #T clk=~clk;
    
    initial
    $readmemb("secret_key.txt",secret_key,0,63);
    
    initial
    $readmemb("img_binps2.txt",img,0,524287);
    
    initial 
    begin
    i1=0;
    i2=0;
    j1=0;
    j2=0;
    k1=0;
    k2=0;
    k3=0;
    end
    
    initial
    begin
        repeat(64)@(posedge clk)
        begin
            in=secret_key[i1];
            i1=i1+1;
        end
    end
    initial
    #0.700
    begin
       repeat(22)@(posedge clk)
       begin
           in=public_key[j1];
           j1=j1+1;
       end
    end
    initial
    #1
    begin
       repeat(100)@(posedge clk)
        begin
            a=q1[8];
            b=q2[10];
            c=q3[10];
            major=(a&b)|(b&c)|(c&a);
            in=major;
        end
    end
     
    initial
    #2.1
    begin
        repeat(524288)@(posedge clk)
        begin
           a=q1[8];
           b=q2[10];
           c=q3[10];
           major=(a&b)|(b&c)|(c&a);
           in=major;
           ip_img=img[k1];
           #0.001 keystream[k1]=key;
           if(i2==8) 
           begin
                i2=0;
                j2=j2+1;
           end
           encrypt[j2][i2]=ct;
           i2=i2+1;
           k1=k1+1;
        end
    end
        
     initial 
     begin
         file_key=$fopen("keystream.txt");    
         file_ct=$fopen("encrypt.txt");
     end
    
    initial
    #5250
    begin 
        for(k2=0;k2<524288;k2=k2+1) 
        begin
            $fwrite(file_key,"%b\n",keystream[k2]);
        end
    end
        
    initial
    #5270
    begin 
    for(k3=0;k3<65536;k3=k3+1) 
        begin
            $fwrite(file_ct,"%b\n",encrypt[k3]);
        end
    end
        
    initial 
    #5290
    begin
        $fclose(file_key);  
        $fclose(file_ct);
    end
        
                
                
        
    initial 
    #5800 $finish; 

endmodule
