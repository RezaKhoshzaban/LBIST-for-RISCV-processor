library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity top_module is
  
  generic(
	N_PI : integer:=256;
        N_SI : integer :=286;	
        N_PO : integer:=232;
        N_SO : integer:=28
    );

port(
    boot_addr_i                   :   in   std_logic_vector(31 downto 0) ;
    core_id_i                     :   in   std_logic_vector(3 downto 0) ;
    cluster_id_i                  :   in   std_logic_vector(5 downto 0) ;
    instr_rdata_i                 :   in   std_logic_vector(127 downto 0); 
    ext_perf_counters_i           :   in   std_logic_vector(1 to 2) ;
    apu_master_result_i           :   in   std_logic_vector(31 downto 0) ;
    apu_master_flags_i            :   in   std_logic_vector(4 downto 0) ;
    irq_id_i                      :   in   std_logic_vector(4 downto 0) ;
    data_rdata_i                  :   in   std_logic_vector(31 downto 0) ;

    clk_i, rst_ni, clock_en_i, test_en_i, fregfile_disable_i,
    instr_gnt_i, instr_rvalid_i, data_gnt_i, data_rvalid_i,
    apu_master_gnt_i, apu_master_valid_i, irq_i, irq_sec_i,
    debug_req_i, fetch_enable_i   :   in  std_logic;
   

    irq_id_o                      :   out  std_logic_vector(4 downto 0) ;
    data_be_o                     :   out  std_logic_vector(3 downto 0) ;
    data_addr_o                   :   out  std_logic_vector(31 downto 0) ;
    data_wdata_o                  :   out  std_logic_vector(31 downto 0) ;
    instr_addr_o                  :   out  std_logic_vector(31 downto 0) ;
    apu_master_operands_o         :   out  std_logic_vector(95 downto 0) ;
    apu_master_op_o               :   out  std_logic_vector(5 downto 0) ;
    apu_master_type_o             :   out  std_logic_vector(1 to 2) ;    
    apu_master_flags_o            :   out  std_logic_vector(14 downto 0) ;

    instr_req_o, data_req_o, data_we_o, apu_master_req_o,
    apu_master_ready_o, irq_ack_o, sec_lvl_o, core_busy_o   :   out  std_logic;
    Normal_Test                   :   in   std_logic;
    Go_Nogo                       :   out  std_logic
    );

end entity top_module;

architecture beh of top_module is

  component lfsr
    generic (
    N     : integer := 286;
    SEED  : integer := 1);
    port (
    CLK        : in std_logic;
    reset_lfsr : in std_logic;
    q          : out std_logic_vector(N downto 0));
  end component;

  component MUX is
	Generic(N: integer:= 256);
	Port (	PI	:	In	std_logic_vector (N-1 downto 0);
			PPI	:	In	std_logic_vector (N-1 downto 0);
			SEL	:   In	std_logic;
			Y	:	Out	std_logic_vector (N-1 downto 0));
  end component;

component phase_shifter is

	generic(N : integer := 286);
	
	port(
	    clk,reset_ps:in std_logic;
	    lfsr_in     :in   std_logic_vector(N-1 downto 0);
	    ps_out      :out  std_logic_vector(N-1 downto 0)
		);
end component;

  component misr
    generic(NBIT: integer :=28);
    port(  
    CLK             :  in    std_logic;
    reset_misr      :  in    std_logic;
    input           :  in    std_logic_vector(NBIT-1 downto 0);
    output          :  out   std_logic_vector(NBIT-1 downto 0)
    );
  end component;

component controller is
  generic ( N : integer := 28);
  port (
    CLK 		        : in  std_logic;
    reset_controller  	: in  std_logic;
    misr_sig	        : in  std_logic_vector ( N-1 downto 0 );
    T_N  		        : in  std_logic;
    scan_en             : out std_logic;
    lfsr_enable         : out std_logic;
    misr_enable         : out std_logic;
    mux_en				: out std_logic;
	test_mode_tp		: out std_logic;
    go_nogo             : out std_logic

	);
     
end component;

component MUX_mem is

	Port (	normal  :	In	std_logic_vector (108 downto 0);
			testing :	In	std_logic_vector (108 downto 0);
		    sel_mem :	In	std_logic;
			out_mem   :	Out	std_logic_vector (108 downto 0));
end component;

component riscv_core_0_128_1_16_1_1_0_0_0_0_0_0_0_0_0_3_6_15_5_1a110800 
    port (
    boot_addr_i          :   in   std_logic_vector(31 downto 0) ;
    core_id_i            :   in   std_logic_vector(3 downto 0) ;
    cluster_id_i         :   in   std_logic_vector(5 downto 0) ;
    instr_addr_o         :   out  std_logic_vector(31 downto 0) ;
    instr_rdata_i        :   in   std_logic_vector(127 downto 0) ;
    data_be_o            :   out  std_logic_vector(3 downto 0) ;
    data_addr_o          :   out  std_logic_vector(31 downto 0) ;
    data_wdata_o         :   out  std_logic_vector(31 downto 0) ;
    data_rdata_i         :   in   std_logic_vector(31 downto 0) ;
    apu_master_operands_o:   out  std_logic_vector(95 downto 0) ;
    apu_master_op_o      :   out  std_logic_vector(5 downto 0) ;
    apu_master_type_o    :   out  std_logic_vector(1 to 2) ;    
    apu_master_flags_o   :   out  std_logic_vector(14 downto 0) ;
    apu_master_result_i  :   in   std_logic_vector(31 downto 0) ;
    apu_master_flags_i   :   in   std_logic_vector(4 downto 0) ;
    irq_id_i             :   in   std_logic_vector(4 downto 0) ;
    irq_id_o             :   out  std_logic_vector(4 downto 0) ;
    ext_perf_counters_i  :   in   std_logic_vector(1 to 2) ;    
    
    clk_i, rst_ni, clock_en_i, test_en_i, fregfile_disable_i, instr_gnt_i,instr_rvalid_i, data_gnt_i, data_rvalid_i, apu_master_gnt_i,
    apu_master_valid_i, irq_i, irq_sec_i, debug_req_i, fetch_enable_i,
    test_si1, test_si2, test_si3, test_si4, test_si5, test_si6, test_si7,
    test_si8, test_si9, test_si10, test_si11, test_si12, test_si13,
    test_si14, test_si15, test_si16, test_si17, test_si18, test_si19,
    test_si20, test_si21, test_si22, test_si23, test_si24, test_si25,test_si26, test_si27, test_si28, test_si29, test_si30,test_mode_tp         : in std_logic;
    
    instr_req_o, data_req_o, data_we_o, apu_master_req_o,
    apu_master_ready_o, irq_ack_o, sec_lvl_o, core_busy_o, test_so1,
    test_so2, test_so3, test_so4, test_so5, test_so6, test_so7, test_so8,
    test_so9, test_so10, test_so11, test_so12, test_so14, test_so16, test_so17, test_so18, test_so19, test_so20,
    test_so21, test_so22, test_so23, test_so24, test_so25,test_so26,
         test_so27, test_so28, test_so29, test_so30 : out std_logic
    );
end component;


  signal mux_sel, test_mode,test_mode_tp_c       : std_logic;
  signal Scan_Out                 : std_logic_vector(N_SO-1 downto 0);
  signal UUT_PO                   : std_logic_vector(231    downto 0);
  signal Scan_In                  : std_logic_vector(N_SI-1 downto 0);
  signal MISR_PO_out              : std_logic_vector(N_PO-1 downto 0);
  signal MISR_SO_out              : std_logic_vector(27 downto 0);
  signal SI_lfsr_out              : std_logic_vector(N_SI downto 0);
  signal mux_out		  : std_logic_vector(N_PI-1 downto 0);
  signal lfsr_en : std_logic;
  signal misr_en : std_logic;
  signal mux_mem_in : std_logic_vector (108 downto 0);

begin


--  not_Normal_Test  <=  not(Normal_Test);


  
ctrl: controller
  generic map(N           =>  28)
port map(
  CLK                     =>      clk_i,
  reset_controller        =>      rst_ni,
  T_N                     =>      Normal_Test,
  misr_sig                =>      MISR_SO_out,
  mux_en			      =>      mux_sel,
  lfsr_enable             =>      lfsr_en,
  scan_en                 =>      test_mode,
  misr_enable			  =>	  misr_en,
  test_mode_tp		      =>	  test_mode_tp_c,
  go_nogo                 =>      Go_Nogo
  );
  


SI_LFSR : lfsr  --648987545 68.61%  744213654 65%   529321598 69.92%
generic map ( N  => N_SI,SEED   => 744213654)
port map (
  CLK        => CLK_i,
  reset_lfsr => lfsr_en,
  q          => SI_lfsr_out
  );


SI_p_s : phase_shifter
generic map (N   => N_SI)
port map (

  clk       => clk_i,
  reset_ps  => lfsr_en,
  lfsr_in   => SI_lfsr_out(285 downto 0),
  ps_out    => Scan_In);
  

SO_MISR : misr
generic map(NBIT  =>28)
port map(  
  clk             =>      clk_i,
  reset_misr      =>      misr_en,
  input           =>      Scan_Out(27 downto 0),
  output          =>      MISR_SO_out
);


MUXX : MUX
	generic map( N => N_PI)


port map (		
		PI(31 downto 0)		=>  	      boot_addr_i,     
		PI(35 downto 32)	=>			  core_id_i,                  
		PI(41 downto 36) 	=>			  cluster_id_i,               
		PI(169 downto 42) 	=>			  instr_rdata_i,             
		PI(201 downto 170) 	=>			  data_rdata_i,               
		PI(233 downto 202) 	=>			  apu_master_result_i,      
		PI(238 downto 234)  =>			  apu_master_flags_i,        
		PI(243 downto 239)  =>			  irq_id_i,                    
		PI(245 downto 244)  =>			  ext_perf_counters_i,        			
		PI(246) 			=>			  apu_master_gnt_i,     
		PI(247) 			=>			  apu_master_valid_i,   
		PI(248) 			=>			  data_gnt_i,           
		PI(249) 			=>			  data_rvalid_i,         
		PI(250) 			=>			  debug_req_i,          
		PI(251) 			=>			  fetch_enable_i,        
		PI(252) 			=>			  instr_gnt_i,          
		PI(253) 			=>			  instr_rvalid_i,        
		PI(254) 			=>			  irq_i,                 
		PI(255) 			=>			  irq_sec_i,             
					  
					  
  
		PPI=> Scan_In (285 downto 30),
		Y  => mux_out,
		SEL=> mux_sel
);

mux_memory : MUX_mem
	port map (	normal  =>    mux_mem_in,
				testing =>    UUT_PO( 136 downto 28),

				out_mem(3 downto 0) =>				data_be_o,  
				out_mem(35 downto 4)=>				data_addr_o,  
				out_mem(67 downto 36) =>			data_wdata_o,
				out_mem(72 downto 68) =>			irq_id_o,
				out_mem(104 downto 73) =>			instr_addr_o,
				out_mem(105) =>						data_req_o,
				out_mem(106) =>						data_we_o,
				out_mem(107) =>						instr_req_o,
				out_mem(108) =>						irq_ack_o,
		    	sel_mem => test_mode_tp_c
);

UUT : riscv_core_0_128_1_16_1_1_0_0_0_0_0_0_0_0_0_3_6_15_5_1a110800
  port map (
  
  
  
  
  clk_i                 =>      clk_i,
  rst_ni                =>      rst_ni,
  clock_en_i            =>      clock_en_i,
  test_en_i             =>      test_mode,   
  fregfile_disable_i    =>      fregfile_disable_i,
  
  
  
  
  boot_addr_i           =>      mux_out(31 downto 0),
  core_id_i             =>      mux_out(35 downto 32),
  cluster_id_i          =>      mux_out(41 downto 36),
  instr_rdata_i         =>      mux_out(169 downto 42),
  data_rdata_i          =>      mux_out(201 downto 170),
  apu_master_result_i   =>      mux_out(233 downto 202),
  apu_master_flags_i    =>      mux_out(238 downto 234),
  irq_id_i              =>      mux_out(243 downto 239),
  ext_perf_counters_i   =>      mux_out(245 downto 244),
    

  apu_master_gnt_i      =>      mux_out(246),
  apu_master_valid_i    =>      mux_out(247),
  data_gnt_i            =>      mux_out(248),
  data_rvalid_i         =>      mux_out(249),
  debug_req_i           =>      mux_out(250),
  fetch_enable_i        =>      mux_out(251),  -- <--
  instr_gnt_i           =>      mux_out(252),
  instr_rvalid_i        =>      mux_out(253),
  irq_i                 =>      mux_out(254),
  irq_sec_i             =>      mux_out(255),




--  apu_master_operands_o =>      Scan_Out (125 downto 30),
--  apu_master_op_o       =>      Scan_Out (131 downto 126),
--  apu_master_type_o     =>      Scan_Out (133 downto 132),
--  apu_master_flags_o    =>      Scan_Out (148 downto 134),
--  data_be_o        ---     =>      Scan_Out (152 downto 149),
--  data_addr_o      ---     =>      Scan_Out (184 downto 153),
--  data_wdata_o    ---      =>      Scan_Out (216 downto 185),
--  irq_id_o        ---      =>      Scan_Out (221 downto 217),
--  instr_addr_o      ---    =>      Scan_Out (253 downto 222),
--  apu_master_ready_o  =>      Scan_Out (254),
--  apu_master_req_o    =>      Scan_Out (255),
--  core_busy_o         =>      Scan_Out (256),
--  data_req_o      ---    =>      Scan_Out (257),
--  data_we_o      ---     =>      Scan_Out (258),
--  instr_req_o     ---    =>      Scan_Out (259),
--  irq_ack_o     ---      =>      Scan_Out (260),
--  sec_lvl_o           =>      Scan_Out (261),

  
    apu_master_operands_o =>      apu_master_operands_o,
  apu_master_op_o       =>   	  apu_master_op_o,
  apu_master_type_o     =>      apu_master_type_o,
  apu_master_flags_o    =>     apu_master_flags_o,
  data_be_o             =>     mux_mem_in(3 downto 0) ,
  data_addr_o           =>     mux_mem_in(35 downto 4) ,
  data_wdata_o          =>     mux_mem_in(67 downto 36),
  irq_id_o              =>     mux_mem_in(72 downto 68),
  instr_addr_o          =>     mux_mem_in(104 downto 73),
  apu_master_ready_o  =>      apu_master_ready_o,
  apu_master_req_o    =>      apu_master_req_o,
  core_busy_o         =>      core_busy_o,
  data_req_o          =>      mux_mem_in(105),
  data_we_o           =>      mux_mem_in(106),
  instr_req_o         =>      mux_mem_in(107),
  irq_ack_o           =>      mux_mem_in(108),
  sec_lvl_o           =>      sec_lvl_o,


    test_si1     =>      Scan_In(0),
    test_so1     =>      Scan_Out(0),
    test_si2     =>      Scan_In(1),
    test_so2     =>      Scan_Out(1),
    test_si3     =>      Scan_In(2),
    test_so3     =>      Scan_Out(2),
    test_si4     =>      Scan_In(3),
    test_so4     =>      Scan_Out(3),
    test_si5     =>      Scan_In(4),
    test_so5     =>      Scan_Out(4),
    test_si6     =>      Scan_In(5),
    test_so6     =>      Scan_Out(5),
    test_si7     =>      Scan_In(6),
    test_so7     =>      Scan_Out(6),
    test_si8     =>      Scan_In(7),
    test_so8     =>      Scan_Out(7),
    test_si9     =>      Scan_In(8),
    test_so9     =>      Scan_Out(8),
    test_si10    =>      Scan_In(9),
    test_so10    =>      Scan_Out(9),
    test_si11    =>      Scan_In(10),
    test_so11    =>      Scan_Out(10),
    test_si12    =>      Scan_In(11),
    test_so12    =>      Scan_Out(11),
    test_si13    =>      Scan_In(12),
--    test_so13    =>      Scan_Out(12), -- <--
    test_si14    =>      Scan_In(13),
    test_so14    =>      Scan_Out(12),
    test_si15    =>      Scan_In(14),
--    test_so15    =>      Scan_Out(14),  -- <--
    test_si16    =>      Scan_In(15),
    test_so16    =>      Scan_Out(13),
    test_si17    =>      Scan_In(16),
    test_so17    =>      Scan_Out(14),
    test_si18    =>      Scan_In(17),
    test_so18    =>      Scan_Out(15),
    test_si19    =>      Scan_In(18),
    test_so19    =>      Scan_Out(16),
    test_si20    =>      Scan_In(19),
    test_so20    =>      Scan_Out(17),
    test_si21    =>      Scan_In(20),
    test_so21    =>      Scan_Out(18),
    test_si22    =>      Scan_In(21),
    test_so22    =>      Scan_Out(19),
    test_si23    =>      Scan_In(22),
    test_so23    =>      Scan_Out(20),
    test_si24    =>      Scan_In(23),
    test_so24    =>      Scan_Out(21),
    test_si25    =>      Scan_In(24),
    test_so25    =>      Scan_Out(22),
    test_si26    =>      Scan_In(25),
    test_so26    =>      Scan_Out(23),
    test_si27    =>      Scan_In(26),
    test_so27    =>      Scan_Out(24),
    test_si28    =>      Scan_In(27),
    test_so28    =>      Scan_Out(25),
    test_si29    =>      Scan_In(28),
    test_so29    =>      Scan_Out(26),
    test_si30    =>      Scan_In(29),
    test_so30    =>      Scan_Out(27),
	test_mode_tp =>      test_mode_tp_c

  );

end beh;
