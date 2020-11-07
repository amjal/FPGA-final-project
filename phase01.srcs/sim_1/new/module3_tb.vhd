library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;
use work.my_package.all;
use std.textio.all;

entity module3_tb is
end;

architecture bench of module3_tb is

  component module3
  	generic(w: integer;
  		   n: integer;
  	   	   m: integer;
  	   	   p: integer);
      Port (DA11:in matrix(1 to n, 1 to n);
  	  	  G: out matrix(1 to p, 1 to p));
  end component;
  signal DA11: matrix(1 to n, 1 to n);
  signal G: matrix(1 to p, 1 to p);
  file DA11_data : text;
  file G_data : text;
  file A_data: text;

begin
  -- Insert values for generic parameters !!
  uut: module3 generic map ( w   =>w ,
                             n   =>n ,
                             m   =>m ,
                             p   =>p  )
                  port map ( DA11 => DA11,
                             G   => G );


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
			if (i <= n) and (j >n) then
				A12(i,j-n) <= A(i,j);
			elsif (i >n ) and (j <=n) then
				A21(i-n,j) <= A(i,j);
			end if;
		end loop;
	end loop;
    file_close(A_data);
    wait;
  end process;

  readDA11: process
	  variable L : line; 
	  variable element: integer;
  begin
	file_open(DA11_data, "C:\Users\Amir\vivadoprojects\Phase01\DA11.input.dat", read_mode);
	for i in 1 to n loop
		readline(DA11_data, L); 
		for j in 1 to n loop
			read(L, element);
			--report integer'image(element) &" " & integer'image(i) &" " & integer'image(j);
			DA11(i,j) <= to_signed(element,w);
		end loop;
	end loop;
    file_close(DA11_data);
    wait;
  end process;

  writeG: process(G)
	  variable L : line;
	  variable element: integer;
  begin
	file_open(G_data, "C:\Users\Amir\vivadoprojects\Phase01\G.input.dat", write_mode);
	for i in 1 to p loop
		for j in 1 to p loop
			element := to_integer(G(i,j));
			write(L, element);
			write(L,' ');
		end loop;
		writeline(G_data,L);
	end loop;
	file_close(G_data);
  end process;
end;
