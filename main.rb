require 'opengl'
require 'glu'
require 'glut'

include Gl
include Glu
include Glut

puts "Hola Mundo"


def display
  #Color de fondo: negro
  glClearColor(0.0, 0.0, 0.0, 0.0)
  #Limpiamos la pantalla
  glClear(GL_COLOR_BUFFER_BIT)
  #Modo proyección
  glMatrixMode(GL_PROJECTION)
  #Cargamos la matriz identidad
  glLoadIdentity
  #Proyección ortográfica dentro del cubo señalado
  glOrtho(-1.0, 1.0, -1.0, 1.0, -1.0, 1.0)

  #Modo Modelado
  glMatrixMode(GL_MODELVIEW)

  #Dibujamos un triángulo
  glBegin(GL_TRIANGLES)
    glColor3f(1.0,0.0,0.0) #Color primer vértice: rojo
    glVertex3f(0.0,0.8,0.0) #Posición primer vértice
    glColor3f(0.0,1.0,0.0) #Color primer vértice: verde
    glVertex3f(-0.6,-0.2,0.0) #Posición primer vértice
    glColor3f(0.0,0.0,1.0) #Color primer vértice: azul
    glVertex3f(0.6,-0.2,0.0) #Posición primer vértice
  glEnd
  glFlush
  glutPostRedisplay #Para evitar que el ciclo siga corriendo
end

glutInit
glutInitDisplayMode(GLUT_SINGLE | GLUT_RGBA)
glutInitWindowSize(500,500)
glutInitWindowPosition(20,20)
glutCreateWindow("Hola OpenGL, en Ruby")
glutDisplayFunc :display
glutMainLoop
