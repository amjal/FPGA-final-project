library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;
use work.my_package.all;
use std.textio.all;

entity module2_tb is
end;

architecture bench of module2_tb is

  component module2
  	generic(w: integer;
  		   n: integer;
  	   	   m: integer;
  	   	   p: integer);
      Port (A11:in matrix(1 to n, 1 to n);
  		  X: in matrix(1 to p, 1 to 1);
  	  	  DA11: out matrix(1 to n, 1 to n));
  end component;

  signal A11: matrix(1 to n, 1 to n);
  signal X: matrix(1 to p, 1 to 1);
  signal DA11: matrix(1 to n, 1 to n);
  file A_data : text;
  file X_data : text;
  file DA11_data : text;

begin
  -- Insert values for generic parameters !!
  uut: module2 generic map ( w   =>w ,
                             n   =>n ,
                             m   =>m ,
                             p   =>p  )
                  port map ( A11 => A11,
                             X   => X,
                             DA11   => DA11 );

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
				A11(i,j) <= A(i,j);
			elsif (i <= n) and (j >n) then
				A12(i,j-n) <= A(i,j);
			elsif (i >n ) and (j <=n) then
				A21(i-n,j) <= A(i,j);
			end if;
		end loop;
	end loop;
    file_close(A_data);
    wait;
  end process;


  readX: process
	  variable L : line; 
	  variable element: integer;
  begin
	file_open(X_data, "C:\Users\Amir\vivadoprojects\Phase01\X.input.dat", read_mode);
	for i in 1 to p loop
		readline(X_data, L); 
		read(L,element); 
		X(i,1) <= to_signed(element,w);
	end loop;
	file_close(X_data);
    wait;
  end process;
	
  writeDA11: process(DA11)
	  variable L : line;
	  variable element: integer;
  begin
	file_open(DA11_data, "C:\Users\Amir\vivadoprojects\Phase01\DA11.input.dat", write_mode);
	for i in 1 to n loop
		for j in 1 to n loop
			element := to_integer(DA11(i,j));
			write(L, element);
			write(L,' ');
	end loop;
		writeline(DA11_data,L);
	end loop;
	file_close(DA11_data);
  end process;

end;
