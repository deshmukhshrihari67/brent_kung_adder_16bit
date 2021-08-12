`timescale 1ns / 1ps

module bk_adder; //testbench
reg[15:0] ain,bin;
reg ciin;
wire[16:0] outo;

bk_add bk(ain,bin,ciin,outo);

initial
begin
    #0 ciin=1'b1;
    #0 ain = 16'haef1; bin = 16'haeff;
    #5 ain = 16'haefa; bin = 16'h0004;
    #5 ain = 16'h0001; bin = 16'h0001;
    #5 $finish;
end
endmodule

module bk_add(a,b,cin,out);

input[15:0] a,b;
input cin;
output[16:0] out;
wire w0,w1;
wire[15:0] sum;
wire carry;
wire[15:0] interg0,interp0; //level 0 signals
wire[7:0] interg1; //level 1 signals
wire[6:0] interp1,interg7; // level 1 and level 7 signals resp.
wire[3:0] interg2; //level 2 signals
wire[2:0] interp2,interg6; //level 2 and level 3 signals resp.
wire[1:0] interg3; //level 3 signals 
wire interp3,interg4,interg5; //level 3,4,5 signals resp.

gen g0(a[0],b[0],interg0[0]); 
propg p0(a[0],b[0],interp0[0]);

gen g1(a[1],b[1],interg0[1]);
propg p1(a[1],b[1],interp0[1]);

gen g2(a[2],b[2],interg0[2]);
propg p2(a[2],b[2],interp0[2]);

gen g3(a[3],b[3],interg0[3]);
propg p3(a[3],b[3],interp0[3]);

gen g4(a[4],b[4],interg0[4]);
propg p4(a[4],b[4],interp0[4]);

gen g5(a[5],b[5],interg0[5]);
propg p5(a[5],b[5],interp0[5]);

gen g6(a[6],b[6],interg0[6]);
propg p6(a[6],b[6],interp0[6]);

gen g7(a[7],b[7],interg0[7]);
propg p7(a[7],b[7],interp0[7]);

gen g8(a[8],b[8],interg0[8]);
propg p8(a[8],b[8],interp0[8]);

gen g9(a[9],b[9],interg0[9]);
propg p9(a[9],b[9],interp0[9]);

gen g10(a[10],b[10],interg0[10]);
propg p10(a[10],b[10],interp0[10]);

gen g11(a[11],b[11],interg0[11]);
propg p11(a[11],b[11],interp0[11]);

gen g12(a[12],b[12],interg0[12]);
propg p12(a[12],b[12],interp0[12]);

gen g13(a[13],b[13],interg0[13]);
propg p13(a[13],b[13],interp0[13]);

gen g14(a[14],b[14],interg0[14]);
propg p14(a[14],b[14],interp0[14]);

gen g15(a[15],b[15],interg0[15]);
propg p15(a[15],b[15],interp0[15]);

//level 1
grey_c gc0(interg0[1],interp0[1],interg0[0],interg1[0]); //correct
black_c bc1(interg0[3],interp0[3],interg0[2],interp0[2],interg1[1],interp1[0]);//correct
black_c bc2(interg0[5],interp0[5],interg0[4],interp0[4],interg1[2],interp1[1]);//correct
black_c bc3(interg0[7],interp0[7],interg0[6],interp0[6],interg1[3],interp1[2]);//correct
black_c bc4(interg0[9],interp0[9],interg0[8],interp0[8],interg1[4],interp1[3]);//correct
black_c bc5(interg0[11],interp0[11],interg0[10],interp0[10],interg1[5],interp1[4]);//correct
black_c bc6(interg0[13],interp0[13],interg0[12],interp0[12],interg1[6],interp1[5]);//correct
black_c bc7(interg0[15],interp0[15],interg0[14],interp0[14],interg1[7],interp1[6]);//correct

//level 2
grey_c gc1(interg1[1],interp1[0],interg1[0],interg2[0]);//correct
black_c bc8(interg1[3],interp1[2],interg1[2],interp1[1],interg2[1],interp2[0]);//correct
black_c bc9(interg1[5],interp1[4],interg1[4],interp1[3],interg2[2],interp2[1]);//correct
black_c bc10(interg1[7],interp1[6],interg1[6],interp1[5],interg2[3],interp2[2]);//correct

//level 3
grey_c gc2(interg2[1],interp2[0],interg2[0],interg3[0]);//correct
black_c bc11(interg2[3],interp2[2],interg2[2],interp2[1],interg3[1],interp3);//correct

//level 4
grey_c gc3(interg3[1],interp3,interg3[0],interg4);//out 15, correct

//level 5
grey_c gc4(interg2[2],interp2[1],interg3[0],interg5);//correct

//level 6
grey_c gc5(interg1[2],interp1[1],interg2[0],interg6[0]);//correct
grey_c gc6(interg1[4],interp1[3],interg3[0],interg6[1]);//correct
grey_c gc7(interg1[6],interp1[5],interg5,interg6[2]);//correct

//level 7
grey_c gc8(interg0[2],interp0[2],interg1[0],interg7[0]);//correct
grey_c gc9(interg0[4],interp0[4],interg2[0],interg7[1]);//correct
grey_c gc10(interg0[6],interp0[6],interg6[0],interg7[2]);//correct
grey_c gc11(interg0[8],interp0[8],interg3[0],interg7[3]);//correct
grey_c gc12(interg0[10],interp0[10],interg6[1],interg7[4]);//correct
grey_c gc13(interg0[12],interp0[12],interg5,interg7[5]);//correct
grey_c gc14(interg0[14],interp0[14],interg6[2],interg7[6]);//correct

//level 8-last level

assign w0 = interp0[0]&cin;
assign  w1 = w0 | interg0[0];
assign  sum[0] = interp0[0] ^  cin;
assign  sum[1] = interp0[1] ^ w1;
assign  sum[2] = interp0[2] ^ interg1[0];//correct
assign  sum[3] = interp0[3] ^ interg7[0];//correct
assign  sum[4] = interp0[4] ^ interg2[0];//correct
assign  sum[5] = interp0[5] ^ interg7[0];//correct
assign  sum[6] = interp0[6] ^ interg6[0];//correct
assign  sum[7] = interp0[7] ^ interg7[2];//correct
assign  sum[8] = interp0[8] ^ interg3[0];//correct
assign  sum[9] = interp0[9] ^ interg7[3];//correct
assign  sum[10] = interp0[10] ^ interg6[1];//correct
assign  sum[11] = interp0[11] ^ interg7[4];//correct
assign  sum[12] = interp0[12] ^ interg5;//correct 
assign  sum[13] = interp0[13] ^ interg7[5];//correct
assign  sum[14] = interp0[14] ^ interg6[2];//correct
assign  sum[15] = interp0[15] ^ interg7[6];//correct
assign carry = interg4;

assign out = {carry,sum};
endmodule

module grey_c(G1g,P1g,G0g,Goutg);

input G1g,P1g,G0g;
output Goutg;
wire inter1;

assign  inter1 = P1g & G0g;
assign  Goutg = inter1 | G1g; 

endmodule

module black_c(G1b,P1b,G0b,P0b,Goutb,Poutb);

input G1b,P1b,G0b,P0b;
output Goutb,Poutb;
wire inter0;

assign  Poutb = P1b & P0b;
assign  inter0 = P1b & G0b;
assign  Goutb = inter0 | G1b;

endmodule

//propagate module
module propg(in2,in3,outp);

input in2,in3;
output outp;

assign  outp = in2 ^ in3;

endmodule

//generate module
module gen(in0,in1,outg);

input in0,in1;
output outg;

assign  outg= in0 & in1;

endmodule
