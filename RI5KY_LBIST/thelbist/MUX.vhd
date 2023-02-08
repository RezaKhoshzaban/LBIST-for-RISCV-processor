library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity MUX is
	Generic(N: integer:= 256);
	Port (	PI  :	In	std_logic_vector (N-1 downto 0);
			PPI :	In	std_logic_vector (N-1 downto 0);
		    SEL :	In	std_logic;
			Y   :	Out	std_logic_vector (N-1 downto 0));
end MUX;



architecture BEHAVIORAL_1 of MUX is

begin

	muxing : process (PI,SEL) 
			begin
			case (sel) is
			when '0' => Y <= PI ;
			when '1' => Y <= PPI;
			when others => Y <= PI;
			end case;
		end process;

end BEHAVIORAL_1;
