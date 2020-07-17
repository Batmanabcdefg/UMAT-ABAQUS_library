      SUBROUTINE ERFI(ERF,B,NTERM)
C>    IMAGINARY ERROR FUNCTION OF SQRT(B); B IS THE DISPERSION PARAM    
      IMPLICIT NONE
      INCLUDE 'PARAM_UMAT.INC'
C
      DOUBLE PRECISION ERF,B,PI
      DOUBLE PRECISION AUX,AUX1,AUX2,AUX3,AUX4,HALF,FACT
      INTEGER I1,J1,NTERM
C
      PI=FOUR*ATAN(ONE)
      AUX=SQRT(TWO*B)
      AUX1=TWO*AUX
      AUX2=(TWO/THREE)*(AUX**THREE)
      HALF=ONE/TWO
      AUX4=ZERO
      DO J1=3,NTERM
        I1=J1-1
       CALL FACTORIAL (FACT,I1)
       AUX3=TWO*J1-ONE
       AUX4=AUX4+(AUX**AUX3)/(HALF*AUX3*FACT)
      ENDDO
C
      ERF=PI**(-ONE/TWO)*(AUX1+AUX2+AUX4)
      RETURN
      END SUBROUTINE ERFI
