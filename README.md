# CHIP_TOP – RTL to Gate-Level Synthesis

This repository demonstrates a complete **RTL to Gate-Level Synthesis flow**
using **Synopsys Design Compiler**.

The project is created mainly for **learning and interview preparation** and
shows how an industry-style synthesis script is written and executed.

---

## 📌 Project Objective
Convert RTL (Verilog) into a **gate-level netlist** while meeting:
- Timing constraints
- Area optimization
- Power optimization

---

## 🛠 Tool Used
- **Synopsys Design Compiler**

---


---

## 🔄 Synthesis Flow
1. Environment setup
2. RTL analysis and elaboration
3. Library linking (HVT / LVT / RVT)
4. Timing constraint application (SDC)
5. High-effort synthesis using `compile_ultra`
6. Gate-level netlist generation
7. QoR reporting (Timing, Area, Power)

---

## ▶️ How to Run the Synthesis
```bash
cd chip_top/synth
csh
source /home/tools/synopsys/cshrc_synopsys
dc_shell -output_log_file ./outputs/synthesis.log

Inside Design Compiler:

source scripts/run_synthesis.tcl

📊 Outputs Generated

Gate-level Verilog netlist

Timing report

Area report

Power report

🎯 Intended Audience

VLSI Freshers

ASIC Synthesis learners

Interview preparation for RTL → Netlist flow
