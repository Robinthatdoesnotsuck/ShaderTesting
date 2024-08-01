using System.Collections;
using System.Collections.Generic;
using JetBrains.Annotations;
using UnityEngine;

public class FollowCameraYaxisAngle : MonoBehaviour
{
    
    private Camera cameraToFollow;
    public float smooth = 5.0f;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        var radians = Mathf.Atan2(cameraToFollow.transform.forward.x, cameraToFollow.transform.forward.z);
        Quaternion rotationAroundX = Quaternion.Euler(0, radians * Mathf.Rad2Deg, 0);
        transform.rotation = rotationAroundX;
    }
}
