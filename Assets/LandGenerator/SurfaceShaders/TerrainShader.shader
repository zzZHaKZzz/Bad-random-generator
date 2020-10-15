Shader "Terrain"
{
	Properties
	{
		_Vector0("Vector 0", Vector) = (0,0,0,0)
		_M("M", Range( 0 , 1)) = 0.35
		_s("s", Range( 0 , 1)) = 0.35
		_Color2("Color 2", Color) = (0,0,0,0)
		_Sand("Sand", Color) = (0,0,0,0)
		_Snow("Snow", Color) = (0,0,0,0)
		_Color3("Color 3", Color) = (1,1,1,0)
		_Color0("Color 0", Color) = (1,1,1,0)
		_m("m", Float) = 0
		_Texture0("Texture 0", 2D) = "white" {}
		_PaintMask("PaintMask", 2D) = "black" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _Color0;
		uniform float4 _Color3;
		uniform sampler2D _Texture0;
		uniform float4 _Texture0_ST;
		uniform float4 _Color2;
		uniform float _m;
		uniform float4 _Texture0_TexelSize;
		uniform float4 _Snow;
		uniform float4 _Vector0;
		uniform float4 _Sand;
		uniform sampler2D _PaintMask;
		uniform float4 _PaintMask_ST;
		uniform float _M;
		uniform float _s;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Texture0 = i.uv_texcoord * _Texture0_ST.xy + _Texture0_ST.zw;
			float4 tex2DNode15 = tex2D( _Texture0, uv_Texture0 );
			float4 lerpResult76 = lerp( _Color0 , _Color3 , (0.0 + (tex2DNode15.a - 0.25) * (1.0 - 0.0) / (0.75 - 0.25)));
			float temp_output_54_0 = ( i.uv_texcoord.x + _Texture0_TexelSize.x );
			float temp_output_56_0 = ( i.uv_texcoord.y + _Texture0_TexelSize.y );
			float2 appendResult61 = (float2(temp_output_54_0 , temp_output_56_0));
			float4 tex2DNode52 = tex2D( _Texture0, appendResult61 );
			float temp_output_57_0 = ( i.uv_texcoord.y - _Texture0_TexelSize.y );
			float2 appendResult62 = (float2(temp_output_54_0 , temp_output_57_0));
			float4 tex2DNode58 = tex2D( _Texture0, appendResult62 );
			float temp_output_55_0 = ( i.uv_texcoord.x - _Texture0_TexelSize.x );
			float2 appendResult63 = (float2(temp_output_55_0 , temp_output_56_0));
			float4 tex2DNode59 = tex2D( _Texture0, appendResult63 );
			float2 appendResult64 = (float2(temp_output_55_0 , temp_output_57_0));
			float4 tex2DNode60 = tex2D( _Texture0, appendResult64 );
			float smoothstepResult74 = smoothstep( 0.5 , 1.0 , ( _m * ( max( max( tex2DNode52.r , tex2DNode58.r ) , max( tex2DNode59.r , tex2DNode60.r ) ) - min( min( tex2DNode52.r , tex2DNode58.r ) , min( tex2DNode59.r , tex2DNode60.r ) ) ) ));
			float clampResult80 = clamp( smoothstepResult74 , 0.0 , 1.0 );
			float4 lerpResult37 = lerp( lerpResult76 , _Color2 , clampResult80);
			float clampResult33 = clamp( (0.0 + (( tex2DNode15.r + (0.0 + (tex2DNode15.a - 0.0) * (_Vector0.z - 0.0) / (1.0 - 0.0)) ) - _Vector0.x) * (1.0 - 0.0) / (_Vector0.y - _Vector0.x)) , 0.0 , 1.0 );
			float4 lerpResult34 = lerp( lerpResult37 , _Snow , clampResult33);
			float4 lerpResult82 = lerp( lerpResult34 , _Sand , tex2DNode15.b);
			float4 color85 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
			float2 uv_PaintMask = i.uv_texcoord * _PaintMask_ST.xy + _PaintMask_ST.zw;
			float4 lerpResult84 = lerp( lerpResult82 , color85 , tex2D( _PaintMask, uv_PaintMask ).r);
			o.Albedo = lerpResult84.rgb;
			o.Metallic = _M;
			o.Smoothness = _s;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=16400
7;140;1906;893;-711.074;1126.856;1.3;True;True
Node;AmplifyShaderEditor.TexturePropertyNode;51;-1362.804,-419.6856;Float;True;Property;_Texture0;Texture 0;12;0;Create;True;0;0;False;0;None;b627a795508d41b488582ecc6a8b8b0b;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;53;-1247.558,616.7914;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexelSizeNode;40;-1449.052,925.269;Float;False;15;1;0;SAMPLER2D;_Sampler040;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;55;-915.8928,633.1978;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;56;-914.3932,823.9888;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;57;-916.6662,932.182;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;54;-918.832,527.0897;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;64;-709.7464,1210.41;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;62;-699.3218,763.1922;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;61;-700.3642,592.2283;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;63;-699.3218,1017.553;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;59;-439.5748,992.0532;Float;True;Property;_TextureSample3;Texture Sample 3;1;0;Create;True;0;0;False;0;None;b627a795508d41b488582ecc6a8b8b0b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;52;-448.4539,577.9832;Float;True;Property;_TextureSample1;Texture Sample 1;1;0;Create;True;0;0;False;0;None;b627a795508d41b488582ecc6a8b8b0b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;60;-433.0747,1197.454;Float;True;Property;_TextureSample4;Texture Sample 4;1;0;Create;True;0;0;False;0;None;b627a795508d41b488582ecc6a8b8b0b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;58;-443.5748,795.0532;Float;True;Property;_TextureSample2;Texture Sample 2;1;0;Create;True;0;0;False;0;None;b627a795508d41b488582ecc6a8b8b0b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMaxOpNode;65;-93.22741,674.561;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMinOpNode;68;-94.68202,795.5186;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMinOpNode;69;-72.79038,1202.08;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;66;-81.12981,1083.238;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;67;90.87666,857.024;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMinOpNode;70;95.0464,971.695;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;73;128.2517,649.1135;Float;False;Property;_m;m;11;0;Create;True;0;0;False;0;0;12.88;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;71;260.7812,839.7833;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;27;-550.116,-878.1074;Float;False;Property;_Vector0;Vector 0;3;0;Create;True;0;0;False;0;0,0,0,0;0.55,0.85,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;15;-830.6461,-603.4058;Float;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;None;b627a795508d41b488582ecc6a8b8b0b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;29;-217.9668,-655.9109;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;72;273.2517,746.1135;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;78;501.1722,-851.5333;Float;False;5;0;FLOAT;0;False;1;FLOAT;0.25;False;2;FLOAT;0.75;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;74;177.5951,486.9669;Float;False;3;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;30;14.61855,-623.3099;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;35;246.702,-905.0887;Float;False;Property;_Color0;Color 0;10;0;Create;True;0;0;False;0;1,1,1,0;0.434,0.628,0.03243944,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;77;239.641,-1093.991;Float;False;Property;_Color3;Color 3;9;0;Create;True;0;0;False;0;1,1,1,0;0.08215009,0.5294118,0.06617647,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;38;602.5057,-389.4236;Float;False;Property;_Color2;Color 2;6;0;Create;True;0;0;False;0;0,0,0,0;0.25,0.1269199,0.00919117,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;80;527.6735,590.1846;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;25;0.4676075,-858.6365;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;76;689.8404,-1068.415;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;33;210.4728,-561.4614;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;36;208.1385,-759.386;Float;False;Property;_Snow;Snow;8;0;Create;True;0;0;False;0;0,0,0,0;0.5595804,0.8455882,0.8455882,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;37;1135.711,-421.9983;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;34;1097.842,-633.288;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;81;1147.28,-915.71;Float;False;Property;_Sand;Sand;7;0;Create;True;0;0;False;0;0,0,0,0;1,0.903,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;83;1885.561,-783.306;Float;True;Property;_PaintMask;PaintMask;13;0;Create;True;0;0;False;0;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;82;1442.807,-758.2025;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;85;2356.874,-679.656;Float;False;Constant;_Paint;Paint;14;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;31;147.4789,-357.5901;Float;False;Property;_M;M;4;0;Create;True;0;0;False;0;0.35;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;32;155.9553,-278.6825;Float;False;Property;_s;s;5;0;Create;True;0;0;False;0;0.35;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;21;-378.7394,-217.3194;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;12;-760,-99.5;Float;False;Property;_showrocks;show,rocks;0;0;Create;True;0;0;False;0;0,0,0,0;0.03,1.01,0.29,0.65;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;19;-753.9635,-186.5469;Float;False;Property;_max;max;1;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;2;-806,126.5;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;14;-4,55.5;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-742.4927,-252.2388;Float;False;Property;_min;min;2;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;22;-141.0514,-215.9464;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;8;-512,125.5;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,1,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;84;2034.474,-475.5562;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;11;-334.5133,391.5648;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1553.046,-445.8699;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Terrain;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;40;0;51;0
WireConnection;55;0;53;1
WireConnection;55;1;40;1
WireConnection;56;0;53;2
WireConnection;56;1;40;2
WireConnection;57;0;53;2
WireConnection;57;1;40;2
WireConnection;54;0;53;1
WireConnection;54;1;40;1
WireConnection;64;0;55;0
WireConnection;64;1;57;0
WireConnection;62;0;54;0
WireConnection;62;1;57;0
WireConnection;61;0;54;0
WireConnection;61;1;56;0
WireConnection;63;0;55;0
WireConnection;63;1;56;0
WireConnection;59;0;51;0
WireConnection;59;1;63;0
WireConnection;52;0;51;0
WireConnection;52;1;61;0
WireConnection;60;0;51;0
WireConnection;60;1;64;0
WireConnection;58;0;51;0
WireConnection;58;1;62;0
WireConnection;65;0;52;1
WireConnection;65;1;58;1
WireConnection;68;0;52;1
WireConnection;68;1;58;1
WireConnection;69;0;59;1
WireConnection;69;1;60;1
WireConnection;66;0;59;1
WireConnection;66;1;60;1
WireConnection;67;0;65;0
WireConnection;67;1;66;0
WireConnection;70;0;68;0
WireConnection;70;1;69;0
WireConnection;71;0;67;0
WireConnection;71;1;70;0
WireConnection;15;0;51;0
WireConnection;29;0;15;4
WireConnection;29;4;27;3
WireConnection;72;0;73;0
WireConnection;72;1;71;0
WireConnection;78;0;15;4
WireConnection;74;0;72;0
WireConnection;30;0;15;1
WireConnection;30;1;29;0
WireConnection;80;0;74;0
WireConnection;25;0;30;0
WireConnection;25;1;27;1
WireConnection;25;2;27;2
WireConnection;76;0;35;0
WireConnection;76;1;77;0
WireConnection;76;2;78;0
WireConnection;33;0;25;0
WireConnection;37;0;76;0
WireConnection;37;1;38;0
WireConnection;37;2;80;0
WireConnection;34;0;37;0
WireConnection;34;1;36;0
WireConnection;34;2;33;0
WireConnection;82;0;34;0
WireConnection;82;1;81;0
WireConnection;82;2;15;3
WireConnection;21;0;15;4
WireConnection;21;3;20;0
WireConnection;21;4;19;0
WireConnection;14;0;11;0
WireConnection;22;0;21;0
WireConnection;22;1;15;1
WireConnection;8;0;2;0
WireConnection;84;0;82;0
WireConnection;84;1;85;0
WireConnection;84;2;83;1
WireConnection;11;0;8;0
WireConnection;11;1;20;0
WireConnection;11;2;19;0
WireConnection;0;0;84;0
WireConnection;0;3;31;0
WireConnection;0;4;32;0
ASEEND*/
//CHKSM=DFE03D4365683ACC3FBDCD2D4CFA145C2938DBA9