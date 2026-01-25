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
set PERIOD 4
set INPUT_DELAY 1
set OUTPUT_DELAY 1
set CLOCK_LATENCY 0.2
set MIN_IO_DELAY 1.0
set MAX_TRANSITION 0.5

## CLOCK BASICS
create_clock -name "clock" -period $PERIOD [get_ports clock]
set_clock_latency $CLOCK_LATENCY [get_clocks clock]
set_clock_uncertainty 0.1 [get_clocks clock]
set_clock_transition 0.5 [get_clocks clock]

## IN/OUT
set INPUTPORTS [remove_from_collection [all_inputs] [get_ports clock]]
set OUTPUTPORTS [all_outputs]

set_input_delay  -clock "clock" -max $INPUT_DELAY $INPUTPORTS
set_output_delay -clock "clock" -max $OUTPUT_DELAY $OUTPUTPORTS
set_input_delay  -clock "clock" -min $MIN_IO_DELAY $INPUTPORTS
set_output_delay -clock "clock" -min $MIN_IO_DELAY $OUTPUTPORTS

set_load 3.3 [all_outputs]

set_driving_cell -lib_cell NBUFFX4_HVT [all_inputs]

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
