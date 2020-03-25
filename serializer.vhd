library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity serializer is
	port (
		clock_i : in std_logic;
		data_i : in std_logic_vector(31 downto 0);
		reset_i : in std_logic;
		enable_i : in std_logic;
		start_transmission_i : in std_logic;
		data_clock_o : out std_logic;
		data_o : out std_logic;
		sync_o : out std_logic;
		enable_o : out std_logic;
end serializer;

architecture rtl of serializer is

type state_type is(idle_state, read_state, transmit_state, sync_state);

signal current_state, next_state : state_type := idle_state;
signal bit_count_sig : integer := 0;
signal data_read_in_sig : std_logic_vector(31 downto 0);

signal sync_rising, sync_falling, data_sync_sig : std_logic := '0';
signal sbit_sig : std_logic := '0';

-- Begin Architecture
begin

state_memory : process(clock_i,reset_i)
begin
	if(reset_i = '1') then
		current_state <= idle_state;
	elsif(rising_edge(clock_i)) then
		current_state <= next_state;
	end if;
end process;

next_state_logic : process(current_state, enable_i, data_sync_sig, start_transmission_i)
begin
	if(current_state = idle_state) then
		if(enable_i = '1') then
			next_state <= read_state;
		else
			next_state <= idle_state;
		end if;
	elsif(current_state = read_state) then	
		if(start_transmission_i = '1') then
			next_state <= transmit_state;
		else
			next_state <= read_state;
		end if;
	elsif(current_state <= transmit_state) then	
		if(data_sync_sig <= '1') then
			next_state <= sync_state;
		else
			next_state <= transmit_state;
		end if;
	elsif(current_state <= sync_state) then
		next_state <= idle_state;
	end if;
end process;

output_logic : process(current_state, sbit_sig, clock_i, data_sync_sig)
begin
	case(current_state) is
		when idle_state => 
			data_clock_o <= '0';
			data_o <= '0';
			enable_o <= '0';
			sync_o <= '0';
		when read_state =>
			data_clock_o <= '0';
			data_o <= '0';
			enable_o <= '0';
			sync_o <= '0';
		when transmit_state =>
			data_clock_o <= clock_i;
			data_o <= sbit_sig;
			enable_o <= '1';
			sync_o <= data_sync_sig;
		when sync_state =>
			data_clock_o <= '0';
			data_o <= '0';
			enable_o <= '0';
			sync_o <= data_sync_sig;
		when others =>
			data_clock_o <= '0';
			data_o <= '0';
			enable_o <= '0';
			sync_o <= '0';
		end case;
end process;