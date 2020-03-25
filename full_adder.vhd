library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity full_adder is
	port(
		bit1_i : in std_logic;
		bit2_i : in std_logic;
		carry_i : in std_logic;
		sum_o : out std_logic;
		carry_o : out std_logic;
		);
end full_adder;

architecture rtl of full_adder is
	signal temp1_sig, temp2_sig, temp3_sig : std_logic;
	
begin

temp1_sig <= bit1_i xor bit2_i;
temp2_sig <= temp1_sig and carry_i;
temp3_sig <= bit1_i and bit2_i;

sum_o <= temp1_sig xor carry_i;
carry_o <= temp2_sig or temp3_sig;

end rtl;