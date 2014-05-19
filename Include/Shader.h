#ifndef SHADER_H
#define SHADER_H

#include <GL/glew.h>
#include <GLFW/glfw3.h>
#include <vector>

class Shader {
public:
	Shader(const char* ccs_VertFile = nullptr,const char* ccs_FragFile = nullptr,const char* ccs_TessControlFile = nullptr,const char* ccs_TessEvalFile = nullptr,const char* ccs_GeomFile = nullptr,const char* ccs_CompuFile = nullptr);
	~Shader();
	void Remove();
	void Use();
	void Load(GLuint glui_ShaderProgram,GLenum gle_ShaderType,const char* ccs_File);
	void FindUniforms(int i_amount,...);//WARNING will clear previous Uniforms
	void FindUniforms(const char* ccs_FilePath);
	void SetUniform(char* cs_Name,char* cs_Type,const int count,...);
	void SetAttribs(int i_Count,...);
	void SetFragOuts(int i_Count,...);
	void SetTexture(char* cs_Name,unsigned int ShaderTexID,unsigned int ModelTexID);
	static void None(){	glUseProgram(0); }
private:
	std::vector<std::pair<int,char*>> lUniforms;
	char* LoadShaderFile(const char* ccs_FilePath);
public:
	unsigned int iShaderID;
};
#endif