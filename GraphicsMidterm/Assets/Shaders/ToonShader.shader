Shader "Custom/ToonShader"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
		MainTexture("Albedo (RGB)", 2D) = "white" {}
		RampTexture("Ramp Texture", 2D) = "white"{}
	}

	SubShader
	{
		CGPROGRAM
		#pragma surface surf ToonRamp fullforwardshadows
		#pragma target 3.0

		float4 _Color;
		sampler2D RampTexture;

		float4 LightingToonRamp(SurfaceOutput s, fixed3 lightDir, fixed atten)
		{
			float diff = dot(s.Normal, lightDir);
			float h = diff * 1.3;
			float2 rh = h;
			float3 ramp = tex2D(RampTexture, rh).rgb;

			float4 c;
			c.rgb = s.Albedo * _LightColor0.rgb * (ramp);
			c.a = s.Alpha;

			return c;
		}
		
		struct Input
		{
			float2 uv_MainTexture;
			float3 viewDir;
		};

		sampler2D MainTexture;

		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = tex2D(MainTexture, IN.uv_MainTexture).rgb * _Color;
		}

		ENDCG
	}
	
	FallBack "Diffuse"
}
