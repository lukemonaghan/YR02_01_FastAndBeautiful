#pragma once

#include <glm/glm.hpp>

// a basic vertex structure supporting position, colour and texture coordinate
struct BasicVertex
{
	BasicVertex(){};
	BasicVertex(glm::vec4 p,glm::vec4 c,glm::vec2 tc,glm::vec2 tc2){
		position =p;
		colour = c;
		texCoord = tc;
		texCoord2 = tc2;
	}
	glm::vec4 position;
	glm::vec4 colour;
	glm::vec2 texCoord;
	glm::vec2 texCoord2;
};
