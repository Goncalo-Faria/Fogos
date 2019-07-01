/*********************************************
 * OPL 12.8.0.0 Model
 * Author: cam
 * Creation Date: Dec 3, 2018 at 3:07:48 PM
 *********************************************/

 int n=...;
 int ignicao_x=...;
 int ignicao_y=...;
 
 int c_norte[1..n][1..n]=...;
 int c_este[1..n][1..n]=...;
 int c_sul[1..n][1..n]=...;
 int c_oeste[1..n][1..n]=...;
 
 dvar float+ t[1..n][1..n];
 dvar float+ funcao_objetivo;
  
 maximize sum(i in 1..n, j in 1..n) (t[i][j] + (1 - n) * t[ignicao_x][ignicao_y]);
 
 subject to {
	funcao_objetivo == sum(i in 1..n, j in 1..n) (t[i][j] + (1 - n) * t[ignicao_x][ignicao_y]);
	
	/* meio */
 	forall(i in 2..n-1, j in 2..n-1) 
 		f1 : t[i][j] - t[i-1][j] <= c_sul[i-1][j];
	forall(i in 2..n-1, j in 2..n-1)  		
 		f2 : t[i][j] - t[i][j-1] <= c_este[i][j-1];
	forall(i in 2..n-1, j in 2..n-1)  		
 		f3 : t[i][j] - t[i+1][j] <= c_norte[i+1][j];
	forall(i in 2..n-1, j in 2..n-1)  		
 		f4 : t[i][j] - t[i][j+1] <= c_oeste[i][j+1];
 		
 	/* canto inferior esquerdo */
	f5 : t[n][1] - t[n-1][1] <= c_sul[n-1][1];
	f6 : t[n][1] - t[n][2] <= c_oeste[n][2];
	
	/* canto inferior direito */
	f7 : t[n][n] - t[n-1][n] <= c_sul[n-1][n];
	f8 : t[n][n] - t[n][n-1] <= c_este[n][n-1];	
	
	/* canto superior direito */
	f9 : t[1][n] - t[2][n] <= c_norte[2][n];
	f10 : t[1][n] - t[1][n-1] <= c_este[1][n-1];	
	
	/* linha superior */
	forall(j in 2..n-1) 
		f11 : t[1][j] - t[2][j] <= c_norte[2][j];
	forall(j in 2..n-1) 		
		f12 : t[1][j] - t[1][j-1] <= c_este[1][j-1];	
	forall(j in 2..n-1) 
		f13 : t[1][j] - t[1][j+1] <= c_oeste[1][j+1];
	
	/* linha inferior */
	forall(j in 2..n-1) 
		f14 : t[n][j] - t[n-1][j] <= c_sul[n-1][j];
	forall(j in 2..n-1) 		
		f15 : t[n][j] - t[n][j-1] <= c_este[n][j-1];	
	forall(j in 2..n-1) 
		f16 : t[n][j] - t[n][j+1] <= c_oeste[n][j+1];
		
	/* linha direita */
	forall(i in 2..n-1) 
		f17 : t[i][n] - t[i-1][n] <= c_sul[i-1][n];
	forall(i in 2..n-1) 		
		f18 : t[i][n] - t[i][n-1] <= c_este[i][n-1];	
	forall(i in 2..n-1) 
		f19 : t[i][n] - t[i+1][n] <= c_norte[i+1][n];
			
	/* linha esquerda */
	forall(i in 2..n-1) 
		f20 : t[i][1] - t[i-1][1] <= c_sul[i-1][1];
	forall(i in 2..n-1) 		
		f21 : t[i][1] - t[i][2] <= c_oeste[i][2];	
	forall(i in 2..n-1) 
		f22 : t[i][1] - t[i+1][1] <= c_norte[i+1][1];
		
 	t[ignicao_x][ignicao_y] == 0;
	
	forall(i in 1..n, j in 1..n)
	  t[i][j] >=0;
 }