library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity MUX_mem is

	Port (	normal  :	In	std_logic_vector (108 downto 0);
			testing :	In	std_logic_vector (108 downto 0);
		    sel_mem :	In	std_logic;
			out_mem   :	Out	std_logic_vector (108 downto 0));
end MUX_mem;



architecture BEHAVIORAL_mux of MUX_mem is

begin

	mem_muxing : process (normal,testing,sel_mem) 
			begin
			case (sel_mem) is
			when '0' => out_mem <= normal;
			when '1' => out_mem <= testing;
			when others => out_mem <= testing;
			end case;
		end process;

end BEHAVIORAL_mux;
