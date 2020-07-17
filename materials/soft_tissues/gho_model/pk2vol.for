      SUBROUTINE PK2VOL(PKVOL,PV,C,NDI)
C>    VOLUMETRIC PK2 STRESS
      IMPLICIT NONE
      INCLUDE 'PARAM_UMAT.INC'
C
      INTEGER NDI,I1,J1
      DOUBLE PRECISION PKVOL(NDI,NDI),C(NDI,NDI),CINV(NDI,NDI)
      DOUBLE PRECISION PV
C
      CALL MATINV3D(C,CINV,NDI)
C
      DO I1=1,NDI
        DO J1=1,NDI
          PKVOL(I1,J1)=PV*CINV(I1,J1)
        END DO
      END DO
C
      RETURN
      END SUBROUTINE PK2VOL
