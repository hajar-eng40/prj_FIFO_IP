library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use Ieee.numeric_std.ALL;


entity Prj_IP_FIFO is
    Port ( 
	      Data_In_Top  : in   unsigned (7 downto 0);
        Data_Out_Top : out  unsigned (7 downto 0);
			  CLK_TOP      : in  STD_LOGIC ;
			  Rst_TOP      : in  STD_LOGIC ;
			  wr_en_TOP    : in  STD_LOGIC ;
			  rd_en_TOP    : in  STD_LOGIC ;
			  full_TOP     : out STD_LOGIC ;
			  empty_TOP    : out STD_LOGIC 
			  );
end Prj_IP_FIFO;

architecture Behavioral of Prj_IP_FIFO is

COMPONENT FIFO_IP
  PORT (
    clk   : IN  STD_LOGIC;
    rst   : IN  STD_LOGIC;
    din   : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
    wr_en : IN  STD_LOGIC;
    rd_en : IN  STD_LOGIC;
    dout  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    full  : OUT STD_LOGIC;
    empty : OUT STD_LOGIC
  );
  
END COMPONENT;

signal Data_Out_sig  : STD_LOGIC_VECTOR (7 downto 0):= (others => '0');
signal Full_sig      : STD_LOGIC;
signal empty_sig     : STD_LOGIC;
signal wr_en_sig     : STD_LOGIC;
signal rd_en_sig     : STD_LOGIC;
--signal rst_en        : STD_LOGIC;

begin

instance_FIFO_IP : FIFO_IP
  PORT MAP (
    clk    =>  CLK_TOP,
    rst    =>  Rst_TOP ,
    din    =>  std_logic_vector (Data_In_Top),
    wr_en  =>  wr_en_TOP,
    rd_en  =>  rd_en_TOP,
    dout   =>  Data_Out_sig,
    full   =>  Full_sig,
    empty  =>  empty_sig
  );
  
process (CLK_TOP)
begin
--
if rising_edge (CLK_TOP) then 
   full_TOP    <=  Full_sig  ;
   empty_TOP   <=  empty_sig ;
	Data_Out_Top <= unsigned (Data_Out_sig );
	

end if;
end process ;	
end Behavioral;

