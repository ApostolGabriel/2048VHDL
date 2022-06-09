----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.05.2022 14:34:41
-- Design Name: 
-- Module Name: muta_dreapta - Behavioral
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

entity muta_dreapta is
Port 
(
signal muta:in STD_LOGIC;
signal mutat:out std_logic
);
end muta_dreapta;

architecture Behavioral of muta_dreapta is

type matr is array(15 downto 0) of STD_LOGIC_VECTOR(11 downto 0);
signal game:matr:=(0 => X"004",
                   1 => X"000",
                   2 => X"004",
                   3 => X"008",
                   4 => X"000",
                   5 => X"002",
                   6 => X"000",
                   7 => X"002",
                   8 => X"004",
                   9 => X"004",
                   10 => X"000",
                   11 => X"008",
                   12 => X"002",
                   13 => X"000",
                   14 => X"000",
                   15 => X"002");

begin


process(muta,game)
variable i:integer;
variable index:integer;
variable index_not_zero:integer:=0;
begin
if muta = '1' then
    i:=0;
    for i in 0 to 3 loop
        index := 4*i;
        if game(index+3) = X"000" then
            if game(index+2) /= X"000" then
                game(index+3) <= game(index+2);
                game(index+2) <= game(index+1);
                game(index+1) <= game(index);
                game(index) <= X"000";
            end if;
        end if;
        if game(index+2) = X"000" then   
            if game(index+1) /= X"000" then
                game(index+2) <= game(index+1);
                game(index+1) <= game(index);
                game(index) <= X"000";
            end if;
        end if; 
        if game(index+1) = X"000" then   
            if game(index) /= X"000" then
                game(index+1) <= game(index);
                game(index) <= X"000";
            end if;
        end if;
    end loop;       
    mutat <= '1';
end if;
end process;



end Behavioral;
