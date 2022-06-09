----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.05.2022 15:29:27
-- Design Name: 
-- Module Name: PRG - Behavioral
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
use IEEE.std_logic_unsigned.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PRG is
Port 
(
signal clk:in std_logic;
signal rst:in std_logic;
signal rand:out std_logic_vector(3 downto 0) 
);
end PRG;

architecture Behavioral of PRG is
signal up:std_logic_vector(3 downto 0):="0000";
signal up2:std_logic_vector(3 downto 0):="0000";
signal down:std_logic_vector(3 downto 0):="1111";
signal temp:std_logic_vector(3 downto 0);
signal counter:std_logic_vector(1 downto 0):="00";
signal clk_divizat:std_logic:='0';
begin

process(clk, counter, clk_divizat)
begin
if rising_edge(clk) then
    if counter = "01" then
        counter <= "00";
        clk_divizat <= not(clk_divizat);
    end if;
    counter <= counter+1;
end if;
end process;

process(rst, clk_divizat)
begin
if rst = '1' then
    up<=temp;
    up2<=temp;
    down<=temp;
elsif rising_edge(clk_divizat) then
    up <= up+1;
    down <= down - 1;
    up2 <= up2 + 3;
end if;
end process;

temp <= (up xor down) xor up2;
rand <= temp;
end Behavioral;
