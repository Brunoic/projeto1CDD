-- Elementos de Sistemas
-- developed by Luciano Soares
-- file: PC.vhd
-- date: 4/4/2017

-- Contador de 16bits
-- if (reset[t] == 1) out[t+1] = 0
-- else if (load[t] == 1)  out[t+1] = in[t]
-- else if (inc[t] == 1) out[t+1] = out[t] + 1
-- else out[t+1] = out[t]

library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity PC is
    port(
        clock     : in  STD_LOGIC;
        increment : in  STD_LOGIC;
        load      : in  STD_LOGIC;
        reset     : in  STD_LOGIC;
        input     : in  STD_LOGIC_VECTOR(15 downto 0);
        output    : out STD_LOGIC_VECTOR(15 downto 0)
    );
end entity;

architecture arch of PC is

component Inc16 is
	port(
		a   :  in STD_LOGIC_VECTOR(15 downto 0);
		q   : out STD_LOGIC_VECTOR(15 downto 0)
	);
end component;

component Mux16 is
	port ( 
			a:   in  STD_LOGIC_VECTOR(15 downto 0);
			b:   in  STD_LOGIC_VECTOR(15 downto 0);
			sel: in  STD_LOGIC;
			q:   out STD_LOGIC_VECTOR(15 downto 0)
		);
end component;

component Register16 is
port(
		clock:   in STD_LOGIC;
		input:   in STD_LOGIC_VECTOR(15 downto 0);
		load:    in STD_LOGIC;
		output: out STD_LOGIC_VECTOR(15 downto 0)
	);
end component;

--S -> saída --E --> Entrada
signal incS: STD_LOGIC_VECTOR(15 downto 0);
signal TempInput: STD_LOGIC_VECTOR(15 downto 0);
signal TempOutput: STD_LOGIC_VECTOR(15 downto 0);
signal RegStore: STD_LOGIC_VECTOR(15 downto 0);
signal MuxS: STD_LOGIC_VECTOR(15 downto 0);
signal TempLoad: STD_LOGIC;

begin
process(reset,input,TempInput)
begin
	if(reset = '1') then
	TempInput <= "0000000000000000";
	TempLoad <= '1';
	else
	TempInput <= input;
	TempLoad <= load;

	end if;
end process;

	bitincrementer: Inc16 PORT MAP(MuxS,incS);
	TempOutput <= incS when increment = '1'
		else MuxS;

	Reg16: Register16 PORT MAP(clock,TempOutput, '1' ,RegStore);

	Mux: Mux16 PORT MAP(RegStore,TempInput,TempLoad,MuxS);
	output <= MuxS;

end architecture;
