----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/23/2020 02:21:34 PM
-- Design Name: 
-- Module Name: module4_tb - Behavioral
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
use std.textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity module4_tb is
end module4_tb;

architecture Behavioral of module4_tb is
	component module4
		generic(w: integer;
				n: integer;
				m: integer;
				p: integer);
		Port (A11: inout matrix(1 to n, 1 to n);
			  X: inout matrix(1 to p, 1 to 1);
			  G_out: out matrix(1 to p, 1 to p);
			  clk: in std_logic;
			  X_select: inout std_logic;
			  A11_select: inout std_logic;
			  algorithm_iteration: out integer;
			  finish: out std_logic);
	end component;
	signal A11: matrix(1 to n, 1 to n);
	signal X: matrix(1 to p, 1 to 1);
	signal G_out: matrix(1 to p, 1 to p);
	signal clk: std_logic := '0';
	signal X_select: std_logic;
	signal A11_select: std_logic;
	signal finish : std_logic;
	signal algorithm_iteration: integer;
	file A_data : text;
	file B_data : text;
	file X_data : text;
	file G_data : text;
begin
	uut: module4 generic map (w =>w, n =>n, m =>m, p =>p)
				 port map(A11 =>A11, X =>X, G_out =>G_out, clk => clk, X_select => X_select,
						 finish => finish, A11_select => A11_select, algorithm_iteration => 
						 algorithm_iteration);

	clk <= not clk after 10 ns;

  readA: process
	  variable L : line; 
	  variable A : matrix(1 to p, 1 to p);
	  variable element: integer;
  begin
	file_open(A_data, "C:\Users\Amir\vivadoprojects\Phase01\A.input.dat", read_mode);
	for i in 1 to p loop
		readline(A_data, L); 
		for j in 1 to p loop
			read(L, element);
			--report integer'image(element) &" " & integer'image(i) &" " & integer'image(j);
			A(i,j) := to_signed(element,w);
			if (i <= n) and (j <=n) then
				case A11_select is
					when '0' => A11(i,j) <= A(i,j);
					when others => A11(i,j) <= (others => 'Z');
				end case;
			elsif (i <= n) and (j >n) then
				A12(i,j-n) <= A(i,j);
			elsif (i >n ) and (j <=n) then
				A21(i-n,j) <= A(i,j);
			end if;
		end loop;
	end loop;
    file_close(A_data);
    wait on A11_select;
  end process;

  readX: process
	  variable L : line; 
	  variable element: integer;
  begin
	file_open(X_data, "C:\Users\Amir\vivadoprojects\Phase01\X.input.dat", read_mode);
	for i in 1 to p loop
		readline(X_data, L); 
		read(L,element); 
		case X_select is
			when '0' => X(i,1) <= to_signed(element,w);
			when others => X(i,1) <= (others =>'Z');
		end case;
	end loop;
	file_close(X_data);
	wait on X_select;
  end process;

  readB: process
	  variable L : line; 
	  variable element: integer;
  begin
	file_open(B_data, "C:\Users\Amir\vivadoprojects\Phase01\B.input.dat", read_mode);
	for i in 1 to p loop
		readline(B_data, L); 
		read(L,element); 
		B(i,1) <= to_signed(element,w);
	end loop;
	file_close(B_data);
    wait;
  end process;

  writeX: process(algorithm_iteration)
	  variable L : line;
	  variable element: integer;
  begin
	if (algorithm_iteration < 4) then
		file_open(X_data, "C:\Users\Amir\vivadoprojects\Phase01\X.output" & integer'image(algorithm_iteration) &".dat", write_mode);
		file_open(G_data, "C:\Users\Amir\vivadoprojects\Phase01\G.output" & integer'image(algorithm_iteration) &".dat", write_mode);
		for i in 1 to p loop
			for j in 1 to p loop
				element := to_integer(G_out(i,j));
				write(L, element);
				write(L,' ');
			end loop;
			writeline(G_data,L);
			element := to_integer(X(i,1));
			write(L, element);
			writeline(X_data,L);
		end loop;
		file_close(X_data);
		file_close(G_data);
	end if;
  end process;

end;
