using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using UnityEngine;
using UnityEngine.EventSystems;

public class ViewDragger : MonoBehaviour, IDragHandler, IBeginDragHandler, IScrollHandler
{
    private Vector2 _lastPosition;
    private Transform _cameraTransform;
    private float _rotateScale = 0.8f;
    private float _translateScale = 0.005f;
    private float _zoomScale = 0.05f;
    
    private void Awake()
    {
        _cameraTransform = Camera.main.transform;
    }

    public void OnBeginDrag(PointerEventData eventData)
    {
        _lastPosition = eventData.position;
    }

    public void OnScroll(PointerEventData pointerEventData)
    {
        //zoom
        _cameraTransform.position = _cameraTransform.position + _cameraTransform.forward * pointerEventData.scrollDelta.y * _zoomScale;
    }
    
    public void OnDrag(PointerEventData pointerEventData)
    {
        Vector2 deltaPosition = pointerEventData.position - _lastPosition;

        if (pointerEventData.button == PointerEventData.InputButton.Right)
        {
            //rotate
            _cameraTransform.RotateAround(Vector3.zero, _cameraTransform.right, -deltaPosition.y * _rotateScale);
            if (Input.GetKey(KeyCode.LeftShift))
            {
                _cameraTransform.RotateAround(Vector3.zero, _cameraTransform.forward, deltaPosition.x * _rotateScale);
            }
            else
            {
                _cameraTransform.RotateAround(Vector3.zero, _cameraTransform.up, deltaPosition.x * _rotateScale);
            }
        }
        else
        {
            //translate
            _cameraTransform.position -= _cameraTransform.right * deltaPosition.x * _translateScale;
            if (pointerEventData.button == PointerEventData.InputButton.Middle)
            {
                //zoom
                _cameraTransform.position -= _cameraTransform.forward * deltaPosition.y * _translateScale;
            }
            else
            {
                _cameraTransform.position -= _cameraTransform.up * deltaPosition.y * _translateScale;
            }
        }

        _lastPosition = pointerEventData.position;
    }
}
