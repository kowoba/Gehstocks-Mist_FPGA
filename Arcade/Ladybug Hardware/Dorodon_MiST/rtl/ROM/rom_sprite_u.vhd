library ieee;
use ieee.std_logic_1164.all,ieee.numeric_std.all;

entity rom_sprite_u is
port (
	clk  : in  std_logic;
	addr : in  std_logic_vector(11 downto 0);
	data : out std_logic_vector(7 downto 0)
);
end entity;

architecture prom of rom_sprite_u is
	type rom is array(0 to  4095) of std_logic_vector(7 downto 0);
	signal rom_data: rom := (
		X"00",X"00",X"00",X"00",X"00",X"0A",X"00",X"AA",X"02",X"AA",X"0A",X"AA",X"0A",X"AA",X"0A",X"AA",
		X"00",X"00",X"00",X"00",X"A8",X"00",X"AB",X"00",X"AB",X"C0",X"AB",X"C0",X"AA",X"C0",X"AA",X"E0",
		X"02",X"AA",X"0A",X"AA",X"0A",X"AA",X"02",X"AA",X"00",X"AA",X"00",X"0A",X"00",X"00",X"00",X"00",
		X"AA",X"00",X"AA",X"80",X"96",X"80",X"56",X"80",X"5A",X"00",X"A8",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"0A",X"00",X"AA",X"02",X"AA",X"02",X"AE",X"0A",X"BA",X"0A",X"BA",
		X"00",X"00",X"00",X"80",X"AA",X"A0",X"AA",X"20",X"AA",X"00",X"AA",X"00",X"BA",X"00",X"EA",X"00",
		X"0A",X"BA",X"0A",X"BA",X"0A",X"3A",X"0A",X"3A",X"00",X"3A",X"00",X"0A",X"00",X"00",X"00",X"00",
		X"EA",X"00",X"EA",X"00",X"EA",X"00",X"3A",X"00",X"3A",X"00",X"0A",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"1A",X"02",X"95",X"05",X"5B",X"06",X"DA",X"36",X"95",
		X"C0",X"00",X"CC",X"00",X"F3",X"C0",X"FF",X"00",X"7F",X"F0",X"6F",X"C0",X"57",X"F0",X"6C",X"00",
		X"25",X"5B",X"16",X"DA",X"36",X"95",X"25",X"5B",X"06",X"DA",X"02",X"94",X"00",X"00",X"00",X"00",
		X"68",X"00",X"54",X"00",X"70",X"00",X"60",X"00",X"40",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"AA",X"02",X"BA",X"02",X"AA",X"0A",X"AB",X"0A",X"EA",X"0A",X"AA",
		X"00",X"00",X"00",X"00",X"80",X"00",X"A8",X"00",X"A8",X"00",X"AA",X"00",X"A6",X"00",X"A5",X"00",
		X"0A",X"AE",X"0B",X"AA",X"0A",X"AA",X"02",X"EA",X"02",X"AE",X"00",X"AA",X"00",X"00",X"00",X"00",
		X"96",X"00",X"A6",X"00",X"AA",X"00",X"A8",X"00",X"A8",X"00",X"80",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"0A",X"00",X"AA",X"02",X"AA",X"02",X"AA",X"0A",X"AA",X"0A",X"AA",
		X"00",X"00",X"2A",X"00",X"AA",X"00",X"AA",X"80",X"AA",X"80",X"AA",X"80",X"AA",X"80",X"AE",X"80",
		X"0A",X"AA",X"0A",X"AA",X"0A",X"AA",X"0A",X"AA",X"02",X"AA",X"02",X"80",X"00",X"00",X"00",X"00",
		X"AE",X"00",X"BA",X"00",X"A8",X"00",X"A0",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"2A",X"00",X"A2",X"02",X"AA",X"02",X"8A",X"0A",X"AA",
		X"00",X"00",X"00",X"00",X"30",X"00",X"BC",X"30",X"AC",X"C0",X"BF",X"00",X"AB",X"C0",X"AB",X"B0",
		X"08",X"A8",X"0A",X"AA",X"0A",X"2A",X"0A",X"A8",X"02",X"AA",X"00",X"00",X"00",X"00",X"00",X"00",
		X"AA",X"80",X"A2",X"80",X"AA",X"00",X"A8",X"00",X"80",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"AA",X"0A",X"95",X"0A",X"66",X"29",X"5A",X"26",X"A5",X"26",X"99",
		X"00",X"00",X"00",X"00",X"80",X"00",X"A8",X"00",X"58",X"20",X"9A",X"20",X"A6",X"A0",X"66",X"20",
		X"2A",X"56",X"25",X"69",X"0A",X"A9",X"0A",X"55",X"02",X"9A",X"00",X"2A",X"00",X"00",X"00",X"00",
		X"9A",X"00",X"9A",X"00",X"66",X"00",X"A8",X"00",X"A0",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"03",X"0A",X"BC",X"2A",X"A0",X"2A",X"A0",X"2A",X"A0",
		X"00",X"00",X"00",X"00",X"3F",X"F0",X"C0",X"C0",X"03",X"00",X"03",X"00",X"0C",X"00",X"0C",X"00",
		X"2A",X"A0",X"0A",X"82",X"00",X"02",X"00",X"02",X"00",X"02",X"00",X"00",X"00",X"00",X"00",X"00",
		X"AC",X"00",X"AA",X"00",X"AA",X"00",X"AA",X"00",X"AA",X"00",X"A8",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"03",X"FC",X"0F",X"FF",X"3F",X"FF",X"3F",X"FF",X"3F",X"FF",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"F0",X"00",X"FF",X"00",X"FF",X"C0",
		X"3F",X"FF",X"3F",X"FF",X"3F",X"7F",X"0F",X"D7",X"03",X"FF",X"00",X"00",X"00",X"00",X"00",X"00",
		X"FF",X"C0",X"FE",X"A0",X"FF",X"20",X"F0",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"02",X"00",X"02",X"00",X"29",X"00",X"AA",X"00",X"AA",X"02",X"69",
		X"00",X"00",X"A0",X"C0",X"A8",X"C0",X"AB",X"F0",X"AF",X"30",X"6A",X"00",X"AA",X"80",X"AA",X"A0",
		X"0A",X"A6",X"0A",X"AA",X"02",X"9A",X"0A",X"A2",X"0A",X"A0",X"02",X"80",X"00",X"00",X"00",X"00",
		X"9A",X"60",X"A6",X"80",X"AA",X"80",X"8A",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"25",X"02",X"95",X"02",X"55",X"0A",X"95",X"0A",X"FF",X"03",X"55",
		X"00",X"00",X"00",X"00",X"50",X"00",X"55",X"00",X"55",X"00",X"55",X"40",X"55",X"40",X"D5",X"40",
		X"0A",X"55",X"09",X"55",X"0A",X"55",X"0A",X"95",X"02",X"A5",X"00",X"95",X"00",X"00",X"00",X"00",
		X"55",X"40",X"55",X"40",X"55",X"40",X"55",X"00",X"55",X"00",X"50",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"03",X"00",X"3F",X"00",X"FA",X"03",X"EA",X"03",X"AA",X"0F",X"A8",X"0E",X"8A",
		X"00",X"00",X"FF",X"00",X"AB",X"C0",X"8A",X"00",X"AA",X"00",X"88",X"00",X"A8",X"00",X"A0",X"00",
		X"0E",X"A8",X"0E",X"AA",X"0F",X"A2",X"03",X"AA",X"03",X"EA",X"00",X"F8",X"00",X"3C",X"00",X"00",
		X"A0",X"00",X"80",X"00",X"80",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"AA",X"02",X"AA",X"02",X"AA",X"0A",X"AA",X"0A",X"AA",X"0A",X"AA",X"0A",X"AA",
		X"00",X"00",X"A0",X"00",X"A8",X"00",X"E8",X"00",X"BB",X"00",X"BF",X"00",X"BF",X"00",X"FC",X"00",
		X"0A",X"AA",X"0A",X"AA",X"0A",X"5A",X"02",X"56",X"02",X"96",X"00",X"AA",X"00",X"00",X"00",X"00",
		X"BC",X"00",X"BF",X"00",X"BB",X"00",X"EB",X"00",X"A8",X"00",X"A0",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"2A",X"02",X"AA",X"0A",X"AA",X"0A",X"AA",X"0A",X"AA",
		X"00",X"00",X"00",X"00",X"00",X"00",X"A0",X"10",X"AA",X"50",X"A9",X"40",X"AA",X"00",X"AA",X"00",
		X"0A",X"AA",X"0B",X"AA",X"0B",X"EA",X"02",X"AA",X"00",X"AA",X"00",X"00",X"00",X"00",X"00",X"00",
		X"A8",X"00",X"A8",X"00",X"A0",X"00",X"80",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"0F",X"00",X"FF",X"03",X"FF",X"03",X"FD",X"03",X"F4",
		X"00",X"00",X"00",X"00",X"00",X"C0",X"F0",X"F0",X"FF",X"FC",X"7F",X"C0",X"5F",X"C0",X"A7",X"F0",
		X"03",X"F6",X"03",X"DA",X"00",X"DA",X"00",X"D2",X"00",X"DA",X"00",X"1A",X"00",X"01",X"00",X"00",
		X"A9",X"F0",X"29",X"F0",X"91",X"F0",X"A9",X"70",X"6A",X"40",X"8A",X"00",X"A4",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"02",X"A8",X"0A",X"AA",X"2A",X"AA",X"2A",X"AA",X"2A",X"AA",X"2A",X"AA",
		X"00",X"00",X"00",X"00",X"00",X"00",X"80",X"00",X"A8",X"00",X"AA",X"00",X"AA",X"80",X"AA",X"80",
		X"2A",X"AA",X"2A",X"AA",X"2A",X"EA",X"0A",X"BE",X"02",X"AA",X"00",X"00",X"00",X"00",X"00",X"00",
		X"A9",X"50",X"AA",X"10",X"AA",X"00",X"A8",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"FF",X"00",X"BF",X"02",X"AF",X"02",X"AF",X"02",X"AF",X"02",X"AF",
		X"00",X"00",X"00",X"00",X"00",X"00",X"F0",X"00",X"FC",X"00",X"FF",X"00",X"FF",X"00",X"FF",X"C0",
		X"02",X"AF",X"02",X"AF",X"02",X"AF",X"02",X"AE",X"00",X"BF",X"00",X"FF",X"00",X"00",X"00",X"00",
		X"FF",X"C0",X"FF",X"00",X"EF",X"00",X"BC",X"00",X"F0",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"03",X"00",X"FF",X"03",X"FA",X"03",X"E8",X"0F",X"EA",X"0F",X"A2",
		X"00",X"00",X"00",X"00",X"E8",X"00",X"AA",X"00",X"AA",X"00",X"8A",X"80",X"52",X"80",X"5A",X"80",
		X"0F",X"A9",X"0F",X"A1",X"0F",X"A8",X"03",X"AA",X"03",X"EA",X"00",X"3A",X"00",X"00",X"00",X"00",
		X"62",X"80",X"6A",X"00",X"8A",X"00",X"A8",X"00",X"A8",X"00",X"80",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"0F",X"C0",X"3F",X"F0",X"3F",X"FC",X"3F",X"3C",X"3C",X"0F",X"3F",X"3F",X"0F",X"FF",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"0F",X"FF",X"3F",X"3F",X"3C",X"0F",X"3F",X"3C",X"3F",X"FC",X"3F",X"F0",X"3F",X"C0",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"03",X"FF",X"3F",X"EF",X"3F",X"AB",X"7B",X"AB",X"0E",X"AB",X"02",X"AB",
		X"00",X"00",X"00",X"00",X"C0",X"00",X"FC",X"00",X"CF",X"00",X"03",X"00",X"CF",X"C0",X"FF",X"C0",
		X"02",X"AB",X"0E",X"AB",X"3E",X"AB",X"3F",X"AB",X"3F",X"EF",X"03",X"FF",X"00",X"00",X"00",X"00",
		X"FF",X"C0",X"CF",X"C0",X"03",X"00",X"CF",X"00",X"FC",X"00",X"C0",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"FF",X"0F",X"FE",X"3F",X"EA",X"3F",X"AA",X"0F",X"AA",X"03",X"AA",
		X"00",X"00",X"00",X"00",X"F0",X"00",X"BF",X"00",X"AF",X"F0",X"AF",X"30",X"AC",X"0C",X"AB",X"3C",
		X"03",X"AA",X"0F",X"AA",X"3F",X"AA",X"3F",X"EA",X"0F",X"FE",X"00",X"FF",X"00",X"00",X"00",X"00",
		X"AB",X"3C",X"AC",X"0C",X"AF",X"30",X"AF",X"F0",X"BF",X"00",X"F0",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"03",X"FF",X"3F",X"EA",X"3F",X"AA",X"3F",X"AA",X"0E",X"AA",X"0E",X"AA",
		X"00",X"00",X"00",X"00",X"F0",X"00",X"AF",X"00",X"AB",X"C0",X"AA",X"30",X"AA",X"30",X"AA",X"F0",
		X"0E",X"AA",X"0E",X"AA",X"3F",X"AA",X"3F",X"AA",X"3F",X"EA",X"03",X"FF",X"00",X"00",X"00",X"00",
		X"AA",X"F0",X"AA",X"30",X"AA",X"30",X"AB",X"C0",X"AF",X"00",X"F0",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"03",X"FF",X"3F",X"EA",X"3F",X"AA",X"3F",X"AA",X"0E",X"AA",X"0E",X"AA",
		X"00",X"00",X"00",X"00",X"F0",X"00",X"AF",X"00",X"AB",X"C0",X"AA",X"30",X"AA",X"30",X"AA",X"F0",
		X"0E",X"AA",X"0E",X"AA",X"3F",X"AA",X"3F",X"AA",X"3F",X"EA",X"03",X"FF",X"00",X"00",X"00",X"00",
		X"AA",X"F0",X"AA",X"30",X"AA",X"30",X"AB",X"C0",X"AF",X"00",X"F0",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"03",X"FC",X"0F",X"FF",X"3F",X"EB",X"3F",X"AB",X"3E",X"AB",X"0E",X"AA",X"0E",X"AA",
		X"00",X"00",X"00",X"00",X"C0",X"00",X"F0",X"00",X"CC",X"00",X"03",X"00",X"CF",X"00",X"FF",X"00",
		X"0E",X"AA",X"0E",X"AA",X"3E",X"AB",X"3F",X"AB",X"3F",X"EB",X"0F",X"FF",X"03",X"FC",X"00",X"00",
		X"FF",X"00",X"CF",X"00",X"03",X"00",X"CC",X"00",X"F0",X"00",X"C0",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"03",X"FC",X"0F",X"BF",X"3F",X"EF",X"3F",X"AF",X"3F",X"BF",X"0F",X"AF",X"03",X"EF",
		X"00",X"00",X"00",X"00",X"C0",X"00",X"F0",X"00",X"FC",X"00",X"CF",X"00",X"03",X"00",X"CF",X"00",
		X"03",X"EF",X"0F",X"AF",X"3F",X"BF",X"3F",X"AF",X"3F",X"EF",X"0F",X"BF",X"03",X"FC",X"00",X"00",
		X"CF",X"00",X"03",X"00",X"CF",X"00",X"FC",X"00",X"F0",X"00",X"C0",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"03",X"F0",X"0E",X"BC",X"3F",X"BF",X"3E",X"BF",X"3E",X"FC",X"0E",X"B0",X"0F",X"BC",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"C0",X"00",X"F0",X"00",X"30",X"00",X"F0",X"00",
		X"0F",X"BC",X"0E",X"B0",X"3E",X"FC",X"3E",X"BF",X"3F",X"BF",X"0E",X"BC",X"03",X"F0",X"00",X"00",
		X"F0",X"00",X"30",X"00",X"F0",X"00",X"C0",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"0B",X"C0",X"3A",X"F0",X"3E",X"F8",X"3A",X"FC",X"3B",X"CF",X"0A",X"03",X"0E",X"CF",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"0E",X"CF",X"0A",X"03",X"3B",X"CF",X"3A",X"FC",X"3E",X"FC",X"3A",X"F0",X"0B",X"C0",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"08",X"02",X"0B",X"02",X"3A",X"02",X"3E",X"00",X"33",X"00",X"F0",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"CC",X"00",X"CC",X"00",X"C0",X"C0",X"C0",X"C0",
		X"0C",X"C0",X"0C",X"CC",X"0E",X"0C",X"02",X"0C",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"23",X"00",X"2B",X"00",X"08",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"30",X"32",X"30",X"F2",X"30",X"C2",X"3C",X"C2",X"0F",X"0F",X"0E",X"0F",
		X"00",X"00",X"00",X"00",X"00",X"00",X"0C",X"C0",X"CC",X"C0",X"83",X"C0",X"83",X"00",X"8B",X"00",
		X"0E",X"3C",X"02",X"30",X"00",X"00",X"00",X"C3",X"00",X"03",X"00",X"00",X"00",X"00",X"00",X"00",
		X"FE",X"00",X"3A",X"00",X"38",X"00",X"08",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"30",X"00",X"30",X"0C",X"8C",X"0C",X"8C",X"0F",X"C2",X"33",X"CA",
		X"00",X"00",X"C2",X"00",X"C2",X"00",X"8A",X"00",X"A8",X"C0",X"AC",X"C0",X"3F",X"C0",X"08",X"C0",
		X"33",X"C8",X"32",X"C8",X"0A",X"3C",X"08",X"33",X"00",X"30",X"00",X"00",X"00",X"00",X"00",X"00",
		X"C8",X"00",X"C8",X"00",X"EC",X"00",X"2C",X"00",X"20",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"C0",X"03",X"B0",X"03",X"B0",X"0C",X"BC",X"3B",X"33",X"3B",X"33",X"CC",X"EF",
		X"00",X"00",X"08",X"00",X"38",X"00",X"32",X"C0",X"E2",X"F0",X"EE",X"30",X"AF",X"80",X"3C",X"80",
		X"CC",X"EB",X"F8",X"FB",X"CB",X"38",X"C8",X"08",X"20",X"02",X"00",X"00",X"00",X"00",X"00",X"00",
		X"0B",X"00",X"CB",X"00",X"C8",X"00",X"F0",X"00",X"C0",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"30",X"00",X"F3",X"23",X"EF",X"2F",X"AF",X"3F",X"AF",X"FF",X"AF",X"FB",X"FF",
		X"03",X"C0",X"CF",X"80",X"FF",X"B0",X"FF",X"B0",X"FE",X"F0",X"EE",X"C0",X"EF",X"C0",X"EB",X"00",
		X"EB",X"FE",X"EB",X"FE",X"EF",X"3E",X"2C",X"0B",X"0C",X"03",X"00",X"00",X"00",X"00",X"00",X"00",
		X"EB",X"00",X"F8",X"00",X"F0",X"00",X"B0",X"00",X"80",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"03",X"00",X"0B",X"0F",X"FE",X"3E",X"BE",X"3B",X"EF",X"2F",X"FF",X"FF",X"FF",X"FB",X"FF",
		X"F0",X"00",X"FC",X"00",X"FE",X"00",X"FE",X"F0",X"FE",X"F0",X"EF",X"F0",X"EF",X"F0",X"BF",X"F0",
		X"FE",X"FB",X"FE",X"FE",X"3F",X"FE",X"0F",X"FC",X"0F",X"F0",X"03",X"C0",X"00",X"00",X"00",X"00",
		X"FE",X"80",X"FF",X"80",X"FF",X"00",X"FF",X"00",X"3C",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"3C",X"0C",X"FA",X"3E",X"BE",X"FF",X"BF",X"FF",X"FF",X"BF",X"FF",
		X"00",X"00",X"00",X"00",X"FC",X"00",X"FA",X"00",X"FE",X"C0",X"FF",X"C0",X"EF",X"C0",X"AE",X"00",
		X"AF",X"EF",X"3F",X"FB",X"3E",X"FB",X"3A",X"FC",X"00",X"F0",X"00",X"00",X"00",X"00",X"00",X"00",
		X"FE",X"00",X"FC",X"00",X"FC",X"00",X"AC",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"FC",X"3C",X"FF",X"3F",X"AF",X"3F",X"EF",X"EF",X"FE",X"FE",X"FF",X"FF",X"FF",
		X"00",X"00",X"00",X"00",X"E0",X"00",X"EC",X"00",X"FC",X"00",X"BC",X"00",X"B0",X"00",X"C0",X"00",
		X"EF",X"FB",X"EB",X"EF",X"3F",X"CF",X"0F",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"C0",X"00",X"C0",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"3C",X"F0",X"FF",X"EC",X"FE",X"BB",X"BF",X"BF",X"FF",X"FF",X"FF",X"FF",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"C0",X"00",X"C0",X"00",X"F0",X"00",X"F0",X"00",
		X"FB",X"EF",X"FF",X"AF",X"3F",X"FF",X"3F",X"CF",X"0F",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"80",X"00",X"80",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"AA",X"AF",X"AA",X"AF",X"AA",X"AF",X"AA",X"AF",X"AA",X"AF",X"AA",X"AF",X"AA",X"03",X"AA",X"80",
		X"FF",X"75",X"FF",X"75",X"FD",X"57",X"FD",X"5F",X"FF",X"FD",X"FF",X"DD",X"FF",X"DD",X"FD",X"55",
		X"AA",X"A0",X"AA",X"A0",X"AA",X"A0",X"AA",X"80",X"AA",X"80",X"AA",X"00",X"A8",X"00",X"00",X"00",
		X"FC",X"00",X"3F",X"FF",X"03",X"FF",X"00",X"3F",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FE",X"BF",X"FA",X"AF",X"EA",X"AF",
		X"7F",X"FC",X"5F",X"FF",X"DF",X"FF",X"DF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"EA",X"AB",X"EA",X"AB",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"2A",X"AA",X"02",X"AA",X"00",X"0A",
		X"FE",X"BF",X"EA",X"AF",X"AA",X"A8",X"AA",X"A8",X"AA",X"A8",X"AA",X"A0",X"AA",X"80",X"A8",X"00",
		X"03",X"FF",X"03",X"FF",X"0F",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FE",X"FF",X"EA",X"FF",X"AA",
		X"FC",X"00",X"F8",X"00",X"FA",X"00",X"EA",X"80",X"AA",X"80",X"AA",X"A0",X"AA",X"A0",X"AA",X"A8",
		X"FA",X"AA",X"0A",X"AA",X"02",X"AA",X"00",X"AA",X"00",X"0A",X"00",X"00",X"00",X"00",X"00",X"00",
		X"AA",X"A8",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"A8",X"AA",X"A8",X"0A",X"80",X"00",X"00",
		X"AA",X"AF",X"AA",X"AF",X"AA",X"AF",X"00",X"03",X"00",X"03",X"00",X"03",X"00",X"00",X"00",X"00",
		X"FD",X"55",X"FF",X"57",X"FF",X"FF",X"FF",X"77",X"FD",X"FD",X"FD",X"FD",X"FD",X"55",X"FF",X"57",
		X"00",X"00",X"00",X"00",X"00",X"03",X"00",X"03",X"00",X"03",X"AA",X"AF",X"AA",X"AF",X"AA",X"AF",
		X"FF",X"FF",X"FD",X"FF",X"FD",X"FF",X"FD",X"55",X"FD",X"55",X"FF",X"FF",X"FD",X"5F",X"FD",X"57",
		X"FF",X"FD",X"FF",X"F5",X"FF",X"F7",X"FF",X"D7",X"FF",X"D7",X"FF",X"5F",X"FF",X"5F",X"FF",X"5F",
		X"FF",X"FC",X"FF",X"F0",X"FF",X"F0",X"FF",X"C0",X"FF",X"C0",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"5F",X"FF",X"5F",X"FF",X"5F",X"FF",X"D7",X"FF",X"D7",X"FF",X"F7",X"FF",X"F5",X"FF",X"FD",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"C3",X"FF",X"C0",X"FF",X"F0",X"FF",X"F0",X"FF",X"FC",
		X"03",X"FF",X"0F",X"FF",X"0F",X"FF",X"3F",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FC",X"00",X"FC",X"00",X"FC",X"00",X"FF",X"00",X"FF",X"00",X"FF",X"00",X"FF",X"00",X"FF",X"00",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"3F",X"FF",X"0F",X"FF",X"0F",X"FF",X"03",X"FF",
		X"FF",X"00",X"FF",X"00",X"FF",X"00",X"FF",X"00",X"FF",X"00",X"FC",X"00",X"FC",X"00",X"FC",X"00",
		X"00",X"00",X"A8",X"00",X"AA",X"00",X"AA",X"80",X"AA",X"80",X"AA",X"A0",X"AA",X"A0",X"AA",X"A0",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"3F",X"03",X"FF",X"3F",X"FF",X"FD",X"55",
		X"AA",X"80",X"AA",X"03",X"AA",X"AF",X"AA",X"AF",X"AA",X"AF",X"AA",X"AF",X"AA",X"AF",X"AA",X"AF",
		X"FF",X"5F",X"FF",X"D7",X"FD",X"55",X"FD",X"55",X"FF",X"FF",X"FF",X"57",X"FD",X"55",X"FD",X"FD",
		X"00",X"0A",X"02",X"AA",X"2A",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"EA",X"AB",X"EA",X"AB",
		X"A8",X"00",X"AA",X"80",X"AA",X"A0",X"AA",X"A8",X"AA",X"A8",X"AA",X"A8",X"EA",X"AF",X"FE",X"BF",
		X"EA",X"AF",X"FA",X"AF",X"FE",X"BF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"DF",X"FF",X"DF",X"FF",X"5F",X"FF",X"7F",X"FF",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"0A",X"00",X"AA",X"02",X"AA",X"0A",X"AA",X"FA",X"AA",
		X"00",X"00",X"0A",X"80",X"AA",X"A8",X"AA",X"A8",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"A8",
		X"FF",X"AA",X"FF",X"EA",X"FF",X"FE",X"FF",X"FF",X"FF",X"FF",X"0F",X"FF",X"03",X"FF",X"03",X"FF",
		X"AA",X"A8",X"AA",X"A0",X"AA",X"A0",X"AA",X"80",X"EA",X"80",X"FA",X"00",X"F8",X"00",X"FC",X"00",
		X"0A",X"AA",X"AA",X"AA",X"AA",X"AA",X"2A",X"AA",X"0A",X"AA",X"0A",X"AA",X"02",X"AA",X"00",X"AA",
		X"BF",X"FD",X"AF",X"FD",X"AB",X"F5",X"AB",X"F5",X"AA",X"FF",X"AA",X"BF",X"AA",X"BF",X"AA",X"3F",
		X"00",X"AA",X"00",X"2A",X"00",X"0A",X"00",X"0A",X"00",X"02",X"00",X"00",X"00",X"00",X"00",X"00",
		X"A8",X"35",X"AA",X"0F",X"AA",X"00",X"AA",X"80",X"AA",X"80",X"AA",X"80",X"AA",X"00",X"28",X"00",
		X"D7",X"F5",X"D7",X"F5",X"5F",X"FD",X"7F",X"FD",X"F7",X"FF",X"77",X"FF",X"77",X"FF",X"57",X"FF",
		X"55",X"FF",X"55",X"FF",X"55",X"FF",X"57",X"FF",X"5F",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"57",X"FF",X"FF",X"FF",X"FF",X"FF",X"0F",X"FF",X"00",X"AA",X"02",X"AA",X"02",X"AA",X"00",X"AA",
		X"FF",X"FA",X"FF",X"AA",X"FA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"A8",X"A8",X"00",
		X"F0",X"FF",X"F0",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FE",X"FF",X"EA",X"AF",X"2A",
		X"FC",X"00",X"FA",X"00",X"FA",X"80",X"EA",X"80",X"AA",X"80",X"AA",X"A0",X"AA",X"A0",X"AA",X"A0",
		X"A8",X"2A",X"A8",X"2A",X"A0",X"2A",X"A0",X"AA",X"80",X"AA",X"00",X"AA",X"00",X"AA",X"00",X"2A",
		X"AA",X"A0",X"AA",X"A0",X"AA",X"80",X"AA",X"80",X"AA",X"80",X"AA",X"00",X"A8",X"00",X"80",X"00",
		X"00",X"AA",X"00",X"0A",X"00",X"03",X"00",X"03",X"00",X"0F",X"00",X"0F",X"00",X"0F",X"00",X"0F",
		X"BF",X"F5",X"FF",X"FD",X"FF",X"FF",X"FF",X"FD",X"FF",X"F7",X"FF",X"F7",X"FF",X"F5",X"FF",X"FD",
		X"00",X"0F",X"00",X"0F",X"00",X"0F",X"00",X"0F",X"00",X"03",X"00",X"03",X"00",X"0A",X"00",X"AA",
		X"FF",X"FF",X"FF",X"F7",X"FF",X"F7",X"FF",X"F5",X"FF",X"F5",X"FF",X"FF",X"FF",X"F5",X"BF",X"F5",
		X"57",X"D5",X"5F",X"D5",X"FF",X"D5",X"DF",X"D5",X"F7",X"55",X"F7",X"55",X"57",X"55",X"5F",X"55",
		X"55",X"FF",X"57",X"FF",X"57",X"FF",X"5F",X"F0",X"5F",X"F0",X"7F",X"FF",X"7F",X"FF",X"7F",X"FF",
		X"FF",X"55",X"FF",X"55",X"FF",X"55",X"57",X"55",X"57",X"D5",X"FF",X"D5",X"7F",X"D5",X"5F",X"D5",
		X"7F",X"FF",X"7F",X"FF",X"7F",X"FF",X"5F",X"F0",X"5F",X"F0",X"57",X"FF",X"57",X"FF",X"55",X"FF",
		X"F3",X"FF",X"C3",X"FF",X"0F",X"FF",X"0F",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FC",X"00",X"FC",X"00",X"FC",X"00",X"FF",X"00",X"FF",X"00",X"FF",X"00",X"FF",X"00",X"FF",X"00",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"0F",X"FF",X"0F",X"FF",X"C3",X"FF",X"F3",X"FF",
		X"FF",X"00",X"FF",X"00",X"FF",X"00",X"FF",X"00",X"FF",X"00",X"FC",X"00",X"FC",X"00",X"FC",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"02",X"00",X"0A",X"00",X"0A",X"00",X"2A",X"00",X"AA",
		X"28",X"00",X"AA",X"00",X"AA",X"80",X"AA",X"80",X"AA",X"80",X"AA",X"0F",X"AA",X"3F",X"A8",X"35",
		X"00",X"AA",X"02",X"AA",X"0A",X"AA",X"0A",X"AA",X"2A",X"AA",X"AA",X"AA",X"AA",X"AA",X"0A",X"AA",
		X"AA",X"3D",X"AA",X"BF",X"AA",X"B5",X"AA",X"F5",X"AB",X"FF",X"AB",X"FD",X"AF",X"F5",X"BF",X"F7",
		X"00",X"AA",X"02",X"AA",X"02",X"AA",X"00",X"AA",X"0F",X"FF",X"FF",X"FF",X"FF",X"FF",X"57",X"FF",
		X"A8",X"00",X"AA",X"A8",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"FA",X"AA",X"FF",X"AA",X"FF",X"FA",
		X"7F",X"FF",X"5F",X"FF",X"57",X"FF",X"57",X"FF",X"FF",X"FD",X"5F",X"FD",X"57",X"F5",X"F7",X"F5",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"5F",X"FF",X"57",X"FF",X"55",X"FF",X"55",X"FF",X"55",X"FF",
		X"00",X"2A",X"00",X"AA",X"00",X"AA",X"80",X"AA",X"A0",X"AA",X"A0",X"2A",X"A8",X"2A",X"A8",X"2A",
		X"80",X"00",X"A8",X"00",X"AA",X"00",X"AA",X"80",X"AA",X"80",X"AA",X"80",X"AA",X"A0",X"AA",X"A0",
		X"AF",X"2A",X"FF",X"EA",X"FF",X"FE",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"F0",X"FF",X"F0",X"FF",
		X"AA",X"A0",X"AA",X"A0",X"AA",X"A0",X"AA",X"80",X"EA",X"80",X"FA",X"80",X"FA",X"00",X"FC",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"02",X"00",X"0A",X"00",X"0A",X"00",X"2A",X"00",X"AA",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"AA",X"02",X"AA",X"0A",X"AA",X"0A",X"AA",X"02",X"AA",X"AA",X"AA",X"AA",X"AA",X"0A",X"AA",
		X"28",X"00",X"AA",X"00",X"AA",X"80",X"AA",X"80",X"AA",X"80",X"AA",X"0F",X"AA",X"3F",X"A8",X"35",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"0F",X"FF",X"FF",X"FF",X"FF",X"FF",X"57",X"FF",
		X"AA",X"3D",X"AA",X"BF",X"AA",X"B5",X"AA",X"F5",X"AB",X"FF",X"AB",X"FD",X"AF",X"F5",X"BF",X"F7",
		X"7F",X"FF",X"5F",X"FF",X"57",X"FF",X"57",X"FF",X"FF",X"FD",X"5F",X"F5",X"57",X"F5",X"F7",X"D5",
		X"2A",X"80",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"EA",X"AA",X"FA",X"AA",X"FF",X"AA",
		X"00",X"00",X"00",X"00",X"A0",X"00",X"AA",X"00",X"AA",X"A0",X"AA",X"A8",X"AA",X"AA",X"AA",X"AA",
		X"FF",X"FA",X"FF",X"FF",X"D7",X"FF",X"55",X"FF",X"55",X"7F",X"55",X"7F",X"55",X"7F",X"55",X"7F",
		X"AA",X"AB",X"EA",X"BF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"F3",X"FF",X"F0",X"FF",X"C0",
		X"00",X"00",X"05",X"50",X"15",X"54",X"55",X"55",X"55",X"55",X"55",X"55",X"15",X"55",X"15",X"55",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"40",X"00",X"40",X"00",X"50",X"00",
		X"15",X"55",X"D5",X"55",X"FD",X"55",X"FF",X"55",X"FF",X"D5",X"FF",X"F5",X"FF",X"F5",X"FF",X"FC",
		X"50",X"00",X"50",X"00",X"50",X"00",X"40",X"00",X"40",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"2A",X"80",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"AA",X"EA",X"AA",X"FA",X"AA",X"FF",X"AA",
		X"00",X"00",X"00",X"00",X"A0",X"00",X"AA",X"00",X"AA",X"A0",X"AA",X"A8",X"AA",X"AA",X"AA",X"AA",
		X"FF",X"FA",X"FF",X"FF",X"D7",X"FF",X"55",X"FF",X"55",X"7F",X"55",X"7F",X"55",X"7F",X"55",X"7F",
		X"AA",X"AB",X"EA",X"BF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"F3",X"FF",X"F0",X"FF",X"C0",
		X"00",X"00",X"05",X"50",X"15",X"54",X"55",X"55",X"55",X"55",X"55",X"55",X"15",X"55",X"15",X"55",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"40",X"00",X"40",X"00",X"50",X"00",
		X"15",X"55",X"D5",X"55",X"FD",X"55",X"FF",X"55",X"FF",X"D5",X"FF",X"F5",X"FF",X"F5",X"FF",X"FC",
		X"50",X"00",X"50",X"00",X"50",X"00",X"40",X"00",X"40",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF");
begin
process(clk)
begin
	if rising_edge(clk) then
		data <= rom_data(to_integer(unsigned(addr)));
	end if;
end process;
end architecture;
