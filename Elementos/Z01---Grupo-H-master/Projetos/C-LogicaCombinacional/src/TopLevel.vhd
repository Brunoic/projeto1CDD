--
-- Elementos de Sistemas - Aula 5 - Logica Combinacional
-- Rafael . Corsi @ insper . edu . br 
--
-- Arquivo exemplo para acionar os LEDs e ler os bottoes
-- da placa DE0-CV utilizada no curso de elementos de 
-- sistemas do 3s da eng. da computacao

----------------------------
-- Bibliotecas ieee       --
----------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

----------------------------
-- Entrada e saidas do bloco
----------------------------
entity TopLevel is
	port(
		SW      : in  std_logic_vector(9 downto 0);
		LEDR    : out std_logic_vector(9 downto 0)
	);
end entity;

----------------------------
-- Implementacao do bloco -- 
----------------------------
architecture rtl of TopLevel is

--------------
-- signals
--------------
component not16 is
	port ( 
			a:   in  STD_LOGIC_VECTOR(15 downto 0);
			q:   out STD_LOGIC_VECTOR(15 downto 0));
end component;

component and16 is
	port ( 
			a:   in  STD_LOGIC_VECTOR(15 downto 0);
			b:   in  STD_LOGIC_VECTOR(15 downto 0);
			q:   out STD_LOGIC_VECTOR(15 downto 0));
end component;

signal interno, interno2 : std_logic;

---------------
-- implementacao
---------------
begin
 

  and1 : and16 port map (
  	a(0) 				=> interno,
	a(15 downto 1) => "000000000000000",
  	b(0) 			   => SW(1),
	b(15 downto 1) => "000000000000000",
	q(15 downto 1) => open,
  	q(0)			   => interno2
  	);
	

  and2 : and16 port map (
  	a(0) 				=> interno2,
	a(15 downto 1) => "000000000000000",
  	b(0) 			   => SW(2),
	b(15 downto 1) => "000000000000000",
	q(15 downto 1) => open,
  	q(0)			   => LEDR(0)
  	);
	

  not1 : not16 port map (
  	a(0)				=> SW(0),
	a(15 downto 1) => "000000000000000",
  	q(0) 				=> interno,
	q(15 downto 1) => open
  	);
  
--LEDR(8) <= (not1 SW(0)) and1 SW(1) and1 SW(2); 
--
end rtl;
