library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;
use work.my_package.all;
use std.textio.all;

entity module1_tb is
end;

architecture bench of module1_tb is

  component module1
  	generic(w: integer;
  		   n: integer;
  	   	   m: integer;
  	   	   p: integer);
      Port (A11:in matrix(1 to n, 1 to n);
  		  X: in matrix(1 to p, 1 to 1);
  	  	  F: out matrix(1 to p, 1 to 1));
  end component;

  signal A11: matrix(1 to n, 1 to n);
  signal X: matrix(1 to p, 1 to 1);
  signal F: matrix(1 to p, 1 to 1);
  file A_data : text;
  file B_data : text;
  file X_data : text;
  file F_data : text;

begin
  -- Insert values for generic parameters !!
  uut: module1 generic map ( w   =>w ,
                             n   =>n ,
                             m   =>m ,
                             p   =>p  )
                  port map ( A11 => A11,
                             X   => X,
                             F   => F );

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
	
  writeF: process(F)
	  variable L : line;
	  variable element: integer;
  begin
	file_open(F_data, "C:\Users\Amir\vivadoprojects\Phase01\F.input.dat", write_mode);
	for i in 1 to p loop
		element := to_integer(F(i,1));
		write(L, element);
		writeline(F_data,L);
	end loop;
	file_close(F_data);
  end process;

end;
