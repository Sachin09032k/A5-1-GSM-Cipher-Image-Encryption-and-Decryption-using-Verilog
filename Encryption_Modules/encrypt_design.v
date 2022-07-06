`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.04.2022 02:50:25
// Design Name: 
// Module Name: encrypt_design
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


module encrypt_design(
    input clk,in,ip_img,
    output [0:18]q1,
    output [0:21]q2,
    output [0:22]q3,
    output reg key=0,
    output reg ct=0,
    output reg taps1,taps2,taps3
    );
    
    reg [0:18]q_reg1=0;
    reg [0:21]q_reg2=0;
    reg [0:22]q_reg3=0;
    
    initial
    begin
    taps1=0;
    taps2=0;
    taps3=0;
    end
    
    initial
    begin
        repeat (64)@(posedge clk)
        begin
            taps1=q_reg1[13]^q_reg1[16]^q_reg1[17]^q_reg1[18]^in;
            #0.002
            q_reg1={taps1,q_reg1[0:17]};
        end
     end 
    initial
    begin
        repeat (64)@(posedge clk)
        begin
            taps2=q_reg2[20]^q_reg2[21]^in;
            #0.002
            q_reg2={taps2,q_reg2[0:20]};
        end
     end 
    initial
    begin
        repeat (64)@(posedge clk)
        begin
            taps3=q_reg3[7]^q_reg3[20]^q_reg3[21]^q_reg3[22]^in;
            #0.002
            q_reg3={taps3,q_reg3[0:21]};
        end
     end
     
     initial
     #0.700
     begin
        repeat (22)@(posedge clk)
        begin
            taps1=q_reg1[13]^q_reg1[16]^q_reg1[17]^q_reg1[18]^in;
            #0.002
            q_reg1={taps1,q_reg1[0:17]}; 
        end
     end
     initial
     #0.700
     begin
        repeat (22)@(posedge clk)
        begin
            taps2=q_reg2[20]^q_reg2[21]^in;
            #0.002 
            q_reg2={taps2,q_reg2[0:20]}; 
        end
     end
     initial
     #0.700
     begin
        repeat (22)@(posedge clk)
        begin
            taps3=q_reg3[7]^q_reg3[20]^q_reg3[21]^q_reg3[22]^in;
            #0.002
            q_reg3={taps3,q_reg3[0:21]};
        end
     end
     
     initial
     #1
     begin
     repeat(100)@(posedge clk)
        begin
           if(in==q_reg1[8])
           begin
                taps1=q_reg1[13]^q_reg1[16]^q_reg1[17]^q_reg1[18];
                #0.002
                q_reg1={taps1,q_reg1[0:17]};
           end
        end
     end
     
     initial
     #1
     begin
     repeat(100)@(posedge clk)
        begin
           if(in==q_reg2[10])
           begin
                taps2=q_reg2[20]^q_reg2[21];
                #0.002 
                q_reg2={taps2,q_reg2[0:20]}; 
           end
        end
     end
     
     initial
     #1
     begin
     repeat(100)@(posedge clk)
        begin
           if(in==q_reg3[10])
           begin
                taps3=q_reg3[7]^q_reg3[20]^q_reg3[21]^q_reg3[22];
                #0.002
                q_reg3={taps3,q_reg3[0:21]};
           end
        end
     end
     
     initial
     #2.1
     begin
     repeat(524288)@(posedge clk)
        begin
           key=q_reg1[18]^q_reg2[21]^q_reg3[22];
           ct=ip_img^key;
        end
    end
     initial
     #2.1
     begin
     repeat(524288)@(posedge clk)
        begin
           if(in==q_reg1[8])
           begin
                taps1=q_reg1[13]^q_reg1[16]^q_reg1[17]^q_reg1[18];
                #0.002
                q_reg1={taps1,q_reg1[0:17]};
           end
        end
     end
     
     initial
     #2.1
     begin
     repeat(524288)@(posedge clk)
        begin
           if(in==q_reg2[10])
           begin
                taps2=q_reg2[20]^q_reg2[21];
                #0.002 
                q_reg2={taps2,q_reg2[0:20]}; 
           end
        end
     end
     
     initial
     #2.1
     begin
     repeat(524288)@(posedge clk)
        begin
           if(in==q_reg3[10])
           begin
                taps3=q_reg3[7]^q_reg3[20]^q_reg3[21]^q_reg3[22];
                #0.002 
                q_reg3={taps3,q_reg3[0:21]};
           end
        end
     end
     
     
  
    assign q1=q_reg1;
    assign q2=q_reg2;
    assign q3=q_reg3;
endmodule
