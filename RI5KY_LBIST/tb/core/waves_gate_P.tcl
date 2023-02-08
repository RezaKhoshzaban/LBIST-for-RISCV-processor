# catch {
#     if {$trdb_all ne ""} {
#	foreach inst $trdb_all {
#	    add wave -group [file tail $inst] $inst/*
#	}
#     }
# } err

# if {$err ne ""} {
#     puts "\[TCL\]: Suppressed error: $err"
# }

# add fc
#set rvcores [find instances -recursive -bydu riscv_core* -nodu]
set rvcores /tb_top/riscv_wrapper_i/top_module_i/UUT
set fpuprivate [find instances -recursive -bydu fpu_private]
set tb_top [find instances -recursive -bydu tb_top -nod]
set mm_ram [find instances -recursive -bydu mm_ram -nod]
set dp_ram [find instances -recursive -bydu dp_ram -nod]

#set rvcores ""
#set fpuprivate ""
#set tb_top ""
#set mm_ram ""
#set dp_ram ""

#  add wave -group "BIST" -group "Controller"               /tb_top/riscv_wrapper_i/top_module_i/ctrl/*
#  add wave -group "BIST" -group "SI_LFSR"                  /tb_top/riscv_wrapper_i/top_module_i/SI_LFSR/*
#  add wave -group "BIST" -group "PI_LFSR_1"                /tb_top/riscv_wrapper_i/top_module_i/PI_LFSR_1/*
#  add wave -group "BIST" -group "SI_ph_shif"               /tb_top/riscv_wrapper_i/top_module_i/SI_ph_shif/*
#  add wave -group "BIST" -group "m_u_x_PI"                 /tb_top/riscv_wrapper_i/top_module_i/m_u_x_PI/*
#  add wave -group "BIST" -group "SO_MISR"                  /tb_top/riscv_wrapper_i/top_module_i/SO_MISR/*
#  add wave -group "BIST" -group "MISR"                     /tb_top/riscv_wrapper_i/top_module_i/SO_MISR/*
#  add wave -group "BIST"                                   /tb_top/riscv_wrapper_i/top_module_i/*
#  add wave -group "BIST"                                   /tb_top/riscv_wrapper_i/top_module_i/ctrl/golden_signature_SO

if {$tb_top ne ""} {
    foreach inst $tb_top {
	add wave -group [file tail $inst] $inst/*
    }
}

if {$mm_ram ne ""} {
    foreach inst $mm_ram {
	add wave -group [file tail $inst] $inst/*
    }
}

if {$dp_ram ne ""} {
    foreach inst $dp_ram {
	add wave -group [file tail $inst] $inst/*
    }
}

if {$rvcores ne ""} {
  set rvprefetch [find instances -recursive -bydu riscv_prefetch_L0_buffer -nodu]

  add wave -group "Core"                                     $rvcores/*
  add wave -group "IF Stage" -group "Hwlp Ctrl"              $rvcores/if_stage_i/hwloop_controller_i/*
  if {$rvprefetch ne ""} {
    add wave -group "IF Stage" -group "Prefetch" -group "L0"   $rvcores/if_stage_i/prefetch_128_prefetch_buffer_i/L0_buffer_i/*
    add wave -group "IF Stage" -group "Prefetch"               $rvcores/if_stage_i/prefetch_128_prefetch_buffer_i/*
#  } {
#    add wave -group "IF Stage" -group "Prefetch" -group "FIFO" $rvcores/if_stage_i/prefetch_32/prefetch_buffer_i/fifo_i/*
#    add wave -group "IF Stage" -group "Prefetch"               $rvcores/if_stage_i/prefetch_32/prefetch_buffer_i/*
  }
  add wave -group "IF Stage"                                 $rvcores/if_stage_i/*
  add wave -group "ID Stage"                                 $rvcores/id_stage_i/*

quietly virtual signal -install /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i { (context /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i )&{mem_reg_1__31_/Q , mem_reg_1__30_/Q , mem_reg_1__29_/Q , mem_reg_1__28_/Q , mem_reg_1__27_/Q , mem_reg_1__26_/Q , mem_reg_1__25_/Q , mem_reg_1__24_/Q , mem_reg_1__23_/Q , mem_reg_1__22_/Q , mem_reg_1__21_/Q , mem_reg_1__20_/Q , mem_reg_1__19_/Q , mem_reg_1__18_/Q , mem_reg_1__17_/Q , mem_reg_1__16_/Q , mem_reg_1__15_/Q , mem_reg_1__14_/Q , mem_reg_1__13_/Q , mem_reg_1__12_/Q , mem_reg_1__11_/Q , mem_reg_1__10_/Q , mem_reg_1__9_/Q , mem_reg_1__8_/Q , mem_reg_1__7_/Q , mem_reg_1__6_/Q , mem_reg_1__5_/Q , mem_reg_1__4_/Q , mem_reg_1__3_/Q , mem_reg_1__2_/Q , mem_reg_1__1_/Q , mem_reg_1__0_/Q }} gpr1

quietly virtual signal -install /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i { (context /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i )&{mem_reg_2__31_/Q , mem_reg_2__30_/Q , mem_reg_2__29_/Q , mem_reg_2__28_/Q , mem_reg_2__27_/Q , mem_reg_2__26_/Q , mem_reg_2__25_/Q , mem_reg_2__24_/Q , mem_reg_2__23_/Q , mem_reg_2__22_/Q , mem_reg_2__21_/Q , mem_reg_2__20_/Q , mem_reg_2__19_/Q , mem_reg_2__18_/Q , mem_reg_2__17_/Q , mem_reg_2__16_/Q , mem_reg_2__15_/Q , mem_reg_2__14_/Q , mem_reg_2__13_/Q , mem_reg_2__12_/Q , mem_reg_2__11_/Q , mem_reg_2__10_/Q , mem_reg_2__9_/Q , mem_reg_2__8_/Q , mem_reg_2__7_/Q , mem_reg_2__6_/Q , mem_reg_2__5_/Q , mem_reg_2__4_/Q , mem_reg_2__3_/Q , mem_reg_2__2_/Q , mem_reg_2__1_/Q , mem_reg_2__0_/Q }} gpr2

quietly virtual signal -install /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i { (context /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i )&{mem_reg_3__31_/Q , mem_reg_3__30_/Q , mem_reg_3__29_/Q , mem_reg_3__28_/Q , mem_reg_3__27_/Q , mem_reg_3__26_/Q , mem_reg_3__25_/Q , mem_reg_3__24_/Q , mem_reg_3__23_/Q , mem_reg_3__22_/Q , mem_reg_3__21_/Q , mem_reg_3__20_/Q , mem_reg_3__19_/Q , mem_reg_3__18_/Q , mem_reg_3__17_/Q , mem_reg_3__16_/Q , mem_reg_3__15_/Q , mem_reg_3__14_/Q , mem_reg_3__13_/Q , mem_reg_3__12_/Q , mem_reg_3__11_/Q , mem_reg_3__10_/Q , mem_reg_3__9_/Q , mem_reg_3__8_/Q , mem_reg_3__7_/Q , mem_reg_3__6_/Q , mem_reg_3__5_/Q , mem_reg_3__4_/Q , mem_reg_3__3_/Q , mem_reg_3__2_/Q , mem_reg_3__1_/Q , mem_reg_3__0_/Q }} gpr3

quietly virtual signal -install /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i { (context /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i )&{mem_reg_4__31_/Q , mem_reg_4__30_/Q , mem_reg_4__29_/Q , mem_reg_4__28_/Q , mem_reg_4__27_/Q , mem_reg_4__26_/Q , mem_reg_4__25_/Q , mem_reg_4__24_/Q , mem_reg_4__23_/Q , mem_reg_4__22_/Q , mem_reg_4__21_/Q , mem_reg_4__20_/Q , mem_reg_4__19_/Q , mem_reg_4__18_/Q , mem_reg_4__17_/Q , mem_reg_4__16_/Q , mem_reg_4__15_/Q , mem_reg_4__14_/Q , mem_reg_4__13_/Q , mem_reg_4__12_/Q , mem_reg_4__11_/Q , mem_reg_4__10_/Q , mem_reg_4__9_/Q , mem_reg_4__8_/Q , mem_reg_4__7_/Q , mem_reg_4__6_/Q , mem_reg_4__5_/Q , mem_reg_4__4_/Q , mem_reg_4__3_/Q , mem_reg_4__2_/Q , mem_reg_4__1_/Q , mem_reg_4__0_/Q }} gpr4

quietly virtual signal -install /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i { (context /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i )&{mem_reg_5__31_/Q , mem_reg_5__30_/Q , mem_reg_5__29_/Q , mem_reg_5__28_/Q , mem_reg_5__27_/Q , mem_reg_5__26_/Q , mem_reg_5__25_/Q , mem_reg_5__24_/Q , mem_reg_5__23_/Q , mem_reg_5__22_/Q , mem_reg_5__21_/Q , mem_reg_5__20_/Q , mem_reg_5__19_/Q , mem_reg_5__18_/Q , mem_reg_5__17_/Q , mem_reg_5__16_/Q , mem_reg_5__15_/Q , mem_reg_5__14_/Q , mem_reg_5__13_/Q , mem_reg_5__12_/Q , mem_reg_5__11_/Q , mem_reg_5__10_/Q , mem_reg_5__9_/Q , mem_reg_5__8_/Q , mem_reg_5__7_/Q , mem_reg_5__6_/Q , mem_reg_5__5_/Q , mem_reg_5__4_/Q , mem_reg_5__3_/Q , mem_reg_5__2_/Q , mem_reg_5__1_/Q , mem_reg_5__0_/Q }} gpr5

quietly virtual signal -install /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i { (context /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i )&{mem_reg_6__31_/Q , mem_reg_6__30_/Q , mem_reg_6__29_/Q , mem_reg_6__28_/Q , mem_reg_6__27_/Q , mem_reg_6__26_/Q , mem_reg_6__25_/Q , mem_reg_6__24_/Q , mem_reg_6__23_/Q , mem_reg_6__22_/Q , mem_reg_6__21_/Q , mem_reg_6__20_/Q , mem_reg_6__19_/Q , mem_reg_6__18_/Q , mem_reg_6__17_/Q , mem_reg_6__16_/Q , mem_reg_6__15_/Q , mem_reg_6__14_/Q , mem_reg_6__13_/Q , mem_reg_6__12_/Q , mem_reg_6__11_/Q , mem_reg_6__10_/Q , mem_reg_6__9_/Q , mem_reg_6__8_/Q , mem_reg_6__7_/Q , mem_reg_6__6_/Q , mem_reg_6__5_/Q , mem_reg_6__4_/Q , mem_reg_6__3_/Q , mem_reg_6__2_/Q , mem_reg_6__1_/Q , mem_reg_6__0_/Q }} gpr6

quietly virtual signal -install /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i { (context /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i )&{mem_reg_7__31_/Q , mem_reg_7__30_/Q , mem_reg_7__29_/Q , mem_reg_7__28_/Q , mem_reg_7__27_/Q , mem_reg_7__26_/Q , mem_reg_7__25_/Q , mem_reg_7__24_/Q , mem_reg_7__23_/Q , mem_reg_7__22_/Q , mem_reg_7__21_/Q , mem_reg_7__20_/Q , mem_reg_7__19_/Q , mem_reg_7__18_/Q , mem_reg_7__17_/Q , mem_reg_7__16_/Q , mem_reg_7__15_/Q , mem_reg_7__14_/Q , mem_reg_7__13_/Q , mem_reg_7__12_/Q , mem_reg_7__11_/Q , mem_reg_7__10_/Q , mem_reg_7__9_/Q , mem_reg_7__8_/Q , mem_reg_7__7_/Q , mem_reg_7__6_/Q , mem_reg_7__5_/Q , mem_reg_7__4_/Q , mem_reg_7__3_/Q , mem_reg_7__2_/Q , mem_reg_7__1_/Q , mem_reg_7__0_/Q }} gpr7

quietly virtual signal -install /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i { (context /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i )&{mem_reg_8__31_/Q , mem_reg_8__30_/Q , mem_reg_8__29_/Q , mem_reg_8__28_/Q , mem_reg_8__27_/Q , mem_reg_8__26_/Q , mem_reg_8__25_/Q , mem_reg_8__24_/Q , mem_reg_8__23_/Q , mem_reg_8__22_/Q , mem_reg_8__21_/Q , mem_reg_8__20_/Q , mem_reg_8__19_/Q , mem_reg_8__18_/Q , mem_reg_8__17_/Q , mem_reg_8__16_/Q , mem_reg_8__15_/Q , mem_reg_8__14_/Q , mem_reg_8__13_/Q , mem_reg_8__12_/Q , mem_reg_8__11_/Q , mem_reg_8__10_/Q , mem_reg_8__9_/Q , mem_reg_8__8_/Q , mem_reg_8__7_/Q , mem_reg_8__6_/Q , mem_reg_8__5_/Q , mem_reg_8__4_/Q , mem_reg_8__3_/Q , mem_reg_8__2_/Q , mem_reg_8__1_/Q , mem_reg_8__0_/Q }} gpr8

quietly virtual signal -install /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i { (context /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i )&{mem_reg_9__31_/Q , mem_reg_9__30_/Q , mem_reg_9__29_/Q , mem_reg_9__28_/Q , mem_reg_9__27_/Q , mem_reg_9__26_/Q , mem_reg_9__25_/Q , mem_reg_9__24_/Q , mem_reg_9__23_/Q , mem_reg_9__22_/Q , mem_reg_9__21_/Q , mem_reg_9__20_/Q , mem_reg_9__19_/Q , mem_reg_9__18_/Q , mem_reg_9__17_/Q , mem_reg_9__16_/Q , mem_reg_9__15_/Q , mem_reg_9__14_/Q , mem_reg_9__13_/Q , mem_reg_9__12_/Q , mem_reg_9__11_/Q , mem_reg_9__10_/Q , mem_reg_9__9_/Q , mem_reg_9__8_/Q , mem_reg_9__7_/Q , mem_reg_9__6_/Q , mem_reg_9__5_/Q , mem_reg_9__4_/Q , mem_reg_9__3_/Q , mem_reg_9__2_/Q , mem_reg_9__1_/Q , mem_reg_9__0_/Q }} gpr9

quietly virtual signal -install /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i { (context /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i )&{mem_reg_10__31_/Q , mem_reg_10__30_/Q , mem_reg_10__29_/Q , mem_reg_10__28_/Q , mem_reg_10__27_/Q , mem_reg_10__26_/Q , mem_reg_10__25_/Q , mem_reg_10__24_/Q , mem_reg_10__23_/Q , mem_reg_10__22_/Q , mem_reg_10__21_/Q , mem_reg_10__20_/Q , mem_reg_10__19_/Q , mem_reg_10__18_/Q , mem_reg_10__17_/Q , mem_reg_10__16_/Q , mem_reg_10__15_/Q , mem_reg_10__14_/Q , mem_reg_10__13_/Q , mem_reg_10__12_/Q , mem_reg_10__11_/Q , mem_reg_10__10_/Q , mem_reg_10__9_/Q , mem_reg_10__8_/Q , mem_reg_10__7_/Q , mem_reg_10__6_/Q , mem_reg_10__5_/Q , mem_reg_10__4_/Q , mem_reg_10__3_/Q , mem_reg_10__2_/Q , mem_reg_10__1_/Q , mem_reg_10__0_/Q }} gpr10

quietly virtual signal -install /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i { (context /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i )&{mem_reg_11__31_/Q , mem_reg_11__30_/Q , mem_reg_11__29_/Q , mem_reg_11__28_/Q , mem_reg_11__27_/Q , mem_reg_11__26_/Q , mem_reg_11__25_/Q , mem_reg_11__24_/Q , mem_reg_11__23_/Q , mem_reg_11__22_/Q , mem_reg_11__21_/Q , mem_reg_11__20_/Q , mem_reg_11__19_/Q , mem_reg_11__18_/Q , mem_reg_11__17_/Q , mem_reg_11__16_/Q , mem_reg_11__15_/Q , mem_reg_11__14_/Q , mem_reg_11__13_/Q , mem_reg_11__12_/Q , mem_reg_11__11_/Q , mem_reg_11__10_/Q , mem_reg_11__9_/Q , mem_reg_11__8_/Q , mem_reg_11__7_/Q , mem_reg_11__6_/Q , mem_reg_11__5_/Q , mem_reg_11__4_/Q , mem_reg_11__3_/Q , mem_reg_11__2_/Q , mem_reg_11__1_/Q , mem_reg_11__0_/Q }} gpr11

quietly virtual signal -install /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i { (context /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i )&{mem_reg_12__31_/Q , mem_reg_12__30_/Q , mem_reg_12__29_/Q , mem_reg_12__28_/Q , mem_reg_12__27_/Q , mem_reg_12__26_/Q , mem_reg_12__25_/Q , mem_reg_12__24_/Q , mem_reg_12__23_/Q , mem_reg_12__22_/Q , mem_reg_12__21_/Q , mem_reg_12__20_/Q , mem_reg_12__19_/Q , mem_reg_12__18_/Q , mem_reg_12__17_/Q , mem_reg_12__16_/Q , mem_reg_12__15_/Q , mem_reg_12__14_/Q , mem_reg_12__13_/Q , mem_reg_12__12_/Q , mem_reg_12__11_/Q , mem_reg_12__10_/Q , mem_reg_12__9_/Q , mem_reg_12__8_/Q , mem_reg_12__7_/Q , mem_reg_12__6_/Q , mem_reg_12__5_/Q , mem_reg_12__4_/Q , mem_reg_12__3_/Q , mem_reg_12__2_/Q , mem_reg_12__1_/Q , mem_reg_12__0_/Q }} gpr12

quietly virtual signal -install /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i { (context /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i )&{mem_reg_13__31_/Q , mem_reg_13__30_/Q , mem_reg_13__29_/Q , mem_reg_13__28_/Q , mem_reg_13__27_/Q , mem_reg_13__26_/Q , mem_reg_13__25_/Q , mem_reg_13__24_/Q , mem_reg_13__23_/Q , mem_reg_13__22_/Q , mem_reg_13__21_/Q , mem_reg_13__20_/Q , mem_reg_13__19_/Q , mem_reg_13__18_/Q , mem_reg_13__17_/Q , mem_reg_13__16_/Q , mem_reg_13__15_/Q , mem_reg_13__14_/Q , mem_reg_13__13_/Q , mem_reg_13__12_/Q , mem_reg_13__11_/Q , mem_reg_13__10_/Q , mem_reg_13__9_/Q , mem_reg_13__8_/Q , mem_reg_13__7_/Q , mem_reg_13__6_/Q , mem_reg_13__5_/Q , mem_reg_13__4_/Q , mem_reg_13__3_/Q , mem_reg_13__2_/Q , mem_reg_13__1_/Q , mem_reg_13__0_/Q }} gpr13

quietly virtual signal -install /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i { (context /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i )&{mem_reg_14__31_/Q , mem_reg_14__30_/Q , mem_reg_14__29_/Q , mem_reg_14__28_/Q , mem_reg_14__27_/Q , mem_reg_14__26_/Q , mem_reg_14__25_/Q , mem_reg_14__24_/Q , mem_reg_14__23_/Q , mem_reg_14__22_/Q , mem_reg_14__21_/Q , mem_reg_14__20_/Q , mem_reg_14__19_/Q , mem_reg_14__18_/Q , mem_reg_14__17_/Q , mem_reg_14__16_/Q , mem_reg_14__15_/Q , mem_reg_14__14_/Q , mem_reg_14__13_/Q , mem_reg_14__12_/Q , mem_reg_14__11_/Q , mem_reg_14__10_/Q , mem_reg_14__9_/Q , mem_reg_14__8_/Q , mem_reg_14__7_/Q , mem_reg_14__6_/Q , mem_reg_14__5_/Q , mem_reg_14__4_/Q , mem_reg_14__3_/Q , mem_reg_14__2_/Q , mem_reg_14__1_/Q , mem_reg_14__0_/Q }} gpr14

quietly virtual signal -install /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i { (context /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i )&{mem_reg_15__31_/Q , mem_reg_15__30_/Q , mem_reg_15__29_/Q , mem_reg_15__28_/Q , mem_reg_15__27_/Q , mem_reg_15__26_/Q , mem_reg_15__25_/Q , mem_reg_15__24_/Q , mem_reg_15__23_/Q , mem_reg_15__22_/Q , mem_reg_15__21_/Q , mem_reg_15__20_/Q , mem_reg_15__19_/Q , mem_reg_15__18_/Q , mem_reg_15__17_/Q , mem_reg_15__16_/Q , mem_reg_15__15_/Q , mem_reg_15__14_/Q , mem_reg_15__13_/Q , mem_reg_15__12_/Q , mem_reg_15__11_/Q , mem_reg_15__10_/Q , mem_reg_15__9_/Q , mem_reg_15__8_/Q , mem_reg_15__7_/Q , mem_reg_15__6_/Q , mem_reg_15__5_/Q , mem_reg_15__4_/Q , mem_reg_15__3_/Q , mem_reg_15__2_/Q , mem_reg_15__1_/Q , mem_reg_15__0_/Q }} gpr15

quietly virtual signal -install /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i { (context /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i )&{mem_reg_16__31_/Q , mem_reg_16__30_/Q , mem_reg_16__29_/Q , mem_reg_16__28_/Q , mem_reg_16__27_/Q , mem_reg_16__26_/Q , mem_reg_16__25_/Q , mem_reg_16__24_/Q , mem_reg_16__23_/Q , mem_reg_16__22_/Q , mem_reg_16__21_/Q , mem_reg_16__20_/Q , mem_reg_16__19_/Q , mem_reg_16__18_/Q , mem_reg_16__17_/Q , mem_reg_16__16_/Q , mem_reg_16__15_/Q , mem_reg_16__14_/Q , mem_reg_16__13_/Q , mem_reg_16__12_/Q , mem_reg_16__11_/Q , mem_reg_16__10_/Q , mem_reg_16__9_/Q , mem_reg_16__8_/Q , mem_reg_16__7_/Q , mem_reg_16__6_/Q , mem_reg_16__5_/Q , mem_reg_16__4_/Q , mem_reg_16__3_/Q , mem_reg_16__2_/Q , mem_reg_16__1_/Q , mem_reg_16__0_/Q }} gpr16

quietly virtual signal -install /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i { (context /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i )&{mem_reg_17__31_/Q , mem_reg_17__30_/Q , mem_reg_17__29_/Q , mem_reg_17__28_/Q , mem_reg_17__27_/Q , mem_reg_17__26_/Q , mem_reg_17__25_/Q , mem_reg_17__24_/Q , mem_reg_17__23_/Q , mem_reg_17__22_/Q , mem_reg_17__21_/Q , mem_reg_17__20_/Q , mem_reg_17__19_/Q , mem_reg_17__18_/Q , mem_reg_17__17_/Q , mem_reg_17__16_/Q , mem_reg_17__15_/Q , mem_reg_17__14_/Q , mem_reg_17__13_/Q , mem_reg_17__12_/Q , mem_reg_17__11_/Q , mem_reg_17__10_/Q , mem_reg_17__9_/Q , mem_reg_17__8_/Q , mem_reg_17__7_/Q , mem_reg_17__6_/Q , mem_reg_17__5_/Q , mem_reg_17__4_/Q , mem_reg_17__3_/Q , mem_reg_17__2_/Q , mem_reg_17__1_/Q , mem_reg_17__0_/Q }} gpr17

quietly virtual signal -install /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i { (context /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i )&{mem_reg_18__31_/Q , mem_reg_18__30_/Q , mem_reg_18__29_/Q , mem_reg_18__28_/Q , mem_reg_18__27_/Q , mem_reg_18__26_/Q , mem_reg_18__25_/Q , mem_reg_18__24_/Q , mem_reg_18__23_/Q , mem_reg_18__22_/Q , mem_reg_18__21_/Q , mem_reg_18__20_/Q , mem_reg_18__19_/Q , mem_reg_18__18_/Q , mem_reg_18__17_/Q , mem_reg_18__16_/Q , mem_reg_18__15_/Q , mem_reg_18__14_/Q , mem_reg_18__13_/Q , mem_reg_18__12_/Q , mem_reg_18__11_/Q , mem_reg_18__10_/Q , mem_reg_18__9_/Q , mem_reg_18__8_/Q , mem_reg_18__7_/Q , mem_reg_18__6_/Q , mem_reg_18__5_/Q , mem_reg_18__4_/Q , mem_reg_18__3_/Q , mem_reg_18__2_/Q , mem_reg_18__1_/Q , mem_reg_18__0_/Q }} gpr18

quietly virtual signal -install /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i { (context /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i )&{mem_reg_19__31_/Q , mem_reg_19__30_/Q , mem_reg_19__29_/Q , mem_reg_19__28_/Q , mem_reg_19__27_/Q , mem_reg_19__26_/Q , mem_reg_19__25_/Q , mem_reg_19__24_/Q , mem_reg_19__23_/Q , mem_reg_19__22_/Q , mem_reg_19__21_/Q , mem_reg_19__20_/Q , mem_reg_19__19_/Q , mem_reg_19__18_/Q , mem_reg_19__17_/Q , mem_reg_19__16_/Q , mem_reg_19__15_/Q , mem_reg_19__14_/Q , mem_reg_19__13_/Q , mem_reg_19__12_/Q , mem_reg_19__11_/Q , mem_reg_19__10_/Q , mem_reg_19__9_/Q , mem_reg_19__8_/Q , mem_reg_19__7_/Q , mem_reg_19__6_/Q , mem_reg_19__5_/Q , mem_reg_19__4_/Q , mem_reg_19__3_/Q , mem_reg_19__2_/Q , mem_reg_19__1_/Q , mem_reg_19__0_/Q }} gpr19

quietly virtual signal -install /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i { (context /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i )&{mem_reg_20__31_/Q , mem_reg_20__30_/Q , mem_reg_20__29_/Q , mem_reg_20__28_/Q , mem_reg_20__27_/Q , mem_reg_20__26_/Q , mem_reg_20__25_/Q , mem_reg_20__24_/Q , mem_reg_20__23_/Q , mem_reg_20__22_/Q , mem_reg_20__21_/Q , mem_reg_20__20_/Q , mem_reg_20__19_/Q , mem_reg_20__18_/Q , mem_reg_20__17_/Q , mem_reg_20__16_/Q , mem_reg_20__15_/Q , mem_reg_20__14_/Q , mem_reg_20__13_/Q , mem_reg_20__12_/Q , mem_reg_20__11_/Q , mem_reg_20__10_/Q , mem_reg_20__9_/Q , mem_reg_20__8_/Q , mem_reg_20__7_/Q , mem_reg_20__6_/Q , mem_reg_20__5_/Q , mem_reg_20__4_/Q , mem_reg_20__3_/Q , mem_reg_20__2_/Q , mem_reg_20__1_/Q , mem_reg_20__0_/Q }} gpr20

quietly virtual signal -install /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i { (context /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i )&{mem_reg_21__31_/Q , mem_reg_21__30_/Q , mem_reg_21__29_/Q , mem_reg_21__28_/Q , mem_reg_21__27_/Q , mem_reg_21__26_/Q , mem_reg_21__25_/Q , mem_reg_21__24_/Q , mem_reg_21__23_/Q , mem_reg_21__22_/Q , mem_reg_21__21_/Q , mem_reg_21__20_/Q , mem_reg_21__19_/Q , mem_reg_21__18_/Q , mem_reg_21__17_/Q , mem_reg_21__16_/Q , mem_reg_21__15_/Q , mem_reg_21__14_/Q , mem_reg_21__13_/Q , mem_reg_21__12_/Q , mem_reg_21__11_/Q , mem_reg_21__10_/Q , mem_reg_21__9_/Q , mem_reg_21__8_/Q , mem_reg_21__7_/Q , mem_reg_21__6_/Q , mem_reg_21__5_/Q , mem_reg_21__4_/Q , mem_reg_21__3_/Q , mem_reg_21__2_/Q , mem_reg_21__1_/Q , mem_reg_21__0_/Q }} gpr21

quietly virtual signal -install /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i { (context /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i )&{mem_reg_22__31_/Q , mem_reg_22__30_/Q , mem_reg_22__29_/Q , mem_reg_22__28_/Q , mem_reg_22__27_/Q , mem_reg_22__26_/Q , mem_reg_22__25_/Q , mem_reg_22__24_/Q , mem_reg_22__23_/Q , mem_reg_22__22_/Q , mem_reg_22__21_/Q , mem_reg_22__20_/Q , mem_reg_22__19_/Q , mem_reg_22__18_/Q , mem_reg_22__17_/Q , mem_reg_22__16_/Q , mem_reg_22__15_/Q , mem_reg_22__14_/Q , mem_reg_22__13_/Q , mem_reg_22__12_/Q , mem_reg_22__11_/Q , mem_reg_22__10_/Q , mem_reg_22__9_/Q , mem_reg_22__8_/Q , mem_reg_22__7_/Q , mem_reg_22__6_/Q , mem_reg_22__5_/Q , mem_reg_22__4_/Q , mem_reg_22__3_/Q , mem_reg_22__2_/Q , mem_reg_22__1_/Q , mem_reg_22__0_/Q }} gpr22

quietly virtual signal -install /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i { (context /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i )&{mem_reg_23__31_/Q , mem_reg_23__30_/Q , mem_reg_23__29_/Q , mem_reg_23__28_/Q , mem_reg_23__27_/Q , mem_reg_23__26_/Q , mem_reg_23__25_/Q , mem_reg_23__24_/Q , mem_reg_23__23_/Q , mem_reg_23__22_/Q , mem_reg_23__21_/Q , mem_reg_23__20_/Q , mem_reg_23__19_/Q , mem_reg_23__18_/Q , mem_reg_23__17_/Q , mem_reg_23__16_/Q , mem_reg_23__15_/Q , mem_reg_23__14_/Q , mem_reg_23__13_/Q , mem_reg_23__12_/Q , mem_reg_23__11_/Q , mem_reg_23__10_/Q , mem_reg_23__9_/Q , mem_reg_23__8_/Q , mem_reg_23__7_/Q , mem_reg_23__6_/Q , mem_reg_23__5_/Q , mem_reg_23__4_/Q , mem_reg_23__3_/Q , mem_reg_23__2_/Q , mem_reg_23__1_/Q , mem_reg_23__0_/Q }} gpr23

quietly virtual signal -install /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i { (context /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i )&{mem_reg_24__31_/Q , mem_reg_24__30_/Q , mem_reg_24__29_/Q , mem_reg_24__28_/Q , mem_reg_24__27_/Q , mem_reg_24__26_/Q , mem_reg_24__25_/Q , mem_reg_24__24_/Q , mem_reg_24__23_/Q , mem_reg_24__22_/Q , mem_reg_24__21_/Q , mem_reg_24__20_/Q , mem_reg_24__19_/Q , mem_reg_24__18_/Q , mem_reg_24__17_/Q , mem_reg_24__16_/Q , mem_reg_24__15_/Q , mem_reg_24__14_/Q , mem_reg_24__13_/Q , mem_reg_24__12_/Q , mem_reg_24__11_/Q , mem_reg_24__10_/Q , mem_reg_24__9_/Q , mem_reg_24__8_/Q , mem_reg_24__7_/Q , mem_reg_24__6_/Q , mem_reg_24__5_/Q , mem_reg_24__4_/Q , mem_reg_24__3_/Q , mem_reg_24__2_/Q , mem_reg_24__1_/Q , mem_reg_24__0_/Q }} gpr24

quietly virtual signal -install /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i { (context /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i )&{mem_reg_25__31_/Q , mem_reg_25__30_/Q , mem_reg_25__29_/Q , mem_reg_25__28_/Q , mem_reg_25__27_/Q , mem_reg_25__26_/Q , mem_reg_25__25_/Q , mem_reg_25__24_/Q , mem_reg_25__23_/Q , mem_reg_25__22_/Q , mem_reg_25__21_/Q , mem_reg_25__20_/Q , mem_reg_25__19_/Q , mem_reg_25__18_/Q , mem_reg_25__17_/Q , mem_reg_25__16_/Q , mem_reg_25__15_/Q , mem_reg_25__14_/Q , mem_reg_25__13_/Q , mem_reg_25__12_/Q , mem_reg_25__11_/Q , mem_reg_25__10_/Q , mem_reg_25__9_/Q , mem_reg_25__8_/Q , mem_reg_25__7_/Q , mem_reg_25__6_/Q , mem_reg_25__5_/Q , mem_reg_25__4_/Q , mem_reg_25__3_/Q , mem_reg_25__2_/Q , mem_reg_25__1_/Q , mem_reg_25__0_/Q }} gpr25

quietly virtual signal -install /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i { (context /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i )&{mem_reg_26__31_/Q , mem_reg_26__30_/Q , mem_reg_26__29_/Q , mem_reg_26__28_/Q , mem_reg_26__27_/Q , mem_reg_26__26_/Q , mem_reg_26__25_/Q , mem_reg_26__24_/Q , mem_reg_26__23_/Q , mem_reg_26__22_/Q , mem_reg_26__21_/Q , mem_reg_26__20_/Q , mem_reg_26__19_/Q , mem_reg_26__18_/Q , mem_reg_26__17_/Q , mem_reg_26__16_/Q , mem_reg_26__15_/Q , mem_reg_26__14_/Q , mem_reg_26__13_/Q , mem_reg_26__12_/Q , mem_reg_26__11_/Q , mem_reg_26__10_/Q , mem_reg_26__9_/Q , mem_reg_26__8_/Q , mem_reg_26__7_/Q , mem_reg_26__6_/Q , mem_reg_26__5_/Q , mem_reg_26__4_/Q , mem_reg_26__3_/Q , mem_reg_26__2_/Q , mem_reg_26__1_/Q , mem_reg_26__0_/Q }} gpr26

quietly virtual signal -install /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i { (context /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i )&{mem_reg_27__31_/Q , mem_reg_27__30_/Q , mem_reg_27__29_/Q , mem_reg_27__28_/Q , mem_reg_27__27_/Q , mem_reg_27__26_/Q , mem_reg_27__25_/Q , mem_reg_27__24_/Q , mem_reg_27__23_/Q , mem_reg_27__22_/Q , mem_reg_27__21_/Q , mem_reg_27__20_/Q , mem_reg_27__19_/Q , mem_reg_27__18_/Q , mem_reg_27__17_/Q , mem_reg_27__16_/Q , mem_reg_27__15_/Q , mem_reg_27__14_/Q , mem_reg_27__13_/Q , mem_reg_27__12_/Q , mem_reg_27__11_/Q , mem_reg_27__10_/Q , mem_reg_27__9_/Q , mem_reg_27__8_/Q , mem_reg_27__7_/Q , mem_reg_27__6_/Q , mem_reg_27__5_/Q , mem_reg_27__4_/Q , mem_reg_27__3_/Q , mem_reg_27__2_/Q , mem_reg_27__1_/Q , mem_reg_27__0_/Q }} gpr27

quietly virtual signal -install /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i { (context /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i )&{mem_reg_28__31_/Q , mem_reg_28__30_/Q , mem_reg_28__29_/Q , mem_reg_28__28_/Q , mem_reg_28__27_/Q , mem_reg_28__26_/Q , mem_reg_28__25_/Q , mem_reg_28__24_/Q , mem_reg_28__23_/Q , mem_reg_28__22_/Q , mem_reg_28__21_/Q , mem_reg_28__20_/Q , mem_reg_28__19_/Q , mem_reg_28__18_/Q , mem_reg_28__17_/Q , mem_reg_28__16_/Q , mem_reg_28__15_/Q , mem_reg_28__14_/Q , mem_reg_28__13_/Q , mem_reg_28__12_/Q , mem_reg_28__11_/Q , mem_reg_28__10_/Q , mem_reg_28__9_/Q , mem_reg_28__8_/Q , mem_reg_28__7_/Q , mem_reg_28__6_/Q , mem_reg_28__5_/Q , mem_reg_28__4_/Q , mem_reg_28__3_/Q , mem_reg_28__2_/Q , mem_reg_28__1_/Q , mem_reg_28__0_/Q }} gpr28

quietly virtual signal -install /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i { (context /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i )&{mem_reg_29__31_/Q , mem_reg_29__30_/Q , mem_reg_29__29_/Q , mem_reg_29__28_/Q , mem_reg_29__27_/Q , mem_reg_29__26_/Q , mem_reg_29__25_/Q , mem_reg_29__24_/Q , mem_reg_29__23_/Q , mem_reg_29__22_/Q , mem_reg_29__21_/Q , mem_reg_29__20_/Q , mem_reg_29__19_/Q , mem_reg_29__18_/Q , mem_reg_29__17_/Q , mem_reg_29__16_/Q , mem_reg_29__15_/Q , mem_reg_29__14_/Q , mem_reg_29__13_/Q , mem_reg_29__12_/Q , mem_reg_29__11_/Q , mem_reg_29__10_/Q , mem_reg_29__9_/Q , mem_reg_29__8_/Q , mem_reg_29__7_/Q , mem_reg_29__6_/Q , mem_reg_29__5_/Q , mem_reg_29__4_/Q , mem_reg_29__3_/Q , mem_reg_29__2_/Q , mem_reg_29__1_/Q , mem_reg_29__0_/Q }} gpr29

quietly virtual signal -install /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i { (context /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i )&{mem_reg_30__31_/Q , mem_reg_30__30_/Q , mem_reg_30__29_/Q , mem_reg_30__28_/Q , mem_reg_30__27_/Q , mem_reg_30__26_/Q , mem_reg_30__25_/Q , mem_reg_30__24_/Q , mem_reg_30__23_/Q , mem_reg_30__22_/Q , mem_reg_30__21_/Q , mem_reg_30__20_/Q , mem_reg_30__19_/Q , mem_reg_30__18_/Q , mem_reg_30__17_/Q , mem_reg_30__16_/Q , mem_reg_30__15_/Q , mem_reg_30__14_/Q , mem_reg_30__13_/Q , mem_reg_30__12_/Q , mem_reg_30__11_/Q , mem_reg_30__10_/Q , mem_reg_30__9_/Q , mem_reg_30__8_/Q , mem_reg_30__7_/Q , mem_reg_30__6_/Q , mem_reg_30__5_/Q , mem_reg_30__4_/Q , mem_reg_30__3_/Q , mem_reg_30__2_/Q , mem_reg_30__1_/Q , mem_reg_30__0_/Q }} gpr30

quietly virtual signal -install /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i { (context /tb_top/riscv_wrapper_i/top_module_i/UUT/id_stage_i/registers_i/riscv_register_file_i )&{mem_reg_31__31_/Q , mem_reg_31__30_/Q , mem_reg_31__29_/Q , mem_reg_31__28_/Q , mem_reg_31__27_/Q , mem_reg_31__26_/Q , mem_reg_31__25_/Q , mem_reg_31__24_/Q , mem_reg_31__23_/Q , mem_reg_31__22_/Q , mem_reg_31__21_/Q , mem_reg_31__20_/Q , mem_reg_31__19_/Q , mem_reg_31__18_/Q , mem_reg_31__17_/Q , mem_reg_31__16_/Q , mem_reg_31__15_/Q , mem_reg_31__14_/Q , mem_reg_31__13_/Q , mem_reg_31__12_/Q , mem_reg_31__11_/Q , mem_reg_31__10_/Q , mem_reg_31__9_/Q , mem_reg_31__8_/Q , mem_reg_31__7_/Q , mem_reg_31__6_/Q , mem_reg_31__5_/Q , mem_reg_31__4_/Q , mem_reg_31__3_/Q , mem_reg_31__2_/Q , mem_reg_31__1_/Q , mem_reg_31__0_/Q }} gpr31


  add wave -noupdate -group RF $rvcores/id_stage_i/registers_i/riscv_register_file_i/gpr*
#  add wave -group "RF"                                       $rvcores/id_stage_i/registers_i/riscv_register_file_i/mem
#  add wave -group "RF_FP"                                    $rvcores/id_stage_i/registers_i/sriscv_register_file_i/mem_fp
  add wave -group "Decoder"                                  $rvcores/id_stage_i/decoder_i/*
  add wave -group "Controller"                               $rvcores/id_stage_i/controller_i/*
  add wave -group "Int Ctrl"                                 $rvcores/id_stage_i/int_controller_i/*
  add wave -group "Hwloop Regs"                              $rvcores/id_stage_i/hwloop_regs_i/*
  add wave -group "EX Stage" -group "ALU"                    $rvcores/ex_stage_i/alu_i/*
  add wave -group "EX Stage" -group "ALU_DIV"                $rvcores/ex_stage_i/alu_i/int_div_div_i/*
  add wave -group "EX Stage" -group "MUL"                    $rvcores/ex_stage_i/mult_i/*
  if {$fpuprivate ne ""} {
    add wave -group "EX Stage" -group "APU_DISP"             $rvcores/ex_stage_i/genblk1/apu_disp_i/*
    add wave -group "EX Stage" -group "FPU"                  $rvcores/ex_stage_i/genblk1/genblk1/fpu_i/*
  }
  add wave -group "EX Stage"                                 $rvcores/ex_stage_i/*
  add wave -group "LSU"                                      $rvcores/load_store_unit_i/*
  add wave -group "CSR"                                      $rvcores/cs_registers_i/*
}

configure wave -namecolwidth  250
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -timelineunits ns
