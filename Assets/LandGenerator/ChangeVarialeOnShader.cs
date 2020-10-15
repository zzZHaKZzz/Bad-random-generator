using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChangeVarialeOnShader : MonoBehaviour {
	public Material generationMaterial;
	public Vector4 _OffsetGroundOffsetMountain,_OffsetLowGroundOffsetOcean;

	// Use this for initialization
	public void Randomize () {
		_OffsetGroundOffsetMountain = new Vector4 (Random.Range (-65535f, 65535f),Random.Range (-65535f, 65535f),Random.Range (-65535f, 65535f),Random.Range (-65535f, 65535f));
		_OffsetLowGroundOffsetOcean = new Vector4 (Random.Range (-65535f, 65535f),Random.Range (-65535f, 65535f),Random.Range (-65535f, 65535f),Random.Range (-65535f, 65535f));
	}
	
	// Update is called once per frame
	void Update () {
		generationMaterial.SetVector ("_OffsetGroundOffsetMountain", _OffsetGroundOffsetMountain);
		generationMaterial.SetVector ("_OffsetLowGroundOffsetOcean", _OffsetLowGroundOffsetOcean);
	}

	void SetIsIsland(bool isIsland){
		
	}
}
