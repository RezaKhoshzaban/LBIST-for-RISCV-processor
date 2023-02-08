library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity misr is
      generic (NBIT: integer:=28);
      port (INPUT     : In std_logic_vector(NBIT-1 downto 0);
            OUTPUT    : Out std_logic_vector(NBIT-1 downto 0);
            clk       : In std_logic;
            reset_misr: In std_logic);
end entity misr;

architecture behavior of misr is
    signal misr_reg: std_logic_vector(NBIT-1 downto 0);

begin 
    compaction: process(INPUT, reset_misr, CLK)
    
    begin
          
           if(falling_edge(CLK))then
      if(reset_misr='0') then
        misr_reg<= (others=>'0');
        else
      
           case(NBIT) is
               when 7=>misr_reg(0)<= INPUT(0) xor misr_reg(4) xor misr_reg(5)xor misr_reg(6)xor misr_reg(7);
               when 20 =>misr_reg(0)<= INPUT(0) xor misr_reg(14) xor misr_reg(16)xor misr_reg(19)xor misr_reg(20);
               when 28 =>misr_reg(0)<= INPUT(0) xor misr_reg(21) xor misr_reg(23)xor misr_reg(26)xor misr_reg(27);			
               when 30 =>misr_reg(0)<= INPUT(0) xor misr_reg(23) xor misr_reg(25)xor misr_reg(28)xor misr_reg(29);
			   when 257 =>misr_reg(0)<= INPUT(0) xor misr_reg(257) xor misr_reg(255)xor misr_reg(251)xor misr_reg(250);
               when 262 =>misr_reg(0)<= INPUT(0) xor misr_reg(261) xor misr_reg(257)xor misr_reg(253)xor misr_reg(252);
               when 286 =>misr_reg(0)<= INPUT(0) xor misr_reg(286) xor misr_reg(285)xor misr_reg(276)xor misr_reg(271);
               when others =>misr_reg(0)<= INPUT(0) xor misr_reg(5) xor misr_reg(1);
       end case;

       for i in 1 to NBIT-1 loop
        misr_reg(i)<= INPUT(i) xor misr_reg(i-1);
           end loop;
     end if;
   end if;
   end process compaction;
   OUTPUT<=misr_reg;

end behavior;
