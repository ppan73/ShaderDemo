Shader "Kinoo/VideoBiPlanarYUVGammaShader"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" { }
        _UVTex("Texture", 2D) = "white" { }
    }
    SubShader
    {
        Tags 
        { 
            "RenderType"="Opaque"
            "Queue"="Transparent" 
        }

        Lighting Off
        Cull Off
        ZWrite Off
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "VideoLib.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            float VideoBrightness;

            sampler2D _MainTex;
            float4 _MainTex_ST;
            
            sampler2D _UVTex;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float2 uv = float2(1.0 - i.uv.x, 1.0 - i.uv.y);
                float colorY = tex2D(_MainTex, uv).r;
                float2 colorUV = tex2D(_UVTex, uv).rg;
               
                float4 colorYUV = float4(colorY, colorUV.x, colorUV.y, 1);
                fixed4 color = ConvertYUVToRGB(colorYUV);
                color = color * pow(2.0, VideoBrightness);
                
                return color;
            }
            ENDCG
        }
    }
}
