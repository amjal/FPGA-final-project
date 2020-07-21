library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

package my_package is
	signal p, n, m: integer;
	type matrix is array (positive range <>, positive range <>) of signed;
	signal B: matrix:= matrix(p,p);
end my_package;

package body my_package is 
end package body;
