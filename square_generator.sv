//module bar_demo 
//   (
//    input  logic [10:0] x, y,     // treated as x-/y-axis
//    output logic [11:0] bar_rgb 
//   );

//   // declaration
//   logic [3:0] up, down;
//   logic [3:0] r, g, b;
   
//   // body
//   assign up = x[6:3];
//   assign down = ~x[6:3];    // "not" reverse the binary sequence 
//   always_comb
//   begin
//      // 16 shades of gray
//      if (y < 128) begin
//         r = x[9];
//         g = x[9];
//         b = x[4];
//      end   
//      // 8 prime colors with 50% intensity
//      else if (y < 300) begin   //256
//         r = {x[8], x[8], 2'b00};
//         g = {x[7], x[7], 2'b00};
//         b = {x[6], x[6], 2'b00};
//      end
//      else begin   
//      // a continuous color spectrum 
//      // width of up/sown can be increased to accommodate finer spectrum
//      // see Fig 23 of http://en.wikipedia.org/wiki/HSL_and_HSV
//      unique case (x[9:7]) 
//         3'b000: begin
//            r = 4'b1111;
//            g = up;
//            b = 4'b0000;
//         end   
//         3'b001: begin
//            r = down;
//            g = 4'b1111;
//            b = 4'b0000;
//         end   
//         3'b010: begin
//            r = 4'b0000;
//            g = 4'b1111;
//            b = up;
//         end   
//         3'b011: begin
//            r = 4'b0000;
//            g = down;
//            b = 4'b1111;
//         end   
//         3'b100: begin
//            r = up;
//            g = 4'b0000;
//            b = 4'b1111;
//         end   
//         3'b101: begin
//            r = 4'b1111;
//            g = 4'b0000;
//            b = down;
//         end   
//         default: begin
//            r = 4'b1111;
//            g = 4'b1111;
//            b = 4'b1111;
//         end  
//         endcase
//      end // else
//   end // always   
//   // output
//   assign bar_rgb = {r, g, b};
//endmodule
module sqr_gen(
    input  logic [10:0] x, y,
    input logic [15:0] sw,
    output logic [11:0] bar_rgb
   );
   logic [3:0] r, g, b;
   logic [7:0] pixels;


   always_comb
   begin
        unique case(sw[3:0])
          4'b0000: pixels = 8'b00010000;    //16
          4'b0001: pixels = 8'b00100000;    //32
          4'b0010: pixels = 8'b01000000;    //64
          4'b0100: pixels = 8'b10000000;    //128
        endcase
   end
   //case(sw[3:0])
//    3'b000:begin         //16 pixels
//        if(238< y< 242 && 318 < x < 322)begin
//            b = sw[7:4];
//            g = sw[11:8];
//            r = sw[15:12];
             
//    end

//        3'b001:begin         //32 pixels
//        if(237< y< 243 && 317 < x < 323)begin
//            b = sw[7:4];
//            g = sw[11:8];
//            r = sw[15:12];
//    end

//        3'b010:begin         //64 pixels
//        if(236< y< 244 && 316 < x < 324)begin
//            b = sw[7:4];
//            g = sw[11:8];
//            r = sw[15:12];
//    end

//        3'b011:begin         //128 pixels
//        if(234< y< 246 && 314 < x <326)begin
//            b = sw[7:4];
//            g = sw[11:8];
//            r = sw[15:12];
//    end
      
//        endcase
   always_comb
   begin
        if(y > 240-(pixels >> 1) && y < 240+(pixels >> 1) && 
           x > 320-(pixels >> 1) && x < 320+(pixels >> 1))
        begin
            b = sw[7:4];
            g = sw[11:8];
            r = sw[15:12];
        end
        else
        begin
            b = 4'b1111 - sw[7:4];
            g = 4'b1111 - sw[11:8];
            r = 4'b1111 - sw[15:12];
        end
end

   assign bar_rgb = {b, g, r};

endmodule
