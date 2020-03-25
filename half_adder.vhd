library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity half_adder is
	port ( 
		bit1_i : in std_logic;
		bit2_i : in std_logic;
		sum_o : out std_logic;
		carry_o : out std_logic
		);
end half_adder;

architecture rtl of half_adder is
begin
	sum_o <= bit1_i xor bit2_i;
	carry_o <= bit1_i and bit2_i;
end rtl;