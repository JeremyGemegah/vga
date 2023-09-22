----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:54:22 09/22/2023 
-- Design Name: 
-- Module Name:    vga_1 - Behavioral 
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

entity vga_1 is
    port(
        clk, clr, red, blue, green : in std_logic;
        h_sync_out, v_sync_out, red_out, blue_out , green_out: out std_logic;
        column_out, row_out: out std_logic_vector(9 downto 0)
    );
end vga_1;

architecture Behavioral of vga_1 is

-------------------------------------------------------------------
---------------------------Declaration of Components---------------

    component sync_count is
        port(
            clr, clk : in std_logic;
            threshold_1, threshold_2, threshold_3, threshold_4: in std_logic_vector( 9 downto 0);
            state_1, state_2, state_3, state_4, roll_over: out std_logic
        );
    end component;


    component FSM is
        port(
            clk,clr,b,bc,bcd, bcde : in std_logic;
            sync,data_on: out std_logic
        );
    end component;

    component counter_10 is
        port (
            input : in std_logic_vector(9 downto 0);
            clk,clr, load, count : in std_logic;
            output : out std_logic_vector(9 downto 0)
        );
    end component;


---------------------------------------------------------------------------
--------------------Declaration of Signals---------------------------------

signal h_data_on,v_data_on,h_roll_over,v_roll_over,b,bc,bcd,bcde,p,pq,pqr,pqrs:  std_logic;
signal f_95,f_140,f_780,f_800,f_2,f_34,f_514,f_528, zero: std_logic_vector(9 downto 0);

begin


----------------------------------------------------------------------------
-------------------Asigning of signals--------------------------------------

    zero <= "0000000000";
    f_95 <= "0001011111";
    f_140 <="0010001100";
    f_780 <="1100001100";
    f_800 <= "1100100000";
    f_2 <= "0000000010";
    f_34 <="0000100010";
    f_514 <="1000000010";
    f_528 <="1000010000";



----------------------------------------------------------------------------
-------------------Instantiating of components------------------------------



    h_count : sync_count port map(
        clr => clr,
        clk => clk,
        threshold_1 =>f_95,
        threshold_2 =>f_140,
        threshold_3 =>f_780,
        threshold_4 =>f_800,
        state_1 =>b,
        state_2 =>bc,
        state_3 =>bcd,
        state_4 =>bcde,
        roll_over =>h_roll_over
    );

    v_count : sync_count port map(
        clr => clr,
        clk => h_roll_over,
        threshold_1 =>f_2,
        threshold_2 =>f_34,
        threshold_3 =>f_514,
        threshold_4 =>f_528,
        state_1 =>p,
        state_2 =>pq,
        state_3 =>pqr,
        state_4 =>pqrs,
        roll_over =>v_roll_over
    );

    horizontal_fsm: fsm port map(
        clk => clk,
        clr => clr,
        b =>b,
        bc =>bc,
        bcd =>bcd,
        bcde =>bcde,
        sync => h_sync_out,
        data_on => h_data_on

    );


    vertical_fsm: fsm port map(
        clk => clk,
        clr => clr,
        b =>p,
        bc =>pq,
        bcd =>pqr,
        bcde =>pqrs,
        sync => v_sync_out,
        data_on => v_data_on 
    );


    column_count: counter_10 port map(
        input => zero,
        clk => clk,
        clr => clr,
        load => bcde,
        count => h_data_on,
        output => column_out
    );


    row_count: counter_10 port map(
        input => zero,
        clk => h_roll_over,
        clr => clr,
        load => v_roll_over,
        count => v_data_on,
        output => row_out
    );

    red_out <= h_data_on and v_data_on and red;
    blue_out <= h_data_on and v_data_on and blue;
    green_out <= h_data_on and v_data_on and green;




end Behavioral;

