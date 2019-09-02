`timescale  1ns/1ps
`define NULL 0
module imwrite(
       input        pixel_clk,
	   input        reset_n,
	   input        de,
	   input [23:0] rgb
	   );
	   
integer fR;
integer fG;
integer fB;

wire [7:0] R;
wire [7:0] G;
wire [7:0] B;

assign R = rgb[23:16];
assign G = rgb[15:8];
assign B = rgb[7:0];	

initial begin
  fR = $fopen("R.txt","w");
  fG = $fopen("G.txt","w");
  fB = $fopen("B.txt","w");
  if(fR == `NULL || fG == `NULL || fB == `NULL) begin
    $display("can not open R.txt or G.txt or B.txt");
	$finish;
  end 
end  

always @(posedge pixel_clk or negedge reset_n) begin
  if(de) begin
    $display("////////////////////////////////////");
    $display("time=[%d],%d,%d,%d",$realtime,R,G,B);
    $fwrite(fR,"%d\n",R);
	$fwrite(fG,"%d\n",G);
	$fwrite(fB,"%d\n",B);
  end
end  
	   

endmodule