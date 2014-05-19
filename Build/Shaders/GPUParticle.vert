#version 150

in vec3 Position;
in vec3 Velocity;
in float Lifetime;
in float Lifespan;
in float Rotation;

out vec3 position;
out float lifetime;
out float lifespan;
out float rotation;

//simply push over
void main() {
	position = Position;
	lifetime = Lifetime;
	lifespan = Lifespan;
	rotation = Rotation;
}

