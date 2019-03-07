library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder is
    port (
        A   : in std_logic;
        B   : in std_logic;
        Cin : in std_logic;
        Cout: out std_logic;
        S   : out std_logic
    );
end adder;

architecture my_adder of adder is
begin
    S <= A xor B xor Cin;
    Cout <= (A and B) or (Cin and (A xor B));
end my_adder;
