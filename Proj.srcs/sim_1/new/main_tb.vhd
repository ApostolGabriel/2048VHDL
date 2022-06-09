----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.05.2022 11:54:17
-- Design Name: 
-- Module Name: main_tb - Behavioral
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
use IEEE.std_logic_arith.ALL;
use IEEE.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main_tb is
--  Port ( );
end main_tb;

architecture Behavioral of main_tb is

signal clk:std_logic;
signal sw:std_logic;
signal btn:std_logic_vector(4 downto 0);
signal castigat:std_logic;

constant CLK_PERIOD:time:=10ns;

begin

generare_clk: process
            begin
            clk<='0';
            wait for (CLK_PERIOD/2);
            clk<='1';
            wait for (CLK_PERIOD/2);
            end process;

DUT:entity WORK.main port map
(
clk=>clk,
sw=>sw,
btn=>btn,
castigat=>castigat
);

simulare : process
            begin
            sw<='0';
            btn<="00000";
            wait for CLK_PERIOD;
            wait for CLK_PERIOD;
            sw <='1';
            wait for 3*CLK_PERIOD;
            btn(4)<='1';
            wait for CLK_PERIOD;
            btn(4)<='0';
            wait for 8*CLK_PERIOD;
            btn(2)<='1';
            wait for CLK_PERIOD;
            btn(2)<='0';
            wait for 8*CLK_PERIOD;
            btn(3)<='1';
            wait for CLK_PERIOD;
            btn(3) <= '0';
            wait for 8*CLK_PERIOD;
            btn(4) <= '1';
            wait for CLK_PERIOD;
            btn(4) <= '0';
            wait for 8*CLK_PERIOD;
            
            end process;

end Behavioral;
