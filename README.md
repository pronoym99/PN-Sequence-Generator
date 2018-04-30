# PN-Sequence-Generator
This is a simulation based VHDL code developed in Xilinx to demonstrate a 4-bit PN sequence generator.

1. INTRODUCTION
A sequence of numbers {𝑏𝑘}=𝑏0𝑏1………𝑏𝑛−1 is a binary sequence if ∀ 𝑖=0,1,………𝑛−1, 𝑏𝑖∈{0,1}. However for {𝑏𝑘} to be a pseudo-random sequence it needs to satisfy some special properties which would be discussed later in great detail. Pseudo-random Noise(PN) is a randomized sequence of binary numbers. The name Pseudo (from Greek pseudēs ‘false’) arises from the fact that the sequence is predictable; however, the prediction becomes more and more difficult with increase in sequence length and complexity of feedback logic. It is also called as maximal length sequence generator concerning the fact that they produce every binary sequence except the locked state.PN Sequence generators have been in use since the beginning of World War 2 especially for the security and encryption level it provides and while in terms of contemporary technology it has got major applications in communication engineering.
2. CONCEPT BEHIND PN SEQUENCE GENERATOR
2.1 Linear Feedback Shift Registers (LFSRs)
Any register whose input bit is a linear function of its previous state is defined as a Linear Function Shift Register. Every shift register contains a series of D-flip flops which are capable of storing a single bit during the interval of a single clock pulse. So an 𝑛-bit shift register shall generate a PN sequence of length 2𝑛 −1. The 2𝑛th bit would be the same as the first bit of the sequence.
2.2 Locked State
The circuitry of any PN sequence register contains a linear feedback path which typically a combinational logic combining outputs of the last flip flop (and at times outputs of intermediate flip flops) which are feedback as input to the first flip flop. Hence, every combinational circuitry produces exactly one state which never occurs in the entire logic table of the PN sequence generator.(Hence 2𝑛−1 instead of 2𝑛 states). However, by mistake if the designer initializes an LFSR with the “lock state” for its circuit, the same state will repeat infinitely and will no more remain a PN sequence.
Page | 2
2.3 Logic Diagram
There are very large number of distinct sequences which can be obtained from a standard LFSR. For an 𝑛-bit shift register the number of distinct sequences that can be obtained is equal to the number of Boolean functions that can be made from 𝑛 distinct variables which is simply 22𝑛. Following is a general circuitry of the same. In general,the consecutive outputs of the last flip flop form the designated sequence.
Figure 2.1 A general Linear Feedback Shift Register consisting of a feedback path which has 𝑚 contributions from intermediate flip flops passed through a combinational circuit
3.4-BIT PN SEQUENCE GENERATOR
3.1 Circuit Diagram
Figure 3.1 A 4-bit PN sequence generator having an XNOR gate to form the feedback path
Page | 3
3.2 Logic table, Lock state and State equation
Following is the logic table of the previously illustrated 4-bit PN sequence generator. Let 𝑄1𝑛,𝑄2𝑛,𝑄3𝑛 and𝑄4𝑛 denote the present state of output of the successive flip flops. Let 𝐷1𝑛+1 denote the next state of input tothe first flip flop. Then the state equation is given by 𝐷1𝑛+1=𝑄1𝑛⊙𝑄4𝑛
Table 3.1 Logic Table for 4-bit PN Sequence Generator with the highlighted column being the desired sequence
CLK Pulse
𝑸𝟏
𝑸𝟐
𝑸𝟑𝑸𝟒
𝒀
1
0
0
0 0
0
2
1
0
0 0
0
3
0
1
0 0
0
4
1
0
1 0
0
5
0
1
0 1
0
6
0
0
1 0
1
7
1
0
0 1
0
8
1
1
0 0
1
9
0
1
1 0
0
10
1
0
1 1
0
11
1
1
0 1
1
12
1
1
1 0
1
13
0
1
1 1
0
14
0
0
1 1
1
15
0
0
0 1
1
It is clearly visible that the LOCK state for the above sequence generator is “1111”. Initialising the logic table with this state would simply create an infinite sequence of 1s.
3.3 VHDL Implementation
3.3.1 VHDL code
The VHDL code was designed and developed in Xilinx V9.2. It consists of a single top level module named as top_module.vhd which contains the core program code with two files placed inside it namely EX_nor.vhd and
Page | 4
logic.vhd which are the VHDL files corresponding to a standard XNOR gate and a positive edge triggered D-flip flop with synchronous active high reset mechanism respectively.
Figure 3.2 File Hierarchy
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity EX_nor is
Port ( a,b : in STD_LOGIC;
y : out STD_LOGIC);
end EX_nor;
architecture Behavioral of EX_nor is
begin
y <= a xnor b;
end Behavioral;
EX_nor.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity logic is
Port ( D,clk,reset : in STD_LOGIC;
Q : out STD_LOGIC);
end logic;
logic.vhd
Page | 5
architecture Behavioral of logic is
begin
process (clk,reset)
begin
if clk'event and clk='1' then
if reset='1' then Q <='0';
else Q <= D;
end if;
end if;
end process;
end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity top_module is
Port ( clk1,rst : in STD_LOGIC;
pn_out: out STD_LOGIC);
end top_module;
architecture hierarchy of top_module is
component logic port ( D,clk,reset : in STD_LOGIC; --Component representing D flip flop
Q : out STD_LOGIC);
end component;
component EX_nor port ( a,b : in STD_LOGIC; --Component representing XNOR gate
y : out STD_LOGIC);
end component;
Signal Q1,Q2,Q3,Q4: STD_LOGIC; --Intermediate outputs from individual flip flops
Signal x: STD_LOGIC;
begin
D1:logic port map(x,clk1,rst,Q1); --Cascading the required flip flops to form an LFSR
D2:logic port map(Q1,clk1,rst,Q2);
D3:logic port map(Q2,clk1,rst,Q3);
D4:logic port map(Q3,clk1,rst,Q4);
G1:EX_nor port map(Q1,Q4,x); --Giving feedback
pn_out <= Q4;
end hierarchy;
top_module.vhd
Page | 6
3.3.2 Simulation
The simulation was done on a standard test bench of size 1000 ns. Following are the simulation results. Its obvious from the simulation results that the sequence repeats after 15 (24−1) clock cycles.
Figure 3.3 Simulation results obtained from a 4- bit PN Sequence Generator with pn_out being the desired sequence
3.3.2 Synthesis
Standard synthesis tools were used in Xilinx and technology and RTL schematics of the various components and modules present were obtained. Following is a detailed illustration of each one of them.
Figure 3.4 Technology schematic of a 4-bit PN Sequence Generator
Figure 3.5.1.A RTL Schematic of top level module
Page | 7
Figure 3.5.2 RTL schematic of D flip flop
Figure 3.5.3.A and Figure 3.5.3.B (top to bottom) Level 1 and Level 2 RTL schematic of XNOR gate
Figure 3.5.1.B Second level RTL schematic of top level module
Page | 8
4.PROPERTIES OF PN SEQUENCE
As described in the introduction not every binary sequence {𝑏𝑘} is a random ( or pseudo-random) sequence untiland unless it satisfies some specific properties which are as follows.
For explaining the properties, we would be taking the output sequence of our own PN sequence generator i.e. 000010100110111.
(a) Balance: The no. of 0s and 1s should differ by atmost one. Now for a given sequence let 𝑁(0) and 𝑁(1) denote the no. of 0s and 1s in the sequence respectively. Then we can say
|𝑁(0)−𝑁(1)|≤1
For the sequence 000010100110111 we have 𝑁(0)=8 and 𝑁(1)=7 and therefore we can say
|𝑁(0)−𝑁(1)|=|8−7|≤1 clearly satisfies the given property and hence its a balanced sequence.
(b) Run length property: A run is defined as a sequence of single type of binary digits. Appearance of the other digit automatically starts a new run. Length of the run is defined as the no. of bits in that run and (here) would be denoted by 𝑙(𝑟𝑢𝑛𝑖𝑘) where 𝑟𝑢𝑛𝑖𝑘 indicates the 𝑖th run in that sequence when read from left to right madeup of the bit 𝑘 where 𝑘∈{0,1}.
Now consider the sequence 000010100110111 which has the following set of runs as illustrated below.
Figure 4.1 Sequence with runs' of zeroes shown in decreasing order of shade of blue in accordance with their lengths.
The run length property states that 12𝑚of the number of runs of each type (i.e. either 𝑟𝑢𝑛𝑖0 or 𝑟𝑢𝑛𝑖1) would be oflength 𝑚.
Written symbolically 12𝑚×Σ𝑟𝑢𝑛𝑖𝑘𝑎𝑙𝑙 𝑖=𝑁({𝑟𝑢𝑛𝑖𝑘 | 𝑙(𝑟𝑢𝑛𝑖𝑘)=𝑚 })
Page | 9
We have for our sequence Σ𝑁(𝑎𝑙𝑙 𝑖𝑟𝑢𝑛𝑖0)=4
Table 4.1 Run count in PN sequence
𝑟𝑢𝑛𝑖𝑘
Illustration
𝑙(𝑟𝑢𝑛𝑖𝑘)
𝑁(𝑟𝑢𝑛𝑖𝑘)
𝑟𝑢𝑛30
1
2=121×4
𝑟𝑢𝑛80
2
1=122×4
Clearly the sequence satisfies the run length property as well.
(c) Auto correlation: This is the most important property which gives a quantitative expression for a sequence 𝑐(𝑛) with its rotated sequence by ±𝜏 places to the right denoted by 𝑐(𝑛−𝜏). The auto correlation property states that the auto correlation function given by
𝑅(𝜏)=1𝑁Σ𝑁(𝐴)−𝑁(𝐷)𝑛
takes up only either of the two values i.e. 1 or −1𝑁 depending on a zero or non-zero shift for 𝑐(𝑛). Here 𝑁 denotes the total number of bits in the sequence and 𝑁(𝐴) and 𝑁(𝐷) denote the no. of agreements and disagreements amongst the standard and rotated sequence respectively. Now consider our sequence being rotated by 𝜏=3 places as illustrated below.
Figure 4.2 Normal PN sequence 𝑐(𝑛) along with its rotated sequence 𝑐(𝑛 − 3)
From the above figure we have 𝑁(𝐴)=7 and 𝑁(𝐷)=8 (if similar elements occur at a given bit it is counted as a single agreement and a disagreement otherwise). Accordingly, we have Σ𝑁(𝐴)−𝑁(𝐷)=−1𝑛 and
𝑅(𝜏)=−115 since 𝑁=15 terms are there in the sequence. Similarly if 𝜏=0, 𝑁(𝐴)=𝑁 and 𝑁(𝐷)=0 (since there would be no disagreements in a sequence when compared with itself) giving us 𝑅(𝜏)=−1𝑁. Clearly the auto correlation property is also satisfied by our output. So, qualitatively speaking we have for any 𝑐(𝑛)
Page | 10
𝑅(𝜏)={1𝜏=0−1𝑁𝜏≠0
Hence our sequence satisfies all the properties for a standardized PN sequence.
5.APPLICATIONS
Applications of a PN sequence are numerous. Some of the most common ones have been mentioned below.
(a) GPS satellite systems
(b) Cellular communications in Code Division Multiple Access i.e. CDMA
(c) LAN/MAN/WAN internet connections
(d) Bluetooth connectivity
(e) Railroads and transportation
Each of the aforementioned applications arise due to the following needs:
(i) Anti-jamming capabilities
(ii) Secure communications
(iii) Low Probability of Detection(LPD) and Low Probability of Intercept(LPI)
(iv) Low Probability of Position Fix(LPPF)
(v) Multiple access
