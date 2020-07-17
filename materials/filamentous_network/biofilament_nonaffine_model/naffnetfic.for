      SUBROUTINE NAFFNETFIC(SFIC,CFIC,F,MF0,RW,FILPROPS,NAFFPROPS,
     1                                   DET,NDI)
C>    NON-AFFINE NETWORK:'FICTICIUOUS' CAUCHY STRESS AND ELASTICITY TNSR
      IMPLICIT NONE
      INCLUDE 'PARAM_UMAT.INC'
C
      DOUBLE PRECISION SFIC(NDI,NDI),
     1                  CFIC(NDI,NDI,NDI,NDI),F(NDI,NDI),MF0(NWP,NDI),
     2                 RW(NWP),
     3                 H(NDI,NDI),HH(NDI,NDI,NDI,NDI),
     4                 HI(NDI,NDI),HHI(NDI,NDI,NDI,NDI)
      DOUBLE PRECISION FILPROPS(6),NAFFPROPS(2),MFI(NDI),MF0I(NDI)
      DOUBLE PRECISION DET,AUX,LAMBDAI,DW,DDW,RWI,AUX1,AUX2,FI,FFI
      DOUBLE PRECISION L,R0,MU0,B0,BETA,LAMBDA,LAMBDA0,N,PP
      INTEGER NDI,I1,J1,K1,L1,M1
C
C     FILAMENT
      L      = FILPROPS(1)
      R0      = FILPROPS(2)
      MU0     = FILPROPS(3)
      BETA    = FILPROPS(4)
      B0      = FILPROPS(5)
      LAMBDA0 = FILPROPS(6)      
C     NETWORK
      N       = NAFFPROPS(1)
      PP      = NAFFPROPS(2)
C
      LAMBDA=ZERO
      H=ZERO
      HH=ZERO
      HI=ZERO
      HHI=ZERO
      AUX=N*(DET**(-ONE))
C  
      DO I1=1,NWP
C
       MFI=ZERO
       DO J1=1,NDI
        MF0I(J1)=MF0(I1,J1)
       END DO
       RWI=RW(I1)
C
       CALL DEFFIL(LAMBDAI,MFI,MF0I,F,NDI)
       LAMBDA=LAMBDA+(LAMBDAI**PP)*RWI
C
       CALL HFILFIC(HI,HHI,PP,LAMBDAI,MFI,RWI,NDI)
C
       DO J1=1,NDI
        DO K1=1,NDI
         H(J1,K1)=H(J1,K1)+HI(J1,K1)
         DO L1=1,NDI
          DO M1=1,NDI
           HH(J1,K1,L1,M1)=HH(J1,K1,L1,M1)+HHI(J1,K1,L1,M1)
          END DO
         END DO
        END DO
       END DO
C
      END DO
C
      LAMBDA=LAMBDA**(PP**(-ONE))
C
      CALL FIL(FI,FFI,DW,DDW,LAMBDA,LAMBDA0,L,R0,MU0,BETA,B0)
C
      CFIC=ZERO
      SFIC=ZERO
      AUX1=AUX*DW*LAMBDA**(ONE-PP)
      AUX2=AUX*(DDW*(LAMBDA**(TWO*(ONE-PP)))-
     1                     (PP-ONE)*DW*(LAMBDA**(ONE-TWO*PP)))
C
      DO J1=1,NDI
       DO K1=1,NDI
        SFIC(J1,K1)=AUX1*H(J1,K1)
        DO L1=1,NDI
         DO M1=1,NDI
          CFIC(J1,K1,L1,M1)=AUX1*HH(J1,K1,L1,M1)+AUX2*H(J1,K1)*H(L1,M1)
         END DO
        END DO
       END DO
      END DO
C
      RETURN
      END SUBROUTINE NAFFNETFIC
