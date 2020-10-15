Shader "TerrainPreview"
{
	Properties
	{
		_TessValue( "Max Tessellation", Range( 1, 32 ) ) = 15
		_Vector0("Vector 0", Vector) = (0,0,0,0)
		_Color2("Color 2", Color) = (0,0,0,0)
		_Sand("Sand", Color) = (0,0,0,0)
		_Snow("Snow", Color) = (0,0,0,0)
		_Color3("Color 3", Color) = (1,1,1,0)
		_Color0("Color 0", Color) = (1,1,1,0)
		_m("m", Float) = 0
		_Texture0("Texture 0", 2D) = "white" {}
		_PaintMask("PaintMask", 2D) = "black" {}
		_Height("Height", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Texture0;
		uniform float4 _Texture0_ST;
		uniform float _Height;
		uniform float4 _Color0;
		uniform float4 _Color3;
		uniform float4 _Color2;
		uniform float _m;
		uniform float4 _Texture0_TexelSize;
		uniform float4 _Snow;
		uniform float4 _Vector0;
		uniform float4 _Sand;
		uniform sampler2D _PaintMask;
		uniform float4 _PaintMask_ST;
		uniform float _TessValue;

		float4 tessFunction( )
		{
			return _TessValue;
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float2 uv_Texture0 = v.texcoord * _Texture0_ST.xy + _Texture0_ST.zw;
			float4 tex2DNode158 = tex2Dlod( _Texture0, float4( uv_Texture0, 0, 0.0) );
			v.vertex.xyz += ( tex2DNode158.r * float3(0,1,0) * _Height );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Texture0 = i.uv_texcoord * _Texture0_ST.xy + _Texture0_ST.zw;
			float4 tex2DNode158 = tex2D( _Texture0, uv_Texture0 );
			float4 lerpResult169 = lerp( _Color0 , _Color3 , (0.0 + (tex2DNode158.a - 0.25) * (1.0 - 0.0) / (0.75 - 0.25)));
			float temp_output_140_0 = ( i.uv_texcoord.x + _Texture0_TexelSize.x );
			float temp_output_138_0 = ( i.uv_texcoord.y + _Texture0_TexelSize.y );
			float2 appendResult143 = (float2(temp_output_140_0 , temp_output_138_0));
			float4 tex2DNode146 = tex2D( _Texture0, appendResult143 );
			float temp_output_139_0 = ( i.uv_texcoord.y - _Texture0_TexelSize.y );
			float2 appendResult142 = (float2(temp_output_140_0 , temp_output_139_0));
			float4 tex2DNode148 = tex2D( _Texture0, appendResult142 );
			float temp_output_137_0 = ( i.uv_texcoord.x - _Texture0_TexelSize.x );
			float2 appendResult144 = (float2(temp_output_137_0 , temp_output_138_0));
			float4 tex2DNode145 = tex2D( _Texture0, appendResult144 );
			float2 appendResult141 = (float2(temp_output_137_0 , temp_output_139_0));
			float4 tex2DNode147 = tex2D( _Texture0, appendResult141 );
			float smoothstepResult162 = smoothstep( 0.5 , 1.0 , ( _m * ( max( max( tex2DNode146.r , tex2DNode148.r ) , max( tex2DNode145.r , tex2DNode147.r ) ) - min( min( tex2DNode146.r , tex2DNode148.r ) , min( tex2DNode145.r , tex2DNode147.r ) ) ) ));
			float clampResult167 = clamp( smoothstepResult162 , 0.0 , 1.0 );
			float4 lerpResult172 = lerp( lerpResult169 , _Color2 , clampResult167);
			float clampResult170 = clamp( (0.0 + (( tex2DNode158.r + (0.0 + (tex2DNode158.a - 0.0) * (_Vector0.z - 0.0) / (1.0 - 0.0)) ) - _Vector0.x) * (1.0 - 0.0) / (_Vector0.y - _Vector0.x)) , 0.0 , 1.0 );
			float4 lerpResult173 = lerp( lerpResult172 , _Snow , clampResult170);
			float4 lerpResult176 = lerp( lerpResult173 , _Sand , tex2DNode158.b);
			float4 color177 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
			float2 uv_PaintMask = i.uv_texcoord * _PaintMask_ST.xy + _PaintMask_ST.zw;
			float4 lerpResult188 = lerp( lerpResult176 , color177 , tex2D( _PaintMask, uv_PaintMask ).r);
			o.Albedo = lerpResult188.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	//CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
7;140;1906;893;2910.959;1538.826;3.056252;True;True
Node;AmplifyShaderEditor.TexturePropertyNode;134;-2312.738,-596.8719;Float;True;Property;_Texture0;Texture 0;17;0;Create;True;0;0;False;0;None;b627a795508d41b488582ecc6a8b8b0b;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;135;-2197.492,439.6049;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexelSizeNode;136;-2398.986,748.0827;Float;False;-1;1;0;SAMPLER2D;_Sampler040;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;138;-1864.327,646.8024;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;137;-1865.827,456.0114;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;140;-1868.766,349.9033;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;139;-1866.6,754.9957;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;142;-1649.256,586.0059;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;141;-1659.681,1033.224;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;144;-1649.256,840.3666;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;143;-1650.298,415.0418;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;146;-1398.388,400.7967;Float;True;Property;_TextureSample1;Texture Sample 1;1;0;Create;True;0;0;False;0;None;b627a795508d41b488582ecc6a8b8b0b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;145;-1389.509,814.8669;Float;True;Property;_TextureSample3;Texture Sample 3;1;0;Create;True;0;0;False;0;None;b627a795508d41b488582ecc6a8b8b0b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;148;-1393.509,617.8669;Float;True;Property;_TextureSample2;Texture Sample 2;1;0;Create;True;0;0;False;0;None;b627a795508d41b488582ecc6a8b8b0b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;147;-1383.009,1020.268;Float;True;Property;_TextureSample4;Texture Sample 4;1;0;Create;True;0;0;False;0;None;b627a795508d41b488582ecc6a8b8b0b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMinOpNode;150;-1044.616,618.3323;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;149;-1043.162,497.3745;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;152;-1031.064,906.0517;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMinOpNode;151;-1022.725,1024.894;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;153;-859.0577,679.8377;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMinOpNode;154;-854.888,794.5087;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;155;-821.6827,471.9271;Float;False;Property;_m;m;16;0;Create;True;0;0;False;0;0;12.88;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;157;-1500.05,-1055.294;Float;False;Property;_Vector0;Vector 0;8;0;Create;True;0;0;False;0;0,0,0,0;0.55,0.85,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;158;-1780.58,-780.5921;Float;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;None;b627a795508d41b488582ecc6a8b8b0b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;156;-689.1531,662.597;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;159;-1167.901,-833.0974;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;160;-676.6826,568.9272;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;163;-935.3157,-800.4962;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;162;-772.3392,309.7805;Float;False;3;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;165;-710.2932,-1271.177;Float;False;Property;_Color3;Color 3;14;0;Create;True;0;0;False;0;1,1,1,0;0.08215009,0.5294118,0.06617647,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;164;-703.2322,-1082.275;Float;False;Property;_Color0;Color 0;15;0;Create;True;0;0;False;0;1,1,1,0;0.434,0.628,0.03243944,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;161;-448.762,-1028.72;Float;False;5;0;FLOAT;0;False;1;FLOAT;0.25;False;2;FLOAT;0.75;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;167;-422.2607,412.9981;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;166;-347.4287,-566.6099;Float;False;Property;_Color2;Color 2;11;0;Create;True;0;0;False;0;0,0,0,0;0.25,0.1269199,0.00919117,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;169;-260.0939,-1245.602;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;168;-949.4666,-1035.823;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;171;-741.7957,-936.5725;Float;False;Property;_Snow;Snow;13;0;Create;True;0;0;False;0;0,0,0,0;0.5595804,0.8455882,0.8455882,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;170;-739.4614,-738.6478;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;172;185.7767,-599.1846;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;174;197.3455,-1092.896;Float;False;Property;_Sand;Sand;12;0;Create;True;0;0;False;0;0,0,0,0;1,0.903,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;173;147.9075,-810.4743;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;175;935.6268,-960.4926;Float;True;Property;_PaintMask;PaintMask;18;0;Create;True;0;0;False;0;None;a0d0e39a11ca2ba4380d5fdea22357cc;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;176;492.8727,-935.389;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;177;1406.94,-856.8425;Float;False;Constant;_Paint;Paint;14;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;82;1008,304;Float;False;Property;_Height;Height;19;0;Create;True;0;0;False;0;0;50;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;80;976,64;Float;False;Constant;_Vector1;Vector 1;13;0;Create;True;0;0;False;0;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;185;-1692.427,-429.4252;Float;False;Property;_min;min;7;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;183;-1755.934,-50.68641;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;184;-953.9343,-121.6864;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;186;-1090.986,-393.1327;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;188;1084.54,-652.7425;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;189;-1284.448,214.3784;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;187;-1461.934,-51.68641;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,1,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;179;-793.9791,-455.8689;Float;False;Property;_s;s;10;0;Create;True;0;0;False;0;0.35;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;178;-802.4554,-534.7764;Float;False;Property;_M;M;9;0;Create;True;0;0;False;0;0.35;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;81;1216,48;Float;False;3;3;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;182;-1703.898,-363.7333;Float;False;Property;_max;max;1;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;181;-1709.934,-276.6864;Float;False;Property;_showrocks;show,rocks;0;0;Create;True;0;0;False;0;0,0,0,0;0.03,1.01,0.29,0.65;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;180;-1328.674,-394.5058;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1520.542,-472.6382;Float;False;True;6;Float;ASEMaterialInspector;0;0;Standard;TerrainPreview;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;1;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;2;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;136;0;134;0
WireConnection;138;0;135;2
WireConnection;138;1;136;2
WireConnection;137;0;135;1
WireConnection;137;1;136;1
WireConnection;140;0;135;1
WireConnection;140;1;136;1
WireConnection;139;0;135;2
WireConnection;139;1;136;2
WireConnection;142;0;140;0
WireConnection;142;1;139;0
WireConnection;141;0;137;0
WireConnection;141;1;139;0
WireConnection;144;0;137;0
WireConnection;144;1;138;0
WireConnection;143;0;140;0
WireConnection;143;1;138;0
WireConnection;146;0;134;0
WireConnection;146;1;143;0
WireConnection;145;0;134;0
WireConnection;145;1;144;0
WireConnection;148;0;134;0
WireConnection;148;1;142;0
WireConnection;147;0;134;0
WireConnection;147;1;141;0
WireConnection;150;0;146;1
WireConnection;150;1;148;1
WireConnection;149;0;146;1
WireConnection;149;1;148;1
WireConnection;152;0;145;1
WireConnection;152;1;147;1
WireConnection;151;0;145;1
WireConnection;151;1;147;1
WireConnection;153;0;149;0
WireConnection;153;1;152;0
WireConnection;154;0;150;0
WireConnection;154;1;151;0
WireConnection;158;0;134;0
WireConnection;156;0;153;0
WireConnection;156;1;154;0
WireConnection;159;0;158;4
WireConnection;159;4;157;3
WireConnection;160;0;155;0
WireConnection;160;1;156;0
WireConnection;163;0;158;1
WireConnection;163;1;159;0
WireConnection;162;0;160;0
WireConnection;161;0;158;4
WireConnection;167;0;162;0
WireConnection;169;0;164;0
WireConnection;169;1;165;0
WireConnection;169;2;161;0
WireConnection;168;0;163;0
WireConnection;168;1;157;1
WireConnection;168;2;157;2
WireConnection;170;0;168;0
WireConnection;172;0;169;0
WireConnection;172;1;166;0
WireConnection;172;2;167;0
WireConnection;173;0;172;0
WireConnection;173;1;171;0
WireConnection;173;2;170;0
WireConnection;176;0;173;0
WireConnection;176;1;174;0
WireConnection;176;2;158;3
WireConnection;184;0;189;0
WireConnection;186;0;180;0
WireConnection;186;1;158;1
WireConnection;188;0;176;0
WireConnection;188;1;177;0
WireConnection;188;2;175;1
WireConnection;189;0;187;0
WireConnection;189;1;185;0
WireConnection;189;2;182;0
WireConnection;187;0;183;0
WireConnection;81;0;158;1
WireConnection;81;1;80;0
WireConnection;81;2;82;0
WireConnection;180;0;158;4
WireConnection;180;3;185;0
WireConnection;180;4;182;0
WireConnection;0;0;188;0
WireConnection;0;11;81;0
ASEEND*/
//CHKSM=0BE0CF0F15F1B8C857D9B7298C34E99B0B5750B0