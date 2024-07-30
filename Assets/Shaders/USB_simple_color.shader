Shader "Unlit/USB_simple_color"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        
        // Floats are used to any type of mesh data
        _Value ("Value", Float) = 1.0
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

            #include "UnityCG.cginc"
            
            float _Value;

            struct meshData // Per vertex mesh data
            {
                // This data mostly comes in batches of 4 that is why we use float4
                // Uv channels begin
                float2 uv : TEXCOORD0; // uv0 coordinates this is the coordinates for different uv mappings on your mesh
                // Uv channel end
                float4 normal: NORMAL; // normal vector for each vertex vertex
                float4 vertex : SV_POSITION; //vertex position
                float4 color : COLOR; // The vertex color
                // it has 4 components
                // One of the components its the sign like the mathematical sign of the tangent
                // It is useful for a lot of stuff
                float4 tangent : TANGENT; // The tangents of the vertex
            };

            // The way we pass data from the vertex shader to the fragment shader
            struct Interpolators
            {
                float4 vertex : SV_POSITION; // clip-space position of the vertex
                float2 uv : TEXTCOORD0; // 
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            // Vertex shader
            // This is called an Interpolator cause
            /*
             * We have vertex data, called it normals, tangents, color, etc.
             * The Interpolator loops on each vertex then it passes data to our fragment shader
             * the data has to be interpolated to translate that data from vertex data to pixel
             * data, it interpolates blending the data from the vertex in its sides so that it
             * can color the parts of the mesh accordingly that doesn't have vertex
             * 
             */
            Interpolators vert (meshData v)
            {
                Interpolators o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            float4 ourFunction() 
            {
                return true;
            }
            
            // Frament shader
            /**
             * It works at a pixel level represented in our screen, it practically modifies the data of the mesh
             * blending its data to fill colors between each vertex
             */
            fixed4 frag(Interpolators i) : SV_Target 
            {
                float4 f = ourFunction();
                return f;
            }

            ENDCG
        }
    }
}
