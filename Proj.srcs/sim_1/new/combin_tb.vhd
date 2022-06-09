----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.05.2022 20:22:51
-- Design Name: 
-- Module Name: combin_tb - Behavioral
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

entity combin_tb is
--  Port ( );
end combin_tb;

architecture Behavioral of combin_tb is


CONSTANT CLK_PERIOD:TIME:=10ns; 
signal clk:std_logic;           
signal mutat:std_logic;
signal mutal:std_logic:='0';
begin

generare_clk: process
            begin
            clk<='0';
            wait for (CLK_PERIOD/2);
            clk<='1';
            wait for (CLK_PERIOD/2);
            end process;

DUT:entity WORK.combin port map
(
mutal=>mutal,
mutat=>mutat
);


simulare: process
        begin
        
        mutal <= '1';
        wait for CLK_PERIOD;
        wait for CLK_PERIOD*19;
        end process;

end Behavioral;
