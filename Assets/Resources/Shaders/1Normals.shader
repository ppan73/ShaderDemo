// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Demo/Normals"
{
    Properties
    {
        _Color ("Main Color", Color) = (1,1,1,1)
    }
    
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            // include Unity Helpers
            #include "UnityCG.cginc"

            //vertex shader inputs
            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            //vertex shader outputs ("vertex to fragment")
            struct v2f
            {
                half3 worldNormal : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            //texture to sample
            sampler2D _MainTex;
            float4 _MainTex_ST;
            fixed4 _Color;
            
            //vertex shader
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                return o;
            }

            //fragment shader
            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = 0;
                //normal -1.0 to +1.0
                col.rgb = i.worldNormal * 0.5 + _Color.rgb * 0.5;
                return col;
            }
            ENDCG
        }
    }
}
