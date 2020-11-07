----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/19/2020 04:01:39 PM
-- Design Name: 
-- Module Name: module1 - Behavioral
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
use work.my_package.all;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity module1 is
	generic(w: integer := w;
		   n: integer := n;
	   	   m: integer := m;
	   	   p: integer := p);
    Port (A11:in matrix(1 to n, 1 to n);
		  X: in matrix(1 to p, 1 to 1);
	  	  F: out matrix(1 to p, 1 to 1);
	  	  clk: in std_logic);
end module1;

architecture Behavioral of module1 is
begin
	process (clk)
		variable AX: matrix(1 to p, 1 to 1);
		variable temp : signed(2*w-1 downto 0);
		variable A: matrix(1 to p, 1 to p);
	begin
		if rising_edge(clk) then
			A := concatenator (A11);
			AX := (others =>(others =>to_signed(0,w)));
			for i in 1 to p loop
				for j in 1 to p loop
					--report integer'image(to_integer(A(i,j))) & " " & integer'image(to_integer(X(j,1)));
					temp := A(i,j)*X(j,1);
					AX(i,1) := Ax(i,1) + temp(w-1 downto 0);
				end loop;
				F(i,1) <= AX(i,1) - B(i,1);
			end loop;
			F <= AX;
		end if;
	end process;
end Behavioral;
