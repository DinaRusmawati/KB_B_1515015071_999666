/****************
Written by : Dina Rusmawati
****************/
        	
predicates
	photo_session(symbol,symbol)- nondeterm (o,o) /*penghubung*/
	costumer(symbol) - nondeterm (o) /*penghubung*/
        photographer(symbol) - nondeterm (o) /*penghubung*/
        request(symbol,symbol) - nondeterm (i,i) /*penghubung*/
        
clauses   	
   photo_session(X,Y):-   /*clauses-nya adalah photo_session akan terjadi jika COSTUMER me-REQUEST photographer yang ada di LIST_PHOTOGRAPHER*/
   	costumer(X), 				
   	photographer(Y), 
   	request(X,Y). /*costumer  request photographer*/
   	
        	costumer(lucy). /*costumer 1*/
        	costumer(nauri). /*costumer 2*/
        	costumer(nadya). /*costumer 3*/
        	costumer(billy). /*costumer 4*/
        	costumer(justin). /*costumer 5*/
        	
        	photographer(josh). /*photographer 1*/
        	photographer(roger). /*photographer 2*/
      
        	request(lucy,josh). /*costumer 1 request photographer 1*/
        	request(nadya,tora). /*costumer 3 request photographer yang tidak ada dilist*/
        	request(justin,william). /*costumer 5 request photographer yang tidak ada dilist*/
        	request(billy,josh). /*costumer 4 request photographer 1*/
        	request(nauri,roger). /*costumer 2 request photographer 2*/
        	
   		
goal
photo_session(X,Y). /*maka goalnya adalah akan menampilkan costumer dan photographer mana yang sedang terlibat photo_session*/