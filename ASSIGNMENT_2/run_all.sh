#!/bin/bash
# ==============================================================================
# Complete Synopsys Automation Script: Linting, VCS Simulation, and DC Synthesis
# Location: /home/synopsis/ANISH_DEY/ASSIGNMENT_2/run_all.sh
# ==============================================================================

set -e # Exit immediately if a command exits with a non-zero status

BASE_DIR="/home/synopsis/ANISH_DEY/ASSIGNMENT_2"

echo "=================================================================="
echo " STAGE 0: SYNOPSYS VCS STATIC LINTING"
echo "=================================================================="

echo "[-] Linting Q1: 4-Bit Barrel Shifter..."
cd "$BASE_DIR/Q1_barrel_shifter"
vcs -sverilog -lint=all barrel_shifter_4bit.v tb_barrel_shifter.v -l lint.log
echo "[✓] Q1 Linting completed (See lint.log)."

echo "[-] Linting Q2: 4-Input Priority Arbiter..."
cd "$BASE_DIR/Q2_priority_arbiter"
vcs -sverilog -lint=all priority_arbiter_4.v tb_priority_arbiter_4.v -l lint.log
echo "[✓] Q2 Linting completed (See lint.log)."

echo "[-] Linting Q3: Glitch-Free Clock Gater..."
cd "$BASE_DIR/Q3_clock_gater"
vcs -sverilog -lint=all clock_gater.v tb_clock_gater.v -l lint.log
echo "[✓] Q3 Linting completed (See lint.log)."

echo "[-] Linting Q4: Dual Registers..."
cd "$BASE_DIR/Q4_dual_reg_swap"
vcs -sverilog -lint=all dual_reg_swap.v tb_dual_reg_swap.v -l lint.log
echo "[✓] Q4 Linting completed (See lint.log)."
echo ""

echo "=================================================================="
echo " STAGE 1: SYNOPSYS VCS BEHAVIORAL SIMULATION & VERIFICATION"
echo "=================================================================="

echo "[-] Running VCS Simulation for Q1: 4-Bit Barrel Shifter..."
cd "$BASE_DIR/Q1_barrel_shifter"
vcs -full64 -sverilog barrel_shifter_4bit.v tb_barrel_shifter.v -debug_access+all -l vcs_compile.log -o simv_q1
./simv_q1 -l vcs_simulate.log
echo "[✓] Q1 Simulation completed successfully."

echo "[-] Running VCS Simulation for Q2: 4-Input Priority Arbiter..."
cd "$BASE_DIR/Q2_priority_arbiter"
vcs -full64 -sverilog priority_arbiter_4.v tb_priority_arbiter_4.v -debug_access+all -l vcs_compile.log -o simv_q2
./simv_q2 -l vcs_simulate.log
echo "[✓] Q2 Simulation completed successfully."

echo "[-] Running VCS Simulation for Q3: Glitch-Free Clock Gater..."
cd "$BASE_DIR/Q3_clock_gater"
vcs -full64 -sverilog clock_gater.v tb_clock_gater.v -debug_access+all -l vcs_compile.log -o simv_q3
./simv_q3 -l vcs_simulate.log
echo "[✓] Q3 Simulation completed successfully."

echo "[-] Running VCS Simulation for Q4: Dual Registers (Swap/Freeze)..."
cd "$BASE_DIR/Q4_dual_reg_swap"
vcs -full64 -sverilog dual_reg_swap.v tb_dual_reg_swap.v -debug_access+all -l vcs_compile.log -o simv_q4
./simv_q4 -l vcs_simulate.log
echo "[✓] Q4 Simulation completed successfully."
echo ""

echo "=================================================================="
echo " STAGE 2: SYNOPSYS DESIGN COMPILER (DC_SHELL) LOGIC SYNTHESIS"
echo "=================================================================="

echo "[-] Synthesizing Q1: 4-Bit Barrel Shifter with DC..."
cd "$BASE_DIR/Q1_barrel_shifter"
dc_shell -f dc_synth_shifter.tcl > dc_synth.log 2>&1
echo "[✓] Q1 Synthesis and reports generated (See dc_synth.log)."

echo "[-] Synthesizing Q2: 4-Input Priority Arbiter with DC..."
cd "$BASE_DIR/Q2_priority_arbiter"
dc_shell -f dc_synth_arbiter.tcl > dc_synth.log 2>&1
echo "[✓] Q2 Synthesis and reports generated (See dc_synth.log)."

echo "[-] Synthesizing Q3: Glitch-Free Clock Gater with DC..."
cd "$BASE_DIR/Q3_clock_gater"
dc_shell -f dc_synth_clock_gater.tcl > dc_synth.log 2>&1
echo "[✓] Q3 Synthesis and reports generated (See dc_synth.log)."

echo "[-] Synthesizing Q4: Dual Registers (Swap/Freeze) with DC..."
cd "$BASE_DIR/Q4_dual_reg_swap"
dc_shell -f dc_synth_dual_reg.tcl > dc_synth.log 2>&1
echo "[✓] Q4 Synthesis and reports generated (See dc_synth.log)."

echo "=================================================================="
echo " ALL STAGES COMPLETED SUCCESSFULLY"
echo "=================================================================="