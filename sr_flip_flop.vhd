----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    06:52:44 09/22/2023 
-- Design Name: 
-- Module Name:    sr_flip_flop - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sr_flip_flop is
    port(
        s,r,clk,clr : in std_logic;
        q : out std_logic
    );
end sr_flip_flop;

architecture Behavioral of sr_flip_flop is

begin

    sync_process: process(clr,clk)
        begin
            if(clr ='1') then 
                q <= '0';
            elsif(rising_edge(clk)) then
                if(s = '1') then
                    q <= '1';
                elsif(r = '1') then
                    q <= '0';
                end if;
            end if;
        end process sync_process;

end Behavioral;

