library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity falling_edge_detector is
	port( 	clock_i : in std_logic;
			signal_i : in std_logic;
			edge_o : out std_logic
		);
end falling_edge_detector;

architecture rtl of falling_edge_detector is

signal temp1_sig, temp2_sig : std_logic;

begin

falling_edge_det_proc : process(clock_i)
begin
	if(rising_edge(clock_i)) then
		temp1_sig <= signal_i;
		temp2_sig <= temp1_sig;
		edge_o <= (not temp1_sig) and temp2_sig;
	end if;
end process;

end rtl;