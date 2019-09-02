`timescale  1ns/1ps
//`define pix_1920_1080
//`define pix_1280_768
//`define pix_1280_720
`define pix_800_600

`ifdef pix_1920_1080
  `define CLK_PERIOD 6.734
`endif

`ifdef pix_1280_768
  `define CLK_PERIOD 12.578
`endif

`ifdef  pix_1280_720
  `define CLK_PERIOD 13.468
`endif

`ifdef  pix_800_600
  `define CLK_PERIOD 25
`endif

module tb_image();

reg pixel_clk;
reg reset_n;
wire [23:0]   rgb;

wire          vga_clk;
wire [11:0]   hcount;
wire [11:0]   vcount;
wire [7:0]	  VGA_R;
wire [7:0]	  VGA_G;
wire [7:0]	  VGA_B;
wire		  VGA_HS;
wire	      VGA_VS;
wire		  VGA_DE;
wire          BLK;

wire [23:0]  VGA_RGB;
reg VGA_VS_r;
wire frame_done_flag;

reg  [11:0] frame_cnt;

assign VGA_RGB = {VGA_R,VGA_G,VGA_B};

initial begin
  pixel_clk = 0;
  reset_n = 0;
  #(`CLK_PERIOD*10);
  reset_n = 1;

  wait(frame_cnt == 12'd2);
  //#(`CLK_PERIOD*480001);
  $stop;
  
end

always #(`CLK_PERIOD/2) pixel_clk = ~pixel_clk;

assign frame_done_flag = (!VGA_VS & (VGA_VS_r))?1'b1:1'b0;

always @(posedge pixel_clk ) begin
  VGA_VS_r <= VGA_VS;
end

always @(posedge pixel_clk or negedge reset_n) begin
  if(!reset_n)
    frame_cnt <= 12'd0;
  else if(frame_done_flag ==1'b1)
    frame_cnt <= frame_cnt + 12'd1;
end

vga_ctl U_VGA(
	.pix_clk(pixel_clk),
	.reset_n(reset_n),
	.VGA_RGB(rgb),
	.VGA_CLK(vga_clk),
	.hcount(hcount),
	.vcount(vcount),
	.VGA_R(VGA_R),
	.VGA_G(VGA_G),
	.VGA_B(VGA_B),
	.VGA_HS(VGA_HS),
	.VGA_VS(VGA_VS),
	.VGA_DE(VGA_DE),
	.BLK(BLK)
	);
	
wire [7:0] y;
wire [7:0] cb;
wire [7:0] cr;

wire o_hs;
wire o_vs;
wire o_de;

rgb_to_ycbcr U_YCBCR(
			.clk(pixel_clk),
			.i_r_8b(VGA_R),
			.i_g_8b(VGA_G),
			.i_b_8b(VGA_B),
  						
			.i_h_sync(VGA_HS),
			.i_v_sync(VGA_VS),
			.i_data_en(VGA_DE),
						
			.o_y_8b(y),
			.o_cb_8b(cb),
			.o_cr_8b(cr),
						
			.o_h_sync(o_hs),
			.o_v_sync(o_vs),                                                                                                  
			.o_data_en(o_de)                                                                                                
						);

imread U_IMREAD(
       .pixel_clk(pixel_clk),
	   .reset_n(reset_n),
	   .de(VGA_DE),
	   .rgb(rgb)
	   );
	   
imwrite U_IMWRITE(
       .pixel_clk(pixel_clk),
	   .reset_n(reset_n),
	   .de(o_de),
	   .rgb({y,cb,cr})
	   );
	   
endmodule