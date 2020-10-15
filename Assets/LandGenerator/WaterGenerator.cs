using System.Collections;
using System.Collections.Generic;
using UnityEngine;
[RequireComponent(typeof(MeshFilter))]
[RequireComponent(typeof(MeshRenderer))]
public class WaterGenerator : MonoBehaviour {
	public RenderTexture renderTexture;
	public MeshGenerator meshGenerator;
	public Vector2Int size;
	public List<Vector3> pos;
	public List<Vector2> uv;
	public int[] index;
	public bool fixSmooth;
	public Mesh mesh;
	public float height,cutOut;
	// Use this for initialization
	void Awake()
	{
		MeshFilter _meshFilter = GetComponent<MeshFilter>();
		//Mesh mesh;
		//List<Vector3> points;

		mesh = new Mesh();
		mesh.indexFormat = UnityEngine.Rendering.IndexFormat.UInt32;
		mesh.SetVertices(pos);
		mesh.SetIndices(index, MeshTopology.Quads, 0);
		mesh.RecalculateNormals();
		_meshFilter.mesh = mesh;
	}

	// Update is called once per frame
	public void CallUpdate () {
		mesh.Clear ();
		pos.Clear ();
		uv.Clear ();
		Vector2 pixelSize=new Vector2(1f/size.x,1f/size.y);
		for (int i = 0; i < size.x; i++) {
			for (int j = 0; j < size.y; j++) {
				if (meshGenerator.texture.GetPixelBilinear (i * pixelSize.x, j * pixelSize.y).b > cutOut &&
					meshGenerator.texture.GetPixelBilinear (i * pixelSize.x, (j + 1) * pixelSize.y).b > cutOut &&
					meshGenerator.texture.GetPixelBilinear ((i + 1) * pixelSize.x, j * pixelSize.y).b > cutOut &&
					meshGenerator.texture.GetPixelBilinear ((i + 1) * pixelSize.x, (j + 1) * pixelSize.y).b > cutOut) {
					AddVertex (i, j);
					AddVertex (i, j + 1);
					AddVertex (i + 1, j + 1);
					AddVertex (i + 1, j);
				}
			}
		}

		index = new int[pos.Count];
		for (int i = 0; i < pos.Count; i++) {
			index [i] = i;
		}


		mesh.SetVertices (pos);
		mesh.SetUVs (0, uv);
		mesh.SetIndices (index, MeshTopology.Quads, 0);
		mesh.RecalculateNormals ();
		if (fixSmooth) {
			Vector3[] tnormals = mesh.normals;
			Vector3 fixNormal = Vector3.zero;
			for (int i = 0; i < tnormals.Length / 4; i++) {
				fixNormal = tnormals [i * 4];
				fixNormal += tnormals [i * 4 + 1];
				fixNormal += tnormals [i * 4 + 2];
				fixNormal += tnormals [i * 4 + 3];
				fixNormal = fixNormal.normalized;
				tnormals [i * 4] = fixNormal;
				tnormals [i * 4 + 1] = fixNormal;
				tnormals [i * 4 + 2] = fixNormal;
				tnormals [i * 4 + 3] = fixNormal;
			}
			mesh.normals = tnormals;
		}

	}

	void AddVertex(int x,int y) {
		Vector2 pixelSize=new Vector2(1f/size.x,1f/size.y);
		pos.Add(new Vector3(x, height * height, y));
		uv.Add (new Vector2 (x * pixelSize.x, y * pixelSize.y));
	}
}
