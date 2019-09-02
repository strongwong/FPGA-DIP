 `timescale  1ns/1ps
`define NULL 0
module imread(
       input pixel_clk,
	   input reset_n,
	   input de,
	   output [23:0] rgb
	   );
	   
integer fR;
integer fG;
integer fB;
reg [7:0] R;
reg [7:0] G;
reg [7:0] B;

initial begin
  fR = $fopen("testR.txt","r");// read in testR.txt
  fG = $fopen("testG.txt","r");
  fB = $fopen("testB.txt","r");
  if(fR == `NULL || fG == `NULL || fB == `NULL) begin
    $display("data_file handle was NULL");
	$finish;
  end
  else begin
    $fscanf(fR,"%d;\n",R);
	$fscanf(fG,"%d;\n",G);
	$fscanf(fB,"%d;\n",B);
  end
end	

always @(posedge pixel_clk or negedge reset_n) begin
  if(reset_n == 0) begin
    R = 8'd0;
	G = 8'd0;
	B = 8'd0;
  end
  else if(de) begin
    if(fR != 0 && fG != 0 && fB != 0) begin
	 $fscanf(fR,"%d;\n",R);
	 $fscanf(fG,"%d;\n",G);
	 $fscanf(fB,"%d;\n",B);
	 $display("time=[%d],%d,%d,%d",$realtime,R,G,B);
	end
  end
    
end

assign rgb ={R,G,B};
   
endmodule