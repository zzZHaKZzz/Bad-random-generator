using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PaintControl : MonoBehaviour {
	public Vector2 pos,oldpos;
	public float size=150,angle,radius=.01f;
	public CustomRenderTexture PaintRenderTexture;
	// Use this for initialization
	public void Start () {
		PaintRenderTexture.Initialize ();
	}
	
	// Update is called once per frame
	void Update () {
		RaycastHit hit;
		if (Input.GetKey(KeyCode.Mouse0) && Physics.Raycast (Camera.main.ScreenPointToRay (Input.mousePosition),out hit)) {
			pos.x = hit.point.x/size;
			pos.y = hit.point.z/size;

			if (Input.GetKeyDown(KeyCode.Mouse0)){
				oldpos = pos;
			}

			if (oldpos != pos) {
				angle = Vector2.SignedAngle (Vector2.up, pos - oldpos);
			} else {
				angle = 0;
			}

			PaintRenderTexture.material.SetVector ("_vector", new Vector4 (oldpos.x, oldpos.y, radius, Vector2.Distance (pos, oldpos)));
			PaintRenderTexture.material.SetFloat ("_angle", angle);

			PaintRenderTexture.Update ();
			oldpos = pos;
		}
	}

	public void SetRadius(float setRad){
		radius = setRad;
	}

}
