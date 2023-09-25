---------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity PC is
    Port ( clock : in STD_LOGIC;
           clear : in STD_LOGIC;
           load : in STD_LOGIC;
           up : in STD_LOGIC;
           down : in STD_LOGIC;
           datain : in STD_LOGIC_VECTOR (11 downto 0);
           dataout : out STD_LOGIC_VECTOR (11 downto 0));
end PC;

architecture Behavioral of PC is

signal reg : std_logic_vector(11 downto 0) := (others => '0'); -- Se�ales del registro. Parten en 0.

begin

reg_prosses : process (clock, clear)        -- Proceso sensible a clock y clear.
        begin
          if (clear = '1') then             -- Si clear = 1
            reg <= (others => '0');         -- Carga 0 en el registro.
          elsif (rising_edge(clock)) then   -- Si flanco de subida de clock.
            if (load = '1') then            -- Si clear = 0, load = 1.
                reg <= datain;              -- Carga la entrada de datos en el registro.
            elsif (up = '1') then           -- Si clear = 0,load = 0 y up = 1.
                reg <= reg + 1;             -- Incrementa el registro en 1.
            elsif (down = '1') then         -- Si clear = 0,load = 0, up = 0 y down = 1. 
                reg <= reg - 1;             -- Decrementa el registro en 1.          
            end if;
          end if;
        end process;
        
dataout <= reg;                             -- Los datos del registro salen sin importar el estado de clock.
            
end Behavioral;
