require 'opengl'
require 'glu'
require 'glut'

include Gl
include Glu
include Glut

#@SQUARE_SIDE = 5.0

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
    glTranslatef(0.0,0.0,-30.0)


    # Dibujamos el cubo
    glTranslatef(0,0,0)
    glPushMatrix()
       glColor3f(1.0,0.0,0.0)
       glutWireCube(5)
    glPopMatrix()

    # Dibujamos el cubo escalado
    glPushMatrix()
       glScalef(2.0,2.0,2.0)
       glColor3f(0.0,1.0,0.0)
       glutWireCube(5)
    glPopMatrix()

    # Dibujamos el cubo trasladado
    glPushMatrix()
       glTranslatef(0,10,0)
       glColor3f(0.0,1.0,1.0)
       glutWireCube(5)
    glPopMatrix()

    # Dibujamos el cubo rotado
    glPushMatrix()
       glRotatef(30,30,0,10)
       glColor3f(0.0,0.5,1.0)
       glutWireCube(5)
    glPopMatrix()

    # Dibujamos el cubo rotado, trasladado, escalado
    glPushMatrix()
       glRotatef(40,30,0,30)
       glTranslatef(-15,-15,-10)
       glScalef(1.5,1.5,1.5)
       glColor3f(0.5,0.5,1.0)
       glutWireCube(5)
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
