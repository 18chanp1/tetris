module synthesizer_reg
(
    input logic SynthesizerSelect_H,
    input logic UDS_L,
    input logic LDS_L,
    input logic WE_L,
    input logic AS_L,
    input logic [15:0] DataIn,
    input logic [31:0] Address,
    input logic Clock,
    input logic Reset_L,
    input logic phoneme_speech_busy,
    input logic phoneme_speech_finish,
    output logic start_phoneme_output,
    output logic [7:0] phoneme_sel,
    output logic [15:0] DataOut
);

    //setup the regs for each driver
    always_ff @(posedge Clock) begin
        if(~Reset_L) begin
            phoneme_sel <= 8'h00;
            start_phoneme_output <= 1'b0;
        end
        //receive a write, update phoneme sel
        else if(~WE_L && ~LDS_L && ~AS_L && SynthesizerSelect_H) begin
            case(Address[13:0])
                //pulse and start
                14'h1: begin
                    phoneme_sel <= DataIn[7:0];
                    start_phoneme_output <= 1'b1;
                end
                //nothing happens
                default: begin
                    phoneme_sel <= phoneme_sel;
                    start_phoneme_output <= 1'b0;
                end
            endcase
        end
        //nothing happens
        else begin
            phoneme_sel <= phoneme_sel;
            start_phoneme_output <= 1'b0;
        end
    end

    //registers that we can read from
    always_comb begin
        DataOut = 16'bz;

        if(WE_L && ~LDS_L && ~AS_L && SynthesizerSelect_H) begin
            case(Address[13:0])
                14'h1: DataOut = {8'b0, phoneme_sel};
                14'h3: DataOut = {15'b0, phoneme_speech_busy};
                14'h5: DataOut = {15'b0, phoneme_speech_finish};
                default: DataOut = 16'bz;
            endcase
        end
    end

endmodule