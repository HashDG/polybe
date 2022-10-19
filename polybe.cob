IDENTIFICATION DIVISION.
PROGRAM-ID. Polybe.
DATE-WRITTEN. 06/10/22.

DATA DIVISION.
WORKING-STORAGE SECTION.
	01	ALPHA		PIC	A(25)	VALUE "ABCDEFGHIJKLMNOPQRSTUVXYZ".
	01	CLE		PIC 	A(25).
	01	CARRE		PIC 	A(25).
	01	ENTREE		PIC 	A(38).
	01	SORTIE		PIC 	A(38).
	01 	XTMP		PIC 	9.
	01 	YTMP		PIC 	9.
	01	TMP		PIC 	99.
	01	I		PIC 	99.
	01	J		PIC 	99.
	01	CHAR		PIC 	A.
	01	BOOL		PIC	9	VALUE ZERO.
	
PROCEDURE DIVISION.
GENERER_CLE.
	DISPLAY "Entrez la clé".
	ACCEPT ENTREE.
	PERFORM VARYING I FROM 1 BY 1 UNTIL I = FUNCTION LENGTH(ENTREE) 
		SUBTRACT I FROM FUNCTION LENGTH(ENTREE) GIVING TMP
		MOVE ENTREE(TMP:1) TO CHAR
		PERFORM VARYING J FROM 1 BY 1 UNTIL J = FUNCTION LENGTH(ALPHA) + 1
			IF ALPHA(J:1) IS = CHAR THEN
				INSPECT ENTREE REPLACING ALL CHAR BY SPACES AFTER ENTREE(TMP:1)
			END-IF
		END-PERFORM
	END-PERFORM.
	MOVE 1 TO J.
	PERFORM VARYING I FROM 1 BY 1 UNTIL I = FUNCTION LENGTH(ENTREE)
		IF ENTREE(I:1) IS NOT = SPACE THEN
			MOVE ENTREE(I:1) TO CLE(J:1)
			ADD 1 TO J
	END-PERFORM.

GENERER_CARRE.
	MOVE CLE TO CARRE.
	INSPECT CLE TALLYING TMP FOR ALL SPACES.
	IF TMP IS = FUNCTION LENGTH(CLE) THEN
		MOVE ALPHA TO CARRE
	ELSE
 		SUBTRACT TMP FROM 27 GIVING TMP
		PERFORM VARYING I FROM 1 BY 1 UNTIL I = FUNCTION LENGTH(ALPHA) + 1
			MOVE ALPHA(I:1) TO CHAR
			MOVE 0 TO BOOL
			PERFORM VARYING J FROM 1 BY 1 UNTIL J = FUNCTION LENGTH(CLE)
				IF CLE(J:1) IS = CHAR THEN
					MOVE 1 TO BOOL
				END-IF
			END-PERFORM	
			IF BOOL = 0 THEN
				MOVE CHAR TO CARRE(TMP:1)
				ADD 1 TO TMP
			END-IF
		END-PERFORM
	END-IF.	
	
AFFICHER_CARRE.
	MOVE ZERO TO TMP.
	DISPLAY CARRE
	PERFORM VARYING I FROM 1 BY 1 UNTIL I = 6
		PERFORM VARYING J FROM 1 BY 1 UNTIL J = 6
			SUBTRACT 1 FROM I GIVING TMP
			MULTIPLY TMP BY 5 GIVING TMP
			ADD J TO TMP
			DISPLAY CARRE(TMP:1) " " WITH NO ADVANCING
		END-PERFORM
		DISPLAY " "	
	END-PERFORM.

CODER_CHAINE.
	MOVE ZERO TO I.
	MOVE SPACE TO CHAR.
	DISPLAY "Entrez la chaîne à coder".
	ACCEPT ENTREE.
	PERFORM VARYING I FROM 1 BY 1 UNTIL I = FUNCTION LENGTH(ENTREE) + 1
		MOVE ENTREE(I:1) TO CHAR
		PERFORM VARYING J FROM 1 BY 1 UNTIL J = FUNCTION LENGTH(CARRE) + 1
			IF CHAR IS = CARRE(J:1) THEN
				SUBTRACT 1 FROM J				
				DIVIDE J BY 5 GIVING XTMP
				COMPUTE YTMP = FUNCTION MOD(J 5)
				ADD 1 TO XTMP
				ADD 1 TO YTMP
				DISPLAY XTMP YTMP WITH NO ADVANCING
				ADD 1 TO J
			END-IF
		END-PERFORM
	END-PERFORM.
	DISPLAY " ".

DECODER_CHAINE.
	MOVE ZERO TO I.
	MOVE SPACE TO CHAR.
	DISPLAY "Entrez la chaîne à décoder".
	ACCEPT ENTREE.
	
	PERFORM VARYING I FROM 1 BY 1 UNTIL I = FUNCTION LENGTH(ENTREE) + 1
		IF ENTREE(I:1) IS NOT = SPACE THEN
			MOVE ENTREE(I:1) TO XTMP
			ADD 1 TO I
			MOVE ENTREE(I:1) TO YTMP
			SUBTRACT 1 FROM XTMP
			COMPUTE TMP = XTMP * 5 + YTMP
			DISPLAY CARRE(TMP:1) WITH NO ADVANCING
		END-IF
	END-PERFORM.
	DISPLAY " ".
	STOP RUN.
END PROGRAM Polybe.

