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

    light_1_position = [20.0, 20.0, 50.0]
    light_2_position = [-20.0, -20.0, 50.0]
    color = [1.0,1.0,1.0,1.0]
    color2 = [0.0,1.0,1.0,1.0]
    ambient = [0.2,0.2,0.2,0.1]
    shine = 1.0

    glEnable(GL_LIGHTING)
    glEnable(GL_LIGHT0)
    glEnable(GL_LIGHT1)
    glEnable(GL_COLOR_MATERIAL)
    glColorMaterial(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE)
    glMaterialfv(GL_FRONT, GL_SPECULAR, color)
    glMaterialf(GL_FRONT, GL_SHININESS, shine * 128.0)
    glEnable(GL_NORMALIZE)
    glShadeModel(GL_SMOOTH)

    

    glLightfv(GL_LIGHT0,GL_POSITION,light_1_position)
    glLightfv(GL_LIGHT0,GL_DIFFUSE,color)
    glLightfv(GL_LIGHT0,GL_SPECULAR,color)

    #glLightfv(GL_LIGHT1,GL_POSITION,light_2_position)
    #glLightfv(GL_LIGHT1,GL_DIFFUSE,color2)
    #glLightfv(GL_LIGHT1,GL_SPECULAR,color2)

    glLightModelfv(GL_LIGHT_MODEL_AMBIENT, ambient)
    
    # Borramos el buffer de color y el Z-Buffer
    glMatrixMode(GL_PROJECTION)
    glLoadIdentity()
    gluPerspective(60.0,1.0,1.0,100.0)
    # Proyección perspectiva. El ángulo de visualización es de 60 grados, la razón ancho/alto es 1 (son inguales), la distancia mínima es z=1.0, y la distancia máxima es z=100.0
    glMatrixMode(GL_MODELVIEW)
    glTranslatef(0.0,0.0,-4.0)

    # Dibujamos el esfera1
    glPushMatrix()
       glColor3f(1.0,1.0,0.0)
       glTranslatef(0.9,0.9,0)
	   glutSolidSphere(0.9, 50, 50);
    glPopMatrix()

    # Dibujamos el esfera2
    glPushMatrix()
       glColor3f(0.0,0.0,1.0)
       glTranslatef(0.9,-0.9,0)
	   glutSolidSphere(0.9, 50, 50);
    glPopMatrix()

    # Dibujamos el esfera3
    glPushMatrix()
       glColor3f(1.0,0.0,1.0)
       glTranslatef(-0.9,-0.9,0)
	   glutSolidSphere(0.9, 50, 50);
    glPopMatrix()

    # Dibujamos el esfera4
    glPushMatrix()
       glColor3f(0.0,1.0,1.0)
       glTranslatef(-0.9,0.9,0)
	   glutSolidSphere(0.9, 50, 50);
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
