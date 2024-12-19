Project Description: AHB to APB Bridge Implementation

The project focuses on designing and implementing an AHB (Advanced High-performance Bus) to APB (Advanced Peripheral Bus) Bridge in a System-on-Chip (SoC) architecture. The purpose of this bridge is to enable efficient communication between high-speed, performance-critical components on the AHB and low-power peripherals on the APB. 

The design is implemented on an FPGA (Field-Programmable Gate Array), with data being sent to and from the FPGA via a Raspberry Pi using the SPI (Serial Peripheral Interface) communication protocol. This project involves transmitting serialized data, processing it on the FPGA, and returning processed results back to the Raspberry Pi.

Key Features and Design Highlights

1. Data Transmission via SPI:
   - The Raspberry Pi sends **100-bit wide data** to the FPGA using SPI. The data is serialized and transmitted bit by bit over the SPI interface to reduce pin usage and ensure efficient communication.

2. Data Decoding on FPGA:
   - The FPGA receives the serialized input through an SPI slave module and decodes it into parallel data.
   - The 100-bit input is divided into multiple signals that correspond to AHB-compatible control and data fields.

3. AHB-Compatible Signal Mapping:
   - The FPGA processes the decoded input and maps it into **AHB-compatible signals**, such as:
     - `HADDR`: Address of the transaction.
     - `HWDATA`: Data to be written in the transaction.
     - `HTRANS`: Transaction type (non-sequential, sequential, etc.).
     - `HWRITE`: Write enable signal.
     - `HREADYIN`: Ready signal from the master.
   - These signals follow the AHB protocol standard for data processing and transaction control.

4. APB Protocol Conversion:
   - The AHB-compatible signals are converted to **APB-compatible signals** using FSM-based control logic. This ensures seamless communication between the high-speed AHB domain and the low-power APB domain.

5. Processed Data Aggregation:
   - After processing, the FPGA aggregates the APB output signals, transaction statuses, and other relevant data into a **104-bit output register**.

6. Data Return to Raspberry Pi:
   - The 104-bit output is serialized within the FPGA and sent back to the Raspberry Pi, bit by bit, through the SPI interface.
   - The Raspberry Pi receives and decodes the output data for verification and analysis.


Modules in the Design

1. SPI Slave Module:
   - Handles SPI communication between the Raspberry Pi and the FPGA.
   - Captures serialized input data from the Raspberry Pi and sends it to the Mapper module.
   - Receives processed output data from the FPGA and sends it back to the Raspberry Pi.

2. Mapper1 Module:
   - Decodes the serialized 100-bit input received from the SPI slave module.
   - Maps the input bits to AHB-compatible signals (`HADDR`, `HWDATA`, `HTRANS`, etc.).
   - Prepares the input for AHB-based processing.

3. AHB to APB Bridge:
   - Implements protocol conversion between AHB and APB.
   - Converts AHB control signals into corresponding APB signals, such as `PADDR`, `PWRITE`, `PENABLE`, and `PSEL`.

4. Mapper2 Module:
   - Combines APB output signals and transaction metadata into a 104-bit register.
   - Sends the serialized output back to the SPI slave module.


System Workflow

1. Input Transmission:
   - The Raspberry Pi generates a 100-bit input signal and transmits it to the FPGA bit by bit using the SPI protocol.

2. Data Processing:
   - The FPGA receives and decodes the input.
   - The input is processed by the AHB to APB bridge logic to perform protocol conversion and transaction management.

3. Output Generation:
   - The FPGA prepares a 104-bit output, combining the results of the APB transactions and relevant status signals.

4. Output Transmission:
   - The FPGA serializes the 104-bit output and sends it back to the Raspberry Pi over the SPI interface.

5. Validation:
   - The Raspberry Pi decodes the output and validates the processed data to ensure the bridge functionality is accurate.



Applications of the AHB to APB Bridge

1. System-on-Chip (SoC) Designs:
   - Allows high-speed AHB components, such as CPUs and memory controllers, to interface with low-speed, low-power APB peripherals like UARTs, GPIOs, and timers.

2. Embedded Systems:
   - Supports data exchange between high-performance processors and energy-efficient devices in microcontrollers, development boards, and consumer electronics.

3. FPGA-Based Prototyping:
   - Serves as a prototype to test AHB and APB interfaces for SoC designs in FPGA environments.


Key Benefits

- Seamless Protocol Conversion: Ensures efficient communication between the AHB and APB domains.
- Low Power Consumption: Maintains energy efficiency by isolating high-speed AHB components from low-power APB peripherals.
- Scalability: Facilitates integration of additional peripherals without redesigning the entire system.
- High Reliability: Maintains data integrity and synchronization across clock domains.


This project demonstrates an efficient implementation of an AHB to APB Bridge on an FPGA, integrating protocol conversion, serialized communication, and modular design for seamless interaction between high-performance and low-power components. Let me know if you need any additional details or explanations!


The Output waveform for the AHB to APB Bridge is:


