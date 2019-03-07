library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity my_ALU is
    port (
        clk     : in std_logic;
        opcode  : in std_logic_vector(3 downto 0);
        A       : in std_logic_vector(3 downto 0);
        B       : in std_logic_vector(3 downto 0);
        O       : out std_logic_vector(3 downto 0)
    );
end my_ALU;

architecture alu of my_ALU is
begin

    process(clk) begin
        if(rising_edge(clk)) then
            case opcode is
                when "0000" => O <= std_logic_vector(unsigned(A) + unsigned(B));
                when "0001" => O <= std_logic_vector(unsigned(A) - unsigned(B));
                when "0010" => O <= std_logic_vector(unsigned(A) + 1);
                when "0011" => O <= std_logic_vector(unsigned(A) - 1);
                when "0100" => O <= std_logic_vector(0 - unsigned(A));
                when "0101" => 
                    if(A > B) then
                        O <= "0001";
                    else
                        O <= "0000";
                    end if;
                --shift unsigned = logical, shift signed = arithmetic
                when "0110" => O <= std_logic_vector(shift_left(unsigned(A), 1));
                when "0111" => O <= std_logic_vector(shift_right(unsigned(A), 1));
                when "1000" => O <= std_logic_vector(shift_right(signed(A), 1));
                when "1001" => O <= std_logic_vector(not A);
                when "1010" => O <= std_logic_vector(A and B);
                when "1011" => O <= std_logic_vector(A or B);
                when "1100" => O <= std_logic_vector(A xor B);
                when "1101" => O <= std_logic_vector(A xnor B);
                when "1110" => O <= std_logic_vector(A nand B);
                when "1111" => O <= std_logic_vector(A nor B);
                
            end case;
        end if;
    end process;

end alu;
