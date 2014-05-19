#version 330

layout( location = 0 ) in vec4 position;
layout( location = 7 ) in vec2 texCoord;
layout( location = 10 ) in vec2 texCoordTESS;

out vec2 TexCoord;
out vec2 TexCoordTESS;

void main() {
	TexCoord = texCoord;
	TexCoordTESS = texCoordTESS;
	gl_Position = position;
}