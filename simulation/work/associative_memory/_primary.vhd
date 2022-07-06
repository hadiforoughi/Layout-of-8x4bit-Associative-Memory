library verilog;
use verilog.vl_types.all;
entity associative_memory is
    port(
        clk             : in     vl_logic;
        wr              : in     vl_logic;
        Address         : in     vl_logic_vector(3 downto 0);
        Data_in         : in     vl_logic_vector(3 downto 0);
        Data_out        : out    vl_logic_vector(3 downto 0);
        Hit             : out    vl_logic
    );
end associative_memory;
