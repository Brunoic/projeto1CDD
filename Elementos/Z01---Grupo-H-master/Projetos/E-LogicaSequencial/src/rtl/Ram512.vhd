-- Elementos de Sistemas
-- by Luciano Soares
-- Ram64.vhd

Library ieee; 
use ieee.std_logic_1164.all;
  
entity Ram512 is
	port(
		clock:   in  STD_LOGIC;
		input:   in  STD_LOGIC_VECTOR(15 downto 0);
		load:    in  STD_LOGIC;
		address: in  STD_LOGIC_VECTOR( 8 downto 0);
		output:  out STD_LOGIC_VECTOR(15 downto 0)
	);
end entity;

architecture arch of Ram512 is

component Ram64 is
	port(
		clock:   in  STD_LOGIC;
		input:   in  STD_LOGIC_VECTOR(15 downto 0);
		load:    in  STD_LOGIC;
		address: in  STD_LOGIC_VECTOR(5 downto 0);
		output:  out STD_LOGIC_VECTOR(15 downto 0)
	);
end component Ram64;

component DMux8Way16 is
	port ( 
			a:   in  STD_LOGIC_VECTOR(15 downto 0);
			sel: in  STD_LOGIC_VECTOR(2 downto 0);
			q0:  out STD_LOGIC_VECTOR(15 downto 0);
			q1:  out STD_LOGIC_VECTOR(15 downto 0);
			q2:  out STD_LOGIC_VECTOR(15 downto 0);
			q3:  out STD_LOGIC_VECTOR(15 downto 0);
			q4:  out STD_LOGIC_VECTOR(15 downto 0);
			q5:  out STD_LOGIC_VECTOR(15 downto 0);
			q6:  out STD_LOGIC_VECTOR(15 downto 0);
			q7:  out STD_LOGIC_VECTOR(15 downto 0));
end component DMux8Way16;

component Mux8Way16 is
	port (  
			a:   in  STD_LOGIC_VECTOR(15 downto 0);
			b:   in  STD_LOGIC_VECTOR(15 downto 0);
			c:   in  STD_LOGIC_VECTOR(15 downto 0);
			d:   in  STD_LOGIC_VECTOR(15 downto 0);
			e:   in  STD_LOGIC_VECTOR(15 downto 0);
			f:   in  STD_LOGIC_VECTOR(15 downto 0);
			g:   in  STD_LOGIC_VECTOR(15 downto 0);
			h:   in  STD_LOGIC_VECTOR(15 downto 0);
			sel: in  STD_LOGIC_VECTOR(2 downto 0);
			q:   out STD_LOGIC_VECTOR(15 downto 0));

end component Mux8Way16;

signal dm1_output,output_ram:STD_LOGIC_VECTOR(127 downto 0);
signal output_dmux:STD_LOGIC_VECTOR(127 downto 0);
signal address_big:STD_LOGIC_VECTOR(2 downto 0);
signal address_small:STD_LOGIC_VECTOR(5 downto 0);
signal load1,load2,load3,load4,load5,load6,load7,load8:STD_LOGIC;

begin
	address_big <= address(8 downto 6);
	address_small <= address(5 downto 0);

	dm1 : DMux8Way16 port map(input,address_big,
		output_dmux(127 downto 112),
		output_dmux(111 downto 96),
		output_dmux(95 downto 80),
		output_dmux(79 downto 64),
		output_dmux(63 downto 48),
		output_dmux(47 downto 32),
		output_dmux(31 downto 16),
		output_dmux(15 downto 0));

	load1 <= load when (address_big = "000") else '0';
	load2 <= load when (address_big = "001") else '0';
	load3 <= load when (address_big = "010") else '0';
	load4 <= load when (address_big = "011") else '0';
	load5 <= load when (address_big = "100") else '0';
	load6 <= load when (address_big = "101") else '0';
	load7 <= load when (address_big = "110") else '0';
	load8 <= load when (address_big = "111") else '0';

	ram_1c: Ram64 port map (clock,output_dmux(127 downto 112),load1,address_small,output_ram(127 downto 112));
	ram_2c: Ram64 port map (clock,output_dmux(111 downto 96),load2,address_small,output_ram(111 downto 96));
	ram_3c: Ram64 port map (clock,output_dmux(95 downto 80),load3,address_small,output_ram(95 downto 80));
	ram_4c: Ram64 port map (clock,output_dmux(79 downto 64),load4,address_small,output_ram(79 downto 64));
	ram_5c: Ram64 port map (clock,output_dmux(63 downto 48),load5,address_small,output_ram(63 downto 48));
	ram_6c: Ram64 port map (clock,output_dmux(47 downto 32),load6,address_small,output_ram(47 downto 32));
	ram_7c: Ram64 port map (clock,output_dmux(31 downto 16),load7,address_small,output_ram(31 downto 16));
	ram_8c: Ram64 port map (clock,output_dmux(15 downto 0),load8,address_small,output_ram(15 downto 0));

	mx : Mux8Way16 port map(
		output_ram(127 downto 112),
		output_ram(111 downto 96),
		output_ram(95 downto 80),
		output_ram(79 downto 64), 
		output_ram(63 downto 48),
		output_ram(47 downto 32),
		output_ram(31 downto 16),
		output_ram(15 downto 0),
		address_big,output);

end architecture;
