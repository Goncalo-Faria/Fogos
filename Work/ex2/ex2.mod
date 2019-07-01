/*********************************************
 * OPL 12.8.0.0 Model
 * Author: jmv
 * Creation Date: 06/12/2018 at 21:57:08
 *********************************************/

int n =...;

int ignicao_x =...;
int ignicao_y =...;

int proteger_x =...;
int proteger_y =...;

int b_rec=...;
int delta=...;
 
int c_norte[1..n][1..n]=...;
int c_este[1..n][1..n]=...;
int c_sul[1..n][1..n]=...;
int c_oeste[1..n][1..n]=...;

dvar float+ t[1..n][1..n];
dvar boolean r[1..n][1..n];

dvar float+ funcao_objetivo;
 
maximize t[proteger_x][proteger_y];

subject to {
	funcao_objetivo == t[proteger_x][proteger_y];

	forall(i in 2..n, j in 1..n)
	  	t[i][j] - t[i-1][j] - (delta * r[i-1][j]) <= c_sul[i-1][j];
	  	
	forall(i in 1..n-1, j in 1..n)
	  	t[i][j] - t[i+1][j] - (delta * r[i+1][j]) <= c_norte[i+1][j];
	  	
	forall(i in 1..n, j in 2..n)
	  	t[i][j] - t[i][j-1] - (delta * r[i][j-1]) <= c_este[i][j-1];
	  	
	forall(i in 1..n, j in 1..n-1)
	  	t[i][j+1] - t[i][j+1] - (delta * r[i][j+1]) <= c_oeste[i][j+1];

	
	t[ignicao_x][ignicao_y] == 0;
	
	sum(i in 1..n, j in 1..n)
	  r[i][j] <= b_rec;
 }