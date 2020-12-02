      SUBROUTINE CONTRACTION42(S,LT,RT,NDI)
C>       DOUBLE CONTRACTION BETWEEN 4TH ORDER AND 2ND ORDER  TENSOR
C>      INPUT:
C>       LT - RIGHT 4TH ORDER TENSOR
C>       RT - LEFT  2ND ODER TENSOR
C>      OUTPUT:
C>       S - DOUBLE CONTRACTED TENSOR (2ND ORDER)
       IMPLICIT NONE
       INCLUDE 'PARAM_UMAT.INC'
C
       DOUBLE PRECISION RT(NDI,NDI),LT(NDI,NDI,NDI,NDI)
       DOUBLE PRECISION S(NDI,NDI)
       DOUBLE PRECISION AUX
C
       INTEGER I1,J1,K1,L1,NDI
C
       DO I1=1,NDI
        DO J1=1,NDI
          AUX=ZERO
         DO K1=1,NDI
          DO L1=1,NDI
            AUX=AUX+LT(I1,J1,K1,L1)*RT(K1,L1)
         END DO
        END DO
           S(I1,J1)=AUX
       END DO
      END DO
       RETURN
      END SUBROUTINE CONTRACTION42