library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity phase_shifter is

	generic(N : integer := 286);
	
	port(
	    clk,reset_ps:in std_logic;
	    lfsr_in     :in   std_logic_vector(N-1 downto 0);
	    ps_out      :out  std_logic_vector(N-1 downto 0)
		);
end entity phase_shifter;

architecture behavioral of phase_shifter is

	signal ps_reg : std_logic_vector (N-1 downto 0);
	begin

shifting : process(lfsr_in,clk,reset_ps) 
			begin
			
				if (falling_edge(clk)) then
					if (reset_ps = '1') then
						ps_reg <= (others => '0');
					else
						ps_reg(0) <= lfsr_in (5) xor lfsr_in(29);
						ps_reg(1) <= lfsr_in (10) xor lfsr_in(22);
						ps_reg(2) <= lfsr_in (15) xor lfsr_in(7);
						ps_reg(3) <= lfsr_in (20) xor lfsr_in(19);
						ps_reg(4) <= lfsr_in (25) xor lfsr_in(12);
						ps_reg(5) <= lfsr_in (1) xor lfsr_in(16);
						ps_reg(6) <= lfsr_in (3) xor lfsr_in(26);
						ps_reg(7) <= lfsr_in (6) xor lfsr_in(10);
						ps_reg(8) <= lfsr_in (9) xor lfsr_in(3);
						ps_reg(9) <= lfsr_in (12) xor lfsr_in(0);
						ps_reg(10) <= lfsr_in (18) xor lfsr_in(27);
						ps_reg(11) <= lfsr_in (21) xor lfsr_in(23);
						ps_reg(12) <= lfsr_in (24) xor lfsr_in(18);
						ps_reg(13) <= lfsr_in (27) xor lfsr_in(1);
						ps_reg(14) <= lfsr_in (0) xor lfsr_in(20);
						ps_reg(15) <= lfsr_in (17) xor lfsr_in(14);
						ps_reg(16) <= lfsr_in (22) xor lfsr_in(11);
						ps_reg(17) <= lfsr_in (29) xor lfsr_in(15);
						ps_reg(18) <= lfsr_in (7) xor lfsr_in(4);
						ps_reg(19) <= lfsr_in (19) xor lfsr_in(25);
						ps_reg(20) <= lfsr_in (16) xor lfsr_in(6);
						ps_reg(21) <= lfsr_in (28) xor lfsr_in(17);
						ps_reg(22) <= lfsr_in (13) xor lfsr_in(28);
						ps_reg(23) <= lfsr_in (23) xor lfsr_in(13);
						ps_reg(24) <= lfsr_in (14) xor lfsr_in(2);
						ps_reg(25) <= lfsr_in (1) xor lfsr_in(24);
						ps_reg(26) <= lfsr_in (26) xor lfsr_in(8);
						ps_reg(27) <= lfsr_in (11) xor lfsr_in(5);
						ps_reg(28) <= lfsr_in (2) xor lfsr_in(9);
						ps_reg(29) <= lfsr_in (4) xor lfsr_in(21);
------------------------------------------------------------------------------------------------
						for i in 30 to 283 loop
						ps_reg(i)<= lfsr_in(i) xor lfsr_in(i+1) xor lfsr_in(i+2);
						end loop;	
						ps_reg(284)<= lfsr_in(284) xor lfsr_in(285) xor lfsr_in(0);
						ps_reg(285)<= lfsr_in(285) xor lfsr_in(0)  xor lfsr_in(1);
					end if;
				end if;
						ps_out <= ps_reg;
			end process shifting;
			

			
end architecture behavioral;
			
			
