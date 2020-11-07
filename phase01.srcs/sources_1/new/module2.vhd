library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.my_package.all;

entity module2 is
	generic(w: integer;
		   n: integer;
	   	   m: integer;
	   	   p: integer);
    Port (A11:in matrix(1 to n,1 to n);
		  X: in matrix(1 to p,1 to 1);
	  	  DA11: out matrix(1 to n ,1 to n):=(others =>(others=>to_signed(0,w)));
		  clk: in std_logic);
end module2;

architecture Behavioral of module2 is
begin
	process(clk)
		variable temp:signed(2*w-1 downto 0);
	begin
		if (rising_edge(clk)) then
			for i in 1 to n loop
				temp :=to_signed(L, w) * to_signed(R,w);
				temp := temp(w-1 downto 0)*X(i,1);
				temp := temp(w-1 downto 0)*X(i,1);
				DA11(i,i) <= temp(w-1 downto 0);
			end loop;
		end if;
end process;
end Behavioral;
