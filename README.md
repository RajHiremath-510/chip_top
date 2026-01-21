# CHIP_TOP – RTL to Gate-Level Synthesis

This repository demonstrates a complete **RTL to Gate-Level Synthesis flow**
using **Synopsys Design Compiler**.

The project is created mainly for **learning and interview preparation** and
shows how an industry-style synthesis script is written and executed.

---

##  Project Objective
Convert RTL (Verilog) into a **gate-level netlist** while meeting:
- Timing constraints
- Area optimization
- Power optimization

---

##  Tool Used
- **Synopsys Design Compiler**

---


---

##  Synthesis Flow
1. Environment setup
2. RTL analysis and elaboration
3. Library linking (HVT / LVT / RVT)
4. Timing constraint application (SDC)
5. High-effort synthesis using `compile_ultra`
6. Gate-level netlist generation
7. QoR reporting (Timing, Area, Power)

---

##  How to Run the Synthesis
```bash
cd chip_top/synth
csh
source /home/tools/synopsys/cshrc_synopsys
dc_shell -output_log_file ./outputs/synthesis.log

Inside Design Compiler:
source scripts/run_synthesis.tcl

## Outputs Generated
Gate-level Verilog netlist

## Reports 
Timing report
Area report
Power report

## Intended Audience
- VLSI Freshers
- ASIC Synthesis Learners
- Interview preparation for RTL to Netlist flow

---

## Project Documentation
Detailed project documentation is available here:  
https://drive.google.com/file/d/1wkCxk2GyQNiErFEtTfVhNjUc_QZ-NkMK/view?usp=sharing

---

## Author & Contact

Rajshekhar S Hiremath  
ASIC / VLSI Synthesis & Physical Design Enthusiast

Portfolio: https://rajhiremath-portfolio.lovable.app/  
LinkedIn: https://www.linkedin.com/in/raj-hiremath-88a707298  
Email: raj.hiremath2004@gmail.com
