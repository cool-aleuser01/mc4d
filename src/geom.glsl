#version 410

layout(triangles) in;
layout(triangle_strip, max_vertices=3) out;

in vec4 vcolor[];
out vec4 color;

in vec3 vpos3[];
out vec3 pos3;

out vec3 normal;

void main()
{
  // Calculate a normal
  vec3 a = gl_in[1].gl_Position.xyz - gl_in[0].gl_Position.xyz;
  vec3 b = gl_in[2].gl_Position.xyz - gl_in[0].gl_Position.xyz;
  normal = normalize(cross(a, b));

  // Ensure it is pointing toward the camera
  if (dot(normal, gl_in[0].gl_Position.xyz) > 0) {
    normal = -normal;
  }

  for(int i = 0; i < gl_in.length(); i++)
  {
     // copy attributes
    gl_Position = gl_in[i].gl_Position;
    color = vcolor[i];
    pos3 = vpos3[i];

    // done with the vertex
    EmitVertex();
  }

  EndPrimitive();
}
