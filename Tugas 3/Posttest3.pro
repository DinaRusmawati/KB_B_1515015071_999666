/****************
Written by : Dina Rusmawati
****************/

domains
price = ulong
merk = symbol
        	
predicates
	photo_session(symbol,symbol)- nondeterm (o,o) 
	costumer(symbol) - nondeterm (o)
        photographer(symbol) - nondeterm (o)
        request(symbol,symbol) - nondeterm (i,i) 
        camera(merk, price, symbol) - nondeterm (i,i,o)
        
clauses   	
   photo_session(X,Y):-   
   	costumer(X), 				
   	photographer(Y), 
   	request(X,Y). 
   	
   		camera(canon, 200000, josh).
   		camera(nikon, 200000, roger).
   		camera(mirrosless, 250000, roger).
   		
        	costumer(lucy). 
        	costumer(nauri). 
        	costumer(nadya). 
        	costumer(billy). 
        	costumer(justin). 
        	
        	photographer(josh). 
        	photographer(roger).
      
        	request(lucy,josh).
        	request(nadya,tora). 
        	request(justin,william).
        	request(billy,josh). 
        	request(nauri,roger). 
        	
   		
goal
photo_session(X,Y);
camera(nikon, 200000, Y);
camera(canon, 200000, Y).

