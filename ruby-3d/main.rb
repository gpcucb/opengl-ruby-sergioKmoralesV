require 'opengl'
require 'glu'
require 'glut'
require 'chunky_png'
require 'wavefront'
require 'sounder'

require_relative 'model'

include Gl
include Glu
include Glut

FPS = 100.freeze
DELAY_TIME = (1000.0 / FPS)
DELAY_TIME.freeze
@mercury_size = 2.0
Sounder::System.set_volume 70

def load_objects
  sound = Sounder::Sound.new "music/background.mp3"
  @explosion_sound = Sounder::Sound.new "music/explosion.mp3"
  puts "Loading model"
  @sun = Model.new('obj/planet', 'obj/sun.mtl')
  @mercury = Model.new('obj/planet', 'obj/mercury.mtl')
  @venus = Model.new('obj/planet', 'obj/venus.mtl')
  @earth = Model.new('obj/planet', 'obj/earth.mtl')
  @mars = Model.new('obj/planet', 'obj/mars.mtl')
  @jupiter = Model.new('obj/planet', 'obj/jupiter.mtl')
  @saturn = Model.new('obj/saturn', 'obj/saturn.mtl')
  @uranus = Model.new('obj/planet', 'obj/uranus.mtl')
  @neptune = Model.new('obj/planet', 'obj/neptune.mtl')
  @pluto = Model.new('obj/planet', 'obj/pluto.mtl')

  @silver = Model.new('obj/silversurfer', 'obj/silversurfer.mtl')
  @silver_glow = Model.new('obj/silversurfer_glow', 'obj/silversurfer_glow.mtl')
  @explosion = Model.new('obj/explosion','obj/explosion.mtl')
  sound.play 
  puts "model loaded"
end

def initGL
  glDepthFunc(GL_LEQUAL)
  glEnable(GL_DEPTH_TEST)
  glClearDepth(1.0)
  
  glClearColor(0.0, 0.0, 0.0, 0.0)
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)

  glEnable(GL_LIGHTING)
  glEnable(GL_LIGHT0)
  glEnable(GL_COLOR_MATERIAL)
  glColorMaterial(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE)
  glEnable(GL_NORMALIZE)
  glShadeModel(GL_SMOOTH)
  glEnable(GL_CULL_FACE)
  glCullFace(GL_BACK)

  light_position = [0.0, 50.0, 100.0]
  light_color = [1.0, 1.0, 1.0, 1.0]
  specular = [1.0, 1.0, 1.0, 0.0]
  ambient = [0.15, 0.15, 0.15, 1.0]
  glLightfv(GL_LIGHT0, GL_POSITION, light_position)
  glLightfv(GL_LIGHT0, GL_DIFFUSE, light_color)
  glLightfv(GL_LIGHT0, GL_SPECULAR, specular)
  glLightModelfv(GL_LIGHT_MODEL_AMBIENT, ambient)
end

def draw
  @frame_start = glutGet(GLUT_ELAPSED_TIME)
  check_fps
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)

   glPushMatrix
    glTranslate(@silver_surfer[0], 0.0, @silver_surfer[2])
    glRotatef(-45.0,0.0,1.0,0.0)
    glScalef(@silver_surfer_size, @silver_surfer_size, @silver_surfer_size)  if @explosion_size < 158.0
    glScalef(0.0, 0.0, 0.0) if @explosion_size >= 158.0
    @silver.draw
  glPopMatrix

  if @sun_size != 0.0 
    glPushMatrix
      glTranslate(0.0, 0.0, 0.0)
      glRotatef(@sun_spin, 0.0, 1.0, 0.0)
      glScalef(@sun_size, @sun_size, @sun_size)
      @sun.draw
    glPopMatrix
  end
  
  if @sun_size < 0.0
    glPushMatrix
      glTranslate(0.0, 0.0, 0.0)
      glScalef(@explosion_size, @explosion_size, @explosion_size) if @explosion_size < 290.0
      @explosion.draw
    glPopMatrix
    @explosion_sound.play if @explosion_size < 6.0
  end

  glPushMatrix
    glTranslate(0.0, 0.0, @silver_surfer_glow[2])
    glRotatef(90.0,0.0,180.0,0.0)
    glScalef(@silver_surfer_glow_size, @silver_surfer_glow_size, @silver_surfer_glow_size)
    @silver_glow.draw
  glPopMatrix

  glPushMatrix
    glTranslate(40.0*Math.cos(@mercury_angle*(Math::PI/180)), 0.0, 40.0*Math.sin(@mercury_angle*(Math::PI/180)))
    glRotatef(@mercury_spin, 0.0, 1.0, 0.0)
    glScalef(@mercury_size, @mercury_size, @mercury_size) if @explosion_size < 158.0
    glScalef(0.0, 0.0, 0.0) if @explosion_size >= 158.0
    @mercury.draw
  glPopMatrix

  glPushMatrix
    glTranslate(60.0*Math.cos(@venus_angle*(Math::PI/180)), 0.0, 60.0*Math.sin(@venus_angle*(Math::PI/180)))
    glRotatef(@venus_spin, 0.0, 1.0, 0.0)
    glScalef(@mercury_size*4.0, @mercury_size*4.0, @mercury_size*4.0) if @explosion_size < 158.0
    glScalef(0.0, 0.0, 0.0) if @explosion_size >= 158.0
    @venus.draw
  glPopMatrix

  glPushMatrix
    glTranslate(85.0*Math.cos(@earth_angle*(Math::PI/180)),0.0, 85.0*Math.sin(@earth_angle*(Math::PI/180)))
    glRotatef(@earth_spin, 0.0, 1.0, 0.0)
    glScalef(@mercury_size*4.0, @mercury_size*4.0, @mercury_size*4.0) if @explosion_size < 158.0
    glScalef(0.0, 0.0, 0.0) if @explosion_size >= 158.0
    @earth.draw
  glPopMatrix
  
  glPushMatrix
    glTranslate(105.0*Math.cos(@mars_angle*(Math::PI/180)),0.0, 105.0*Math.sin(@mars_angle*Math::PI/180))
    glRotatef(@mars_spin, 0.0, 1.0, 0.0)
    glScalef(@mercury_size*2.5, @mercury_size*2.5, @mercury_size*2.5) if @explosion_size < 158.0
    glScalef(0.0, 0.0, 0.0) if @explosion_size >= 158.0
    @mars.draw
  glPopMatrix
  
  glPushMatrix
    glTranslate(130.0*Math.cos(@jupiter_angle*(Math::PI/180)), 0.0,130.0*Math.sin(@jupiter_angle*Math::PI/180))
    glRotatef(@jupiter_spin, 0.0, 1.0, 0.0)
    glScalef(@mercury_size*8.0, @mercury_size*8.0, @mercury_size*8.0) if @explosion_size < 158.0
    glScalef(0.0, 0.0, 0.0) if @explosion_size >= 158.0
    @jupiter.draw
  glPopMatrix
  
  glPushMatrix
    glTranslate(190.0*Math.cos(@saturn_angle*(Math::PI/180)), 0.0,190.0*Math.sin(@saturn_angle*Math::PI/180))
    glRotatef(@saturn_spin, 0.0, 1.0, 0.0)
    glScalef(@mercury_size*8.0, @mercury_size*8.0, @mercury_size*8.0) if @explosion_size < 158.0
    glScalef(0.0, 0.0, 0.0) if @explosion_size >= 158.0
    @saturn.draw
  glPopMatrix
  
  glPushMatrix
    glTranslate(250.0*Math.cos(@uranus_angle*(Math::PI/180)), 0.0, 250.0*Math.sin(@uranus_angle*Math::PI/180))
    glRotatef(@uranus_spin, 0.0, 1.0, 0.0)
    glScalef(@mercury_size*6.0, @mercury_size*6.0, @mercury_size*6.0) if @explosion_size < 158.0
    glScalef(0.0, 0.0, 0.0) if @explosion_size >= 158.0
    @uranus.draw
  glPopMatrix
  
  glPushMatrix
    glTranslate(290.0*Math.cos(@neptune_angle*(Math::PI/180)), 0.0, 290.0*Math.sin(@neptune_angle*Math::PI/180))
    glRotatef(@neptune_spin, 0.0, 1.0, 0.0)
    glScalef(@mercury_size*6.0, @mercury_size*6.0, @mercury_size*6.0) if @explosion_size < 158.0
    glScalef(0.0, 0.0, 0.0) if @explosion_size >= 158.0
    @neptune.draw
  glPopMatrix
  
  glPushMatrix
    glTranslate(320.0*Math.cos(@pluto_angle*(Math::PI/180)), 0.0, 320.0*Math.sin(@pluto_angle*Math::PI/180))
    glRotatef(@pluto_spin, 0.0, 1.0, 0.0)
    glScalef(@mercury_size*0.7, @mercury_size*0.7, @mercury_size*0.7) if @explosion_size < 158.0
    glScalef(0.0, 0.0, 0.0) if @explosion_size >= 158.0
    @pluto.draw
  glPopMatrix

   glutSwapBuffers
end

def reshape(width, height)
  glViewport(0, 0, width, height)
  glMatrixMode(GL_PROJECTION)
  glLoadIdentity
  gluPerspective(45, (1.0 * width) / height, 0.001, 2000.0)
  glMatrixMode(GL_MODELVIEW)
  glLoadIdentity()
  #gluLookAt(-300.0, 450.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0)
  gluLookAt(-200.0, 300.0, -650.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0)
end


def validate_spin(angle)
  if angle > 360.0
    angle = angle - 360.0
  end
  angle
end

def idle
  @sun_spin += (24.47 /@slow_factor)
  @mercury_spin += (0.16  /@slow_factor)
  @venus_spin += (0.675  /@slow_factor)
  @earth_spin += (1 /@slow_factor)
  @mars_spin += (1.026  /@slow_factor)
  @jupiter_spin += ((11.86)  /@slow_factor)
  @uranus_spin += ((84)  /@slow_factor) 
  @saturn_spin += ((29)  /@slow_factor)
  @neptune_spin += ((164.79)  /@slow_factor)
  @pluto_spin += ((247) /@slow_factor)
  
  if @arrives_sun == false
    @silver_surfer[0] += 1
    @silver_surfer[2] += 1
  else
    @sun_size -=0.2 if @sun_size > 0.0
    @explosion_size += 1 if(@sun_size < 0.0 && @explosion_size < 290.0)
  end

  @silver_surfer_size -= 0.1 if @silver_surfer_size > 0.0
  @silver_surfer_glow_size += 0.3 if @explosion_size >= 158.0
  @silver_surfer_glow[2] += 3 if @explosion_size >= 158.0

  @arrives_sun = true if @silver_surfer[0] == 0.0

  @earth_angle += 0.02
  @mercury_angle += (0.02*4)
  @venus_angle += (0.02*1.6)
  @mars_angle += (0.02*0.52)
  @jupiter_angle += (0.02*0.40)
  @saturn_angle += (0.02*0.32)
  @uranus_angle += (0.02*0.205)
  @neptune_angle += (0.02*0.108)
  @pluto_angle += (0.02*0.06)  
  
  @mercury_angle = @mercury_angle - 360.0 if @mercury_angle > 360.0
  @venus_angle = @venus_angle - 360.0 if @venus_angle > 360.0
  @mars_angle = @mars_angle - 360.0 if @mars_angle > 360.0
  @earth_angle = @earth_angle - 360.0 if @earth_angle > 360.0
  @jupiter_angle = @jupiter_angle - 360.0 if @jupiter_angle > 360.0
  @saturn_angle = @saturn_angle - 360.0 if @saturn_angle > 360.0
  @neptune_angle = @neptune_angle - 360.0 if @neptune_angle > 360.0
  @pluto_angle = @pluto_angle - 360.0 if @pluto_angle > 360.0
  @uranus_angle = @uranus_angle - 360.0 if @uranus_angle > 360.0

  @sun_spin = @sun_spin - 360.0 if @sun_spin > 360.0
  @mercury_spin = @mercury_spin - 360.0 if @mercury_spin > 360.0
  @venus_spin = @venus_spin - 360.0 if @venus_spin > 360.0
  @mars_spin = @mars_spin - 360.0 if @mars_spin > 360.0
  @earth_spin = @earth_spin - 360.0 if @earth_spin > 360.0
  @jupiter_spin = @jupiter_spin - 360.0 if @jupiter_spin > 360.0
  @saturn_spin = @saturn_spin - 360.0 if @saturn_spin > 360.0
  @neptune_spin = @neptune_spin - 360.0 if @neptune_spin > 360.0
  @pluto_spin = @pluto_spin - 360.0 if @pluto_spin > 360.0
  @uranus_spin = @uranus_spin - 360.0 if @uranus_spin > 360.0

  @frame_time = glutGet(GLUT_ELAPSED_TIME) - @frame_start
  
  if (@frame_time< DELAY_TIME)
    sleep((DELAY_TIME - @frame_time) / 1000.0)
  end
  glutPostRedisplay
end

def check_fps
  current_time = glutGet(GLUT_ELAPSED_TIME)
  delta_time = current_time - @previous_time

  @frame_count += 1

  if (delta_time > 1000)
    fps = @frame_count / (delta_time / 1000.0)
    puts "FPS: #{fps}"
    @frame_count = 0
    @previous_time = current_time
  end
end

@slow_factor = 40

@earth_angle = 30.0
@mercury_angle = 45.0
@venus_angle = 90.0
@mars_angle = 180.0
@jupiter_angle = 300.0
@saturn_angle = 200.0
@neptune_angle = 25.0
@uranus_angle = 150.0
@pluto_angle = 70.0 

@earth_spin = 0.0
@sun_spin = 0.0
@mercury_spin = 0.0
@venus_spin = 0.0
@mars_spin = 0.0
@jupiter_spin = 0.0
@saturn_spin = 0.0
@neptune_spin = 0.0
@uranus_spin = 0.0
@pluto_spin = 0.0 
@silver_surfer = [-200.0,0.0,-200.0]
@silver_surfer_size = @mercury_size *15.0
@silver_surfer_glow = [0.0,0.0,0.0]
@silver_surfer_glow_size = 1.0
@arrives_sun = false
@sun_size = @mercury_size *15.0
@explosion_size = 1.0
@previous_time = 0
@frame_count = 0

load_objects
glutInit
glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE | GLUT_DEPTH)
glutInitWindowSize(800,600)
glutInitWindowPosition(10,10)
glutCreateWindow("Hola OpenGL, en Ruby")
glutDisplayFunc :draw
glutReshapeFunc :reshape
glutIdleFunc :idle
initGL
glutMainLoop
