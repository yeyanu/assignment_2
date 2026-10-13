# ==============================================================================
# LINTING (VCS):
# ==============================================================================

# Q1: 4-Bit Barrel Shifter
cd /home/synopsis/ANISH_DEY/ASSIGNMENT_2/Q1_barrel_shifter
vcs -sverilog -lint=all barrel_shifter_4bit.v tb_barrel_shifter.v -l lint.log

# Q2: 4-Input Priority Arbiter
cd /home/synopsis/ANISH_DEY/ASSIGNMENT_2/Q2_priority_arbiter
vcs -sverilog -lint=all priority_arbiter_4.v tb_priority_arbiter_4.v -l lint.log

# Q3: Glitch-Free Clock Gater
cd /home/synopsis/ANISH_DEY/ASSIGNMENT_2/Q3_clock_gater
vcs -sverilog -lint=all clock_gater.v tb_clock_gater.v -l lint.log

# Q4: Dual 8-Bit Registers (Swap & Freeze)
cd /home/synopsis/ANISH_DEY/ASSIGNMENT_2/Q4_dual_reg_swap
vcs -sverilog -lint=all dual_reg_swap.v tb_dual_reg_swap.v -l lint.log


# ==============================================================================
# SIMULATION (VCS):
# ==============================================================================

# Q1: 4-Bit Barrel Shifter
cd /home/synopsis/ANISH_DEY/ASSIGNMENT_2/Q1_barrel_shifter
vcs -full64 -sverilog barrel_shifter_4bit.v tb_barrel_shifter.v -debug_access+all -l vcs_compile.log -o simv && ./simv -l vcs_simulate.log

# Q2: 4-Input Priority Arbiter
cd /home/synopsis/ANISH_DEY/ASSIGNMENT_2/Q2_priority_arbiter
vcs -full64 -sverilog priority_arbiter_4.v tb_priority_arbiter_4.v -debug_access+all -l vcs_compile.log -o simv && ./simv -l vcs_simulate.log

# Q3: Glitch-Free Clock Gater
cd /home/synopsis/ANISH_DEY/ASSIGNMENT_2/Q3_clock_gater
vcs -full64 -sverilog clock_gater.v tb_clock_gater.v -debug_access+all -l vcs_compile.log -o simv && ./simv -l vcs_simulate.log

# Q4: Dual 8-Bit Registers (Swap & Freeze)
cd /home/synopsis/ANISH_DEY/ASSIGNMENT_2/Q4_dual_reg_swap
vcs -full64 -sverilog dual_reg_swap.v tb_dual_reg_swap.v -debug_access+all -l vcs_compile.log -o simv && ./simv -l vcs_simulate.log


# ==============================================================================
# SYNTHESIS (DC SHELL):
# ==============================================================================

# Q1: 4-Bit Barrel Shifter
cd /home/synopsis/ANISH_DEY/ASSIGNMENT_2/Q1_barrel_shifter
dc_shell -f dc_synth_shifter.tcl > dc_synth.log 2>&1

# Q2: 4-Input Priority Arbiter
cd /home/synopsis/ANISH_DEY/ASSIGNMENT_2/Q2_priority_arbiter
dc_shell -f dc_synth_arbiter.tcl > dc_synth.log 2>&1

# Q3: Glitch-Free Clock Gater
cd /home/synopsis/ANISH_DEY/ASSIGNMENT_2/Q3_clock_gater
dc_shell -f dc_synth_clock_gater.tcl > dc_synth.log 2>&1

# Q4: Dual 8-Bit Registers (Swap & Freeze)
cd /home/synopsis/ANISH_DEY/ASSIGNMENT_2/Q4_dual_reg_swap
dc_shell -f dc_synth_dual_reg.tcl > dc_synth.log 2>&1