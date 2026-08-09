--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:12:42 08/09/2026
-- Design Name:   
-- Module Name:   C:/Users/KING/Desktop/fpga-ise/sample_Prj/Primitive_prj/Prj_FIFO_tb.vhd
-- Project Name:  Primitive_prj
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Prj_IP_FIFO
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Prj_FIFO_tb IS
END Prj_FIFO_tb;
 
ARCHITECTURE behavior OF Prj_FIFO_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Prj_IP_FIFO
    PORT(
         Data_In_Top : IN  unsigned(7 downto 0);
         Data_Out_Top : OUT  unsigned(7 downto 0);
         CLK_TOP : IN  std_logic;
         Rst_TOP : IN  std_logic;
         wr_en_TOP : IN  std_logic;
         rd_en_TOP : IN  std_logic;
         full_TOP : OUT  std_logic;
         empty_TOP : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Data_In_Top : unsigned(7 downto 0) := (others => '0');
   signal CLK_TOP   : std_logic := '0';
   signal Rst_TOP   : std_logic := '0';
   signal wr_en_TOP : std_logic := '0';
   signal rd_en_TOP : std_logic := '0';

 	--Outputs
   signal Data_Out_Top : unsigned(7 downto 0);
   signal full_TOP : std_logic;
   signal empty_TOP : std_logic;

   -- Clock period definitions
   constant CLK_TOP_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Prj_IP_FIFO PORT MAP (
          Data_In_Top  => Data_In_Top,
          Data_Out_Top => Data_Out_Top,
          CLK_TOP      => CLK_TOP,
          Rst_TOP      => Rst_TOP,
          wr_en_TOP    => wr_en_TOP,
          rd_en_TOP    => rd_en_TOP,
          full_TOP     => full_TOP,
          empty_TOP    => empty_TOP
        );

   -- Stimulus process
   stim_proc: process
   begin		
     
      wait for 1 ns;	
if full_TOP <= '0'	then
		Rst_TOP  <='1';
	for i in 0 to 16 loop
      wr_en_TOP     <= '1';
		CLK_TOP       <= '1';	
      wait for CLK_TOP_period/4;			
		Data_In_Top     <= to_unsigned (i,8);
		wait for CLK_TOP_period/4;
		CLK_TOP       <= '0';
		wait for CLK_TOP_period/2;
		wr_en_TOP     <= '0';
	end loop;
end if;

if full_TOP <= '1'	then	
	for i in 0 to 16 loop
      wr_en_TOP      <= '0';
		rd_en_TOP      <= '1';
		CLK_TOP        <= '1';	
      wait for CLK_TOP_period/4;			
		CLK_TOP <= '0';
		wait for CLK_TOP_period/4;
		rd_en_TOP      <= '0';
	end loop;
end if;		
    --end loop;
	 
	 
    end process;

END;
