----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.04.2022 14:01:21
-- Design Name: 
-- Module Name: nexys4 - Behavioral
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

entity nexys4 is
Port 
(
signal clk:in STD_LOGIC;
signal sw:in STD_LOGIC_VECTOR(15 downto 0);
signal btn:in STD_LOGIC_VECTOR(4 downto 0);
signal RX:in STD_LOGIC;
signal led:out STD_LOGIC_VECTOR(15 downto 0);
signal cat:out STD_LOGIC_VECTOR(7 downto 0);
signal an:out STD_LOGIC_VECTOR(7 downto 0);
signal TX:out STD_LOGIC
);
end nexys4;

architecture Behavioral of nexys4 is


signal btn_centru:STD_LOGIC;
signal btn_sus:STD_LOGIC;
signal btn_jos:STD_LOGIC;
signal btn_stanga:STD_LOGIC;
signal btn_dreapta:STD_LOGIC;

type matr is array(15 downto 0) of STD_LOGIC_VECTOR(11 downto 0);
signal game:matr:=(0 => X"004",
                   1 => X"000",
                   2 => X"004",
                   3 => X"008",
                   4 => X"008",
                   5 => X"002",
                   6 => X"000",
                   7 => X"002",
                   8 => X"004",
                   9 => X"004",
                   10 => X"008",
                   11 => X"008",
                   12 => X"002",
                   13 => X"000",
                   14 => X"000",
                   15 => X"002");

begin

MPG1:entity WORK.MPG port map
(
btn=>btn(0),
clk=>clk,
rez=>btn_centru
);

MPG2:entity WORK.MPG port map
(
btn=>btn(1),
clk=>clk,
rez=>btn_sus
);

MPG3:entity WORK.MPG port map
(
btn=>btn(4),
clk=>clk,
rez=>btn_jos
);

MPG4:entity WORK.MPG port map
(
btn=>btn(2),
clk=>clk,
rez=>btn_stanga
);

MPG5:entity WORK.MPG port map
(
btn=>btn(3),
clk=>clk,
rez=>btn_dreapta
);


end Behavioral;
