/*********************************************
 * OPL 12.8.0.0 Model
 * Author: cam
 * Creation Date: Dec 5, 2018 at 11:20:41 PM
 *********************************************/

int n=...;
int c_norte[1..n][1..n]=...;
int c_este[1..n][1..n]=...;
int c_sul[1..n][1..n]=...;
int c_oeste[1..n][1..n]=...;
int b=...;
int delta=...;
int k=...;

dvar float+ f[1..n][1..n][1..n][1..n];
dvar boolean r[1..n][1..n];
dvar boolean l[1..n][1..n][1..n][1..n];
dvar float+ funcao_objetivo;
  
maximize sum(a in 1..n, c in 1..n) ((14-a-c)/500) * (sum(i in 1..n, j in 1..n) l[i][j][a][c]);
 
subject to {
	funcao_objetivo == sum(a in 1..n, c in 1..n) ((14-a-c)/500) * (sum(i in 1..n, j in 1..n) l[i][j][a][c]);
	
	/* restricao (21) */
	forall(i in 1..n, j in 1..n)
		f[i][j][i][j] == 0;
	
 
 	/* restricao (22) */
 	forall(i in 1..n, j in 1..n)
 	  forall(a in 1..n, c in 1..n) 
 			l[i][j][a][c] * k - f[i][j][a][c] <= 0;
 	
 	
 	/* restricao (23) */
	sum(i in 1..n, j in 1..n) r[i][j] <= b;
	
	
 	/* restricao (20) */
 	
 	/* sul */
 	forall(i in 2..n, j in 1..n) 
 		forall(a in 1..n, c in 1..n)
 			f[i][j][a][c] - f[i-1][j][a][c] - delta * r[i-1][j] <= c_sul[i-1][j];
 	
 	/* norte */
 	forall(i in 1..n-1, j in 1..n) 
 		forall(a in 1..n, c in 1..n)
 			f[i][j][a][c] - f[i+1][j][a][c] - delta * r[i+1][j] <= c_norte[i+1][j];

 	/* oeste */
 	forall(i in 1..n, j in 1..n-1) 
 		forall(a in 1..n, c in 1..n)
 			f[i][j][a][c] - f[i][j+1][a][c] - delta * r[i][j+1] <= c_oeste[i][j+1]; 		 	
 	
 	/* este */
 	forall(i in 1..n, j in 2..n) 
 		forall(a in 1..n, c in 1..n)
 			f[i][j][a][c] - f[i][j-1][a][c] - delta * r[i][j-1] <= c_este[i][j-1];
 		 	
 }