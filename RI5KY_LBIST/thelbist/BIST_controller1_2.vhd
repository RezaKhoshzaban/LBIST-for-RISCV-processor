library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity controller is
  generic ( N : integer := 28);
  port (
    CLK 				: in  std_logic;
    reset_controller  	: in  std_logic;
    misr_sig	        : in  std_logic_vector ( N-1 downto 0 );
    T_N  				: in  std_logic;
    scan_en             : out std_logic;
    lfsr_enable         : out std_logic;
    misr_enable         : out std_logic;
    mux_en              : out std_logic;
	test_mode_tp		: out std_logic;
    go_nogo             : out std_logic

	);
     
end controller;


architecture beh of controller is
	

	signal golden       : std_logic_vector ( N-1 downto 0);
	type   State is (reset, initial_shift_in,PI_PO,shift_in_capture,comparison);
	signal present_state: State;
	signal next_state   : State;
	signal cnt          : integer;
	signal cont         : integer;
	signal cnt_enable   :std_logic;
	signal cont_enable  :std_logic;
	signal pattern_counter :integer;



	begin
	
		State_transition: process(CLK,reset_controller,pattern_counter)
			begin	
				if reset_controller = '0' then
					present_state <= reset;
				elsif CLK'event and CLK = '1' and T_N = '1' then
					
					present_state <= next_state;
					
				end if;
			end process;

		counter1: process(CLK)
				begin
					if cnt_enable = '1' then cnt <= cnt + 1;
					else   cnt <= 0;
					end if;
			end process counter1;

		counter2: process(CLK)
				begin
					if cont_enable = '1' then cont <= cont + 1;
					else   cont <= 0;
					end if;
			end process counter2;
								

		nxt_state      : process(present_state,cnt,cont)
			begin
				case present_state is
					when reset =>
						
						scan_en     <= '0';
						lfsr_enable <= '1';
						misr_enable <= '0';
						go_nogo     <= '0';
						mux_en      <= '0';	
						test_mode_tp<= '0';
						cnt_enable  <= '0';  
						cont_enable <= '0'; 
						pattern_counter<= 0; 

						

						next_state <= initial_shift_in;
						
					when initial_shift_in => --lfsr filling the chains

						test_mode_tp<= '1';
						scan_en     <= '1';
						lfsr_enable <= '0';
						misr_enable <= '0';
						cnt_enable  <= '1';
						mux_en      <= '0';

						if (cnt < 203) then
						next_state <= initial_shift_in;
						else

						next_state <= PI_PO;
						end if;


					when PI_PO => -- Memory feeding PIs and MISR capturing POs
						cont_enable <= '0';
						cnt_enable  <= '0';
						mux_en 	    <= '1';
						scan_en     <= '0';
						lfsr_enable <= '0';
						misr_enable <= '1';
					    pattern_counter <= pattern_counter + 1;
						next_state <= shift_in_capture;

						
					when shift_in_capture => --MISR capturing PPOs

						mux_en      <= '0';
						scan_en     <= '1';
						lfsr_enable <= '0';
						misr_enable <= '1';
						cont_enable <= '1';

						
						--counter check  --double counter
							 if (pattern_counter < 60) then
								if (cont < 203)  then 
										next_state <= shift_in_capture;
									else
										next_state <= PI_PO;
								end if;
									else 
										next_state <= comparison;
							end if;

					when comparison => --comparison
						cont_enable <= '0';
						cnt_enable  <= '0';
						test_mode_tp<= '0';
						lfsr_enable <= '0';
						misr_enable <= '0';
						golden		<= x"FA8B948";
						go_nogo		<= '1';

						if golden  = misr_sig   then go_nogo <= '1';
							else go_nogo <= '0';
						end if;
						next_state <= reset;

				end case;
			end process;
end beh;

