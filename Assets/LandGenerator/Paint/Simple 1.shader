Shader "CustomRenderTexture/Simple"
{
    Properties
    {
        _SelfTexture2D("InputTex", 2D) = "white" {}
        _vector("pos (x,y),Radius,Distance ", Vector) = (0,0,0,0)
		_angle("angle", Float) = 0
    }

    SubShader
    {
        Lighting Off
        Blend One Zero

        Pass
        {
            CGPROGRAM
            #include "UnityCustomRenderTexture.cginc"
            #pragma vertex CustomRenderTextureVertexShader
            #pragma fragment frag
            #pragma target 3.0

            uniform float4 _vector;
			uniform float _angle;

			float2 MyCustomExpression3_g8( float2 uv , float ang , float2 piv )
			{
				float _cos = cos(ang);
				float _sin = sin(ang);
				return (mul(uv-piv,float2x2(_cos, -_sin, _sin,_cos))+piv);
			}

            float4 frag(v2f_customrendertexture IN) : COLOR
            {
//                return .1f + tex2D(_SelfTexture2D, IN.localTexcoord.xy);
				float2 uv02 = IN.localTexcoord.xy;
				float2 appendResult17 = (float2(_vector.x , _vector.y));
				float2 uv3_g8 = ( uv02 - appendResult17 );
				float ang3_g8 = radians( _angle );
				float2 localMyCustomExpression3_g8 = MyCustomExpression3_g8( uv3_g8 , ang3_g8 , float2( 0,0 ));
				float clampResult20 = clamp( (localMyCustomExpression3_g8).y , 0.0 , _vector.w );
				float clampResult33 = clamp( ( 1.0 - (0.0 + (distance( localMyCustomExpression3_g8 , float2(0.0 , clampResult20) ) - 0.0) * (2.0 - 0.0) / (_vector.z - 0.0)) ) , 0.0 , 1.0 );
				return max (clampResult33,tex2D(_SelfTexture2D, IN.localTexcoord.xy).r);
            }
            ENDCG
        }
    }
}