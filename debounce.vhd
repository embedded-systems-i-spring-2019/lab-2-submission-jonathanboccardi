library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity debounce is
    port(
        clk : in std_logic;
        btn : in std_logic;
        dbnc: out std_logic
    );
end debounce;

architecture db of debounce is
    signal count    : std_logic_vector(21 downto 0) := (others => '0');
    signal shift    : std_logic_vector(1 downto 0);
begin

    process(clk, btn) begin
        if(rising_edge(clk)) then
            if(unsigned(count) < 2500000) then
            dbnc <= '0';
                if(shift(1) = '1') then
                    count <= std_logic_vector(unsigned(count) + 1);
                else
                    count <= (others => '0');
                end if;
            else
                dbnc <= '1';
                if (btn = '0') then
                    dbnc <= '0';
                    count <= (others => '0');
                end if;
            end if;
            shift(1) <= shift(0);
            shift(0) <= btn;
        end if;
    end process;
end db;