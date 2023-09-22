----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:40:50 09/22/2023 
-- Design Name: 
-- Module Name:    counter_10 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
    use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter_10 is
    port (
        input : in std_logic_vector(9 downto 0);
        clk,clr, load, count : in std_logic;
        output : out std_logic_vector(9 downto 0)
    );
end counter_10;

architecture Behavioral of counter_10 is
    signal zero : std_logic_vector(9 downto 0);
    signal number: std_logic_vector(9 downto 0);
begin
   zero <= "0000000000";

sync_process:  process(clr,clk,input)


        begin
        

            if(clr = '1') then
                number <= zero;
            elsif(rising_edge(clk)) then
                if(load = '1') then
                   number <= input;
						 elsif( count = '1') then
							number <= number + "0000000001";
						end if;
            end if;
    end process sync_process;
	 
	output <= number;

  

end Behavioral;

