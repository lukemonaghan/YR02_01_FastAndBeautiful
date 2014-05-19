#version 150

in vec4 Colour;
in vec2 TexCoord;

uniform sampler2D DiffuseTexture;
uniform int useTextures;

void main(){
	vec4 texel;
	if (useTextures != 0){
		texel = texture(DiffuseTexture,TexCoord) * Colour;
	}else{
		texel = Colour;
	}
	if (texel.a <= 0.1f){discard;}
	gl_FragColor = texel;
}

