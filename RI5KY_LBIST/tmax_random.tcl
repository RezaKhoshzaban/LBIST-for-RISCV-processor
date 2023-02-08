## Build and DRC
read_netlist gate/NangateOpenCellLibrary.tlib -library
read_netlist gate/riscv_core_scan.v
run_build_model riscv_core_0_128_1_16_1_1_0_0_0_0_0_0_0_0_0_3_6_15_5_1a110800
run_drc gate/riscv_core_scan.spf


set_patterns -random
set_random_patterns -clock clk_i
set_random_patterns -length 100000


## Fault list (select one of the following)
#add_faults -all
#add_faults ex_stage_i/alu_i
add_faults ex_stage_i/alu_i/int_div_div_i
#add_faults ex_stage_i/mult_i
#add_faults id_stage_i/registers_i/riscv_register_file_i
#read_faults previous_fsim_faults.txt -force_retain_code -add


run_fault_sim

report_summaries

quit

