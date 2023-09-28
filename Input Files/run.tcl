#TCL Script to run basic Synthesis Flow:

set_db init_lib_search_path /home/install/FOUNDRY/digital/90nm/dig/lib/
set_db hdl_search_path /home/student/Documents/UniversalRegister
set_db library slow.lib

read_hdl uniReg.v
elaborate
read_sdc /home/student/Documents/uniReg/constraints.sdc

set_db syn_generic_effort medium
syn_generic
set_db syn_map_effort medium
syn_map
set_db syn_opt_effort medium
syn_opt

write_hdl > uniReg_netlist.v
write_sdc > uniReg_block.sdc

report_area > uniReg_area.rep
report_gates > uniReg_gates.rep
report_power > uniReg_power.rep

gui_show

