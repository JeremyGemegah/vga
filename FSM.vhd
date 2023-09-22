----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:05:13 09/22/2023 
-- Design Name: 
-- Module Name:    FSM - Behavioral 
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

entity FSM is
    port(
        clk,clr,b,bc,bcd, bcde : in std_logic;
        sync,data_on: out std_logic
    );
end FSM;

architecture Behavioral of FSM is

    type state_type is (st0, st1, st2, st3);
    signal ps,ns: state_type;

begin

sync_process: process(clk, clr,ns)
    begin
        if(clr = '1') then
            ps <= st0;
        elsif(rising_edge(clk)) then
            ps <= ns;
        end if;
        end process sync_process;
 
comb_process: process(ps,b,bc,bcd,bcde)
            begin
                data_on <= '0';
                sync <= '0';
                case ps is 
                    when st0 =>
                        data_on <= '0';
                        sync <= '0';
                        if(b ='1') then
                            ns <= st1;
                        else
                            ns <= st0;
                                         
                        end if ;
                    when st1 => 
                            data_on <= '0';
                            sync <= '1';
                            if(bc ='1') then
                                ns <= st2;
                                else
                                ns <= st1;
                            end if;
                    when st2 => 
                                data_on <= '1';
                                sync <= '1';
                                if(bcd ='1') then 
                                    ns <= st3;
                                else
                                    ns <= st2;
                                end if;
                    when st3 => 
                                data_on <= '0';
                                sync <= '1';
                                if(bcde ='1') then
                                    ns <= st0;
                                else
                                    ns <= st3;
                                end if;

                    when others =>
                                    ns <= st0;
                    end case;
						  
				end process comb_process;

end Behavioral;

