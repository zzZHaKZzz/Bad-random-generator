using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TestInit : MonoBehaviour {
	public CustomRenderTexture customRenderTexture;
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		customRenderTexture.Initialize ();
	}
}
