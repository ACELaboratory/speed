#! /usr/bin/octave -qf

function plot_two (filename,A,legendA,B,legendB,header)
	window=figure();
	plot(A(:,1), A(:,2), [";" legendA ";"], B(:,1), B(:,2), [";" legendB ";"]);
	FS = findall(window,'-property','FontSize');
	set(FS,'FontSize',12);
	set(FS,'FontName','Roboto');
	xlabel('LBA');
	ylabel("Speed, MB/s");
	grid on;
	title(header);
	print(window,'-dpng','-color','-r300',filename);
	pause(1);
	delete(window);
endfunction

function plot_two_lba (filename,A,legendA,B,legendB,header)
	window=figure();
	plot([1:length(A)]/60, A, [";" legendA ";"], [1:length(B)]/60 ,B, [";" legendB ";"]);
	FS = findall(window,'-property','FontSize');
	set(FS,'FontSize',12);
	set(FS,'FontName','Roboto');
	xlabel("Time, min");
	ylabel("Speed, MB/s");
	grid on;
	title(header);
	print(window,'-dpng','-color','-r300',filename);
	pause(1);
	delete(window);
endfunction

function plot_three (filename,A,legendA,B,legendB,C,legendC,header)
	window=figure();
	plot(A(:,1),A(:,2),[";" legendA ";"],B(:,1),B(:,2),[";" legendB ";"],C(:,1),C(:,2),[";" legendC ";"]);
	FS = findall(window,'-property','FontSize');
	set(FS,'FontSize',12);
	set(FS,'FontName','Roboto');
	xlabel('LBA');
	ylabel("Speed, MB/s");
	grid on;
	title(header);
	print(window,'-dpng','-color','-r300',filename);
	pause(3);
	delete(window);
endfunction

#echo on all
graphics_toolkit("gnuplot"); 
csv_folder = 'csv/';
plots_folder = 'plots/';

A=csvread([csv_folder "1_Express WDC WD10EZEX-60ZF5A0.csv"]);
B=csvread([csv_folder "2_Marvell 9128 WDC WD10EZEX-60ZF5A0.csv"]);
C=csvread([csv_folder "3_SAMSUNG HD103SJ almost ideal conditions.csv"]);
D=csvread([csv_folder "4_WDC WD20EADS-00S2B0 2Tb.csv"]);
E=csvread([csv_folder "6_ST500LT012 AMD PC almost ideal.csv"]);
F=csvread([csv_folder "5_ST500LT012 AMD PC 100 CPU.csv"]);

plot_two([plots_folder '1.png'], A,'1TB WD10EZEX-60ZF5A0 (PC-3000 controller)',B,'1 TB WD10EZEX-60ZF5A0 (Marvell 9128)','Reading speed in different controllers');
plot_three([plots_folder '2.png'], A,"1TB WD10EZEX-60ZF5A0 (PC-3000 controller)",B,"1TB WD10EZEX-60ZF5A0 (Marvell 9128)",C,"1TB Samsung HD103SJ",'Reading speed in different controllers');
plot_three([plots_folder '3.png'], A,"1TB WD10EZEX-60ZF5A0 (PC-3000 controller)",B,"1TB WD10EZEX-60ZF5A0 (Marvell 9128)",D,"2TB WD Green WD20EADS-00S2B0",'Reading speed in different controllers');
plot_two([plots_folder '4.png'], F,'no other software running',E,'100% CPU and some network usage','Reading Seagate ST500LT012 in different conditions');

H = movavg(F(:,2), 100, 200, 1); 	# high CPU
G = movavg(E(:,2), 100, 200, 1);  # almost ideal

plot_two_lba([plots_folder '5.png'], G,"no other software running", H,"significant CPU and network usage",'Reading Seagate ST500LT012 in different conditions - processed');