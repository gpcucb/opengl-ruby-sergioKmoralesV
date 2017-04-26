require 'opengl'
require 'glu'
require 'glut'

include Gl
include Glu
include Glut

def display

  glDepthFunc(GL_LEQUAL);
  glEnable(GL_DEPTH_TEST);
  glClearDepth(1.0);

  #Color de fondo: negro
  glClearColor(0.0, 0.0, 0.0, 0.0)
  #Limpiamos la pantalla
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
  #Modo proyección
  glMatrixMode(GL_PROJECTION)
  #Cargamos la matriz identidad
  glLoadIdentity
  #Proyección ortográfica dentro del cubo señalado
  # glOrtho(-1.0, 1.0, -1.0, 1.0, -1.0, 1.0)
  #Proyección perspectiva. El ángulo de visualización es de 60 grados, la razón ancho/alto es 1 (son inguales), la distancia mínima es z=1.0, y la distancia máxima es z=100.0
  gluPerspective(60.0,1.0,1.0,100.0)
  glTranslatef(0.0,0.0,-2.0)

  #Modo Modelado
  glMatrixMode(GL_MODELVIEW)
  #Dibujamos un cuadrado
  glBegin(GL_QUADS)
    #  Dibujamos un cuadrado
     glColor3f(0.0,1.0,1.0)
    #  Color para el cuadrado
     glVertex3f(-0.5,0.5,-0.5)
    #  Coordenadas del primer vértice (superior-izquierda)
     glVertex3f(-0.5,-0.5,0.5)
    #  Coordenadas del segundo vértice (inferior-izquierda)
     glVertex3f(0.5,-0.5,0.5)
    #  Coordenadas del primer vértice (inferior-derecha)
     glVertex3f(0.5,0.5,-0.5)
    #  Coordenadas del primer vértice (superior-derecha)
  glEnd()

  glBegin(GL_TRIANGLES)
    #  Dibujamos un cuadrado
     glColor3f(1.0,0.0,0.0)
    #  Color para el cuadrado
     glVertex3f(0.0,0.5,0.0)
    #  Coordenadas del primer vértice (superior-izquierda)
     glVertex3f(-0.7,-0.5,0.0)
    #  Coordenadas del segundo vértice (inferior-izquierda)
     glVertex3f(0.7,-0.5,0.0)
    #  Coordenadas del primer vértice (inferior-derecha)
    #  Coordenadas del primer vértice (superior-derecha)
  glEnd()
  # Terminamos de dibujar
  glFlush #Forzar el dibujado
  #glutPostRedisplay #Para evitar que el ciclo siga corriendo
  # sleep(20)
end

glutInit
glutInitDisplayMode(GLUT_SINGLE | GLUT_RGBA | GLUT_DEPTH)
glutInitWindowSize(500,500)
glutInitWindowPosition(20,20)
glutCreateWindow("Hola OpenGL, en Ruby")
glutDisplayFunc :display
glutMainLoop
