Shader "Kinoo/BrushStrokeShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color ("Base Color", Color) = (1,1,1,1)
        _OuterColor ("Outer Color", Color) = (1,1,1,1)
        _LineWidth ("Line Width", Float) = 50.0
        _OutlineWidth ("Outline Width", Float) = 10.0
        _InnerAlpha ("Inner Alpha", Float) = 1.0
        _OuterAlpha ("Inner Alpha", Float) = 1.0
        _IgnoreSegments ("Ignore Segments", Int) = 0

        [HideInInspector]
        _SrcBlend ("", Float) = 5
        [HideInInspector]
        _DstBlend ("", Float) = 10
    }
    SubShader
    {
        Tags 
        { 
            "RenderType" = "Transparent"
            "Queue" = "Transparent"
            "IgnoreProjector" = "True"
            "PreviewType" = "Plane"
        }
        
        ZWrite Off
        Lighting Off
        Cull Off
        LOD 100
        
        Pass
        {
            Blend [_SrcBlend] [_DstBlend]

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            #define MAX_LINE_SEGMENT_COUNT 100

            struct appdata
            {
                float4 vertex : POSITION;
                float4 color : COLOR;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float4 color : COLOR;
                float2 uv : TEXCOORD0;
            };

            fixed4 _Color;
            fixed4 _OuterColor;
            int _IgnoreSegments;
            float _LineWidth;
            float _OutlineWidth;
            float _InnerAlpha;
            float _OuterAlpha;
            int _LineSegmentCount;
            float4 _LineSegmentArray[MAX_LINE_SEGMENT_COUNT];

            // not really used, needed because all ui graphics need textures
            sampler2D _MainTex;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.color = v.color;
                o.uv = v.uv;
                return o;
            }

            float lineDistance(float2 pixelPos, float4 segment)
            {
                float2 point0 = segment.xy;
                float2 point1 = segment.zw;
            
                float2 pa = pixelPos - point0;
                float2 ba = point1 - point0;
                float h = clamp(dot(pa, ba) / dot(ba, ba), 0.0, 1.0);
                return length(pa - ba * h);
            }

            float pointDistance(float2 pixelPos, float4 segment)
            {
                float2 point0 = segment.xy;
                float2 point1 = segment.zw;
            
                float dist = distance(pixelPos, point0);
                dist = min(dist, distance(pixelPos, point1));
                return dist;
            }

            fixed4 BrushColorFromDistance(float dist)
            {
                float halfLineWidth = _LineWidth / 2.0f;
                float4 color = float4(0.0, 0.0, 0.0, 0.0);
                float innerStep = step(dist, halfLineWidth - _OutlineWidth);
                float innerSmoothStep = smoothstep(halfLineWidth - _OutlineWidth, halfLineWidth, dist);
                 
                color += innerStep * float4(_Color.xyz, _InnerAlpha);
                color += (step(dist, halfLineWidth) - innerStep) * float4(_OuterColor.xyz, lerp(_InnerAlpha, _OuterAlpha, innerSmoothStep));
                return color;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float dist = 100000;
                for (int lineSegmentIndex = 0; lineSegmentIndex < _LineSegmentCount; lineSegmentIndex ++)
                {
                    if (_IgnoreSegments != 0)
                    {
                        dist = min(dist, pointDistance(i.uv.xy, _LineSegmentArray[lineSegmentIndex]));
                    }
                    else
                    {
                        dist = min(dist, lineDistance(i.uv.xy, _LineSegmentArray[lineSegmentIndex]));
                    }
                }

                float4 color = BrushColorFromDistance(dist);
                return color;
            }
            ENDCG
        }
    }
    Fallback off
}
