############################################################
# Project        : CHIP_TOP
# Tool           : Synopsys Design Compiler
# Flow           : RTL → Gate-Level Netlist
# Author         : Rajshekhar S Hiremath
# Purpose        : Learning + Interview Preparation
############################################################

#-----------------------------------------------------------
# Variables
#-----------------------------------------------------------
set TOP_DESIGN ChipTop
set RTL_DIR     ./inputs/rtl
set OUT_DIR     ./outputs
set RPT_DIR     $OUT_DIR/qor_reports

#-----------------------------------------------------------
# Create output directories if not present
#-----------------------------------------------------------
if {![file exists $OUT_DIR]} {
    file mkdir $OUT_DIR
}

if {![file exists $RPT_DIR]} {
    file mkdir $RPT_DIR
}

#-----------------------------------------------------------
# Search Path
#-----------------------------------------------------------
set search_path "$RTL_DIR"

#-----------------------------------------------------------
# Target & Link Libraries
#-----------------------------------------------------------
set target_library "
    saed32hvt_ss0p95v125c.db
    saed32lvt_ss0p95v125c.db
    saed32rvt_ss0p95v125c.db
    saed32sram_ss0p95v125c.db
    saed32sraml_ss0p95v125c_iop95v.db
"

set link_library "* $target_library"

#-----------------------------------------------------------
# Read RTL File List
#-----------------------------------------------------------
source $RTL_DIR/rtl_file_list.tcl

#-----------------------------------------------------------
# Analyze & Elaborate
#-----------------------------------------------------------
analyze -format verilog $top
elaborate $TOP_DESIGN

current_design $TOP_DESIGN
link

#-----------------------------------------------------------
# Apply Constraints
#-----------------------------------------------------------
source $RTL_DIR/my_chip.sdc

#-----------------------------------------------------------
# Compile (High Effort)
#-----------------------------------------------------------
compile_ultra -no_autoungroup

#-----------------------------------------------------------
# Write Gate-Level Netlist
#-----------------------------------------------------------
write_file -format verilog -hierarchy \
    -output $OUT_DIR/chip_top_netlist.v

#-----------------------------------------------------------
# Reports
#-----------------------------------------------------------
report_area   > $RPT_DIR/area_report.rpt
report_timing > $RPT_DIR/timing_report.rpt
report_power  > $RPT_DIR/power_report.rpt

#-----------------------------------------------------------
# Save Design
#-----------------------------------------------------------
write -format ddc -hierarchy -output $OUT_DIR/chip_top.ddc

puts "========================================"
puts " Synthesis completed successfully "
puts " Outputs available in ./outputs/"
puts "========================================"
