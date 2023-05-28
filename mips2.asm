.data
	#miejsce dla ewentualnych 100 skladnikow sumy
	tablica:			.word 0:104
	intro:				.asciiz "Program dodaje dowolna ilosc liczb do siebie,\nale jesli ilosc dodawanych przekroczy 100,\nnie wszystkie zostana wyswietlone po podaniu wyniku.\nNiemozliwe jest tez dodanie do siebie zadnej lub tylko jednej liczby, minimum dwie liczby mozna do siebie dodac.\nPodaj ilosc liczb, ktore chcesz dodac: "
	pokazPierwszaLiczbe:		.asciiz "\nPodaj pierwsza liczbe: "
	pokazNastepnaLiczbe:		.asciiz "\nPodaj nastepna liczbe: "
	pokazSume:			.asciiz "\nSuma: "
	pokazSkladniki:			.asciiz "\nNa ten wynik skladaly sie te liczby:\n"
	przestrzen:			.asciiz ", "
	playLista:			.asciiz "\nplaylista z ktorej sie uczylem \nhttps://www.youtube.com/watch?v=u5Foo6mmW0I&list=PL5b07qlmA3P6zUdDf-o97ddfpvPFuNa5A"
	koniec0:			.asciiz "\nnie ma co dodawac, sprobuj jeszcze raz\n"
	koniec1:			.asciiz "\do czego mam niby dodac ta jedna liczbe? Sprobuj jeszcze raz\n"
	# $t0 - ilosc liczb do dodania
	# $t1 - pierwsza liczba
	# $s0 - indeksy liczb
	# $t3 - licznik petli
	# $t3 - 
.text
.globl main
	main:
		#wyswietl pierwsze powiadomienie
		li $v0, 4
		la $a0, intro
		syscall
		
		#pobranie od uzytkownika informacji ile liczb chce dodawac
		li $v0, 5
		syscall
	
		#przeniesienie tej wartosci
		move $t0, $v0
		
		#sprawdzenie czy rowne 0
		beq $t0, $zero, end0
		
		#sprawdzenie czy rowne 1
		beq $t0, 1, end1
		
		addi $t0, $t0, -1
	
		#podanie pierwszel liczby
		li $v0, 4
		la $a0, pokazPierwszaLiczbe
		syscall
	
		#wprowadzenie pierwszej liczby
		li $v0, 5
		syscall
	
		move $t1, $v0
		addi $t4, $t1, 0
		#wyzerowanie indeksow
		addi $s0, $zero, 0
		#wyzerowanie licznika petli
		addi $t3, $zero, 0
	
		#zapis pierwszej liczby
		sw $t1, tablica($s0)
	
		while1:
			beq $t3, $t0, exit1
			#nastepny index tablicy
			addi $s0, $s0, 4
			#podanie kolejnej liczby
			li $v0, 4
			la $a0, pokazNastepnaLiczbe
			syscall
			#wprowadzenie kolejnej liczby
			li $v0, 5
			syscall
			#przeniesienie do rejesttru t1 i zapisanie w tablicy
			move $t1, $v0
			add $t4, $t1, $t4 
			sw $t1, tablica($s0)
			#inkrementacja petli
			addi $t3, $t3, 1
		
			j while1
		
		exit1:
			#wyswietlenie kolejnego stringa
			li $v0, 4
			la $a0, pokazSume
			syscall
			################
			addi $s0, $s0, 4
			sw $t4, tablica($s0)
			################
			#wyswietlenie sumy
			li $v0, 1
			add $a0, $t4, $zero
			syscall
			
			
		#wyzerowanie indeksow do odczytu
		addi $s1, $zero, 0
		
		li $v0, 4
		la $a0, pokazSkladniki
		syscall
		
		
		
		#wyswietlenie skladnikow
		while2:
		
		#skladnik o indeksie $s1
		li $v0, 1
		lw $a0, tablica($s1)
		
		#zwiekszenie indeksu
		add $s1, $s1, 4
		syscall
		
		#warunek petli
		beq $t5, $t0, end
		
		#przecinek i spacja
		li $v0, 4
		la $a0, przestrzen
		syscall
		#inkrementacja petli
		add $t5, $t5, 1
		
		#powrot do poczatku petli
		j while2
		
		end:
			li $v0, 4
			la $a0, playLista
			syscall
			
			li $v0, 10
			syscall
		
		end0:
			li $v0, 4
			la $a0, koniec0
			syscall
			j main
			
		end1:
			li $v0, 4
			la $a0, koniec1
			syscall
			j main
