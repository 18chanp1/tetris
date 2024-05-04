#ifndef JLIB_H_
#define JLIB_H_


#define OCTL_TETRIS_DEFAULT    (0xA2)

#define MILLISECONDS_PER_SEC (1000)

#define TETRIS_ROWS 20
#define TETRIS_COLS 15
#define TRUE 1
#define FALSE 0
#define INITIAL_TETRIS_SPEED (2)
#define TETRIS_SPEED_INCREASE (1)
#define NUM_SHAPES (7)
#define MAX_SHAPE_SIZE (4)
#define NUM_LINE_SUCCESS_MESSAGES (3)
#define RED_COLOR    (0x4)
#define GREEN_COLOR  (0x2)
#define BLUE_COLOR   (0x1)
#define TETRIS_COLOR (GREEN_COLOR)

#define VGA_BASE 0xf0040000
#define VGA_CTL (*(volatile unsigned char *)(VGA_BASE + 0x1))
#define VGA_CRX (*(volatile unsigned char *)(VGA_BASE + 0x3))
#define VGA_CRY (*(volatile unsigned char *)(VGA_BASE + 0x5))
#define VGA_TXT_BASE VGA_BASE + 0x2001
#define VGA_RAM(adr, val) ((*(volatile unsigned char *)(VGA_BASE + 0x2001 + (adr << 1))) = val)




#endif