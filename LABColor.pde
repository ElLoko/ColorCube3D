// Script made by Timo Bickert in 2017
// License see GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007

// This script creates a 3D color cube to explain the LAB color space.
// The script was a training 
// inspired by the work of Daniel Shifferman


class LABColor {
  
   private float LAB_L;
   private float LAB_a;
   private float LAB_b;
   private float RGB_r;
   private float RGB_g;
   private float RGB_b;

  public LABColor(float _LAB_L, float _LAB_a, float _LAB_b) {
    this.LAB_L = _LAB_L;
    this.LAB_a = _LAB_a;
    this.LAB_b = _LAB_b;
    this.calculateColor();
  }

  private void calculateColor() {
    float[] rgb = new float[3];
    rgb = LAB2RGB(this.LAB_L, this.LAB_a, this.LAB_b);
    this.RGB_r = rgb[0];
    this.RGB_g = rgb[1];
    this.RGB_b = rgb[2];
  }
  
  public HashMap getColor() {
    HashMap<String, Float> colors = new HashMap<String, Float>();   
    colors.put("LAB_L", LAB_L);
    colors.put("LAB_a", LAB_a);
    colors.put("LAB_b", LAB_b);
    colors.put("RGB_r", RGB_r);
    colors.put("RGB_g", RGB_g);
    colors.put("RGB_b", RGB_b);    
    return colors;
  }
     
  //private float deltaE(PVector LABProbe, PVector LABSample) {
  //  return (float)Math.sqrt( (LABProbe.x - LABSample.x) * (LABProbe.x - LABSample.x) + (LABProbe.y - LABSample.y) * (LABProbe.y - LABSample.y) + (LABProbe.z - LABSample.z) * (LABProbe.z - LABSample.z) );
  //}


  private float[] LAB2RGB(float L, float a, float b) {
    float[] RGB = new float[3];

    float ref_X = 95.682;
    float ref_Y = 100;
    float ref_Z = 108.833;

    float var_Y = (L + 16) / 116;
    float var_X = a / 500 + var_Y;
    float var_Z = var_Y - (b / 200);

    if ((var_Y*var_Y*var_Y) > 0.008856) {
      var_Y = var_Y * var_Y * var_Y;
    } else {
      var_Y = (var_Y - 16 / 116) / 7.787;
    }

    if ((var_X * var_X * var_X) > 0.008856) {
      var_X = var_X * var_X * var_X;
    } else {
      var_X = (var_X - 16 / 116) / 7.787;
    }

    if ((var_Z * var_Z * var_Z) > 0.008856) {
      var_Z = var_Z * var_Z * var_Z;
    } else {
      var_Z = (var_Z - 16 / 116) / 7.787;
    }

    float X = ref_X * var_X;
    float Y = ref_Y * var_Y;
    float Z = ref_Z * var_Z;

    var_X = X / 100;
    var_Y = Y / 100;
    var_Z = Z / 100;

    float var_R = var_X * 3.2406 + var_Y * -1.5372 + var_Z * -0.4986;
    float var_G = var_X * -0.9689 + var_Y * 1.8758 + var_Z * 0.0415;
    float var_B = var_X * 0.0557 + var_Y * -0.204 + var_Z * 1.057;

    if (var_R > 0.0031308) {
      var_R = 1.055 * (float)Math.pow(var_R, 1 / 2.4) - 0.055;
    } else {
      var_R = 12.92 * var_R;
    }

    if (var_G > 0.0031308) {
      var_G = 1.055 * (float)Math.pow(var_G, (1 / 2.4)) - 0.055;
    } else {
      var_G = 12.92 * var_G;
    }

    if (var_B > 0.0031308) {
      var_B = 1.055 * (float)Math.pow(var_B, (1 / 2.4)) - 0.055;
    } else {
      var_B = 12.92 * var_B;
    }

    float R = var_R * 255;
    float G = var_G * 255;
    float B = var_B * 255;

    if (R < 0) {
      R = 0;
    } else if (R > 255) {
      R = 255;
    }

    if (G < 0) {
      G = 0;
    } else if (G > 255) {
      G = 255;
    }

    if (B < 0) {
      B = 0;
    } else if (B > 255) {
      B = 255;
    }

    RGB[0] = R;
    RGB[1] = G;
    RGB[2] = B;

    return RGB;
  }
}