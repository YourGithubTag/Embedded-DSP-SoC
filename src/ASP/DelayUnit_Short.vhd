library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DelayUnit_Short is 
port (
    clk : in std_logic;
	 ValidData: in std_logic;
	 reset : in std_logic;
	 enable : in std_logic;
	 Input : in std_logic_vector(15 downto 0);
	 output: out std_logic_vector(15 downto 0)
         );
end DelayUnit_Short;

architecture arch of DelayUnit_Short is

TYPE data_array  is array (0 to 5000) OF std_logic_vector(15 DOWNTO 0); 
SIGNAL Data : data_array;
signal pointer: integer := 0;
SIGNAL Output_q :	std_logic_vector(15 downto 0) := (OTHERS => '0'); 
SIGNAL IO:  std_logic := '0';

begin
 process(clk)
 begin
	if (rising_edge(clk)) then
	
	if (reset = '1') then
		IO <= '0';
		pointer <= 0;
		
	end if;
	
	if ((enable = '1') and (ValidData = '1') ) then 
		
			Output_q <= Data(pointer);
			Data(pointer -1) <= Input;
			pointer <= pointer + 1;
		 
		  if (pointer = (5000 -1)) then
				pointer <= 1;
				IO <= not IO;
		 end if;
		 
	end if;	
end if;
end process;
 output <= Output_q when IO = '1' else (others => '0');
end arch;