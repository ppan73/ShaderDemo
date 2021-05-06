using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ComputeShaderDemo : MonoBehaviour
{
    public ComputeShader Shader;
    public MeshRenderer meshRenderer;

    private RenderTexture tex;
    private int kernelHandle;
    
    private void Awake()
    {
        gameObject.SetActive(false);
    }

    public void Init()
    {
        gameObject.SetActive(true);
        
        //Get the compute shader kernel
        kernelHandle = Shader.FindKernel("Demo");

        //Create texture
        tex = new RenderTexture(256,256,24);
        tex.enableRandomWrite = true;
        tex.Create();
    }

    public void Kill()
    {
        gameObject.SetActive(false);
    }

    void Update()
    {
        Shader.SetFloat("Time", Time.time);
        Shader.SetTexture(kernelHandle, "Result", tex);
        Shader.Dispatch(kernelHandle, 256 / 8, 256 / 8, 1);

        meshRenderer.material.mainTexture = tex;
    }
}
