----------------------------------------------------------------------------
-- Title           : FreqIn
-----------------------------------------------------------------------------
-- Author          : Jules and Léo
-- Date Created    : 01-07-2016
-----------------------------------------------------------------------------
-- Description     : Description
--							
--
-----------------------------------------------------------------------------
-- Copyright 2016. All rights reserved
-----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;





entity FreqIn is
	port 	(
			clk				: in std_logic;
			reset_in			: in std_logic;
			enable_in		: in std_logic;
			reg0_value_out	: out std_logic_vector(7 downto 0);
			gpio_in			: in std_logic
	);
		
end entity FreqIn;



architecture RTL of FreqIn is
	
	type 		state_type is (s0,s1,s2,s3);
	signal 	state : state_type;
  
begin
	
	
	
	process(clk, reset_in, enable_in, gpio_in)
	
		variable count	: natural := 0;
		constant f_clk : natural := 50000000;
	
	
	begin
		
		if reset_in = '0' then
			count := 0;
			state <= s0;
			
		elsif rising_edge(clk) then
		
			case state is
			
				when s0 =>
					count := 0;
					if enable_in = '1' then
						if gpio_in = '1' then
							state <= s1;
						end if;
					end if;
					
				when s1 =>
					count := count + 1;
					if gpio_in = '0' then
						state <= s2;
					end if;
					
				when s2 =>
					count := count + 1;
					if gpio_in = '1' then
						reg0_value_out <= std_logic_vector(to_unsigned(((f_clk/count)-50)/195,8));
						count := 0;
						if enable_in = '1' then
							state <= s1;
						else
							state <= s0;
						end if;
					end if;
					
				when others =>
					count := 0;
					state <= s0;
					--test
			end case;
			
		end if;
		
	end process;
	
end RTL;