----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.05.2022 20:16:10
-- Design Name: 
-- Module Name: combin - Behavioral
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
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity combin is
Port 
(
signal mutal:in STD_LOGIC;
signal mutat:out std_logic
);
end combin;

architecture Behavioral of combin is
type matr is array(3 downto 0) of STD_LOGIC_VECTOR(11 downto 0);
signal game:matr:=(0 => X"000",
                   1 => X"004",
                   2 => X"002",
                   3 => X"002");
                   

begin

process(mutal,game)
variable i:integer;

begin
if mutal = '1' then
    if game(3)/=X"000" then
        if game(3) = game(2) then
            game(3) <= game(3)(10 downto 0) & "0";
            game(2) <= game(1);
            game(1) <= game(0);
            game(0) <= X"000";
        end if;
   end if;

     
    report integer'image(conv_integer(unsigned(game(0)))) & " " &
            integer'image(conv_integer(unsigned(game(1)))) & " " &
            integer'image(conv_integer(unsigned(game(2)))) & " " &
            integer'image(conv_integer(unsigned(game(3)))) severity note;
       
            
    mutat <= '1';
end if;
end process;

end Behavioral;
