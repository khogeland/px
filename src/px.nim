from colorsys import hsvToRgb
from colorsys import rgbToHsv
import gifwriter

func numberFucker(numbers: seq[int]): seq[int] =
  result = @[0, 0, 0]
  for i in 0..len(numbers)-1:
    let a = (if i != 0: i-1 else: len(numbers) - 1) 
    result[i] = (numbers[a] + numbers[i])

func doubleFucker(anums, bnums: seq[int]): seq[int] =
  result = @[0, 0, 0]
  for i in 0..len(anums)-1:
    if anums[i] > bnums[i]:
      result[i] = anums[i] + bnums[i]
    else:
      result[i] = (anums[i] - bnums[i])

func `%`(a, b: int): int =
  if b == 0:
    return a
  return a mod b

when isMainModule:
  var
    gif = newGif("out.gif", 128, 128, fps=24)
    pixels = newSeq[Color](128 * 128)

  for frame in 0..<128:
    for i in 0..<pixels.len:
      let x = i mod 128
      let y = int(i / 128)
      #var rgb = numberFucker(@[frame - i, 255 - int(i/80), (frame * int(i/40)) mod 120])
      # cool 1
      #var coolio = @[int(frame/2 * (i/5)) mod 150, frame - i, 255 - int(i/80)]
      var coolio = @[
        #frame,
        #(int(frame/2 * (i/1))) % frame,
        #frame*2,
        #y, y, y,
        #x, x, x,
        #1, 1, 1,
        int((frame*2) - (i*x)),
        1,
        (frame*4 - int(i/5)),
        #int((frame*2) - (i*x)),
        #int((frame*2) - (i*x)),
      ]
      #var rgb = @[
        #frame - i,
        #int(frame/2 * (i/5)) mod 150,
        #255 - int(i/80)]
      var rgb = @[
        int((frame*4) + (i*y)),
        (frame*2 + int(i/10)),
        #frame * y,
        #((y-(frame*11) % (y+1)) * (x*((frame+1)%16))),
        #(int(frame * int(i/5)) % int(y/2)),
        int((frame*2) + (i*y)),
        # VERY GOOD LOOP int((frame*2) + (i*y)),
        # LOOP int(float(frame)*1.1 + (i/y)),
        # LOOP (frame*2 + int(i/64)),
        #((frame*2) - (x%2)),
        #int(frame/2 * (i/5)) mod 180,
        #(frame*2) - x,
        #int(frame/2 * (i/5)) mod 180,
      ]

      #rgb = coolio
      rgb = doubleFucker(coolio, rgb)

      #var hsved = rgbToHsv(@[float(coolio[0])/255, float(coolio[1])/255, float(coolio[2])/255])

      #rgb = numberFucker(rgb)
      #rgb = numberFucker(rgb)
      #var rgb = @[
      #frame mod 32,
      ##0,
      #(y mod (frame+1)) mod 32,
      ##0,
      #(int(frame / y*255) mod 32) * 5
      #]
      var h = float(max(rgb))
      rgb[0] = abs(rgb[0] % 255)
      rgb[1] = abs(rgb[1] % 255)
      rgb[2] = abs(rgb[2] % 255)
      if (i == 11):
        echo(frame)
      let arst = hsvToRgb(@[
        float(rgb[0])/255,
        float(rgb[1])/255,
        float(rgb[2])/255,
      ])
      #let arst = hsvToRgb(hsved)
      #pixels[i].r = uint8(float(rgb[0]) / h * 255)
      #pixels[i].g = uint8(float(rgb[1]) / h * 255)
      #pixels[i].b = uint8(float(rgb[2]) / h * 255)

      #pixels[i].r = uint8(float(arst[0]) / h * 255)
      #pixels[i].g = uint8(float(arst[1]) / h * 255)
      #pixels[i].b = uint8(float(arst[2]) / h * 255)

      pixels[i].r = uint8(arst[0] * 255)
      pixels[i].g = uint8(arst[1] * 255)
      pixels[i].b = uint8(arst[2] * 255)
      #echo (rgb)
      #echo (pixels[i])
    gif.write(pixels)

  gif.close()
