library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;





entity FreqIn_TB is

		
end entity;


architecture TB of FreqIn_TB is
	
	constant PERIOD 			: time := 20 ns;
	signal clk					: STD_LOGIC := '0';
	signal reset_in 			: std_logic := '0';
	signal senable_in 		: std_logic := '0';
	signal sreg0_value_out	: std_logic_vector(7 downto 0);
	signal sgpio_in 			: std_logic;

	component FreqIn is
		port 	(
				
				clk				: in std_logic;
				reset_in			: in std_logic;
				enable_in		: in std_logic;
				reg0_value_out	: out std_logic_vector(7 downto 0);
				gpio_in			: in std_logic
				
				);
	end component;
	
	
	
begin
	
	i1: FreqIn
	port map (
		clk				=>clk,
		reset_in			=>reset_in,
		enable_in		=>senable_in,
		reg0_value_out => sreg0_value_out, 
		gpio_in			=>sgpio_in
	);



	reset_in_P: process
	begin
		reset_in <= '0';
		wait for PERIOD ;
		reset_in <= '1';
		wait;
	end process;
	
	clk_P: process
	begin
		clk <= '0';
		wait for PERIOD/2;
		clk <= '1';
		wait for PERIOD/2;
	end process;

	stimulus: process
	begin
		sgpio_in <= '0';
		if reset_in = '0' then
			wait until reset_in = '1';
		end if;
		
		for i in 0 to 2 loop	--on choisit n périodes pour avoir 1ms		pour les servo moteurs (frequence min a frequence max)
			senable_in <= '1';
			sgpio_in <= '1';
			wait for 1 ms; --tester avec 1ms
			senable_in <= '0';
			sgpio_in <= '0';
			wait for 20 ms - 1 ms; --tester avec 1ms
		end loop;
		
		for i in 0 to 2 loop	--on choisit n périodes pour avoir 2ms				
			senable_in <= '1';
			sgpio_in <= '1';
			wait for 2 ms; --tester avec 2ms
			senable_in <= '0';
			sgpio_in <= '0';
			wait for 20 ms - 2 ms; --tester avec 2ms
		end loop;
		
		/*for i in 0 to 2 loop	--on choisit n périodes pour avoir 1ms				
			senable_in <= '1';
			sgpio_in <= '1';
			wait for (1 ms + (1 ms / 255)); 
			senable_in <= '0';
			sgpio_in <= '0';
			wait for 20 ms - 1 ms + 1 ms / 255;
		end loop;*/
		
	end process;

end TB;