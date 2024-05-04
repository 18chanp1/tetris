module vga_reg 
(
    input logic VgaSelect_H,
    input logic UDS_L,
    input logic LDS_L,
    input logic WE_L,
    input logic AS_L,
    input logic [15:0] DataIn,
    input logic [31:0] Address,
    input logic Clock,
    input logic Reset_L,
    input logic [11:0] TEXT_A,
    output logic [7:0] TEXT_D,
    output logic [15:0] DataOut,
    output logic [7:0] ctl,
    output logic [7:0] crx,
    output logic [7:0] cry
);

    //instantiate the text buffer here
    text_buffer_2 tb2_inst (
        .clock(Clock),
        .data(DataIn[7:0]),
        .rdaddress(TEXT_A),
        .wraddress(Address[12:1]),
        .wren(~WE_L && ~LDS_L && ~AS_L && VgaSelect_H && Address[13]),
        .q(TEXT_D)
    );

    // define the registers
    always_ff @(posedge Clock) begin
        if(~Reset_L) begin
            ctl <= 8'b1111_0010;
            crx <= 8'd40;
            cry <= 8'd20;
        end
        else if(~WE_L && ~LDS_L && ~AS_L && VgaSelect_H) begin
            case(Address[13:0])
                14'h1: ctl <= DataIn[7:0];
                14'h3: crx <= DataIn[7:0];
                14'h5: cry <= DataIn[7:0];
            endcase
        end
    end

    //define the tristates
    always_comb begin
        DataOut = 16'bz;
        if(WE_L && ~LDS_L && ~AS_L && VgaSelect_H) begin
            case(Address[13:0])
                14'h1: DataOut = ctl;
                14'h3: DataOut = crx;
                14'h5: DataOut = cry;
				default: DataOut = 16'bz;
            endcase
        end
        if(WE_L && ~LDS_L && ~AS_L && VgaSelect_H && Address[13]) begin
            DataOut = 8'h69;
        end
    end
endmodule