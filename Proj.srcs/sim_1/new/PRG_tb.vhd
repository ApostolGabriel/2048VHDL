----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.05.2022 14:08:38
-- Design Name: 
-- Module Name: PRG_tb - Behavioral
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

entity PRG_tb is
--  Port ( );
end PRG_tb;

architecture Behavioral of PRG_tb is

CONSTANT CLK_PERIOD:TIME:=10ns;
signal clk:std_logic;

signal rst:std_logic;
signal rand:std_logic_vector(3 downto 0); 

begin

generare_clk: process
                begin
                clk<='0';
                wait for (CLK_PERIOD/2);
                clk<='1';
                wait for (CLK_PERIOD/2);
                end process;
                
DUT:entity WORK.PRG port map
(
clk=>clk,
rst=>rst,
rand=>rand
);

end Behavioral;
