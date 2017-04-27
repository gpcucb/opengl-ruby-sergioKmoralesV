require 'opengl'
require 'glu'
require 'glut'

include Gl
include Glu
include Glut

@BODY_HEIGHT = 4.0
@BODY_WIDTH = 2.5
@BODY_LENGTH = 1.0

@ARM_HEIGHT = 3.5
@ARM_WIDTH = 1.0
@ARM_LENGTH = 1.0

@LEG_HEIGHT = 4.5
@LEG_WIDTH = 1.0
@LEG_LENGTH = 1.0

@HEAD_RADIUS = 1.1

def display
    glDepthFunc(GL_LEQUAL)
         glEnable(GL_DEPTH_TEST)
    # Activamos el  el Z-Buffer
    glClearColor(0.0,0.0,0.0,0.0)
    glClearDepth(1.0)
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
    # Borramos el buffer de color y el Z-Buffer
    glMatrixMode(GL_PROJECTION)
    glLoadIdentity()
    gluPerspective(60.0,1.0,1.0,100.0)
    # Proyección perspectiva. El ángulo de visualización es de 60 grados, la razón ancho/alto es 1 (son inguales), la distancia mínima es z=1.0, y la distancia máxima es z=100.0
    glMatrixMode(GL_MODELVIEW)
    glTranslatef(0.0,0.0,-16.0)
    # Dibujamos el cuerpo
    glTranslatef(0,@BODY_HEIGHT/2,0)
    glPushMatrix()
       glScalef(@BODY_WIDTH,@BODY_HEIGHT,@BODY_LENGTH)
       glColor3f(0.0,0.3,0.8)
       glutSolidCube(1)
    glPopMatrix()
    # Dibujamos el brazo derecho
    glPushMatrix()
       glTranslatef(-(@BODY_WIDTH)/2,(@BODY_HEIGHT-@ARM_HEIGHT)/2,0)
       glTranslatef(0,@ARM_HEIGHT/2,0)
       glRotatef(-30,0,0,1)
       glTranslatef(0,-@ARM_HEIGHT/2,0)
       glPushMatrix()
         glScalef(@ARM_WIDTH,@ARM_HEIGHT,@ARM_LENGTH)
         glutSolidCube(1)
       glPopMatrix()
       # ya tenemos el brazo... la mano
       glTranslatef(0,-(@ARM_HEIGHT+@ARM_WIDTH)/2,0)
       glColor3f(1,0.6,0.6)
       glScalef(@ARM_WIDTH,@ARM_WIDTH,@ARM_LENGTH)
       glutSolidCube(1)
    glPopMatrix()
    # Dibujamos el brazo izquierdo
    glColor3f(0.0,0.3,0.8)
    glPushMatrix()
       glTranslatef((@BODY_WIDTH)/2,(@BODY_HEIGHT-@ARM_HEIGHT)/2,0)
       glTranslatef(0,@ARM_HEIGHT/2,0)
       glRotatef(30,0,0,1)
       glTranslatef(0,-@ARM_HEIGHT/2,0)
       glPushMatrix()
         glScalef(@ARM_WIDTH,@ARM_HEIGHT,@ARM_LENGTH)
         glutSolidCube(1)
       glPopMatrix()
       # ya tenemos el brazo... la mano
       glTranslatef(0,-(@ARM_HEIGHT+@ARM_WIDTH)/2,0)
       glColor3f(1,0.6,0.6)
       glScalef(@ARM_WIDTH,@ARM_WIDTH,@ARM_LENGTH)
       glutSolidCube(1)
    glPopMatrix()
    #Dibujamos la pierna derecha
    glColor3f(0.0,0.3,0.8)
    glPushMatrix()
       glTranslatef(-(@BODY_WIDTH-@LEG_WIDTH)/2,-
  (@BODY_HEIGHT+@LEG_HEIGHT)/2,0)
       glPushMatrix()
         glScalef(@LEG_WIDTH,@LEG_HEIGHT,@LEG_LENGTH)
         glutSolidCube(1)
       glPopMatrix()
       # ahora el píe
       glTranslatef(0,-(@LEG_HEIGHT+@LEG_WIDTH)/2,@LEG_LENGTH)
       glColor3f(0.3,0.4,0.4)
       glScalef(@LEG_WIDTH,@LEG_WIDTH,@LEG_LENGTH*2)
       glutSolidCube(1)
    glPopMatrix()
    #Dibujamos la pierna izquierda
    glColor3f(0.0,0.3,0.8)
    glPushMatrix()
       glTranslatef((@BODY_WIDTH-@LEG_WIDTH)/2,-(@BODY_HEIGHT+@LEG_HEIGHT)/2,0)
       glPushMatrix()
         glScalef(@LEG_WIDTH,@LEG_HEIGHT,@LEG_LENGTH)
         glutSolidCube(1)
       glPopMatrix()
       # ahora el píe
       glTranslatef(0,-(@LEG_HEIGHT+@LEG_WIDTH)/2,@LEG_LENGTH)
       glColor3f(0.3,0.4,0.4)
       glScalef(@LEG_WIDTH,@LEG_WIDTH,@LEG_LENGTH*2)
       glutSolidCube(1)
    glPopMatrix()
    # Dibujamos la cabeza
    glColor3f(1,0.6,0.6)
    glPushMatrix()
       glTranslatef(0,@BODY_HEIGHT/2 + @HEAD_RADIUS*3/4,0)
       glutSolidSphere(@HEAD_RADIUS,10,10)
    glPopMatrix()
    glFlush()
end


glutInit
glutInitDisplayMode(GLUT_SINGLE | GLUT_RGBA | GLUT_DEPTH)
glutInitWindowSize(500,500)
glutInitWindowPosition(20,20)
glutCreateWindow("Hola OpenGL, en Ruby")
glutDisplayFunc :display
glutMainLoop
