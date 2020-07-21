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
use my_package.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity module1 is
	generic(w: integer;
		   n: integer:= n;
	   	   m: integer:= m;
	   	   p: integer:= p);
    Port (A11:in matrix(n,n);
		  X: in matrix(p,p);
	  	  F: out matrix(p,p));
end module1;

architecture Behavioral of module1 is
	signal A
begin
	A(dfded:dfd)<= A11;
	for i in range(0 to n) generate 
	end for;


	
end Behavioral;
