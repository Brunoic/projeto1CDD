-- by Luciano Soares
-- BinaryDigit.vhd

Library ieee;
use ieee.std_logic_1164.all;

entity BinaryDigit is
	port(
		clock:   in STD_LOGIC;
		input:   in STD_LOGIC;
		load:    in STD_LOGIC;
		output: out STD_LOGIC
	);
end entity;

architecture fds of BinaryDigit is

  component Mux2Way is
    port(
      a: in STD_LOGIC;   
      b: in STD_LOGIC;  
      sel: in STD_LOGIC; 
      q: out STD_LOGIC   
    );
  end component;

  component FlipFlopD is
    port(
      clock: in STD_LOGIC;  
      d: in STD_LOGIC; 
      clear: in STD_LOGIC;   
      preset: in STD_LOGIC;   
      q: out STD_LOGIC   
    );
  end component;

 signal d,o,preset,clear: STD_LOGIC;

begin
  flip: FlipFlopD PORT MAP (clock,d,preset,clear,o);
  mux: Mux2Way PORT MAP (o,input,load,d);
  output <= o;

end architecture;