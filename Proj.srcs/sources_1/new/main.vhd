----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.05.2022 10:57:44
-- Design Name: 
-- Module Name: main - Behavioral
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

entity main is
Port
(
signal clk: in std_logic;
signal sw: in std_logic;
signal btn: in std_logic_vector(4 downto 0);
signal castigat: out std_logic
);
end main;

architecture Behavioral of main is

type stari is (idle, start, verifica_locuri, generare, asteapta_buton,
        muta_jos_zerouri, muta_jos1, muta_jos2, muta_jos3,
        muta_sus_zerouri, muta_sus1, muta_sus2, muta_sus3,
        muta_stanga_zerouri, muta_stanga1, muta_stanga2, muta_stanga3, 
        muta_dreapta_zerouri, muta_dreapta1, muta_dreapta2, muta_dreapta3, 
verificare, stop);
signal stare_curenta:stari:=idle;
signal stare_urmatoare:stari:=idle;

type matr is array(15 downto 0) of STD_LOGIC_VECTOR(11 downto 0);
signal game:matr:=(0 => X"000",
                   1 => X"000",
                   2 => X"000",
                   3 => X"000",
                   4 => X"000",
                   5 => X"000",
                   6 => X"000",
                   7 => X"000",
                   8 => X"000",
                   9 => X"000",
                   10 => X"000",
                   11 => X"000",
                   12 => X"000",
                   13 => X"000",
                   14 => X"000",
                   15 => X"000");

signal castigat_temp:std_logic:='0';
signal rstgen:std_logic:='0';
signal rand:std_logic_vector(3 downto 0);
signal rand_temp:std_logic_vector(3 downto 0):="0000";
signal wait_gen:std_logic:='0';
signal lost:std_logic:='0';
signal liber:std_logic_vector(15 downto 0):=(others=>'1');

begin

process(clk, stare_urmatoare)
begin
if btn(0) = '1' then
stare_curenta <= idle;
end if;
if rising_edge(clk) then
    stare_curenta <= stare_urmatoare;
end if;
end process;

process(clk,stare_curenta)
begin
case stare_curenta is
when idle => 
        if sw = '1' then
            stare_urmatoare <= start;
        end if;
when start => stare_urmatoare <= verifica_locuri;
when verifica_locuri => stare_urmatoare <= generare;
when generare => 
        if lost = '1' then
            stare_urmatoare <= stop;
        else
            if wait_gen = '0' then 
                stare_urmatoare <= asteapta_buton;
            else 
                stare_urmatoare <= generare;
            end if;
        end if;
when asteapta_buton => 
        if btn(1) = '1' then
            stare_urmatoare <= muta_sus_zerouri;
        elsif btn(2) = '1' then
            stare_urmatoare <= muta_stanga_zerouri;
        elsif btn(3) = '1' then
            stare_urmatoare <= muta_dreapta_zerouri;
        elsif btn(4) = '1' then
            stare_urmatoare <= muta_jos_zerouri;
        end if;        
when muta_sus_zerouri => stare_urmatoare <= muta_sus1;
when muta_sus1 => stare_urmatoare <= muta_sus2;
when muta_sus2 => stare_urmatoare <= muta_sus3;
when muta_sus3 => stare_urmatoare <= verificare;
when muta_stanga_zerouri => stare_urmatoare <= muta_stanga1;
when muta_stanga1 => stare_urmatoare <= muta_stanga2;
when muta_stanga2 => stare_urmatoare <= muta_stanga3;
when muta_stanga3 => stare_urmatoare <= verificare;
when muta_dreapta_zerouri => stare_urmatoare <= muta_dreapta1;
when muta_dreapta1 => stare_urmatoare <= muta_dreapta2;
when muta_dreapta2 => stare_urmatoare <= muta_dreapta3;
when muta_dreapta3 => stare_urmatoare <= verificare;
when muta_jos_zerouri => stare_urmatoare <= muta_jos1;
when muta_jos1 => stare_urmatoare <= muta_jos2;
when muta_jos2 => stare_urmatoare <= muta_jos3;
when muta_jos3 => stare_urmatoare <= verificare;
when verificare => 
        if castigat_temp = '1' then
            stare_urmatoare <= stop;
        else
            stare_urmatoare <= verifica_locuri;
        end if;
when others => stare_urmatoare <= idle;
end case;
end process;

process(stare_curenta, game, rand, liber)
variable index:integer;
begin
case stare_curenta is
when idle => 
            game <= (0 => X"002",
                       1 => X"000",
                       2 => X"002",
                       3 => X"000",
                       4 => X"000",
                       5 => X"004",
                       6 => X"000",
                       7 => X"004",
                       8 => X"000",
                       9 => X"008",
                       10 => X"002",
                       11 => X"002",
                       12 => X"000",
                       13 => X"000",
                       14 => X"002",
                       15 => X"002");
                --game <= (others=>(others=>'0'));
                castigat <= '0';
when verifica_locuri =>
        for I in 0 to 3 loop
            for J in 0 to 3 loop
                if game(4*I+J) = X"000" then
                    liber(4*I+J) <= '0';
                else
                    liber(4*I+J) <= '1';
                end if;
            end loop;
        end loop;
when generare => 
        if liber = X"FFFF" then
            lost <= '1';
        else
            if liber(CONV_INTEGER(UNSIGNED(rand))) = '1' then
                wait_gen <='1';
            else 
                game(CONV_INTEGER(UNSIGNED(rand))) <= X"002";
                wait_gen <= '0';
            end if;
        end if;
when muta_dreapta_zerouri =>
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
when muta_dreapta1 =>
        for i in 0 to 3 loop
            index := 4*i;
            if game(index+3)/=X"000" then
                if game(index+3) = game(index+2) then
                    game(index+3) <= game(index+3)(10 downto 0) & "0";
                    game(index+2) <= game(index+1);
                    game(index+1) <= game(index);
                    game(index) <= X"000";
                end if;
            end if;
        end loop;
when muta_dreapta2 =>
        for i in 0 to 3 loop
            index := 4*i;
            if game(index+2)/=X"000" then
                if game(index+2) = game(index+1) then
                    game(index+2) <= game(index+2)(10 downto 0) & "0";
                    game(index+1) <= game(index);
                    game(index) <= X"000";
                end if;
            end if;
        end loop;
when muta_dreapta3 =>
        for i in 0 to 3 loop
            index := 4*i;
            if game(index+1)/=X"000" then
                if game(index+1) = game(index) then
                    game(index+1) <= game(index+1)(10 downto 0) & "0";
                    game(index) <= X"000";
                end if;
            end if;
        end loop;
when muta_stanga_zerouri =>
for i in 0 to 3 loop
        index := 4*i;
            if game(index) = X"000" then
                if game(index+1) /= X"000" then
                    game(index) <= game(index+1);
                    game(index+1) <= game(index+2);
                    game(index+2) <= game(index+3);
                    game(index+3) <= X"000";
                end if;
            end if;
            if game(index+1) = X"000" then   
                if game(index+2) /= X"000" then
                    game(index+1) <= game(index+2);
                    game(index+2) <= game(index+3);
                    game(index+3) <= X"000";
                end if;
            end if; 
            if game(index+2) = X"000" then   
                if game(index+3) /= X"000" then
                    game(index+2) <= game(index+3);
                    game(index+3) <= X"000";
                end if;
            end if;
        end loop;
when muta_stanga1 =>
        for i in 0 to 3 loop
            index := 4*i;
            if game(index)/=X"000" then
                if game(index) = game(index+1) then
                    game(index) <= game(index)(10 downto 0) & "0";
                    game(index+1) <= game(index+2);
                    game(index+2) <= game(index+3);
                    game(index+3) <= X"000";
                end if;
            end if;
        end loop;
when muta_stanga2 =>
        for i in 0 to 3 loop
            index := 4*i;
            if game(index+1)/=X"000" then
                if game(index+1) = game(index+2) then
                    game(index+1) <= game(index+1)(10 downto 0) & "0";
                    game(index+2) <= game(index+3);
                    game(index+3) <= X"000";
                end if;
            end if;
        end loop;
when muta_stanga3 =>
        for i in 0 to 3 loop
            index := 4*i;
            if game(index+2)/=X"000" then
                if game(index+2) = game(index+3) then
                    game(index+2) <= game(index+2)(10 downto 0) & "0";
                    game(index+3) <= X"000";
                end if;
            end if;
        end loop;
when muta_jos_zerouri =>
        for i in 0 to 3 loop
            index := i;
            if game(index+4*3) = X"000" then
                if game(index+4*2) /= X"000" then
                    game(index+4*3) <= game(index+4*2);
                    game(index+4*2) <= game(index+4*1);
                    game(index+4*1) <= game(index);
                    game(index) <= X"000";
                end if;
            end if;
            if game(index+4*2) = X"000" then   
                if game(index+4*1) /= X"000" then
                    game(index+4*2) <= game(index+4*1);
                    game(index+4*1) <= game(index);
                    game(index) <= X"000";
                end if;
            end if; 
            if game(index+4*1) = X"000" then   
                if game(index) /= X"000" then
                    game(index+4*1) <= game(index);
                    game(index) <= X"000";
                end if;
            end if;
        end loop;
when muta_jos1 =>
        for i in 0 to 3 loop
            index := i;
            if game(index+4*3)/=X"000" then
                if game(index+4*3) = game(index+4*2) then
                    game(index+4*3) <= game(index+4*3)(10 downto 0) & "0";
                    game(index+4*2) <= game(index+4*1);
                    game(index+4*1) <= game(index);
                    game(index) <= X"000";
                end if;
            end if;
        end loop;
when muta_jos2 =>
        for i in 0 to 3 loop
            index := i;
            if game(index+4*2)/=X"000" then
                if game(index+4*2) = game(index+4*1) then
                    game(index+4*2) <= game(index+4*2)(10 downto 0) & "0";
                    game(index+4*1) <= game(index);
                    game(index) <= X"000";
                end if;
            end if;
        end loop;
when muta_jos3 =>
        for i in 0 to 3 loop
            index := i;
            if game(index+4*1)/=X"000" then
                if game(index+4*1) = game(index) then
                    game(index+4*1) <= game(index+4*1)(10 downto 0) & "0";
                    game(index) <= X"000";
                end if;
            end if;
        end loop;
when muta_sus_zerouri =>
        for i in 0 to 3 loop
            index := i;
            if game(index) = X"000" then
                if game(index+4*1) /= X"000" then
                    game(index) <= game(index+4*1);
                    game(index+4*1) <= game(index+4*2);
                    game(index+4*2) <= game(index+4*3);
                    game(index+4*3) <= X"000";
                end if;
            end if;
            if game(index+4*1) = X"000" then   
                if game(index+4*2) /= X"000" then
                    game(index+4*1) <= game(index+4*2);
                    game(index+4*2) <= game(index+4*3);
                    game(index+4*3) <= X"000";
                end if;
            end if; 
            if game(index+4*2) = X"000" then   
                if game(index+4*3) /= X"000" then
                    game(index+4*2) <= game(index+4*3);
                    game(index+4*3) <= X"000";
                end if;
            end if;
        end loop;
when muta_sus1 =>
        for i in 0 to 3 loop
            index := i;
            if game(index)/=X"000" then
                if game(index) = game(index+4*1) then
                    game(index) <= game(index)(10 downto 0) & "0";
                    game(index+4*1) <= game(index+4*2);
                    game(index+4*2) <= game(index+4*3);
                    game(index+4*3) <= X"000";
                end if;
            end if;
        end loop;
when muta_sus2 =>
        for i in 0 to 3 loop
            index := i;
            if game(index+4*1)/=X"000" then
                if game(index+4*1) = game(index+4*2) then
                    game(index+4*1) <= game(index+4*1)(10 downto 0) & "0";
                    game(index+4*2) <= game(index+4*3);
                    game(index+4*3) <= X"000";
                end if;
            end if;
        end loop;
when muta_sus3 =>
        for i in 0 to 3 loop
            index := i;
            if game(index+4*2)/=X"000" then
                if game(index+4*2) = game(index+4*3) then
                    game(index+4*2) <= game(index+4*2)(10 downto 0) & "0";
                    game(index+4*3) <= X"000";
                end if;
            end if;
        end loop;
when verificare =>
        for i in 0 to 3 loop
            for j in 0 to 3 loop
                if game(4*i+j) = X"800" then
                    castigat <= '1';
                end if;
            end loop;
        end loop;
when others=>
end case;
end process;



generator:entity WORK.PRG port map
(
clk=>clk,
rst=>rstgen,
rand=>rand
);

end Behavioral;
