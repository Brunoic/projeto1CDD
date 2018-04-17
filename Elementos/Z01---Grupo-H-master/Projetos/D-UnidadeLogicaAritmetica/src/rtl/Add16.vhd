-- Elementos de Sistemas
-- by Luciano Soares
-- Add16.vhd

-- Soma dois valores de 16 bits
-- ignorando o carry mais significativo

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Add16 is
	port(
		a   :  in STD_LOGIC_VECTOR(15 downto 0);
		b   :  in STD_LOGIC_VECTOR(15 downto 0);
		q   : out STD_LOGIC_VECTOR(15 downto 0)
	);
end entity;

architecture rtl of Add16 is

component FullAdder is
	port(
		a,b,c:      in STD_LOGIC;   -- entradas
		soma,vaium: out STD_LOGIC   -- sum e carry
	);
end component;

signal C : STD_LOGIC_VECTOR(15 downto 0);

begin
	add0: FullAdder PORT MAP ( a(0), b(0), '0', q(0), C(0));
    add1: FullAdder PORT MAP ( a(1), b(1), C(0), q(1), C(1));
    add2: FullAdder PORT MAP ( a(2), b(2), C(1), q(2), C(2));
    add3: FullAdder PORT MAP ( a(3), b(3), C(2), q(3), C(3));
    add4: FullAdder PORT MAP ( a(4), b(4), C(3), q(4), C(4));
    add5: FullAdder PORT MAP ( a(5), b(5), C(4), q(5), C(5));
    add6: FullAdder PORT MAP ( a(6), b(6), C(5), q(6), C(6));
    add7: FullAdder PORT MAP ( a(7), b(7), C(6), q(7), C(7));
    add8: FullAdder PORT MAP ( a(8), b(8), C(7), q(8), C(8));
    add9: FullAdder PORT MAP ( a(9), b(9), C(8), q(9), C(9));
    add10: FullAdder PORT MAP ( a(10), b(10), C(9), q(10), C(10));
    add11: FullAdder PORT MAP ( a(11), b(11), C(10), q(11), C(11));
    add12: FullAdder PORT MAP ( a(12), b(12), C(11), q(12), C(12));
    add13: FullAdder PORT MAP ( a(13), b(13), C(12), q(13), C(13));
    add14: FullAdder PORT MAP ( a(14), b(14), C(13), q(14), C(14));
    add15: FullAdder PORT MAP ( a(15), b(15), C(14), q(15), C(15));
 
end architecture;
