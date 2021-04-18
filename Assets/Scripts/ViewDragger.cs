using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class ViewDragger : MonoBehaviour, IDragHandler, IBeginDragHandler
{
    private Vector2 _lastPosition;
    private Transform _cameraTransform;
    private float _rotateScale = 0.4f;
    private float _translateScale = 0.01f;
    
    private void Awake()
    {
        _cameraTransform = Camera.main.transform;
    }

    public void OnBeginDrag(PointerEventData eventData)
    {
        _lastPosition = eventData.position;
    }

    public void OnDrag(PointerEventData pointerEventData)
    {
        Vector2 deltaPosition = pointerEventData.position - _lastPosition;

        if (Input.GetKey(KeyCode.Space))
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
            Vector3 currentCameraPosition = _cameraTransform.position;
            Vector3 newPosition;
            if (Input.GetKey(KeyCode.LeftShift))
            {
                newPosition = new Vector3(currentCameraPosition.x - deltaPosition.x * _translateScale, currentCameraPosition.y, currentCameraPosition.z - deltaPosition.y * _translateScale);
            }
            else
            {
                newPosition = new Vector3(currentCameraPosition.x - deltaPosition.x * _translateScale, currentCameraPosition.y - deltaPosition.y * _translateScale, currentCameraPosition.z);
            }
            _cameraTransform.position = newPosition;
        }

        _lastPosition = pointerEventData.position;
    }
}
