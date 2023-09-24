----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.07.2023 18:53:41
-- Design Name: 
-- Module Name: FFD - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FFD is
    Port ( D : in STD_LOGIC;
           C : in STD_LOGIC;
           Q : out STD_LOGIC);
end FFD;


architecture Behavioral of FFD is

component D_Latch
      Port (
          D : in STD_LOGIC;
          C : in STD_LOGIC;
          Q : out STD_LOGIC
      );
end component;

signal not_c1 : std_logic ;
signal not_c2 : std_logic ;
signal q1 : std_logic ;

begin
not_c1 <= not C;
not_c2 <= not not_c1;

inst_LD1: D_Latch port map(

    D => D,
    C => not_c1,
    Q => q1
);

inst_LD2: D_Latch port map(

    D => q1,
    C => not_c2,
    Q => Q
);



end Behavioral;
