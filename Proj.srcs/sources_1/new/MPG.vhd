----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.04.2022 15:02:06
-- Design Name: 
-- Module Name: MPG - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MPG is
Port 
(
signal btn:in STD_LOGIC;
signal clk:in STD_LOGIC;
signal rez:out STD_LOGIC 
);
end MPG;

architecture Behavioral of MPG is

signal counter:STD_LOGIC_VECTOR(15 downto 0);

signal Q1:STD_LOGIC;
signal Q2:STD_LOGIC;
signal Q3:STD_LOGIC;

begin

process(clk)
begin
if rising_edge(clk) then
    if counter = x"FFFF" then
        Q1 <= btn;
    end if;
    Q2 <= Q1;
    Q3 <= Q2;
    counter <= counter+1;
end if;
end process;

rez <= not(Q3) and Q2;

end Behavioral;
