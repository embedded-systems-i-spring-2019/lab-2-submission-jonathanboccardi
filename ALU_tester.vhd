library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_tester is
    port (
        clk : in std_logic;
        btn : in std_logic_vector(3 downto 0);
        sw  : in std_logic_vector(3 downto 0);
        led : out std_logic_vector(3 downto 0)
    );
end ALU_tester;

architecture alu_test of ALU_tester is
    component debounce
        port(
            clk : in std_logic;
            btn : in std_logic;
            dbnc: out std_logic
        );
    end component;
    
    component my_ALU
        port(
            clk     : in std_logic;
            opcode  : in std_logic_vector(3 downto 0);
            A       : in std_logic_vector(3 downto 0);
            B       : in std_logic_vector(3 downto 0);
            O       : out std_logic_vector(3 downto 0)
        );
    end component;
    
    signal A        : std_logic_vector(3 downto 0);
    signal B        : std_logic_vector(3 downto 0);
    signal op       : std_logic_vector(3 downto 0);
    signal dbnc     : std_logic_vector(3 downto 0);
    signal tempout  : std_logic_vector(3 downto 0);
    
begin

    debounce0: debounce
        port map (
            clk => clk,
            btn => btn(0),
            dbnc => dbnc(0)
        );
    debounce1: debounce
        port map (
            clk => clk,
            btn => btn(1),
            dbnc => dbnc(1)
        );
    debounce2: debounce
        port map (
            clk => clk,
            btn => btn(2),
            dbnc => dbnc(2)
        );
    debounce3: debounce
        port map (
            clk => clk,
            btn => btn(3),
            dbnc => dbnc(3)
        );
        
    alu: my_ALU
        port map (
            clk => clk,
            opcode => op,
            A => A,
            B => B,
            O => tempout            
        );
        
    setABop: process(clk) begin
        if (rising_edge(clk)) then
            led <= tempout;
            if (dbnc(2) = '1') then
                op <= sw;
            elsif (dbnc(1) = '1') then
                A <= sw;
            elsif (dbnc(0) = '1') then
                B <= sw;
            elsif (dbnc(3) = '1') then
                op <= "0000";
                A <= "0000";
                B <= "0000";
            end if;
        end if;
    end process;

end alu_test;
