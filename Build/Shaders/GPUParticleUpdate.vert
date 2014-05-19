#version 330

//in my information from the last out
in vec3 Position;
in vec3 Velocity;
in float Lifetime;
in float Lifespan;
in float Rotation;

//out my information for the next in
out vec3 position;
out vec3 velocity;
out float lifetime;
out float lifespan;
out float rotation;

//!--These must be pushed
uniform float time;
uniform float deltaTime;
//!--These must be pushed

//!--These are all defaulted, also done through the CPP
uniform float lifeMin = 1;
uniform float lifeMax = 5;
uniform float rotationStepMax = 0;
uniform vec3 acceleration = vec3(0);
uniform vec3 StartVelocity = vec3(0);
uniform vec3 emitterPosition = vec3(0);
uniform vec3 emitterRange = vec3(1);
uniform vec3 VelocityJitter = vec3(0);

//RAND
const float INVERSE_MAX_UINT = 1.0f / 4294967295.0f;
float rand(uint seed, float range) {
	uint i=(seed^12345391u)*2654435769u;
	i^=(i<<6u)^(i>>26u);
	i*=2654435769u;
	i+=(i<<5u)^(i>>12u);
	return float(range * i) * INVERSE_MAX_UINT;
}

//MAIN
void main() {
	uint seed = uint(time * 100.0) + uint(gl_VertexID);

	//move the particle how we told it to
	velocity = Velocity + acceleration * deltaTime;
	position = Position + velocity * deltaTime;
	lifetime = Lifetime + deltaTime;
	lifespan = Lifespan;
	rotation = Rotation + rand(seed++, rotationStepMax) * deltaTime;

	// emit a new particle as soon as it dies by resetting its variables
	if (position.y < 0.0f){lifetime = lifespan+1;}
	
	if (lifetime > lifespan) {
		position.x = emitterPosition.x + rand(seed++,emitterRange.x) - (emitterRange.x/2);
		position.y = emitterPosition.y + rand(seed++,emitterRange.y) - (emitterRange.y/2);
		position.z = emitterPosition.z + rand(seed++,emitterRange.z) - (emitterRange.z/2);
		if (StartVelocity == vec3(0,0,0)){
			velocity = vec3(rand(seed++, 2) - 1,rand(seed++, 2) - 1,rand(seed++, 2) - 1);
		}else{
			velocity = StartVelocity;
			velocity += vec3(
				rand(seed++, VelocityJitter.x) - (VelocityJitter.x/2),
				rand(seed++, VelocityJitter.y) - (VelocityJitter.y/2),
				rand(seed++, VelocityJitter.z) - (VelocityJitter.z/2)
			);
		}
		lifetime = 0;
		lifespan = rand(seed++, lifeMax - lifeMin) + lifeMin;
		rotation = 0;
	}
}

