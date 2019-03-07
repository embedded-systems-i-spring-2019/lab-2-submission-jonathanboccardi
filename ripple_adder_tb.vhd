library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ripple_adder_tb is
end ripple_adder_tb;

architecture testbench of ripple_adder_tb is
    signal A_tb : std_logic_vector(3 downto 0) := (others => '0');
    signal B_tb : std_logic_vector(3 downto 0) := (others => '0');
    signal S_tb : std_logic_vector(3 downto 0) := (others => '0');
    signal Cin_tb : std_logic := '0';
    signal Cout_tb: std_logic := '0';
    
    component ripple_adder
        port (
            A   : in std_logic_vector(3 downto 0);
            B   : in std_logic_vector(3 downto 0);
            Cin : in std_logic;
            Cout: out std_logic;        
            S   : out std_logic_vector(3 downto 0)
        );
    end component;
begin
    
    FourBitAdder: ripple_adder
        port map (
            A => A_tb,
            B => B_tb,
            Cin => Cin_tb,
            S => S_tb,
            Cout => Cout_tb
        );

    test: process begin
        wait for 100ns;
        A_tb <= "0000";
        B_tb <= "0101";
        Cin_tb <= '1';
        --S = 0110
        
        wait for 100ns;
        A_tb <= "0001";
        B_tb <= "0101";
        Cin_tb <= '0';
        --S = 0110
        
        wait for 100ns;
        A_tb <= "0111";
        B_tb <= "0111";
        Cin_tb <= '1';
        --S = 1111
        
        wait for 100ns;
        A_tb <= "1101";
        B_tb <= "0010";
        Cin_tb <= '0';
        --S = 1111
        
        wait for 100ns;
        A_tb <= "1010";
        B_tb <= "1101";
        Cin_tb <= '1';
        --S = 1000 Cout = 1
    end process;
    
    

end testbench;
