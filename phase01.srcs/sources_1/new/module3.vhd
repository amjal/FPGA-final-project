library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;   
use work.my_package.all;

entity module3 is
	generic(w: integer;
		   n: integer;
	   	   m: integer;
	   	   p: integer);
    Port (DA11:in matrix(1 to n, 1 to n);
	  	  G: out matrix(1 to p, 1 to p);
		  clk: in std_logic);
end module3;

architecture Behavioral of module3 is
begin
	process(clk)
    	variable s1,s2:signed(w-1 downto 0):=to_signed(1,w);
		variable temp: signed (2*w-1 downto 0); 
        variable S:signed(w-1 downto 0);
		variable DA: matrix(1 to p, 1 to p);
    begin
		if rising_edge(clk) then
			DA := concatenator(DA11);
			s1 := to_signed(1,w);
			s2 := to_signed(1,w);
			for i in 1 to p loop
				temp:= s1 * DA(i,i);
				s1 := temp(w-1 downto 0);
				temp:= s2 * DA(i, p - i + 1);
				s2 := temp(w-1 downto 0);
			end loop;
			S:= s1 - s2;
			S:= shift_right(s,z);
			for i in 1 to p loop
				for j in 1 to p loop
					temp := to_signed(to_integer(S),w) * DA(j,i);
					temp := -1 * temp(w-1 downto 0);
					G(i,j) <= temp(w-1 downto 0);
				end loop;
			end loop;
		end if;
    end process;
end Behavioral;
