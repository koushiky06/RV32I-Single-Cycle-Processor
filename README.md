# RV32I Single-Cycle RISC-V Processor

A complete implementation of a 32-bit single-cycle RISC-V processor core supporting the base integer instruction set (RV32I). Designed and modeled using Verilog HDL within the AMD Vivado design suite.

## 🛠️ Architecture Modules Implemented
* **Arithmetic Logic Unit (ALU):** Executes all arithmetic, logical, and shift operations.
* **Control Unit & ALU Control:** Decodes opcodes and functional fields to coordinate data path control signals.
* **Register File:** Implements 32 general-purpose 32-bit registers with synchronous write and asynchronous read.
* **Immediate Generator:** Extracts and sign-extends variant immediate formats (I, S, B, U, J) from instructions.
* **Instruction & Data Memory:** Emulates unified/separate address spaces for instruction fetching and load/store operations.

## 🔬 Simulation and Verification
The design has been verified using behavioral simulation via the Vivado Simulator. 
* **`test_bench_TB.v`:** Contains the comprehensive stimulus suite used to verify correct pipeline/datapath flow.
* **`tb_single_cycle_behav.wcfg`:** Saved Vivado waveform configuration file mapping out core signals (`PC_Top`, `RD_Instr`, `ALUResult`, and the full Internal Register File state).
