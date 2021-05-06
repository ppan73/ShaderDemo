// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Demo/AmplifyTest2"
{
	Properties
	{
		_EdgeLength ( "Edge length", Range( 2, 50 ) ) = 15
		_cracked("cracked", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma surface surf StandardSpecular keepalpha addshadow fullforwardshadows exclude_path:deferred vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _cracked;
		uniform float4 _cracked_ST;
		uniform float _EdgeLength;

		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, _EdgeLength);
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float3 ase_vertexNormal = v.normal.xyz;
			float3 ase_vertex3Pos = v.vertex.xyz;
			v.vertex.xyz += ( ase_vertexNormal * ( sin( ( ( _Time.w + ase_vertex3Pos.y ) / 0.6291569 ) ) / 7.263133 ) );
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			float2 uv_cracked = i.uv_texcoord * _cracked_ST.xy + _cracked_ST.zw;
			o.Albedo = tex2D( _cracked, uv_cracked ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18600
43;84;1614;1183;347.1172;509.7007;1.065002;True;True
Node;AmplifyShaderEditor.TimeNode;36;-358.3001,-169.1156;Inherit;True;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PosVertexDataNode;38;-369.9763,116.5121;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;37;-84.92158,100.834;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-216.9763,534.2208;Inherit;False;Constant;_Frequency;Frequency;1;0;Create;True;0;0;False;0;False;0.6291569;0;0.1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;39;94.19671,256.5744;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;41;246.1178,176.937;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;155.1326,568.0221;Inherit;False;Constant;_Amplitude;Amplitude;1;0;Create;True;0;0;False;0;False;7.263133;0;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;42;462.0237,293.5121;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;46;561.7039,-18.37299;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;844.4448,180.8637;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;19;409.5188,-409.4024;Inherit;True;Property;_cracked;cracked;5;0;Create;True;0;0;False;0;False;-1;14a090a40ab3644d98141f0cf6485c57;26cb40d02c3264edfafe76eec72fb048;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1123.03,-130.1172;Float;False;True;-1;6;ASEMaterialInspector;0;0;StandardSpecular;Demo/AmplifyTest2;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;0;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;37;0;36;4
WireConnection;37;1;38;2
WireConnection;39;0;37;0
WireConnection;39;1;35;0
WireConnection;41;0;39;0
WireConnection;42;0;41;0
WireConnection;42;1;43;0
WireConnection;45;0;46;0
WireConnection;45;1;42;0
WireConnection;0;0;19;0
WireConnection;0;11;45;0
ASEEND*/
//CHKSM=FA3EEBB6E3F2F4257D721644C25C6D8385CF1563