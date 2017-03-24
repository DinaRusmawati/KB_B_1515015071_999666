predicates 
	nondeterm kejadian(symbol,symbol)
	nondeterm barangbukti(symbol,symbol)
	nondeterm tkp(symbol,symbol)
	nondeterm saksi(symbol,symbol)
	nondeterm keluarga(symbol,symbol)
	nondeterm kasus

clauses

kasus:-
	kejadian(X, T),
	keluarga(Y, X),
	tkp(T, X),
	barangbukti(Y, M),
	saksi(O, M),
	write(" Terjadi kasus " , X, " di " , T, " keluarga " , Y, " karena telah ditemukan barang bukti sebuah " , M,
	" oleh saksi " , O, "\n"). 
	
	
	kejadian(pembunuhan, rumah).
	
	keluarga(uchiha, pembunuhan).
	keluarga(hyuuga, teror).
	keluarga(uzumaki, pencurian).

	barangbukti(hyuuga, pisau).
	barangbukti(uchiha, pisau).
	barangbukti(uzumaki, surat).
	barangbukti(uzumaki, pisau).
	
	tkp(rumah, pembunuhan).
	tkp(sekolah, pencurian).
	tkp(gedung, teror).
	
	saksi(hinata, pisau).
	saksi(sasuke, surat).
	
goal
	kasus.