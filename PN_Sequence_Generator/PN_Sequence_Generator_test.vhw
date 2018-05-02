--------------------------------------------------------------------------------
-- Copyright (c) 1995-2007 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 9.2i
--  \   \         Application : ISE
--  /   /         Filename : PN_Sequence_Generator_test.vhw
-- /___/   /\     Timestamp : Wed May 02 18:46:29 2018
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: PN_Sequence_Generator_test
--Device: Xilinx
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE STD.TEXTIO.ALL;

ENTITY PN_Sequence_Generator_test IS
END PN_Sequence_Generator_test;

ARCHITECTURE testbench_arch OF PN_Sequence_Generator_test IS
    FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";

    COMPONENT top_module
        PORT (
            clk : In std_logic;
            rst : In std_logic;
            pn_out : Out std_logic
        );
    END COMPONENT;

    SIGNAL clk : std_logic := '0';
    SIGNAL rst : std_logic := '0';
    SIGNAL pn_out : std_logic := '0';

    constant PERIOD : time := 40 ns;
    constant DUTY_CYCLE : real := 0.5;
    constant OFFSET : time := 100 ns;

    BEGIN
        UUT : top_module
        PORT MAP (
            clk => clk,
            rst => rst,
            pn_out => pn_out
        );

        PROCESS    -- clock process for clk
        BEGIN
            WAIT for OFFSET;
            CLOCK_LOOP : LOOP
                clk <= '0';
                WAIT FOR (PERIOD - (PERIOD * DUTY_CYCLE));
                clk <= '1';
                WAIT FOR (PERIOD * DUTY_CYCLE);
            END LOOP CLOCK_LOOP;
        END PROCESS;

        PROCESS
            BEGIN
                -- -------------  Current Time:  550ns
                WAIT FOR 550 ns;
                rst <= '1';
                -- -------------------------------------
                WAIT FOR 490 ns;

            END PROCESS;

    END testbench_arch;

