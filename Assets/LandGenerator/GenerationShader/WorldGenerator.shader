Shader "Hidden/WorldGenerator"
{
	Properties
	{
		_OffsetGroundOffsetMountain("OffsetGround,OffsetMountain", Vector) = (0,0,0,0)
		_OffsetLowGroundOffsetOcean("OffsetLowGround,OffsetOcean", Vector) = (0,0,0,0)
		_pow("pow", Float) = 0
		_v("v", Float) = 0
		_MaxHeight("MaxHeight", Float) = 256
		_StartHeightGround("StartHeightGround", Float) = 0
		_HeightGround("HeightGround", Float) = 0
		_Water("Water", Float) = 0
		_Float0("Float 0", Float) = 0.5
		_B("B", Range( 0.5 , 1)) = 0.5
		_Ocean("Ocean", Range( 0 , 1)) = 0
		[MaterialToggle]_isIsland("isIsland", Float) = 0
		_DephtLake("DephtLake", Range( 0 , 1)) = 0.15
		_SizeLake("SizeLake", Range( 0 , 1)) = 0.85
	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Opaque" }
		LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend Off
		Cull Back
		ColorMask RGBA
		ZWrite On
		ZTest LEqual
		Offset 0 , 0
		
		
		
		Pass
		{
			Name "Unlit"
			
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			

			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 ase_texcoord : TEXCOORD0;
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord : TEXCOORD0;
			};

			uniform float4 _OffsetGroundOffsetMountain;
			uniform float _HeightGround;
			uniform float _MaxHeight;
			uniform float _StartHeightGround;
			uniform float _pow;
			uniform float _v;
			uniform float _Water;
			uniform float4 _OffsetLowGroundOffsetOcean;
			uniform float _SizeLake;
			uniform float _DephtLake;
			uniform float _B;
			uniform float _Float0;
			uniform float _Ocean;
			uniform float _isIsland;
			float MyCustomExpression( float2 p , float2 _offset , float _scale , float _gain , float _power , float _value , float _amplitude , float _frequency )
			{
				                p = p * _scale + _offset;
				                for( int i = 0; i < 7; i++ )
				                {
				                    float2 i = floor( p * _frequency );
				                    float2 f = frac( p * _frequency );      
				                    float2 t = f * f * f * ( f * ( f * 6.0 - 15.0 ) + 10.0 );
				                    float2 a = i + float2( 0.0, 0.0 );
				                    float2 b = i + float2( 1.0, 0.0 );
				                    float2 c = i + float2( 0.0, 1.0 );
				                    float2 d = i + float2( 1.0, 1.0 );
				                    a = -1.0 + 2.0 * frac( sin( float2( dot( a, float2( 127.1, 311.7 ) ),dot( a, float2( 269.5,183.3 ) ) ) ) * 43758.5453123 );
				                    b = -1.0 + 2.0 * frac( sin( float2( dot( b, float2( 127.1, 311.7 ) ),dot( b, float2( 269.5,183.3 ) ) ) ) * 43758.5453123 );
				                    c = -1.0 + 2.0 * frac( sin( float2( dot( c, float2( 127.1, 311.7 ) ),dot( c, float2( 269.5,183.3 ) ) ) ) * 43758.5453123 );
				                    d = -1.0 + 2.0 * frac( sin( float2( dot( d, float2( 127.1, 311.7 ) ),dot( d, float2( 269.5,183.3 ) ) ) ) * 43758.5453123 );
				                    float A = dot( a, f - float2( 0.0, 0.0 ) );
				                    float B = dot( b, f - float2( 1.0, 0.0 ) );
				                    float C = dot( c, f - float2( 0.0, 1.0 ) );
				                    float D = dot( d, f - float2( 1.0, 1.0 ) );
				                    float noise = ( lerp( lerp( A, B, t.x ), lerp( C, D, t.x ), t.y ) );              
				                    _value += _amplitude * noise;
				                    _frequency *= 2;
				                    _amplitude *= _gain;
				                }
				                _value = clamp( _value, -1.0, 1.0 );
				                return pow(_value * 0.5 + 0.5,_power);
			}
			
			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				o.ase_texcoord.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord.zw = 0;
				float3 vertexValue =  float3(0,0,0) ;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				fixed4 finalColor;
				float2 uv01 = i.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float2 p10_g18 = uv01;
				float2 appendResult32 = (float2(_OffsetGroundOffsetMountain.x , _OffsetGroundOffsetMountain.y));
				float2 _offset10_g18 = appendResult32;
				float _scale10_g18 = 1.0;
				float _gain10_g18 = 0.5;
				float _power10_g18 = 1.0;
				float _value10_g18 = 0.0;
				float _amplitude10_g18 = 1.5;
				float _frequency10_g18 = 2.0;
				float localMyCustomExpression10_g18 = MyCustomExpression( p10_g18 , _offset10_g18 , _scale10_g18 , _gain10_g18 , _power10_g18 , _value10_g18 , _amplitude10_g18 , _frequency10_g18 );
				float temp_output_4_0 = ( 1.0 / _MaxHeight );
				float temp_output_19_0 = ( ( localMyCustomExpression10_g18 * _HeightGround * temp_output_4_0 ) + ( _StartHeightGround * temp_output_4_0 ) );
				float2 p10_g20 = uv01;
				float2 appendResult33 = (float2(_OffsetGroundOffsetMountain.z , _OffsetGroundOffsetMountain.w));
				float2 _offset10_g20 = appendResult33;
				float _scale10_g20 = 1.0;
				float _gain10_g20 = 0.5;
				float _power10_g20 = _pow;
				float _value10_g20 = _v;
				float _amplitude10_g20 = 1.5;
				float _frequency10_g20 = 2.0;
				float localMyCustomExpression10_g20 = MyCustomExpression( p10_g20 , _offset10_g20 , _scale10_g20 , _gain10_g20 , _power10_g20 , _value10_g20 , _amplitude10_g20 , _frequency10_g20 );
				float temp_output_70_0 = localMyCustomExpression10_g20;
				float temp_output_56_0 = max( temp_output_19_0 , temp_output_70_0 );
				float clampResult25 = clamp( temp_output_56_0 , 0.0 , 1.0 );
				float temp_output_91_0 = ( _Water * temp_output_4_0 );
				float2 p10_g21 = uv01;
				float2 appendResult71 = (float2(_OffsetLowGroundOffsetOcean.x , _OffsetLowGroundOffsetOcean.y));
				float2 _offset10_g21 = appendResult71;
				float _scale10_g21 = 1.0;
				float _gain10_g21 = 0.5;
				float _power10_g21 = 1.0;
				float _value10_g21 = 0.0;
				float _amplitude10_g21 = 1.5;
				float _frequency10_g21 = 2.0;
				float localMyCustomExpression10_g21 = MyCustomExpression( p10_g21 , _offset10_g21 , _scale10_g21 , _gain10_g21 , _power10_g21 , _value10_g21 , _amplitude10_g21 , _frequency10_g21 );
				float temp_output_69_0 = localMyCustomExpression10_g21;
				float clampResult96 = clamp( (0.0 + (temp_output_69_0 - _SizeLake) * (_DephtLake - 0.0) / (1.0 - _SizeLake)) , 0.0 , _DephtLake );
				float temp_output_98_0 = ( clampResult96 / _DephtLake );
				float lerpResult99 = lerp( clampResult25 , ( min( clampResult25 , temp_output_91_0 ) - clampResult96 ) , temp_output_98_0);
				float clampResult108 = clamp( (1.0 + (( distance( uv01 , float2( 0.5,0.5 ) ) * 2.0 ) - _B) * (0.0 - 1.0) / (1.0 - _B)) , 0.0 , 1.0 );
				float smoothstepResult111 = smoothstep( 0.0 , 1.0 , pow( clampResult108 , _Float0 ));
				float2 p10_g23 = uv01;
				float2 appendResult105 = (float2(_OffsetLowGroundOffsetOcean.z , _OffsetLowGroundOffsetOcean.w));
				float2 _offset10_g23 = appendResult105;
				float _scale10_g23 = 1.0;
				float _gain10_g23 = 0.5;
				float _power10_g23 = 1.0;
				float _value10_g23 = 0.0;
				float _amplitude10_g23 = 1.5;
				float _frequency10_g23 = 2.0;
				float localMyCustomExpression10_g23 = MyCustomExpression( p10_g23 , _offset10_g23 , _scale10_g23 , _gain10_g23 , _power10_g23 , _value10_g23 , _amplitude10_g23 , _frequency10_g23 );
				float temp_output_104_0 = localMyCustomExpression10_g23;
				float blendOpSrc110 = smoothstepResult111;
				float blendOpDest110 = temp_output_104_0;
				float temp_output_110_0 = ( saturate(  (( blendOpSrc110 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpSrc110 - 0.5 ) ) * ( 1.0 - blendOpDest110 ) ) : ( 2.0 * blendOpSrc110 * blendOpDest110 ) ) ));
				float temp_output_1_0_g24 = (-1.0 + (( lerpResult99 * temp_output_110_0 ) - 0.0) * (1.0 - -1.0) / (1.0 - 0.0));
				float clampResult117 = clamp( ( (1.0 + (temp_output_110_0 - 0.0) * (0.0 - 1.0) / (1.0 - 0.0)) - ( temp_output_104_0 * 0.2 ) ) , 0.0 , 1.0 );
				float temp_output_106_0 = ( _isIsland * clampResult117 );
				float lerpResult116 = lerp( lerpResult99 , ( ( (0.0 + (( pow( abs( temp_output_1_0_g24 ) , _Float0 ) * sign( temp_output_1_0_g24 ) ) - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)) - 0.5 ) + _Ocean ) , temp_output_106_0);
				float2 p10_g25 = uv01;
				float2 _offset10_g25 = float2( 0,0 );
				float _scale10_g25 = 1.0;
				float _gain10_g25 = 0.5;
				float _power10_g25 = 1.0;
				float _value10_g25 = 0.0;
				float _amplitude10_g25 = 1.5;
				float _frequency10_g25 = 2.0;
				float localMyCustomExpression10_g25 = MyCustomExpression( p10_g25 , _offset10_g25 , _scale10_g25 , _gain10_g25 , _power10_g25 , _value10_g25 , _amplitude10_g25 , _frequency10_g25 );
				float4 appendResult61 = (float4(lerpResult116 , 0.0 , max( temp_output_98_0 , temp_output_106_0 ) , localMyCustomExpression10_g25));
				
				
				finalColor = appendResult61;
				return finalColor;
			}
			ENDCG
		}
	}
	//CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=16400
-609;820;1906;893;2427.591;-592.5693;1.598531;True;True
Node;AmplifyShaderEditor.CommentaryNode;72;-1823.069,-434.2188;Float;False;1321.381;755.9959;Ground;9;5;32;4;67;16;18;20;15;19;;0,1,0,1;0;0
Node;AmplifyShaderEditor.Vector4Node;31;-2019.93,371.5089;Float;False;Property;_OffsetGroundOffsetMountain;OffsetGround,OffsetMountain;2;0;Create;True;0;0;False;0;0,0,0,0;51591.71,46996.27,48096.95,-26801.32;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;32;-1295.846,-331.5563;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-2569.671,-210.0293;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;5;-1766.653,206.7771;Float;False;Property;_MaxHeight;MaxHeight;7;0;Create;True;0;0;False;0;256;50;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;4;-1478.422,71.98628;Float;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-1624.67,-254.2452;Float;False;Property;_HeightGround;HeightGround;9;0;Create;True;0;0;False;0;0;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;73;-1740.373,345.9757;Float;False;1184.835;406.1411;Mountain;4;37;33;56;70;;0.4558824,0.4558824,0.4558824,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-1620.688,-174.5222;Float;False;Property;_StartHeightGround;StartHeightGround;8;0;Create;True;0;0;False;0;0;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;67;-1064.877,-384.2188;Float;False;PerlinNoise;-1;;18;b85dad9adb6536b40b3f6b6f464d26ec;0;6;7;FLOAT2;0,0;False;11;FLOAT2;0,0;False;12;FLOAT;1;False;14;FLOAT;0.5;False;15;FLOAT;1;False;16;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-828.67,-345.2452;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;33;-1690.373,427.1917;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-1942.729,804.7372;Float;False;Property;_pow;pow;5;0;Create;True;0;0;False;0;0;3.39;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;100;-2489.373,1528.154;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-1673.089,637.1168;Float;False;Property;_v;v;6;0;Create;True;0;0;False;0;0;0.41;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-1370.907,-171.6041;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;66;-2064.497,910.2863;Float;False;Property;_OffsetLowGroundOffsetOcean;OffsetLowGround,OffsetOcean;3;0;Create;True;0;0;False;0;0,0,0,0;-35107.1,-4218.055,24990.43,48670.1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;103;-2421.602,1709.332;Float;False;Property;_B;B;14;0;Create;True;0;0;False;0;0.5;0.722;0.5;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;70;-1369.047,563.4837;Float;False;PerlinNoise;-1;;20;b85dad9adb6536b40b3f6b6f464d26ec;0;6;7;FLOAT2;0,0;False;11;FLOAT2;0,0;False;12;FLOAT;1;False;14;FLOAT;0.5;False;15;FLOAT;1;False;16;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;71;-1802.189,926.1486;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-655.6877,-279.5222;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;101;-2323.509,1547.419;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;56;-709.5382,395.9757;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;127;-97.01763,1464.357;Float;False;Property;_DephtLake;DephtLake;17;0;Create;True;0;0;False;0;0.15;0.21;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;90;-2526.245,181.4915;Float;False;Property;_Water;Water;12;0;Create;True;0;0;False;0;0;15.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;102;-2445.82,1998.766;Float;True;5;0;FLOAT;0;False;1;FLOAT;0.6;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;69;-1476.093,1040.676;Float;False;PerlinNoise;-1;;21;b85dad9adb6536b40b3f6b6f464d26ec;0;6;7;FLOAT2;0,0;False;11;FLOAT2;0,0;False;12;FLOAT;1;False;14;FLOAT;0.5;False;15;FLOAT;1;False;16;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;126;-108.0176,1389.357;Float;False;Property;_SizeLake;SizeLake;18;0;Create;True;0;0;False;0;0.85;0.711;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;91;-2045.128,-4.481598;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;108;-2139.311,2186.754;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;25;-284.0135,8.46059;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;93;-243.7821,912.6688;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;113;-2119.75,2330.906;Float;False;Property;_Float0;Float 0;13;0;Create;True;0;0;False;0;0.5;0.41;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;105;-1805.764,1032.921;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;96;-6.063789,927.8594;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMinOpNode;89;-24.68451,419.6512;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;121;-1816.472,2277.254;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;104;-1900.977,2087.838;Float;False;PerlinNoise;-1;;23;b85dad9adb6536b40b3f6b6f464d26ec;0;6;7;FLOAT2;0,0;False;11;FLOAT2;0,0;False;12;FLOAT;1;False;14;FLOAT;0.5;False;15;FLOAT;1;False;16;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;94;170.0503,895.6179;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;111;-1641.896,2123.199;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;98;201.5014,1154.121;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;110;-1375.255,2100.228;Float;False;HardLight;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;99;444.2862,1012.359;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;123;-1523.895,2949.736;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;115;-1091.736,2624.935;Float;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;107;462.196,644.7921;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;112;685.1818,846.8336;Float;True;SmoothSimple;-1;;24;7ad0d2d1888d97147b10a47b127c27c2;0;2;8;FLOAT;2.72;False;6;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;122;-751.756,2553.449;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;120;1082.935,614.1627;Float;False;Property;_Ocean;Ocean;15;0;Create;True;0;0;False;0;0;0.346;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;117;-483.1065,2067.521;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;124;-585.7223,1905.314;Float;False;Property;_isIsland;isIsland;16;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;118;1005.226,736.5399;Float;False;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;106;-333.5901,1952.045;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;119;1260.775,729.5399;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;125;462.6853,1187.004;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;68;-582.692,-636.4955;Float;False;PerlinNoise;-1;;25;b85dad9adb6536b40b3f6b6f464d26ec;0;6;7;FLOAT2;0,0;False;11;FLOAT2;0,0;False;12;FLOAT;1;False;14;FLOAT;0.5;False;15;FLOAT;1;False;16;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;116;1274.895,1312.401;Float;False;3;0;FLOAT;1;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;26;356.7204,-117.4468;Float;False;Property;_Color0;Color 0;0;0;Create;True;0;0;False;0;0,0,0,0;0.5441177,0.5441177,0.5441177,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;84;-1057.544,986.9827;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.25;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;86;-1748.097,1515.287;Float;False;Property;_min;min;11;0;Create;True;0;0;False;0;0;-0.11;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;85;-768.9145,1045.454;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.54;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;61;97.31093,52.65575;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;92;-386.1946,1166.788;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;377.7204,110.5532;Float;False;Property;_Float2;Float 2;1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;63;-1861.507,715.7273;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;64;-2078.533,714.5199;Float;False;Constant;_TexturePixelSize;TexturePixelSize;10;0;Create;True;0;0;False;0;256;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;1204.71,25.88681;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;74;-614.5231,907.6978;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;373.7204,44.55325;Float;False;Property;_Float1;Float 1;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;22;963.5485,90.09713;Float;False;Constant;_Vector0;Vector 0;3;0;Create;True;0;0;False;0;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.OneMinusNode;82;-1257.358,989.0046;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;79;-1398.44,1467.438;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareGreater;77;-1007.701,819.593;Float;False;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;78;-921.9035,1206.686;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;87;-1756.133,1634.452;Float;False;Property;_max;max;10;0;Create;True;0;0;False;0;0;5.52;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;57;537.845,323.8741;Float;False;True;2;Float;ASEMaterialInspector;0;1;Hidden/WorldGenerator;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;True;False;True;0;False;-1;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;RenderType=Opaque=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;True;0;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;0
WireConnection;32;0;31;1
WireConnection;32;1;31;2
WireConnection;4;1;5;0
WireConnection;67;7;1;0
WireConnection;67;11;32;0
WireConnection;15;0;67;0
WireConnection;15;1;16;0
WireConnection;15;2;4;0
WireConnection;33;0;31;3
WireConnection;33;1;31;4
WireConnection;100;0;1;0
WireConnection;20;0;18;0
WireConnection;20;1;4;0
WireConnection;70;7;1;0
WireConnection;70;11;33;0
WireConnection;70;15;34;0
WireConnection;70;16;37;0
WireConnection;71;0;66;1
WireConnection;71;1;66;2
WireConnection;19;0;15;0
WireConnection;19;1;20;0
WireConnection;101;0;100;0
WireConnection;56;0;19;0
WireConnection;56;1;70;0
WireConnection;102;0;101;0
WireConnection;102;1;103;0
WireConnection;69;7;1;0
WireConnection;69;11;71;0
WireConnection;91;0;90;0
WireConnection;91;1;4;0
WireConnection;108;0;102;0
WireConnection;25;0;56;0
WireConnection;93;0;69;0
WireConnection;93;1;126;0
WireConnection;93;4;127;0
WireConnection;105;0;66;3
WireConnection;105;1;66;4
WireConnection;96;0;93;0
WireConnection;96;2;127;0
WireConnection;89;0;25;0
WireConnection;89;1;91;0
WireConnection;121;0;108;0
WireConnection;121;1;113;0
WireConnection;104;7;1;0
WireConnection;104;11;105;0
WireConnection;94;0;89;0
WireConnection;94;1;96;0
WireConnection;111;0;121;0
WireConnection;98;0;96;0
WireConnection;98;1;127;0
WireConnection;110;0;111;0
WireConnection;110;1;104;0
WireConnection;99;0;25;0
WireConnection;99;1;94;0
WireConnection;99;2;98;0
WireConnection;123;0;104;0
WireConnection;115;0;110;0
WireConnection;107;0;99;0
WireConnection;107;1;110;0
WireConnection;112;8;113;0
WireConnection;112;6;107;0
WireConnection;122;0;115;0
WireConnection;122;1;123;0
WireConnection;117;0;122;0
WireConnection;118;0;112;0
WireConnection;106;0;124;0
WireConnection;106;1;117;0
WireConnection;119;0;118;0
WireConnection;119;1;120;0
WireConnection;125;0;98;0
WireConnection;125;1;106;0
WireConnection;68;7;1;0
WireConnection;116;0;99;0
WireConnection;116;1;119;0
WireConnection;116;2;106;0
WireConnection;84;0;82;0
WireConnection;85;0;69;0
WireConnection;85;1;86;0
WireConnection;85;2;87;0
WireConnection;61;0;116;0
WireConnection;61;2;125;0
WireConnection;61;3;68;0
WireConnection;92;0;25;0
WireConnection;92;1;91;0
WireConnection;63;1;64;0
WireConnection;23;0;25;0
WireConnection;23;1;22;0
WireConnection;74;0;56;0
WireConnection;74;1;78;0
WireConnection;82;0;69;0
WireConnection;79;0;69;0
WireConnection;79;1;66;3
WireConnection;77;0;19;0
WireConnection;77;1;70;0
WireConnection;78;0;77;0
WireConnection;78;1;79;0
WireConnection;57;0;61;0
ASEEND*/
//CHKSM=1FFD9E9B506AE3358BFB2D40A6BE05498FA0CE0F