library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity half_adder_tb is
end half_adder_tb;

architecture Behavioral of half_adder_tb is
	signal bit1_sig : std_logic := '0';
	signal bit2_sig : std_logic := '0';
	signal sum_sig : std_logic;
	signal carry : std_logic;

begin

UUT : entity work.half_adder
	port map (
		bit1_i => bit1_sig,
		bit2_i => bit2_sig,
		sum_o => sum_sig,
		carry_o => carry_sig
		);
		
process is
	begin
		bit1_sig <= '0';
		bit2_sig <= '0';
		wait for 10 ns;
		bit1_sig <= '0';
		bit2_sig <= '1';
		wait for 10 ns;
		bit1_sig <= '1';
		bit2_sig <= '0';
		wait for 10 ns;
		bit1_sig <= '1';
		bit2_sig <= '1';
		wait for 10ns;
end process;
end Behavioral;