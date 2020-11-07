----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/23/2020 01:19:29 PM
-- Design Name: 
-- Module Name: module4 - Behavioral
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

entity module4 is
	generic(w: integer:=w;
			n: integer:=n;
			m: integer:=m;
			p: integer:=p);
    Port (clk: in std_logic;
	  	  A11: inout matrix(1 to n, 1 to n):= (others =>(others =>(others =>'Z')));
          X: inout matrix(1 to p, 1 to 1):=(others =>(others =>(others =>'Z')));
	  	  G_out: out matrix(1 to p, 1 to p);
		  X_select: inout std_logic := '0';
		  A11_select: inout std_logic := '0';
		  algorithm_iteration: out integer := 0;
		  finish: out std_logic);
end module4;

architecture Behavioral of module4 is
	component module1
		generic(w: integer;
				n: integer;
				m: integer;
				p: integer);
		port (A11: in matrix(1 to n, 1 to n);
		      X: in matrix(1 to p, 1 to 1);
			  F: out matrix(1 to p, 1 to 1);
			  clk: in std_logic);
	end component;
	signal F : matrix (1 to p, 1 to 1);

	component module2
		generic(w: integer;
				n: integer;
				m: integer;
				p: integer);
		port (A11: in matrix(1 to n, 1 to n);
			  X: in matrix(1 to p, 1 to 1);
			  DA11: out matrix(1 to n, 1 to n);
			  clk: in std_logic);
	end component;
	signal DA11: matrix(1 to n, 1 to n);

	component module3
		generic(w: integer;
				n: integer;
				m: integer;
				p: integer);
		Port (DA11: in matrix(1 to n, 1 to n);
			  G: out matrix(1 to p, 1 to p);
			  clk: in std_logic);
	end component;
	signal G: matrix(1 to p, 1 to p);

begin
	m1: module1 generic map(w =>w, n =>n, m =>m, p =>p)
				port map(A11 =>A11, X =>X, F =>F, clk =>clk);
	m2: module2 generic map(w =>w, n =>n, m =>m, p =>p)
				port map(A11 =>A11, X =>X, DA11 =>DA11, clk =>clk);
	m3: module3 generic map(w =>w, n =>n, m =>m, p =>p)
				port map(DA11 => DA11, G =>G, clk =>clk);

	G_out <= G;
	-- G is calculated from DA11 by module 3. DA11 is calculated by module2. So calculation of G is 
	-- one clock behind calculation of DA11. But module 2 puts initial value 0 on DA11. So initially G is zero.
	-- Therefore initially deltaX is zero. Therefore in the first clock of the following process, mediatory_X
	-- is equal to X.
	process(clk)
		variable deltaX: matrix(1 to p, 1 to 1);
		variable temp: signed(2*w -1 downto 0);
		variable mediatory_X: matrix(1 to p, 1 to 1);
		variable mediatory_A11: matrix(1 to n, 1 to n);
		variable err: integer;
		variable algorithm_iteration_v: integer := 0;
	begin
		if (falling_edge(clk)) then
			deltaX := (others =>(others=>to_signed(0,w)));
			mediatory_A11 := (others =>(others=>to_signed(0,w)));
			err := 0;
			for i in 1 to p loop
				for j in 1 to p loop
					temp := G(i,j) * F(j,1);
					deltaX(i,1) := deltaX(i,1) + temp(w-1 downto 0);
				end loop;
				mediatory_X(i,1) := X(i,1) + deltaX(i,1);
				if i <= n then
					temp := mediatory_X(i,1)*mediatory_X(i,1);
					temp := R*temp(w-1 downto 0);
					mediatory_A11(i,i) := temp(w-1 downto 0);
				end if;
				err := err + to_integer(deltaX(i,1));
			end loop;
			if err > E then
				finish <='1';
			else
				finish <='0';
			end if;
			X <= mediatory_X;
			A11 <= mediatory_A11;
			X_select <= '1';
			A11_select <= '1';
			algorithm_iteration_v := algorithm_iteration_v +1;
			algorithm_iteration <= algorithm_iteration_v;
		end if;
	end process;

end Behavioral;
