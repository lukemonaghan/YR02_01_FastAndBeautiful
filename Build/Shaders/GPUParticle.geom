#version 330

layout(points) in;
layout(triangle_strip, max_vertices = 4) out;

in vec3 position[];
in float lifetime[];
in float lifespan[];
in float rotation[];

out vec4 Colour;
out vec2 TexCoord;

uniform mat4 Projection;

uniform mat4 cameraTransform;

uniform vec2 sizeStart = vec2(1);
uniform vec2 sizeEnd = vec2(0);

uniform vec4 colourStart = vec4(1);
uniform vec4 colourEnd = vec4(0);

mat4 rotationmatrix;

void main( ) {
	// interpolate colour
	Colour = mix( colourStart, colourEnd, lifetime[0] / lifespan[0] );
	// calculate the size and create the corners of a quad
	float halfSize;
	if (sizeStart.x == sizeEnd.x){
		halfSize = sizeStart.x * 0.5f;
	}else{
		halfSize = mix( sizeStart.x, sizeEnd.x, lifetime[0] / lifespan[0] ) * 0.5f;
	}

	//create rotational matrix
	rotationmatrix = mat4(	cos(rotation[0]),-sin(rotation[0]),0.0,0.0,sin(rotation[0]), cos(rotation[0]),0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,1.0);  
	//Create the quad with rotation
	vec3 corners[4];
	corners[0] = (rotationmatrix * vec4(  halfSize, -halfSize, 0 ,1)).xyz;
	corners[1] = (rotationmatrix * vec4(  halfSize,  halfSize, 0 ,1)).xyz;
	corners[2] = (rotationmatrix * vec4( -halfSize, -halfSize, 0 ,1)).xyz;
	corners[3] = (rotationmatrix * vec4( -halfSize,  halfSize, 0 ,1)).xyz;

	// billboard
	vec3 zAxis = normalize( cameraTransform[3].xyz - position[0] );
	vec3 xAxis = cross( cameraTransform[1].xyz, zAxis );
	vec3 yAxis = cross( zAxis, xAxis );
	mat3 billboard = mat3(xAxis,yAxis,zAxis);

	//make our View (done on GPU to save pushing two uniforms, less CPU load)
	mat4 View = inverse(cameraTransform);
	//finally push each to shader
	gl_Position = Projection * View * vec4(billboard * corners[0] + position[0], 1);
	TexCoord = vec2(0,1);
	EmitVertex();

	gl_Position = Projection * View * vec4(billboard * corners[1] + position[0], 1);
	TexCoord = vec2(0,0);
	EmitVertex();

	gl_Position = Projection * View * vec4(billboard * corners[2] + position[0], 1);
	TexCoord = vec2(1,1);
	EmitVertex();

	gl_Position = Projection * View * vec4(billboard * corners[3] + position[0], 1);
	TexCoord = vec2(1,0);
	EmitVertex();
}

