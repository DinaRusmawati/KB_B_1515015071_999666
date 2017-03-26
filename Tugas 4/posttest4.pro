/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  
 FileName: CH04E12.PRO
 Purpose: 
 Written by: PDC
 Modifyed by: Eugene Akimov
 Comments: 
******************************************************************************/


domains     							%memberikan nama pada parameter
  name,sex,occupation,object,vice,substance = symbol 		%parameter ini menggunakan tipe data symbol
  age=integer 							%parameter ini menggunakan tipe data integer

predicates							%mendeklarasikan relasi
  person(name,age,sex,occupation) - nondeterm (o,o,o,o), nondeterm (i,o,o,i), nondeterm (i,o,i,o) %predikat person
  had_affair(name,name) - nondeterm (i,i), nondeterm (i,o)	%pedikat had_affair
  killed_with(name,object) - determ (i,o)			%predikat killed_with
  killed(name) - procedure (o)					%predikat killed dengan procedure
  killer(name) - nondeterm (o)					%predikat killed dengan nondeterm
  motive(vice) - nondeterm (i)					%predikat motive 
  smeared_in(name,substance) - nondeterm (i,o), nondeterm (i,i)	%predikat smeared_in
  owns(name,object) - nondeterm (i,i)				%predikat owns
  operates_identically(object,object) - nondeterm (o,i)		%predikat operates_identically
  owns_probably(name,object) - nondeterm (i,i)			%predikat owns_probably
  suspect(name) - nondeterm (i)					%predikat suspect
			
/* * * Facts about the murder * * */                            %fakta - fakta tentang pembunuhan
clauses
  person(bert,55,m,carpenter).					%bert is a carpenter aged 55 and he has a male gender
  person(allan,25,m,football_player).				%allan is a football_player aged 25 and he has a male gender
  person(allan,25,m,butcher).					%allan is a butcher aged 25 and he has a male gender
  person(john,25,m,pickpocket).					%john is a pickpocket aged 25 and he has a male gender

  had_affair(barbara,john).					%barbara had_affair with john
  had_affair(barbara,bert).					%barbara had_affair with bert
  had_affair(susan,john).					%susan had_affair with john

  killed_with(susan,club).					%susan killed_with a club
  killed(susan).						%susan was killed

  motive(money).						%the motive is a money
  motive(jealousy).						%the motive is a jealousy
  motive(righteousness).					%the motive is a righteousness

  smeared_in(bert,blood).					%bert smeared_in blood
  smeared_in(susan,blood).					%susan smeared_in blood
  smeared_in(allan,mud).					%allan smeared_in mud
  smeared_in(john,chocolate).					%john smeared_in chocolate
  smeared_in(barbara,chocolate).				%barbara smeared_in chocolate

  owns(bert,wooden_leg).					%bert owns the wooden_leg
  owns(john,pistol).						%john owns the pistol

/* * * Background knowledge * * */				%dasar pengetahuan

  operates_identically(wooden_leg, club).			%the operates_identically of wooden_leg same with a club
  operates_identically(bar, club).				%the operates_identically of bar same with a club
  operates_identically(pair_of_scissors, knife).		%the operates_identically pair_of_scissors same with a knife
  operates_identically(football_boot, club).			%the operates_identically of football_boot same with a club

  owns_probably(X,football_boot):-				%kemungkinan sepatu bola milik X jika maka
	person(X,_,_,football_player).				%X dan orang lainnya pemain sepakbola
  owns_probably(X,pair_of_scissors):-				%kemungkinan gunting milik X jika maka
	person(X,_,_,hairdresser).				%X dan orang lainnya adalah pekerja salon
  owns_probably(X,Object):-					%kemungkinan benda milik X jika maka
	owns(X,Object).						%X memiliki benda itu
					
/* * * * * * * * * * * * * * * * * * * * * * *			%dicurigai semua orang yang memiliki senjata yang 
* 								kerjanya mirip dengan senjata penyebab siti terbunuh.
 * Suspect all those who own a weapon with   *
 * which Susan could have been killed.       *
 * * * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-							%X dicurigai jika maka
	killed_with(susan,Weapon) ,				%X dicurigai jika maka
	operates_identically(Object,Weapon) ,			%Cara kerja benda tersebut mirip dengan senjata dan
	owns_probably(X,Object).				%Kemungkinan X memiliki benda

/* * * * * * * * * * * * * * * * * * * * * * * * * *		%dicurigai laki-laki yang selingkuh dengan susan
 * Suspect men who have had an affair with Susan.  *
 * * * * * * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-						%X dicurigai jika maka
	motive(jealousy),				%cemburu adalah motifnya dan
	person(X,_,m,_),				%X adalah orang tersebut yang berjender m dan
	had_affair(susan,X).				%susan selingkuh dengan X

/* * * * * * * * * * * * * * * * * * * * *	  	%dicurigai perempuan yang selingkuh dengan
* 							laki-laki yang juga selingkuh dengan siti	
 * Suspect females who have had an       *
 * affair with someone that Susan knew.  *
 * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-					%X dicurigai jika maka
	motive(jealousy),			%cemburu adalah motifnya dan
	person(X,_,f,_),			%X adalah orang tersebut yang berjender f dan
	had_affair(X,Man),			%Laki - laki tersebut selingkuh dengan X dan
	had_affair(susan,Man).			%Susan selingkuh dengan laki-laki

/* * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Suspect pickpockets whose motive could be money.  *		dicurigai pencopet yang mempunyai motif uang
 * * * * * * * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-				%X dicurigai jika maka
	motive(money),			%motifnya adalah uang dan 
	person(X,_,_,pickpocket).	%X adalah seorang pencopet

  killer(Killer):- 				%pembunuh tersebut dikatakan pembunuh jika maka
	person(Killer,_,_,_),			%orang tersebut adalah pembunuh dan orang lainnya dan
	killed(Killed),				%jika orang tersebut terbunuh dan
	Killed <> Killer, /* It is not a suicide */    /* Bukan bunuh diri */  %relasi dari terbunuh adalah pembunuh dan
	suspect(Killer),			%pembunuh tersebut dicurigai dan 
	smeared_in(Killer,Goo),			%pembunuh ternodai oleh zat dan
	smeared_in(Killed,Goo).			%yang terbunuh ternodai oleh zat

goal				%merupakan sebuah jawaban 
  killer(X).			%siapa kah yang menjadi pembunuh?
  
  %jawaban dari semua clausesnya adalah bert
  %karena pembunuh ternodai oleh zat, maka bert adalah orangnya
  %didalam clause smeared_in blood terdapat dua orang yaitu bert dan susan
  %didalam goal ditanyakan, siapakah yang menjadi pembunuh? berarti adalah bert
  
