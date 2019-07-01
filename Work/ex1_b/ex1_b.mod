/*********************************************
 * OPL 12.8.0.0 Model
 * Author: cam
 * Creation Date: Dec 2, 2018 at 4:24:54 PM
 *********************************************/

 int n=...;
 int ignicao_x=...;
 int ignicao_y=...;
 
 int c_norte[1..n][1..n]=...;
 int c_este[1..n][1..n]=...;
 int c_sul[1..n][1..n]=...;
 int c_oeste[1..n][1..n]=...;
 
 dvar float+ x_norte[1..n][1..n];
 dvar float+ x_este[1..n][1..n];
 dvar float+ x_sul[1..n][1..n];
 dvar float+ x_oeste[1..n][1..n];
 dvar float+ funcao_objetivo;
 
 minimize sum(i in 1..n, j in 1..n) (c_norte[i][j]*x_norte[i][j] + c_este[i][j]*x_este[i][j] + c_sul[i][j]*x_sul[i][j] + c_oeste[i][j]*x_oeste[i][j]);
 
 subject to {
 	 funcao_objetivo == sum(i in 1..n, j in 1..n) (c_norte[i][j]*x_norte[i][j] + c_este[i][j]*x_este[i][j] + c_sul[i][j]*x_sul[i][j] + c_oeste[i][j]*x_oeste[i][j]); 
 
  	 /* nodo 1 */
  	 (x_norte[ignicao_x+1][ignicao_y] + x_oeste[ignicao_x][ignicao_y+1]) - 
  	 (x_sul[ignicao_x][ignicao_y] + x_este[ignicao_x][ignicao_y]) == 1 - (n*n);
	
	 /* nodo canto superior direito */ 
 	 (x_este[1][n-1] + x_norte[2][n]) - 
  	 (x_sul[1][n] + x_oeste[1][n]) == 1;  
  	 
  	 /* nodo canto inferior direito */
  	 (x_este[n][n-1] + x_sul[n-1][n]) - 
  	 (x_norte[n][n] + x_oeste[n][n]) == 1;  
  	 
  	 /* nodo canto inferior esquerdo */
  	 (x_sul[n-1][1] + x_oeste[n][2]) - 
  	 (x_norte[n][1] + x_este[n][1]) == 1;  	 
	 
	 /* meio */ 	  	
  	 forall(i in 2..n-1, j in 2..n-1) 
  	 ((x_norte[i+1][j] + x_este[i][j-1] + x_sul[i-1][j] + x_oeste[i][j+1]) - 
  	  (x_norte[i][j] + x_este[i][j] + x_sul[i][j] + x_oeste[i][j])) == 1;

	 /* linha superior */
	 forall(j in 2..n-1) 
	 ((x_este[1][j-1] + x_norte[2][j] + x_oeste[1][j+1]) - 
   	  (x_este[1][j] + x_sul[1][j] + x_oeste[1][j])) == 1;  
  	 
  	 /* linha baixo */
	 forall(j in 2..n-1) 
	 ((x_este[n][j-1] + x_sul[n-1][j] + x_oeste[n][j+1]) - 
  	  (x_este[n][j] + x_norte[n][j] + x_oeste[n][j])) == 1;    	 
  	 
  	 /* linha esquerda */
	 forall(i in 2..n-1) 
	 ((x_norte[i+1][1] + x_sul[i-1][1] + x_oeste[i][2]) - 
  	  (x_norte[i][1] + x_sul[i][1] + x_este[i][1])) == 1;    	 
  	 
  	 /* linha direita */
  	 forall(i in 2..n-1) 
	 ((x_norte[i+1][n] + x_sul[i-1][n] + x_este[i][n-1]) - 
  	  (x_norte[i][n] + x_sul[i][n] + x_oeste[i][n])) == 1;  
  	 	   	   	   	
 }
 
 
 
 