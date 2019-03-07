library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ripple_adder is
    port (
        A   : in std_logic_vector(3 downto 0);
        B   : in std_logic_vector(3 downto 0);
        Cin : in std_logic;
        Cout: out std_logic;        
        S   : out std_logic_vector(3 downto 0)
    );
end ripple_adder;

architecture ra of ripple_adder is
    --will map components to these signals
    signal Ainput : std_logic_vector(3 downto 0);
    signal Binput : std_logic_vector(3 downto 0);
    --these Cs are intermediates between adders
    signal Cinput : std_logic_vector(3 downto 0);
    signal Coutput: std_logic_vector(3 downto 0);
    
    component adder
        port(
            A   : in std_logic;
            B   : in std_logic;
            Cin : in std_logic;
            Cout: out std_logic;
            S   : out std_logic
        );
    end component;
begin
    
    adder3: adder
        port map(
                A => Ainput(3),
                B => Binput(3),
                Cin => Cinput(3),
                Cout => Coutput(3),
                S => S(3)
            );
    adder2: adder
        port map(
                A => Ainput(2),
                B => Binput(2),
                Cin => Cinput(2),
                Cout => Coutput(2),
                S => S(2)
            );
    adder1: adder
        port map(
                A => Ainput(1),
                B => Binput(1),
                Cin => Cinput(1),
                Cout => Coutput(1),
                S => S(1)
            );
    adder0: adder
        port map(
                A => Ainput(0),
                B => Binput(0),
                Cin => Cinput(0),
                Cout => Coutput(0),
                S => S(0)
            );
    
    Ainput <= A;
    Binput <= B;        
    Cinput(0) <= Cin;
    Cinput(1) <= Coutput(0);
    Cinput(2) <= Coutput(1);
    Cinput(3) <= Coutput(2);
    Cout <= Coutput(3);
    
end ra;
