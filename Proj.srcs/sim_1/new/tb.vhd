----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.05.2022 15:10:53
-- Design Name: 
-- Module Name: tb - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.std_logic_arith.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is

signal clk:STD_LOGIC;
signal sw:STD_LOGIC_VECTOR(15 downto 0);
signal btn:STD_LOGIC_VECTOR(4 downto 0);
signal RX:STD_LOGIC;
signal led:STD_LOGIC_VECTOR(15 downto 0);
signal cat:STD_LOGIC_VECTOR(7 downto 0);
signal an:STD_LOGIC_VECTOR(7 downto 0);
signal TX:STD_LOGIC;

CONSTANT CLK_PERIOD:TIME:=10ns;

begin

generare_clk: process
                begin
                clk<='0';
                wait for (CLK_PERIOD/2);
                clk<='1';
                wait for (CLK_PERIOD/2);
                end process;

DUT:entity WORK.nexys4 port map
(
clk=>clk,
sw=>sw,
btn=>btn,
RX=>RX,
led=>led,
cat=>cat,
an=>an,
TX=>TX
);

simulare: process
            begin
            btn(3)<='0';
            wait for (CLK_PERIOD/2);
            btn(3)<='1';
            wait for (CLK_PERIOD/2);
            end process;

end Behavioral;
