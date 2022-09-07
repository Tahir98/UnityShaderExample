// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/transparent"
{
	Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Concentration ("Concentration", Range(0,1)) = 0.5
    }

	SubShader {
		Tags { "Queue" = "Transparent" } 
		Pass {
			Cull Off
			ZWrite Off
			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM

			#pragma vertex vertexShader 
			#pragma fragment fragmentShader

			sampler2D _MainTex;
			fixed4 _Color;
			float _Concentration;

			void vertexShader(float4 vertexPos : POSITION,
				out float4 pos : SV_POSITION,
				out float4 texCoord : TEXCOORD0)  
			{
				pos =  UnityObjectToClipPos(vertexPos);
				return;
			}
 
			float4 fragmentShader(float4 pos : SV_POSITION, 
			   float4 texCoord : TEXCOORD0) : COLOR 
			{
				float4 oColor = tex2D (_MainTex, texCoord.xy) * _Color;
				oColor.w = _Concentration;

			    return oColor;
			}

			ENDCG // here ends the part in Cg 
		}
	}
}
