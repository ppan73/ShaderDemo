using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEditor;
using UnityEngine;
using UnityEngine.UI;

public class ButtonsPanel : MonoBehaviour
{
    //public
    public Button modelSelectButton;
    public Button shaderSelectButton;
    public Text shaderText;
    public Button resetViewButton;
    public Transform modelsFolder;
    public Button computeShaderButton;
    public ComputeShaderDemo computeShaderDemo;
    
    public Material material;
    
    //private
    private List<Shader> _shaderList = new List<Shader>();
    private List<GameObject> _modelList = new List<GameObject>();

    private int _currentModelIndex;
    private int _currentShaderIndex;
    
    private Vector3 _initialCameraPosition;
    private Quaternion _initialCameraRotation;
    
    private void Awake()
    {
        //hooks
        modelSelectButton.onClick.AddListener(HandleModelSelect);
        shaderSelectButton.onClick.AddListener(HandleShaderSelect);
        resetViewButton.onClick.AddListener(HandleResetView);
        computeShaderButton.onClick.AddListener(HandleComputeShader);
        
        //camera
        _initialCameraPosition = Camera.main.transform.position;
        _initialCameraRotation = Camera.main.transform.rotation;
        
        //get shaders
        computeShaderDemo.Kill();
        _shaderList = Resources.LoadAll<Shader>("Shaders").ToList();
        
        //get models
        for (int i = 0; i < modelsFolder.childCount; ++i)
        {
            _modelList.Add(modelsFolder.GetChild(i).gameObject);
        }

        _currentShaderIndex = 0;
        _currentModelIndex = 0;
        SetShader(_currentShaderIndex);
        ShowModel(_currentModelIndex);
    }

    //Handlers
    private void HandleModelSelect()
    {
        if (++_currentModelIndex >= _modelList.Count)
        {
            _currentModelIndex = 0;
        }

        ShowModel(_currentModelIndex);
    }

    private void HandleShaderSelect()
    {
        if (++_currentShaderIndex >= _shaderList.Count)
        {
            _currentShaderIndex = 0;
        }

        SetShader(_currentShaderIndex);
    }

    private void SetShader(int shaderIndex)
    {
        shaderText.text = _shaderList[shaderIndex].name;
        material.shader = _shaderList[shaderIndex];
    }
    
    private void ShowModel(int modelIndex)
    {
        for (int i = 0; i < _modelList.Count; ++i)
        {
            if (i == modelIndex)
            {
                _modelList[i].SetActive(true);
            }
            else
            {
                _modelList[i].SetActive(false);
            }
        }
    }

    private void HandleResetView()
    {
        Camera.main.transform.position = _initialCameraPosition;
        Camera.main.transform.rotation = _initialCameraRotation;
    }

    private void HandleComputeShader()
    {
        if (computeShaderDemo.gameObject.activeSelf)
        {
            modelsFolder.gameObject.SetActive(true);
            computeShaderDemo.Kill();
        }
        else
        {
            modelsFolder.gameObject.SetActive(false);
            computeShaderDemo.Init();
        }
    }
}
