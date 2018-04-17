-- Elementos de Sistemas
-- by Luciano Soares
-- Inc16.vhd

-- Incrementador de 16 bits
-- adiciona 1 ao valore de entrada (adição aritmética)

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Inc16 is
	port(
		a   :  in STD_LOGIC_VECTOR(15 downto 0);
		q   : out STD_LOGIC_VECTOR(15 downto 0)
	);
end entity;

architecture rtl of Inc16 is

component HalfAdder is
	port(
		a,b:        in STD_LOGIC;   -- entradas
		soma,vaium: out STD_LOGIC   -- sum e carry
	);
end component;

signal B : STD_LOGIC_VECTOR(15 downto 0);

begin
	halfadd0 : HalfAdder PORT MAP (a(0),  '1', q(0), B(0));
	halfadd1 : HalfAdder PORT MAP (a(1), B(0), q(1), B(1));
	halfadd2 : HalfAdder PORT MAP (a(2), B(1), q(2), B(2));
	halfadd3 : HalfAdder PORT MAP (a(3), B(2), q(3), B(3));
	halfadd4 : HalfAdder PORT MAP (a(4), B(3), q(4), B(4));
	halfadd5 : HalfAdder PORT MAP (a(5), B(4), q(5), B(5));
	halfadd6 : HalfAdder PORT MAP (a(6), B(5), q(6), B(6));
	halfadd7 : HalfAdder PORT MAP (a(7), B(6), q(7), B(7));
	halfadd8 : HalfAdder PORT MAP (a(8), B(7), q(8), B(8));
	halfadd9 : HalfAdder PORT MAP (a(9), B(8), q(9), B(9));
	halfadd10 : HalfAdder PORT MAP (a(10), B(9), q(10), B(10));
	halfadd11 : HalfAdder PORT MAP (a(11), B(10), q(11), B(11));
	halfadd12 : HalfAdder PORT MAP (a(12), B(11), q(12), B(12));
	halfadd13 : HalfAdder PORT MAP (a(13), B(12), q(13), B(13));
	halfadd14 : HalfAdder PORT MAP (a(14), B(13), q(14), B(14));
	halfadd15 : HalfAdder PORT MAP (a(15), B(14), q(15), B(15));


end architecture;
