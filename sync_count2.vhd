----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    07:05:48 09/22/2023 
-- Design Name: 
-- Module Name:    sync_count2 - Behavioral 
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

entity sync_count2 is
    port(
        clr, clk : in std_logic;
        threshold_1, threshold_2, threshold_3, threshold_4: in std_logic_vector( 9 downto 0);
        state_1, state_2, state_3, state_4, roll_over: out std_logic;
        output : out std_logic_vector(9 downto 0)
    );
end sync_count2;

architecture Behavioral of sync_count2 is

    component counter_10 is
        port (
            input : in std_logic_vector(9 downto 0);
            clk,clr, load, count : in std_logic;
            output : out std_logic_vector(9 downto 0)
        );
    end component;

    signal last_state: std_logic;
    signal count : std_logic_vector(9 downto 0);

begin

    counter: counter_10 port map(
        input => "0000000000",
        clk => clk,
        clr => clr,
        load => last_state,
        count => '1',
        output => count
    );

    last_state <= '1' when (count = threshold_4) else
        '0';

        roll_over <= last_state;
        state_4 <= last_state;

        state_1 <= '1' when (count = threshold_1) else
            '0';

        state_2 <= '1' when (count = threshold_2) else
            '0';

        state_3 <= '1' when (count = threshold_3) else
            '0';

        output <= count;


end Behavioral;

