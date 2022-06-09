----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.05.2022 14:45:07
-- Design Name: 
-- Module Name: muta_dreapta_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity muta_dreapta_tb is
--  Port ( );
end muta_dreapta_tb;

architecture Behavioral of muta_dreapta_tb is

CONSTANT CLK_PERIOD:TIME:=10ns; 
signal clk:std_logic;           
signal mutat:std_logic;
signal muta:std_logic:='0';

begin

generare_clk: process
            begin
            clk<='0';
            wait for (CLK_PERIOD/2);
            clk<='1';
            wait for (CLK_PERIOD/2);
            end process;

DUT:entity WORK.muta_dreapta port map
(
muta=>muta,
mutat=>mutat
);


simulare: process
        begin
        
        muta <= '1';
        wait for CLK_PERIOD;
        wait for CLK_PERIOD*19;
        end process;

end Behavioral;
