library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_module is
    Port ( clk,rst : in  STD_LOGIC;
           pn_out : out  STD_LOGIC);
end top_module;

architecture hierarchy of top_module is

Signal Q1,Q2,Q3,Q4: STD_LOGIC:='0';                      --Intermediate outputs from individual flip flops
Signal x: STD_LOGIC:='0';

component logic port ( D,clk,reset : in STD_LOGIC;       --Component representing D flip flop
                                 Q : out STD_LOGIC);
end component;
component EX_nor port ( a,b : in STD_LOGIC;              --Component representing XNOR gate
                          y : out STD_LOGIC);
end component;

begin

D1:logic port map(x,clk,rst,Q1);                         --Cascading the required flip flops to form an LFSR
D2:logic port map(Q1,clk,rst,Q2);
D3:logic port map(Q2,clk,rst,Q3);
D4:logic port map(Q3,clk,rst,Q4);
G1:EX_nor port map(Q1,Q4,x);                             --Giving feedback
pn_out <= Q4;

end hierarchy;

