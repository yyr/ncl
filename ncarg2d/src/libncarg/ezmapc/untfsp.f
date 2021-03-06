C
C $Id: untfsp.f,v 1.5 2008-07-27 00:17:12 haley Exp $
C
C                Copyright (C)  2000
C        University Corporation for Atmospheric Research
C                All Rights Reserved
C
C The use of this Software is governed by a License Agreement.
C
      SUBROUTINE UNTFSP (INUNIT,IOUNIT,FACTOR,IFLG)
C
C SUBROUTINE TO DETERMINE CONVERGENCE FACTOR BETWEEN TWO LINEAL UNITS
C
C * INPUT ........
C * INUNIT * UNIT CODE OF SOURCE.
C * IOUNIT * UNIT CODE OF TARGET.
C
C * OUTPUT .......
C * FACTOR * CONVERGENCE FACTOR FROM SOURCE TO TARGET.
C * IFLG   * RETURN FLAG .EQ. 0 , NORMAL RETURN.
C            RETURN FLAG .NE. 0 , ABNORMAL RETURN.
C
      IMPLICIT REAL (A-Z)
      INTEGER INUNIT,IOUNIT,IFLG,MAXUNT
      DIMENSION FACTRS(6,6)
      COMMON /PRINZ0/ IPEMSG,IPELUN,IPPARM,IPPLUN
        INTEGER IPEMSG,IPELUN,IPPARM,IPPLUN
      SAVE   /PRINZ0/
      PARAMETER (ZERO = 0.0E0, MAXUNT = 6)
      DATA FACTRS /0.1000000000000000E01 , 0.0000000000000000E00 ,
     .             0.0000000000000000E00 , 0.2062648062470963E06 ,
     .             0.5729577951308231E02 , 0.0000000000000000E00 ,
     .             0.0000000000000000E00 , 0.1000000000000000E01 ,
     .             0.3048006096012192E00 , 0.0000000000000000E00 ,
     .             0.0000000000000000E00 , 0.1000002000004000E01 ,
     .             0.0000000000000000E00 , 0.3280833333333333E01 ,
     .             0.1000000000000000E01 , 0.0000000000000000E00 ,
     .             0.0000000000000000E00 , 0.3280839895013124E01 ,
     .             0.4848136811095360E-5 , 0.0000000000000000E00 ,
     .             0.0000000000000000E00 , 0.1000000000000000E01 ,
     .             0.2777777777777778E-3 , 0.0000000000000000E00 ,
     .             0.1745329251994330E-1 , 0.0000000000000000E00 ,
     .             0.0000000000000000E00 , 0.3600000000000000E04 ,
     .             0.1000000000000000E01 , 0.0000000000000000E00 ,
     .             0.0000000000000000E00 , 0.9999980000000000E00 ,
     .             0.3048000000000000E00 , 0.0000000000000000E00 ,
     .             0.0000000000000000E00 , 0.1000000000000000E01 /
C
      IF (INUNIT .GE. 0 .AND. INUNIT .LT. MAXUNT .AND.
     .    IOUNIT .GE. 0 .AND. IOUNIT .LT. MAXUNT) THEN
         FACTOR = FACTRS(IOUNIT+1 , INUNIT+1)
         IF (FACTOR .NE. ZERO) THEN
            IFLG = 0
            RETURN
         ELSE
            IF (IPEMSG .EQ. 0) WRITE (IPELUN,2000) INUNIT,IOUNIT
 2000       FORMAT (' INCONSISTENT UNIT CODES = ',I6,' / ',I6)
            IFLG = 12
            RETURN
         END IF
      ELSE
         IF (INUNIT.LT.0 .OR. INUNIT.GE.MAXUNT) THEN
            IF (IPEMSG .EQ. 0) WRITE (IPELUN,2010) INUNIT
 2010       FORMAT (' ILLEGAL SOURCE OR TARGET UNIT CODE = ',I6)
         ELSE
            IF (IPEMSG .EQ. 0) WRITE (IPELUN,2010) IOUNIT
         END IF
         IFLG = 11
         RETURN
      END IF
C
      END
