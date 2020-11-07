library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

package my_package is
	constant w : integer := 16;
	constant L:integer:= 3;
	constant R :integer := 2;
	constant p : integer := 7;
	constant m : integer := 3;
	constant n : integer := 4;
	constant Z : integer := 2;
	constant E : integer := 10;
	type matrix is array (positive range <>, positive range <>) of signed(w-1 downto 0);
	signal A12 : matrix(1 to n, 1 to m);
	signal A21 : matrix(1 to m, 1 to n);
	signal B: matrix(1 to p, 1 to 1);
	impure function concatenator (A11: matrix) return matrix;
end my_package;

package body my_package is 
	impure function concatenator (A11:matrix) return matrix is
		variable A : matrix(1 to p, 1 to p);
	begin
		for i in 1 to p loop
			for j in 1 to p loop
				if (i <= n) and ( j <= n) then
					A(i,j) := A11(i,j);
				elsif (i <=n ) and (j > n) then
					A(i,j) := A12(i,j-n);
				elsif (i >n ) and (j <= n) then
					A(i,j) := A21(i-n, j);
				else
					A(i,j) := to_signed(0,w);
				end if;
			end loop;
		end loop;
		return A;
	end concatenator;
end package body;
