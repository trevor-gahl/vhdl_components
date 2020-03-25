library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pulse_generator is
	generic (pulse_limit_g : integer := 11);
	port   (clock_i : in std_logic;
			pulse_clock_i : in std_logic;
			reset_i : in std_logic;
			pulse_count_o : out integer;
			pulse_o : out std_logic);
end pulse_generator;

architecture rtl of pulse_generator is

signal pulse_s1_sig, pulse_s2_sig, pulse_sig : std_logic := '0';
signal pulse_count_sig : integer := 0;

pulse_gen_proc : process(clock_i)
begin
	if(rising_edge(clock_i)) then
		pulse_s1_sig <= pulse_clock_i;
		pulse_s2_sig <= pulse_s1_sig;
		pulse_sig <= (not pulse_s2_sig) and pulse_s1_sig;
		
		if(pulse_sig = '1') then
			if(pulse_count_sig = pulse_limit_g) then
				pulse_count_sig <= 0;
			else
				pulse_count_sig <= pulse_count_sig + 1;
			end if;
		end if;
	end if;
end process;