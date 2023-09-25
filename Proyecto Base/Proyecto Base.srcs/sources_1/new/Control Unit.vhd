library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit is
    Port ( from_status : in STD_LOGIC_VECTOR (2 downto 0);
           from_rom : in STD_LOGIC_VECTOR (19 downto 0);
           enableA : out STD_LOGIC; --carga A
           enableB : out STD_LOGIC; --carga B
           selA : out STD_LOGIC_VECTOR (1 downto 0);
           selB : out STD_LOGIC_VECTOR (1 downto 0);
           loadPC : out STD_LOGIC;
           selALU : out STD_LOGIC_VECTOR (2 downto 0);
           w: out STD_LOGIC);
           
end ControlUnit;

architecture Behavioral of ControlUnit is

signal jmp_cond : std_logic;

begin

    with from_rom (6 downto 0) select
    enableA  <=   '1'     when "0000001", --MOV A,B
                  '0'     when "0000010", --MOV B,A
                  '1'     when "0000011", --MOV A,L
                  '0'     when "0000100", --MOV B,L
                  '1'     when "0000101", --MOV A,DIR
                  '0'     when "0000110", --MOV B,DIR
                  '0'     when "0000111", --MOV DIR,A
                  '0'     when "0001000", --MOV DIR,B
                  '1'     when "0001001", --ADD A,B
                  '0'     when "0001010", --ADD B,A
                  '1'     when "0001011", --ADD A,LIT
                  '0'     when "0001100", --ADD B,LIT
                  '1'     when "0001101", --ADD A,DIR
                  '0'     when "0001110", --ADD B,DIR
                  '0'     when "0001111", --ADD DIR
                  '1'     when "0010000", --SUB A,B
                  '0'     when "0010001", --SUB B,A
                  '1'     when "0010010", --SUB A,LIT
                  '0'     when "0010011", --SUB B,LIT
                  '1'     when "0010100", --SUB A,DIR
                  '0'     when "0010101", --SUB B,DIR
                  '0'     when "0010110", --SUB DIR
                  '1'     when "0010111", --AND A,B
                  '0'     when "0011000", --AND B,A
                  '1'     when "0011001", --AND A,LIT
                  '0'     when "0011010", --AND B,LIT
                  '1'     when "0011011", --AND A,DIR
                  '0'     when "0011100", --AND B,DIR
                  '0'     when "0011101", --AND DIR
                  '1'     when "0011110", --OR A,B
                  '0'     when "0011111", --OR B,A
                  '1'     when "0100000", --OR A,LIT
                  '0'     when "0100001", --OR B,LIT
                  '1'     when "0100010", --OR A,DIR
                  '0'     when "0100011", --OR B,DIR
                  '0'     when "0100100", --OR DIR
                  '1'     when "0100101", --XOR A,B
                  '0'     when "0100110", --XOR B,A
                  '1'     when "0100111", --XOR A,LIT
                  '0'     when "0101000", --XOR B,LIT
                  '1'     when "0101001", --XOR A,DIR
                  '0'     when "0101010", --XOR B,DIR
                  '0'     when "0101011", --XOR DIR
                  '1'     when "0101100", --NOT A,A
                  '0'     when "0101101", --NOT B,A
                  '0'     when "0101110", --NOT DIR
                  '1'     when "0101111", --SHL A,A
                  '0'     when "0110000", --SHL B,A
                  '0'     when "0110001", --SHL DIR
                  '1'     when "0110010", --SHR A,A
                  '0'     when "0110011", --SHR B,A
                  '0'     when "0110100", --SHR DIR
                  '1'     when "0110101", --INC A
                  '0'     when "0110110", --INC B
                  '0'     when "0110111", --INC DIR
                  '1'     when "0111000", --DEC A
                  '0'     when "0111001", --CMP A,B
                  '0'     when "0111010", --CMP A,LIT
                  '0'     when "0111011", --CMP A,DIR
                  '0'     when "0111100", --JMP Ins
                  '0'     when "0111101", --JEQ Ins
                  '0'     when "0111110", --JNE Ins
                  '0'     when "0000000", --NOP
                  '0'     when others;
                  
 with from_rom (6 downto 0) select
 enableB  <=   '0'     when "0000001", --MOV A,B
               '1'     when "0000010", --MOV B,A
               '0'     when "0000011", --MOV A,L
               '1'     when "0000100", --MOV B,L
               '0'     when "0000101", --MOV A,DIR
               '1'     when "0000110", --MOV B,DIR
               '0'     when "0000111", --MOV DIR,A
               '0'     when "0001000", --MOV DIR,B
               '0'     when "0001001", --ADD A,B
               '1'     when "0001010", --ADD B,A
               '0'     when "0001011", --ADD A,LIT
               '1'     when "0001100", --ADD B,LIT
               '0'     when "0001101", --ADD A,DIR
               '1'     when "0001110", --ADD B,DIR
               '0'     when "0001111", --ADD DIR
               '0'     when "0010000", --SUB A,B
               '1'     when "0010001", --SUB B,A
               '0'     when "0010010", --SUB A,LIT
               '1'     when "0010011", --SUB B,LIT
               '0'     when "0010100", --SUB A,DIR
               '1'     when "0010101", --SUB B,DIR
               '0'     when "0010110", --SUB DIR
               '0'     when "0010111", --AND A,B
               '1'     when "0011000", --AND B,A
               '0'     when "0011001", --AND A,LIT
               '1'     when "0011010", --AND B,LIT
               '0'     when "0011011", --AND A,DIR
               '1'     when "0011100", --AND B,DIR
               '0'     when "0011101", --AND DIR
               '0'     when "0011110", --OR A,B
               '1'     when "0011111", --OR B,A
               '0'     when "0100000", --OR A,LIT
               '1'     when "0100001", --OR B,LIT
               '0'     when "0100010", --OR A,DIR
               '1'     when "0100011", --OR B,DIR
               '0'     when "0100100", --OR DIR
               '0'     when "0100101", --XOR A,B
               '1'     when "0100110", --XOR B,A
               '0'     when "0100111", --XOR A,LIT
               '1'     when "0101000", --XOR B,LIT
               '0'     when "0101001", --XOR A,DIR
               '1'     when "0101010", --XOR B,DIR
               '0'     when "0101011", --XOR DIR
               '0'     when "0101100", --NOT A,A
               '1'     when "0101101", --NOT B,A
               '0'     when "0101110", --NOT DIR
               '0'     when "0101111", --SHL A,A
               '1'     when "0110000", --SHL B,A
               '0'     when "0110001", --SHL DIR
               '0'     when "0110010", --SHR A,A
               '1'     when "0110011", --SHR B,A
               '0'     when "0110100", --SHR DIR
               '0'     when "0110101", --INC A
               '1'     when "0110110", --INC B
               '0'     when "0110111", --INC DIR
               '0'     when "0111000", --DEC A
               '0'     when "0111001", --CMP A,B
               '0'     when "0111010", --CMP A,LIT
               '0'     when "0111011", --CMP A,DIR
               '0'     when "0111100", --JMP Ins
               '0'     when "0111101", --JEQ Ins
               '0'     when "0111110", --JNE Ins
               '0'     when "0000000", --NOP
               '0'     when others;

with from_rom (6 downto 0) select
 selA  <=      "01"     when "0000001", --MOV A,B
               "00"     when "0000010", --MOV B,A
               "01"     when "0000011", --MOV A,L
               "01"     when "0000100", --MOV B,L
               "01"     when "0000101", --MOV A,DIR
               "01"     when "0000110", --MOV B,DIR
               "00"     when "0000111", --MOV DIR,A
               "01"     when "0001000", --MOV DIR,B
               "00"     when "0001001", --ADD A,B
               "00"     when "0001010", --ADD B,A
               "00"     when "0001011", --ADD A,LIT
               "00"     when "0001100", --ADD B,LIT
               "00"     when "0001101", --ADD A,DIR
               "00"     when "0001110", --ADD B,DIR
               "00"     when "0001111", --ADD DIR
               "00"     when "0010000", --SUB A,B
               "00"     when "0010001", --SUB B,A
               "00"     when "0010010", --SUB A,LIT
               "00"     when "0010011", --SUB B,LIT
               "00"     when "0010100", --SUB A,DIR
               "00"     when "0010101", --SUB B,DIR
               "00"     when "0010110", --SUB DIR
               "00"     when "0010111", --AND A,B
               "00"     when "0011000", --AND B,A
               "00"     when "0011001", --AND A,LIT
               "00"     when "0011010", --AND B,LIT
               "00"     when "0011011", --AND A,DIR
               "00"     when "0011100", --AND B,DIR
               "00"     when "0011101", --AND DIR
               "00"     when "0011110", --OR A,B
               "00"     when "0011111", --OR B,A
               "00"     when "0100000", --OR A,LIT
               "00"     when "0100001", --OR B,LIT
               "00"     when "0100010", --OR A,DIR
               "00"     when "0100011", --OR B,DIR
               "00"     when "0100100", --OR DIR
               "00"     when "0100101", --XOR A,B
               "00"     when "0100110", --XOR B,A
               "00"     when "0100111", --XOR A,LIT
               "00"     when "0101000", --XOR B,LIT
               "00"     when "0101001", --XOR A,DIR
               "00"     when "0101010", --XOR B,DIR
               "00"     when "0101011", --XOR DIR
               "00"     when "0101100", --NOT A,A
               "00"     when "0101101", --NOT B,A
               "00"     when "0101110", --NOT DIR
               "00"     when "0101111", --SHL A,A
               "00"     when "0110000", --SHL B,A
               "00"     when "0110001", --SHL DIR
               "00"     when "0110010", --SHR A,A
               "00"     when "0110011", --SHR B,A
               "00"     when "0110100", --SHR DIR
               "00"     when "0110101", --INC A
               "10"     when "0110110", --INC B
               "10"     when "0110111", --INC DIR
               "00"     when "0111000", --DEC A
               "00"     when "0111001", --CMP A,B
               "00"     when "0111010", --CMP A,LIT
               "00"     when "0111011", --CMP A,DIR
               "00"     when "0111100", --JMP Ins
               "00"     when "0111101", --JEQ Ins
               "00"     when "0111110", --JNE Ins
               "00"     when "0000000", --NOP
               "00"     when others;

with from_rom (6 downto 0) select
 selB  <=      "00"     when "0000001", --MOV A,B
               "01"     when "0000010", --MOV B,A
               "10"     when "0000011", --MOV A,L
               "10"     when "0000100", --MOV B,L
               "11"     when "0000101", --MOV A,DIR
               "11"     when "0000110", --MOV B,DIR
               "01"     when "0000111", --MOV DIR,A
               "00"     when "0001000", --MOV DIR,B
               "00"     when "0001001", --ADD A,B
               "00"     when "0001010", --ADD B,A
               "10"     when "0001011", --ADD A,LIT
               "10"     when "0001100", --ADD B,LIT
               "11"     when "0001101", --ADD A,DIR
               "11"     when "0001110", --ADD B,DIR
               "00"     when "0001111", --ADD DIR
               "00"     when "0010000", --SUB A,B
               "00"     when "0010001", --SUB B,A
               "10"     when "0010010", --SUB A,LIT
               "10"     when "0010011", --SUB B,LIT
               "11"     when "0010100", --SUB A,DIR
               "11"     when "0010101", --SUB B,DIR
               "00"     when "0010110", --SUB DIR
               "00"     when "0010111", --AND A,B
               "00"     when "0011000", --AND B,A
               "10"     when "0011001", --AND A,LIT
               "10"     when "0011010", --AND B,LIT
               "11"     when "0011011", --AND A,DIR
               "11"     when "0011100", --AND B,DIR
               "00"     when "0011101", --AND DIR
               "00"     when "0011110", --OR A,B
               "00"     when "0011111", --OR B,A
               "10"     when "0100000", --OR A,LIT
               "10"     when "0100001", --OR B,LIT
               "11"     when "0100010", --OR A,DIR
               "11"     when "0100011", --OR B,DIR
               "00"     when "0100100", --OR DIR
               "00"     when "0100101", --XOR A,B
               "00"     when "0100110", --XOR B,A
               "10"     when "0100111", --XOR A,LIT
               "10"     when "0101000", --XOR B,LIT
               "11"     when "0101001", --XOR A,DIR
               "11"     when "0101010", --XOR B,DIR
               "00"     when "0101011", --XOR DIR
               "00"     when "0101100", --NOT A,A
               "00"     when "0101101", --NOT B,A
               "00"     when "0101110", --NOT DIR
               "00"     when "0101111", --SHL A,A
               "00"     when "0110000", --SHL B,A
               "00"     when "0110001", --SHL DIR
               "00"     when "0110010", --SHR A,A
               "00"     when "0110011", --SHR B,A
               "00"     when "0110100", --SHR DIR
               "10"     when "0110101", --INC A
               "00"     when "0110110", --INC B
               "11"     when "0110111", --INC DIR
               "10"     when "0111000", --DEC A
               "00"     when "0111001", --CMP A,B
               "10"     when "0111010", --CMP A,LIT
               "11"     when "0111011", --CMP A,DIR
               "00"     when "0111100", --JMP Ins
               "00"     when "0111101", --JEQ Ins
               "00"     when "0111110", --JNE Ins
               "00"     when "0000000", --NOP
               "00"     when others;

with from_rom (6 downto 0) select
-- MOV "000" -- ADD "000" -- SUB "001" -- AND "010" -- OR "011"
-- XOR "100" -- NOT "101" -- SHR "110" -- SHL "111"
             
 selALU <= "000"     when "0000001", --MOV A,B
           "000"     when "0000010", --MOV B,A
           "000"     when "0000011", --MOV A,L
           "000"     when "0000100", --MOV B,L
           "000"     when "0000101", --MOV A,DIR
           "000"     when "0000110", --MOV B,DIR
           "000"     when "0000111", --MOV DIR,A
           "000"     when "0001000", --MOV DIR,B
           "000"     when "0001001", --ADD A,B
           "000"     when "0001010", --ADD B,A
           "000"     when "0001011", --ADD A,LIT
           "000"     when "0001100", --ADD B,LIT
           "000"     when "0001101", --ADD A,DIR
           "000"     when "0001110", --ADD B,DIR
           "000"     when "0001111", --ADD DIR
           "001"     when "0010000", --SUB A,B
           "001"     when "0010001", --SUB B,A
           "001"     when "0010010", --SUB A,LIT
           "001"     when "0010011", --SUB B,LIT
           "001"     when "0010100", --SUB A,DIR
           "001"     when "0010101", --SUB B,DIR
           "001"     when "0010110", --SUB DIR
           "010"     when "0010111", --AND A,B
           "010"     when "0011000", --AND B,A
           "010"     when "0011001", --AND A,LIT
           "010"     when "0011010", --AND B,LIT
           "010"     when "0011011", --AND A,DIR
           "010"     when "0011100", --AND B,DIR
           "010"     when "0011101", --AND DIR
           "011"     when "0011110", --OR A,B
           "011"     when "0011111", --OR B,A
           "011"     when "0100000", --OR A,LIT
           "011"     when "0100001", --OR B,LIT
           "011"     when "0100010", --OR A,DIR
           "011"     when "0100011", --OR B,DIR
           "011"     when "0100100", --OR DIR
           "100"     when "0100101", --XOR A,B
           "100"     when "0100110", --XOR B,A
           "100"     when "0100111", --XOR A,LIT
           "100"     when "0101000", --XOR B,LIT
           "100"     when "0101001", --XOR A,DIR
           "100"     when "0101010", --XOR B,DIR
           "100"     when "0101011", --XOR DIR
           "101"     when "0101100", --NOT A,A
           "101"     when "0101101", --NOT B,A
           "101"     when "0101110", --NOT DIR
           "111"     when "0101111", --SHL A,A
           "111"     when "0110000", --SHL B,A
           "111"     when "0110001", --SHL DIR
           "110"     when "0110010", --SHR A,A
           "110"     when "0110011", --SHR B,A
           "110"     when "0110100", --SHR DIR
           "000"     when "0110101", --INC A
           "000"     when "0110110", --INC B
           "000"     when "0110111", --INC DIR
           "001"     when "0111000", --DEC A
           "001"     when "0111001", --CMP A,B
           "001"     when "0111010", --CMP A,LIT
           "001"     when "0111011", --CMP A,DIR
           "000"     when "0111100", --JMP Ins
           "000"     when "0111101", --JEQ Ins
           "000"     when "0111110", --JNE Ins
           "000"     when "0000000", --NOP
           "000"     when others;

with from_rom (6 downto 0) select              
 w  <=       '0'     when "0000001", --MOV A,B
             '0'     when "0000010", --MOV B,A
             '0'     when "0000011", --MOV A,L
             '0'     when "0000100", --MOV B,L
             '0'     when "0000101", --MOV A,DIR
             '0'     when "0000110", --MOV B,DIR
             '1'     when "0000111", --MOV DIR,A
             '1'     when "0001000", --MOV DIR,B
             '0'     when "0001001", --ADD A,B
             '0'     when "0001010", --ADD B,A
             '0'     when "0001011", --ADD A,LIT
             '0'     when "0001100", --ADD B,LIT
             '0'     when "0001101", --ADD A,DIR
             '0'     when "0001110", --ADD B,DIR
             '1'     when "0001111", --ADD DIR
             '0'     when "0010000", --SUB A,B
             '0'     when "0010001", --SUB B,A
             '0'     when "0010010", --SUB A,LIT
             '0'     when "0010011", --SUB B,LIT
             '0'     when "0010100", --SUB A,DIR
             '0'     when "0010101", --SUB B,DIR
             '1'     when "0010110", --SUB DIR
             '0'     when "0010111", --AND A,B
             '0'     when "0011000", --AND B,A
             '0'     when "0011001", --AND A,LIT
             '0'     when "0011010", --AND B,LIT
             '0'     when "0011011", --AND A,DIR
             '0'     when "0011100", --AND B,DIR
             '1'     when "0011101", --AND DIR
             '0'     when "0011110", --OR A,B
             '0'     when "0011111", --OR B,A
             '0'     when "0100000", --OR A,LIT
             '0'     when "0100001", --OR B,LIT
             '0'     when "0100010", --OR A,DIR
             '0'     when "0100011", --OR B,DIR
             '1'     when "0100100", --OR DIR
             '0'     when "0100101", --XOR A,B
             '0'     when "0100110", --XOR B,A
             '0'     when "0100111", --XOR A,LIT
             '0'     when "0101000", --XOR B,LIT
             '0'     when "0101001", --XOR A,DIR
             '0'     when "0101010", --XOR B,DIR
             '1'     when "0101011", --XOR DIR
             '0'     when "0101100", --NOT A,A
             '0'     when "0101101", --NOT B,A
             '1'     when "0101110", --NOT DIR
             '0'     when "0101111", --SHL A,A
             '0'     when "0110000", --SHL B,A
             '1'     when "0110001", --SHL DIR
             '0'     when "0110010", --SHR A,A
             '0'     when "0110011", --SHR B,A
             '1'     when "0110100", --SHR DIR
             '0'     when "0110101", --INC A
             '0'     when "0110110", --INC B
             '1'     when "0110111", --INC DIR
             '0'     when "0111000", --DEC A
             '0'     when "0111001", --CMP A,B
             '0'     when "0111010", --CMP A,LIT
             '0'     when "0111011", --CMP A,DIR
             '0'     when "0111100", --JMP Ins
             '0'     when "0111101", --JEQ Ins
             '0'     when "0111110", --JNE Ins
             '0'     when "0000000", --NOP
             '0'     when others;
        
with from_rom (6 downto 0) select              
    jmp_cond  <=    '1'     when "0111100", --JMP Ins
                    '1'     when "0111101", --JEQ Ins
                    '1'     when "0111110", --JNE Ins
                    '0'     when others;

with from_rom (6 downto 0) select              
    loadPC  <=    jmp_cond                         when "0111100", --JMP Ins
                  jmp_cond and from_status(1)      when "0111101", --JEQ Ins
                  jmp_cond and not(from_status(1)) when "0111110", --JNE Ins
                  '0'     when others;
       
end Behavioral;