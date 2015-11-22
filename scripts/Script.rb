module Script
  def self.px
    logpos($game_player.x, $game_player.real_x, $game_player.direction == 6)
  end

  def self.py
    logpos($game_player.y, $game_player.real_y, $game_player.direction == 2)
  end

  # Temporary switch assignment
  def self.tmp_s1=(val)
    $game_switches[TMP_INDEX+0] = val
  end

  def self.tmp_s2=(val)
    $game_switches[TMP_INDEX+1] = val
  end

  def self.tmp_s3=(val)
    $game_switches[TMP_INDEX+2] = val
  end

  def self.tmp_v1=(val)
    $game_variables[TMP_INDEX+0] = val
  end

  def self.tmp_v2=(val)
    $game_variables[TMP_INDEX+1] = val
  end

  def self.tmp_v3=(val)
    $game_variables[TMP_INDEX+2] = val
  end

  private
  TMP_INDEX = 22

  def self.logpos(pos, realpos, positive)
    bigpos = pos * 128
    if realpos < bigpos
      return pos - 1 if positive
    elsif realpos > bigpos
      return pos + 1 if positive
    end
    return pos
  end
end

def enter_name
  $game_temp.name_calling = true
end

def check_exit(min, max, x: -1, y: -1)
  result = false
  if x >= 0
    if $game_player.x == x
      if $game_player.y >= min && $game_player.y <= max
        result = true
      end
    end
  elsif y >= 0
    if $game_player.y == y
      if $game_player.x >= min && $game_player.x <= max
        result = true
      end
    end
  end
  Script.tmp_s1 = $game_switches[11] ? false : result
end

def bg(name)
  $game_map.bg_name = name
end

def particles(type)
  $game_map.particles_type = type
end

def ambient(r, g = -1, b = -1)
  g = r if g < 0
  b = r if b < 0
  #$scene.ambient = Color.new(r, g, b)
end

def clear_ambient
  #$scene.ambient = Color.new(255, 255, 255)
end

def add_light(id, file, intensity, x, y)
  #$scene.add_light(id, file, intensity, x, y)
end

def del_light(id)
  #$scene.del_light(id)
end

def clear_lights
  #$scene.clear_lights
end

def fade_in_bulb
  #$scene.fade_in_bulb
end

def clamp_panorama
  $game_map.clamped_panorama = true
end

def wrap_map
  $game_map.wrapping = true
end
