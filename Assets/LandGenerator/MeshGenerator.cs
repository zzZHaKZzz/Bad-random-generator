using System.Collections;
using System.Collections.Generic;
using UnityEngine;
[RequireComponent(typeof(MeshFilter))]
[RequireComponent(typeof(MeshRenderer))]
[RequireComponent(typeof(MeshCollider))]
public class MeshGenerator : MonoBehaviour {
	public RenderTexture renderTexture;
    public Texture2D texture;
    public Vector2Int size;
    public List<Vector3> pos;
	public List<Vector2> uv;
    public int[] index;
	public bool fixSmooth;
    public Mesh mesh;
    public float height;


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
		texture = new Texture2D (renderTexture.width, renderTexture.height);
		texture.wrapMode = TextureWrapMode.Clamp;
    }
	
	// Update is called once per frame
	public void CallUpdate () {
		RenderTexture.active = renderTexture;
		texture.ReadPixels (new Rect (0, 0, renderTexture.width, renderTexture.height), 0, 0);
		texture.Apply ();
		GetComponent<MeshRenderer> ().material.mainTexture = texture;
		mesh.Clear ();
		pos.Clear ();
		uv.Clear ();
		for (int i = 0; i < size.x; i++) {
			for (int j = 0; j < size.y; j++) {
				AddVertex (i, j);
				AddVertex (i, j + 1);
				AddVertex (i + 1, j + 1);
				AddVertex (i + 1, j);
			}
		}

		index = new int[(size.x) * (size.y) * 4];
		for (int i = 0; i < index.Length; i++) {
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

		GetComponent<MeshCollider> ().sharedMesh = mesh;
	}

	void AddVertex(int x,int y) {
        Vector2 pixelSize=new Vector2(1f/size.x,1f/size.y);
		pos.Add(new Vector3(x, texture.GetPixelBilinear(x * pixelSize.x, y * pixelSize.y).r * height, y));
		uv.Add (new Vector2 (x * pixelSize.x, y * pixelSize.y));
    }
}
