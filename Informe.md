# Informe Entrega 1 Proyecto Arquitectura de Computadores IIC2324

## Grupo 94

## Integrantes:

- Nicolas 
    - Roles: Desarrollo de componentes (ALU, ...)
- Julian
    - Roles: Desarrollo de componentes (PC, 
- Vicente Bragado
    - Roles: Desarrollo de software (instrucciones de assembly, opcode) y unidad de control

## 1. Estructura de palabra:

La palabra de 36 bits está dividida en dos partes. La primera (16 bits más significativos) corresponden a instrucciones para dirección de memoria o un literal de 16 bits. En el caso de dirección de memoria, los 12 bits menos significativos de estos 16 son utilizados, con el resto de los bits siendo 0s. 

Los 7 bits menos significativos de la palabra de 36 bits corresponden al opcode. Por lo mismo, los 13 bits que sobran son 0s. 

## 2. Codigo de máquina: algoritmo de multiplicación en código de máquina (4x2)

000000000000000000000000000000000011 -- Data MOV A, 0

000000000000000000000000000000000111 --      MOV (0), A

000000000000000000000000000000000011 --      MOV A, 0

000000000000000100000000000000000111 --      MOV (1), A

000000000000010000000000000000000011 --      MOV A, 4

000000000000001000000000000000000111 --      MOV (2), A

000000000000001000000000000000000011 --      MOV A, 2

000000000000001100000000000000000111 --      MOV (3), A 

000000000000001000000000000000000101 -- Code MOV A, (2)

000000000000001100000000000000000110 --      MOV B, (3)  

000000000000000000000000000000000111 --      MOV (0), A

000000000000110000000000000000111100 --      JMP (12)

000000000000000000000000000000111010 -- mult: CMP A, 0

000000000001010100000000000000111101 --       JEQ (21)    

000000000000001100000000000000000101 --       MOV A, (3)

000000000000000100000000000000001101 --       ADD A, (1)

000000000000000100000000000000000111 --       MOV (1), A

000000000000000000000000000000000101 --       MOV A, (0)

000000000000000100000000000000010010 --       SUB A, 1

000000000000000000000000000000000111 --       MOV (0), A

000000000000110000000000000000111100 --       JMP (12)

000000000000000100000000000000000101 -- end:  MOV A, (1)

000000000001010100000000000000111100 --       JMP (21)