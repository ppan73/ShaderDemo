// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Demo/AmplifyTest"
{
	Properties
	{
		_ColorMix("Color Mix", Range( 0 , 1)) = 0
		_SmoothnessLevel("Smoothness Level", Range( 0 , 1)) = 0
		_SpecularLevel("Specular Level", Range( 0 , 1)) = 0
		_cracked("cracked", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf StandardSpecular keepalpha addshadow fullforwardshadows exclude_path:deferred 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _cracked;
		uniform float4 _cracked_ST;
		uniform float _ColorMix;
		uniform float _SpecularLevel;
		uniform float _SmoothnessLevel;

		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			float2 uv_cracked = i.uv_texcoord * _cracked_ST.xy + _cracked_ST.zw;
			o.Normal = tex2D( _cracked, uv_cracked ).rgb;
			float4 color8 = IsGammaSpace() ? float4(0.245283,0.245283,0.245283,0) : float4(0.0490081,0.0490081,0.0490081,0);
			float4 color9 = IsGammaSpace() ? float4(1,0,0.1773129,0) : float4(1,0,0.02647097,0);
			float4 lerpResult7 = lerp( color8 , color9 , _ColorMix);
			o.Albedo = lerpResult7.rgb;
			float3 temp_cast_2 = (_SpecularLevel).xxx;
			o.Specular = temp_cast_2;
			o.Smoothness = _SmoothnessLevel;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18600
-2299;226;1947;1121;914.9763;343.4879;1;True;True
Node;AmplifyShaderEditor.ColorNode;8;-308.3636,-279.6144;Inherit;False;Constant;_Color0;Color 0;0;0;Create;True;0;0;False;0;False;0.245283,0.245283,0.245283,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;9;-311.5537,-90.5397;Inherit;False;Constant;_Color1;Color 1;0;0;Create;True;0;0;False;0;False;1,0,0.1773129,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;12;-330.5171,111.7528;Inherit;False;Property;_ColorMix;Color Mix;0;0;Create;True;0;0;False;0;False;0;0.1404411;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;18;111.0237,-2.487854;Inherit;True;Property;_cracked;cracked;3;0;Create;True;0;0;False;0;False;-1;26cb40d02c3264edfafe76eec72fb048;26cb40d02c3264edfafe76eec72fb048;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;7;118.9461,-249.0445;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;13;109.9926,406.7579;Inherit;False;Property;_SmoothnessLevel;Smoothness Level;1;0;Create;True;0;0;False;0;False;0;0.2844603;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;111.9725,307.9729;Inherit;False;Property;_SpecularLevel;Specular Level;2;0;Create;True;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;569.2149,-124.5549;Float;False;True;-1;2;ASEMaterialInspector;0;0;StandardSpecular;Demo/AmplifyTest;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;0;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;7;0;8;0
WireConnection;7;1;9;0
WireConnection;7;2;12;0
WireConnection;0;0;7;0
WireConnection;0;1;18;0
WireConnection;0;3;14;0
WireConnection;0;4;13;0
ASEEND*/
//CHKSM=6088A433E9EBDDCC8FC75A465E24ADAFF35F543B