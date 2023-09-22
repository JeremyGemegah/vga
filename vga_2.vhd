----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    07:11:24 09/22/2023 
-- Design Name: 
-- Module Name:    vga_2 - Behavioral 
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

entity vga_2 is
    port(
        clk,clr,red,green,blue : in std_logic;
        h_sync_out,v_sync_out, red_out,green_out, blue_out: out std_logic;
        column_out,row_out: out std_logic_vector(9 downto 0)
    );
end vga_2;

architecture Behavioral of vga_2 is

----------------------------------------------------------------------------------------------
------------------------------Declaration of components---------------------------------------

component sync_count2 is
    port(
        clr, clk : in std_logic;
        threshold_1, threshold_2, threshold_3, threshold_4: in std_logic_vector( 9 downto 0);
        state_1, state_2, state_3, state_4, roll_over: out std_logic;
        output : out std_logic_vector(9 downto 0)
    );
end component;

component sr_flip_flop is
    port(
        s,r,clk,clr : in std_logic;
        q : out std_logic
    );
end component;


----------------------------------------------------------------------------------------------
------------------------------Declaration of signals------------------------------------------

signal h_data_on,v_data_on, roll_over,d,de,deb,debc,r,rs,rsp,rspq: std_logic;
signal f_640,f_660,f_755,f_800,f_480,f_494,f_496,f_528: std_logic_vector(9 downto 0);

begin

----------------------------------------------------------------------------------------------
------------------------------Asigning of Signals---------------------------------------------

f_528 <= "1000010000";
f_496 <= "0111110000";
f_494 <= "0111101110";
f_480 <= "0111100000";
f_640 <= "1010000000";
f_660 <= "1010010100";
f_755 <= "1011110011";
f_800 <= "1100100000";



h_count : sync_count2 port map(
    clr => clr,
    clk => clk,
    threshold_1 =>f_640,
    threshold_2 =>f_660,
    threshold_3 =>f_755,
    threshold_4 =>f_800,
    state_1 =>d,
    state_2 =>de,
    state_3 =>deb,
    state_4 =>debc,
    roll_over =>roll_over,
    output => column_out
);

v_count : sync_count2 port map(
    clr => clr,
    clk => roll_over,
    threshold_1 =>f_480,
    threshold_2 =>f_494,
    threshold_3 =>f_496,
    threshold_4 =>f_528,
    state_1 =>r,
    state_2 =>rs,
    state_3 =>rsp,
    state_4 =>rspq,
    output => row_out,
    roll_over => open
);

h_sync_out_register: sr_flip_flop port map(
    s => deb,
    clk => clk,
    clr => clr,
    r => de,
    q => h_sync_out
);


v_sync_out_register: sr_flip_flop port map(
    s => rsp,
    clk => roll_over,
    clr => clr,
    r => rs,
    q => v_sync_out
);


h_data_on_register: sr_flip_flop port map(
    s => debc,
    clk => clk,
    clr => clr,
    r => d,
    q => h_data_on
);



v_data_on_register: sr_flip_flop port map(
    s => rspq,
    clk => clk,
    clr => clr,
    r => r,
    q => v_data_on
    
);

red_out <= h_data_on and v_data_on and red;
blue_out <= h_data_on and v_data_on and blue;
green_out <= h_data_on and v_data_on and green;


end Behavioral;

