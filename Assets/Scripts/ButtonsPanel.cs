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

    public Material material;
    
    //private
    private List<Shader> _shaderList = new List<Shader>();
    private List<GameObject> _modelList = new List<GameObject>();

    private int _currentModelIndex;
    private int _currentShaderIndex;
    
    private Vector3 _initialCameraPosition;
    private Quaternion _initialCameraRotation;

    private const string SHADER_KEY = "CurrentShaderIndex";
    private const string MODEL_KEY = "CurrentModelIndex";
    
    private void Awake()
    {
        //hooks
        modelSelectButton.onClick.AddListener(HandleModelSelect);
        shaderSelectButton.onClick.AddListener(HandleShaderSelect);
        resetViewButton.onClick.AddListener(HandleResetView);

        //camera
        _initialCameraPosition = Camera.main.transform.position;
        _initialCameraRotation = Camera.main.transform.rotation;
        
        //get shaders
        _shaderList = Resources.LoadAll<Shader>("Shaders").ToList();
        
        //get models
        for (int i = 0; i < modelsFolder.childCount; ++i)
        {
            _modelList.Add(modelsFolder.GetChild(i).gameObject);
        }

        _currentShaderIndex = PlayerPrefs.GetInt(SHADER_KEY, 0);
        _currentModelIndex = PlayerPrefs.GetInt(MODEL_KEY, 0);
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
        PlayerPrefs.SetInt(MODEL_KEY, _currentModelIndex);

        ShowModel(_currentModelIndex);
    }

    private void HandleShaderSelect()
    {
        if (++_currentShaderIndex >= _shaderList.Count)
        {
            _currentShaderIndex = 0;
        }
        PlayerPrefs.SetInt(SHADER_KEY, _currentShaderIndex);

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
}
