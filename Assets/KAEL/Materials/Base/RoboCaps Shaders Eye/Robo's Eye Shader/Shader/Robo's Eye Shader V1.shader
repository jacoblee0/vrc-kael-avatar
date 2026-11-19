// Upgrade NOTE: replaced tex2D unity_Lightmap with UNITY_SAMPLE_TEX2D

// Made with Amplify Shader Editor v1.9.8.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "RoboCap/Robos Eye Shader V1"
{
	Properties
	{
		_ParallaxAmount("Parallax Amount", Float) = -0.4
		_PupilSize("Pupil Size", Vector) = (0.3,0.34,0,0)
		_FlowScale("Flow Scale", Vector) = (1,1,0,0)
		_EyeRoundness("Eye Roundness", Float) = 50
		_BackgroundNoise("Background Noise", 2D) = "white" {}
		_BaseColor("Base Color", Color) = (0,0.373857,1)
		_BaseColorIntensity("Base Color Intensity", Float) = 1
		[HDR]_HighlightColor("Highlight Color", Color) = (0.768116,0,1)
		_HighlightIntensity("Highlight Intensity", Float) = 1
		_HighlightThreshold("Highlight Threshold", Float) = 1
		_Highlight2Color("Highlight 2 Color", Color) = (1,1,1,0)
		_Highlight2Intensity("Highlight 2 Intensity", Float) = 1
		_CloudNoiseColor("Cloud Noise Color", Color) = (0.5754717,0.5754717,0.5754717)
		_CloudNoiseVisibillity("Cloud Noise Visibillity", Float) = 1
		_ShadowIntensity("Shadow Intensity", Float) = 5
		[Header(Flow)]_FlowNoiseScale("Flow Noise Scale", Vector) = (1,1,0,0)
		_ShadowThreshold("Shadow Threshold", Float) = 1.2
		_CenterColor("Center Color", Color) = (0.9859011,0.4009434,1)
		_CenterColorIntensity("Center Color Intensity", Float) = 0.5
		_LineColor("Line Color", Color) = (1,1,1)
		_LineIntensity("Line Intensity", Float) = 1
		_LineThreshold("Line Threshold", Float) = 1
		_FlowColor("Flow Color", Color) = (1,1,1,0)
		_FlowSpeed("Flow Speed", Float) = 1
		_FlowIntensity("Flow Intensity", Float) = 1
		_FlowContrast("Flow Contrast", Float) = 1
		[ToggleUI]_ScrollingNoiseReverse("Scrolling Noise Reverse", Float) = 0
		_ReflectionIntensity("Reflection Intensity", Float) = 1
		_ReflectionHighlightIntensity("Reflection Highlight Intensity", Float) = 1
		_ElectricityIntensity("Electricity Intensity", Float) = 0
		_ElectricityColor("Electricity Color", Color) = (0.6196079,0.8686028,1)
		_ElectricitySpeed("Electricity Speed", Float) = 0.1
		_ElectricityThickness("Electricity Thickness", Float) = 1
		_StarColor("Star Color", Color) = (1,1,1)
		_StarsAmount("Stars Amount", Float) = 1
		_StarsScale("Stars Scale", Float) = 1
		_ColorSaturation("Color Saturation", Float) = 1
		_StarsIntensity("Stars Intensity", Float) = 1
		_ColorIntensity("Color Intensity", Float) = 1
		_ColorContrast("Color Contrast", Float) = 1
		_ColorCutoffInfluence("Color Cutoff Influence", Range( 0 , 1)) = 0
		_Cutoff("Cutoff", Float) = 1
		_CutoffHardness("Cutoff Hardness", Float) = 1
		[ToggleUI]_UnlitToggle("Unlit Toggle", Float) = 0
		_DarkningOutlineSmoothing("Darkning Outline Smoothing", Float) = 0.25
		_DarkningOutline("Darkning Outline", Float) = 1
		_HighlightNoise("Highlight Noise", 2D) = "white" {}
		_PupilOpacity("Pupil Opacity", Range( 0 , 1)) = 1
		_HueShift("Hue Shift", Range( 0 , 1)) = 0
		_LineRotationSpeed("Line Rotation Speed", Float) = 0
		_HueShiftSpeed("Hue Shift Speed", Float) = 0
		_PulseSpeed("Pulse Speed", Float) = 1
		[ToggleUI]_PulsingToggle("Pulsing Toggle", Float) = 0
		_PulseRange("Pulse Range", Vector) = (1,2,0,0)
		_LinesEmissionBoost("Lines Emission Boost", Float) = 0
		_ElectricityEmissionBoost("Electricity Emission Boost", Float) = 0
		_HighlightEmissionBoost("Highlight Emission Boost", Float) = 0
		_CenterColorEmissionBoost("Center Color Emission Boost", Float) = 0
		_FlowEmissionBoost("Flow Emission Boost", Float) = 0
		[ToggleUI]_StarsShowupPupil("Stars Showup Pupil", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityCG.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 3.5
		#define ASE_VERSION 19801
		#pragma multi_compile _ LIGHTMAP_ON
		#pragma multi_compile _ DYNAMICLIGHTMAP_ON
		#pragma multi_compile _ DIRLIGHTMAP_COMBINED
		#pragma surface surf Unlit alpha:fade keepalpha vertex:vertexDataFunc 
		struct Input
		{
			float2 vertexToFrag10_g167;
			float2 uv_texcoord;
			float3 viewDir;
			INTERNAL_DATA
			float2 vertexToFrag249;
			float3 worldPos;
			float2 vertexToFrag258;
			float3 worldNormal;
		};

		uniform float _UnlitToggle;
		uniform float3 _HighlightColor;
		uniform float _EyeRoundness;
		uniform float _HighlightThreshold;
		uniform float _HighlightIntensity;
		uniform sampler2D _HighlightNoise;
		uniform float4 _Highlight2Color;
		uniform float _Highlight2Intensity;
		uniform float _HighlightEmissionBoost;
		uniform float _LineRotationSpeed;
		uniform float _ParallaxAmount;
		uniform float _LineThreshold;
		uniform float _LineIntensity;
		uniform float _LinesEmissionBoost;
		uniform float3 _BaseColor;
		uniform float2 _PupilSize;
		uniform float3 _CenterColor;
		uniform float _CenterColorIntensity;
		uniform float _CloudNoiseVisibillity;
		uniform float3 _CloudNoiseColor;
		uniform float _BaseColorIntensity;
		uniform float4 _FlowColor;
		uniform float _FlowIntensity;
		uniform float2 _FlowScale;
		uniform sampler2D _BackgroundNoise;
		uniform float2 _FlowNoiseScale;
		uniform float _ScrollingNoiseReverse;
		uniform float _FlowSpeed;
		uniform float _FlowContrast;
		uniform float _ElectricitySpeed;
		uniform float _ElectricityThickness;
		uniform float _ElectricityIntensity;
		uniform float3 _ElectricityColor;
		uniform float3 _LineColor;
		uniform float _PupilOpacity;
		uniform float _StarsScale;
		uniform float _StarsAmount;
		uniform float _StarsIntensity;
		uniform float3 _StarColor;
		uniform float _StarsShowupPupil;
		uniform float _ReflectionIntensity;
		uniform float _ShadowThreshold;
		uniform float _ShadowIntensity;
		uniform float _DarkningOutline;
		uniform float _DarkningOutlineSmoothing;
		uniform float _HueShift;
		uniform float _HueShiftSpeed;
		uniform float _ColorSaturation;
		uniform float _ColorContrast;
		uniform float _FlowEmissionBoost;
		uniform float _CenterColorEmissionBoost;
		uniform float _ElectricityEmissionBoost;
		uniform float _ReflectionHighlightIntensity;
		uniform float _PulsingToggle;
		uniform float _ColorIntensity;
		uniform float2 _PulseRange;
		uniform float _PulseSpeed;
		uniform float _Cutoff;
		uniform float _CutoffHardness;
		uniform float _ColorCutoffInfluence;


		float3 HSVToRGB( float3 c )
		{
			float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
			float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
			return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
		}


		float3 RGBToHSV(float3 c)
		{
			float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
			float4 p = lerp( float4( c.bg, K.wz ), float4( c.gb, K.xy ), step( c.b, c.g ) );
			float4 q = lerp( float4( p.xyw, c.r ), float4( c.r, p.yzx ), step( p.x, c.r ) );
			float d = q.x - min( q.w, q.y );
			float e = 1.0e-10;
			return float3( abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
		}

		struct Gradient
		{
			int type;
			int colorsLength;
			int alphasLength;
			float4 colors[8];
			float2 alphas[8];
		};


		Gradient NewGradient(int type, int colorsLength, int alphasLength, 
		float4 colors0, float4 colors1, float4 colors2, float4 colors3, float4 colors4, float4 colors5, float4 colors6, float4 colors7,
		float2 alphas0, float2 alphas1, float2 alphas2, float2 alphas3, float2 alphas4, float2 alphas5, float2 alphas6, float2 alphas7)
		{
			Gradient g;
			g.type = type;
			g.colorsLength = colorsLength;
			g.alphasLength = alphasLength;
			g.colors[ 0 ] = colors0;
			g.colors[ 1 ] = colors1;
			g.colors[ 2 ] = colors2;
			g.colors[ 3 ] = colors3;
			g.colors[ 4 ] = colors4;
			g.colors[ 5 ] = colors5;
			g.colors[ 6 ] = colors6;
			g.colors[ 7 ] = colors7;
			g.alphas[ 0 ] = alphas0;
			g.alphas[ 1 ] = alphas1;
			g.alphas[ 2 ] = alphas2;
			g.alphas[ 3 ] = alphas3;
			g.alphas[ 4 ] = alphas4;
			g.alphas[ 5 ] = alphas5;
			g.alphas[ 6 ] = alphas6;
			g.alphas[ 7 ] = alphas7;
			return g;
		}


		float2 voronoihash107( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi107( float2 v, float time, inout float2 id, inout float2 mr, float smoothness, inout float2 smoothId )
		{
			float2 n = floor( v );
			float2 f = frac( v );
			float F1 = 8.0;
			float F2 = 8.0; float2 mg = 0;
			for ( int j = -1; j <= 1; j++ )
			{
				for ( int i = -1; i <= 1; i++ )
			 	{
			 		float2 g = float2( i, j );
			 		float2 o = voronoihash107( n + g );
					o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = f - g - o;
					float d = 0.5 * dot( r, r );
			 //		if( d<F1 ) {
			 //			F2 = F1;
			 			float h = smoothstep(0.0, 1.0, 0.5 + 0.5 * (F1 - d) / smoothness); F1 = lerp(F1, d, h) - smoothness * h * (1.0 - h);mg = g; mr = r; id = o;
			 //		} else if( d<F2 ) {
			 //			F2 = d;
			
			 //		}
			 	}
			}
			return F1;
		}


		float4 SampleGradient( Gradient gradient, float time )
		{
			float3 color = gradient.colors[0].rgb;
			UNITY_UNROLL
			for (int c = 1; c < 8; c++)
			{
			float colorPos = saturate((time - gradient.colors[c-1].w) / ( 0.00001 + (gradient.colors[c].w - gradient.colors[c-1].w)) * step(c, (float)gradient.colorsLength-1));
			color = lerp(color, gradient.colors[c].rgb, lerp(colorPos, step(0.01, colorPos), gradient.type));
			}
			#ifndef UNITY_COLORSPACE_GAMMA
			color = half3(GammaToLinearSpaceExact(color.r), GammaToLinearSpaceExact(color.g), GammaToLinearSpaceExact(color.b));
			#endif
			float alpha = gradient.alphas[0].x;
			UNITY_UNROLL
			for (int a = 1; a < 8; a++)
			{
			float alphaPos = saturate((time - gradient.alphas[a-1].y) / ( 0.00001 + (gradient.alphas[a].y - gradient.alphas[a-1].y)) * step(a, (float)gradient.alphasLength-1));
			alpha = lerp(alpha, gradient.alphas[a].x, lerp(alphaPos, step(0.01, alphaPos), gradient.type));
			}
			return float4(color, alpha);
		}


		inline float noise_randomValue (float2 uv) { return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453); }

		inline float noise_interpolate (float a, float b, float t) { return (1.0-t)*a + (t*b); }

		inline float valueNoise (float2 uv)
		{
			float2 i = floor(uv);
			float2 f = frac( uv );
			f = f* f * (3.0 - 2.0 * f);
			uv = abs( frac(uv) - 0.5);
			float2 c0 = i + float2( 0.0, 0.0 );
			float2 c1 = i + float2( 1.0, 0.0 );
			float2 c2 = i + float2( 0.0, 1.0 );
			float2 c3 = i + float2( 1.0, 1.0 );
			float r0 = noise_randomValue( c0 );
			float r1 = noise_randomValue( c1 );
			float r2 = noise_randomValue( c2 );
			float r3 = noise_randomValue( c3 );
			float bottomOfGrid = noise_interpolate( r0, r1, f.x );
			float topOfGrid = noise_interpolate( r2, r3, f.x );
			float t = noise_interpolate( bottomOfGrid, topOfGrid, f.y );
			return t;
		}


		float SimpleNoise(float2 UV)
		{
			float t = 0.0;
			float freq = pow( 2.0, float( 0 ) );
			float amp = pow( 0.5, float( 3 - 0 ) );
			t += valueNoise( UV/freq )*amp;
			freq = pow(2.0, float(1));
			amp = pow(0.5, float(3-1));
			t += valueNoise( UV/freq )*amp;
			freq = pow(2.0, float(2));
			amp = pow(0.5, float(3-2));
			t += valueNoise( UV/freq )*amp;
			return t;
		}


		inline float2 UnityVoronoiRandomVector( float2 UV, float offset )
		{
			float2x2 m = float2x2( 15.27, 47.63, 99.41, 89.98 );
			UV = frac( sin(mul(UV, m) ) * 46839.32 );
			return float2( sin(UV.y* +offset ) * 0.5 + 0.5, cos( UV.x* offset ) * 0.5 + 0.5 );
		}
		
		//x - Out y - Cells
		float3 UnityVoronoi( float2 UV, float AngleOffset, float CellDensity, inout float2 mr )
		{
			float2 g = floor( UV * CellDensity );
			float2 f = frac( UV * CellDensity );
			float t = 8.0;
			float3 res = float3( 8.0, 0.0, 0.0 );
		
			for( int y = -1; y <= 1; y++ )
			{
				for( int x = -1; x <= 1; x++ )
				{
					float2 lattice = float2( x, y );
					float2 offset = UnityVoronoiRandomVector( lattice + g, AngleOffset );
					float d = distance( lattice + offset, f );
		
					if( d < res.x )
					{
						mr = f - lattice - offset;
						res = float3( d, offset.x, offset.y );
					}
				}
			}
			return res;
		}


		float2 voronoihash571( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi571( float2 v, float time, inout float2 id, inout float2 mr, float smoothness, inout float2 smoothId )
		{
			float2 n = floor( v );
			float2 f = frac( v );
			float F1 = 8.0;
			float F2 = 8.0; float2 mg = 0;
			for ( int j = -1; j <= 1; j++ )
			{
				for ( int i = -1; i <= 1; i++ )
			 	{
			 		float2 g = float2( i, j );
			 		float2 o = voronoihash571( n + g );
					o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = f - g - o;
					float d = 0.5 * dot( r, r );
			 		if( d<F1 ) {
			 			F2 = F1;
			 			F1 = d; mg = g; mr = r; id = o;
			 		} else if( d<F2 ) {
			 			F2 = d;
			
			 		}
			 	}
			}
			return F1;
		}


		float2 voronoihash594( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi594( float2 v, float time, inout float2 id, inout float2 mr, float smoothness, inout float2 smoothId )
		{
			float2 n = floor( v );
			float2 f = frac( v );
			float F1 = 8.0;
			float F2 = 8.0; float2 mg = 0;
			for ( int j = -1; j <= 1; j++ )
			{
				for ( int i = -1; i <= 1; i++ )
			 	{
			 		float2 g = float2( i, j );
			 		float2 o = voronoihash594( n + g );
					o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = f - g - o;
					float d = 0.5 * dot( r, r );
			 		if( d<F1 ) {
			 			F2 = F1;
			 			F1 = d; mg = g; mr = r; id = o;
			 		} else if( d<F2 ) {
			 			F2 = d;
			
			 		}
			 	}
			}
			return F1;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.vertexToFrag10_g167 = ( ( v.texcoord1.xy * (unity_LightmapST).xy ) + (unity_LightmapST).zw );
			float3 ase_positionWS = mul( unity_ObjectToWorld, v.vertex );
			float3 ase_normalWS = UnityObjectToWorldNormal( v.normal );
			float3 ase_tangentWS = UnityObjectToWorldDir( v.tangent.xyz );
			half tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
			float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * tangentSign;
			float3x3 ase_worldToTangent = float3x3( ase_tangentWS, ase_bitangentWS, ase_normalWS );
			float3 ase_viewVectorTS = mul( ase_worldToTangent, ( _WorldSpaceCameraPos.xyz - ase_positionWS ) );
			float3 ase_viewDirTS = normalize( ase_viewVectorTS );
			float3 break72 = ase_viewDirTS;
			float2 appendResult73 = (float2(break72.x , break72.y));
			float2 Parallax_Logic28 = ( _ParallaxAmount * ( appendResult73 / break72.z ) );
			o.vertexToFrag249 = Parallax_Logic28;
			float2 temp_output_66_0 = ( float2( 1,1 ) / _PupilSize );
			float2 uv_TexCoord70 = v.texcoord.xy * temp_output_66_0 + ( float2( 0.5,0.5 ) + ( temp_output_66_0 / float2( -2,-2 ) ) );
			float2 Pupil_Scale_Logic64 = uv_TexCoord70;
			float2 Non_Spherized_Pupil106 = ( Pupil_Scale_Logic64 + Parallax_Logic28 );
			o.vertexToFrag258 = Non_Spherized_Pupil106;
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Normal = float3(0,0,1);
			float4 tex2DNode7_g167 = UNITY_SAMPLE_TEX2D( unity_Lightmap, i.vertexToFrag10_g167 );
			float3 decodeLightMap6_g167 = DecodeLightmap(tex2DNode7_g167);
			float3 temp_output_12_0_g177 = ( decodeLightMap6_g167 * ( 1.0 ) );
			float dotResult28_g177 = dot( float3(0.2126729,0.7151522,0.072175) , temp_output_12_0_g177 );
			float3 temp_cast_1 = (dotResult28_g177).xxx;
			float temp_output_21_0_g177 = 0.0;
			float3 lerpResult31_g177 = lerp( temp_cast_1 , temp_output_12_0_g177 , temp_output_21_0_g177);
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float temp_output_2572_0 = ( ( ( lerpResult31_g177.x + 1.0 ) * ase_lightColor.a ) * (( _UnlitToggle )?( 0.0 ):( 1.0 )) );
			float ifLocalVar2555 = 0;
			if( 0.0001 > temp_output_2572_0 )
				ifLocalVar2555 = 1.0;
			else if( 0.0001 < temp_output_2572_0 )
				ifLocalVar2555 = temp_output_2572_0;
			float clampResult2568 = clamp( ( ifLocalVar2555 * 1.0 ) , 0.0 , 2.0 );
			float2 temp_output_2_0_g124 = i.uv_texcoord;
			float2 temp_output_11_0_g124 = ( temp_output_2_0_g124 - float2( 0.5,0.5 ) );
			float dotResult12_g124 = dot( temp_output_11_0_g124 , temp_output_11_0_g124 );
			float2 temp_cast_2 = (_EyeRoundness).xx;
			float smoothstepResult152 = smoothstep( 0.0 , 6.0 , -( ( temp_output_2_0_g124 + ( temp_output_11_0_g124 * ( dotResult12_g124 * dotResult12_g124 * temp_cast_2 ) ) + float2( 0,0 ) ).y - 1.2 ));
			float smoothstepResult174 = smoothstep( 0.0 , 10.0 , -( ( temp_output_2_0_g124 + ( temp_output_11_0_g124 * ( dotResult12_g124 * dotResult12_g124 * temp_cast_2 ) ) + float2( 0,0 ) ).y - 0.3 ));
			float smoothstepResult176 = smoothstep( 0.0 , 4.0 , ( smoothstepResult174 * 50.0 ));
			float3 temp_cast_3 = (0.1).xxx;
			float3 temp_cast_4 = (0.4).xxx;
			float2 appendResult164 = (float2(1.0 , ( -0.01 * _Time.y )));
			float2 uv_TexCoord166 = i.uv_texcoord * float2( 0.8,1 ) + appendResult164;
			float4 tex2DNode167 = tex2D( _HighlightNoise, uv_TexCoord166 );
			float3 smoothstepResult169 = smoothstep( temp_cast_3 , temp_cast_4 , tex2DNode167.rgb);
			float smoothstepResult216 = smoothstep( 0.0 , 10.0 , -( ( temp_output_2_0_g124 + ( temp_output_11_0_g124 * ( dotResult12_g124 * dotResult12_g124 * temp_cast_2 ) ) + float2( 0,0 ) ).y - 0.8 ));
			float smoothstepResult210 = smoothstep( 0.0 , 5.0 , ( smoothstepResult216 * 50.0 ));
			float3 temp_cast_5 = (0.1).xxx;
			float3 temp_cast_6 = (0.4).xxx;
			float3 smoothstepResult202 = smoothstep( temp_cast_5 , temp_cast_6 , tex2DNode167.rgb);
			float3 Lower_Eye_Highlight358 = ( ( ( _HighlightColor * pow( saturate( ( pow( smoothstepResult152 , 1.2 ) * 5.0 ) ) , _HighlightThreshold ) * ( _HighlightIntensity * 3.0 ) ) + ( saturate( ( ( smoothstepResult176 * smoothstepResult169 ) * 10.0 ) ) * ( _HighlightIntensity * float3( 0.75,0.75,0.75 ) * ( _HighlightColor * float3( 0.5,0.5,5 ) ) ) ) ) + ( saturate( ( ( smoothstepResult210 * smoothstepResult202 ) * 10.0 ) ) * _Highlight2Color.rgb * ( _Highlight2Intensity * 0.2 ) ) );
			float3 temp_output_12_0_g176 = Lower_Eye_Highlight358;
			float dotResult28_g176 = dot( float3(0.2126729,0.7151522,0.072175) , temp_output_12_0_g176 );
			float3 temp_cast_7 = (dotResult28_g176).xxx;
			float temp_output_21_0_g176 = 0.0;
			float3 lerpResult31_g176 = lerp( temp_cast_7 , temp_output_12_0_g176 , temp_output_21_0_g176);
			float mulTime2729 = _Time.y * _LineRotationSpeed;
			float temp_output_2731_0 = ( 0.0 + mulTime2729 );
			float temp_output_767_0 = cos( temp_output_2731_0 );
			float3 break72 = i.viewDir;
			float2 appendResult73 = (float2(break72.x , break72.y));
			float2 Parallax_Logic28 = ( _ParallaxAmount * ( appendResult73 / break72.z ) );
			float2 temp_output_754_0 = ( float2( 1,1 ) / _PupilSize );
			float2 uv_TexCoord757 = i.uv_texcoord * temp_output_754_0 + ( float2( 0.5,0.5 ) + ( temp_output_754_0 / float2( -2,-2 ) ) );
			float2 temp_output_2_0_g122 = ( Parallax_Logic28 + uv_TexCoord757 );
			float2 temp_output_11_0_g122 = ( temp_output_2_0_g122 - float2( 0.5,0.5 ) );
			float dotResult12_g122 = dot( temp_output_11_0_g122 , temp_output_11_0_g122 );
			float2 temp_cast_8 = (_EyeRoundness).xx;
			float2 temp_output_762_0 = ( temp_output_2_0_g122 + ( temp_output_11_0_g122 * ( dotResult12_g122 * dotResult12_g122 * temp_cast_8 ) ) + float2( 0,0 ) );
			float2 _RotationPoint1 = float2(0.5,0.5);
			float2 break765 = ( temp_output_762_0 - _RotationPoint1 );
			float temp_output_766_0 = sin( temp_output_2731_0 );
			float2 appendResult774 = (float2(( ( temp_output_767_0 * break765.x ) + ( temp_output_766_0 * break765.y ) ) , ( ( break765.x * temp_output_766_0 ) - ( temp_output_767_0 * break765.y ) )));
			float2 temp_output_34_0_g126 = ( ( ( appendResult774 * ( _PupilSize * float2( 0.4,0.7 ) ) ) + _RotationPoint1 ) - float2( 0.5,0.5 ) );
			float2 break39_g126 = temp_output_34_0_g126;
			float2 appendResult50_g126 = (float2(( 1.0 * ( length( temp_output_34_0_g126 ) * 2.0 ) ) , ( ( atan2( break39_g126.x , break39_g126.y ) * ( 1.0 / 6.28318548202515 ) ) * 1.0 )));
			float saferPower783 = abs( sin( ( appendResult50_g126.y * 70.0 ) ) );
			float smoothstepResult786 = smoothstep( 0.0 , 25.0 , pow( saferPower783 , 2.0 ));
			float temp_output_792_0 = saturate( ( smoothstepResult786 * 200.0 ) );
			float temp_output_778_0 = distance( temp_output_762_0 , float2( 0.5,0.5 ) );
			float mulTime2733 = _Time.y * _LineRotationSpeed;
			float temp_output_2734_0 = ( 0.0 * mulTime2733 );
			float temp_output_2410_0 = cos( temp_output_2734_0 );
			float2 temp_output_2397_0 = ( float2( 1,1 ) / _PupilSize );
			float2 uv_TexCoord2400 = i.uv_texcoord * temp_output_2397_0 + ( float2( 0.5,0.5 ) + ( temp_output_2397_0 / float2( -2,-2 ) ) );
			float2 temp_output_2_0_g121 = ( Parallax_Logic28 + uv_TexCoord2400 );
			float2 temp_output_11_0_g121 = ( temp_output_2_0_g121 - float2( 0.5,0.5 ) );
			float dotResult12_g121 = dot( temp_output_11_0_g121 , temp_output_11_0_g121 );
			float2 temp_cast_9 = (_EyeRoundness).xx;
			float2 temp_output_2405_0 = ( temp_output_2_0_g121 + ( temp_output_11_0_g121 * ( dotResult12_g121 * dotResult12_g121 * temp_cast_9 ) ) + float2( 0,0 ) );
			float2 _RotationPoint3 = float2(0.5,0.5);
			float2 break2408 = ( temp_output_2405_0 - _RotationPoint3 );
			float temp_output_2409_0 = sin( temp_output_2734_0 );
			float2 appendResult2417 = (float2(( ( temp_output_2410_0 * break2408.x ) + ( temp_output_2409_0 * break2408.y ) ) , ( ( break2408.x * temp_output_2409_0 ) - ( temp_output_2410_0 * break2408.y ) )));
			float2 temp_output_34_0_g125 = ( ( ( appendResult2417 * ( _PupilSize * float2( 0.4,0.7 ) ) ) + _RotationPoint3 ) - float2( 0.5,0.5 ) );
			float2 break39_g125 = temp_output_34_0_g125;
			float2 appendResult50_g125 = (float2(( 1.0 * ( length( temp_output_34_0_g125 ) * 2.0 ) ) , ( ( atan2( break39_g125.x , break39_g125.y ) * ( 1.0 / 6.28318548202515 ) ) * 1.0 )));
			float saferPower735 = abs( sin( ( appendResult50_g125.y * 40.0 ) ) );
			float smoothstepResult695 = smoothstep( 0.0 , 25.0 , pow( saferPower735 , 5.0 ));
			float temp_output_701_0 = saturate( ( smoothstepResult695 * 200.0 ) );
			float temp_output_689_0 = distance( temp_output_2405_0 , float2( 0.5,0.5 ) );
			float mulTime2735 = _Time.y * _LineRotationSpeed;
			float temp_output_2736_0 = ( 0.5 * mulTime2735 );
			float temp_output_814_0 = cos( temp_output_2736_0 );
			float2 temp_output_2423_0 = ( float2( 1,1 ) / _PupilSize );
			float2 uv_TexCoord2426 = i.uv_texcoord * temp_output_2423_0 + ( float2( 0.5,0.5 ) + ( temp_output_2423_0 / float2( -2,-2 ) ) );
			float2 temp_output_2_0_g123 = ( Parallax_Logic28 + uv_TexCoord2426 );
			float2 temp_output_11_0_g123 = ( temp_output_2_0_g123 - float2( 0.5,0.5 ) );
			float dotResult12_g123 = dot( temp_output_11_0_g123 , temp_output_11_0_g123 );
			float2 temp_cast_10 = (_EyeRoundness).xx;
			float2 temp_output_2430_0 = ( temp_output_2_0_g123 + ( temp_output_11_0_g123 * ( dotResult12_g123 * dotResult12_g123 * temp_cast_10 ) ) + float2( 0,0 ) );
			float2 _RotationPoint2 = float2(0.5,0.5);
			float2 break812 = ( temp_output_2430_0 - _RotationPoint2 );
			float temp_output_813_0 = sin( temp_output_2736_0 );
			float2 appendResult821 = (float2(( ( temp_output_814_0 * break812.x ) + ( temp_output_813_0 * break812.y ) ) , ( ( break812.x * temp_output_813_0 ) - ( temp_output_814_0 * break812.y ) )));
			float2 temp_output_34_0_g127 = ( ( ( appendResult821 * ( _PupilSize * float2( 0.4,0.7 ) ) ) + _RotationPoint2 ) - float2( 0.5,0.5 ) );
			float2 break39_g127 = temp_output_34_0_g127;
			float2 appendResult50_g127 = (float2(( 1.0 * ( length( temp_output_34_0_g127 ) * 2.0 ) ) , ( ( atan2( break39_g127.x , break39_g127.y ) * ( 1.0 / 6.28318548202515 ) ) * 1.0 )));
			float saferPower830 = abs( sin( ( appendResult50_g127.y * 50.0 ) ) );
			float smoothstepResult833 = smoothstep( 0.0 , 25.0 , pow( saferPower830 , 1.0 ));
			float temp_output_839_0 = saturate( ( smoothstepResult833 * 300.0 ) );
			float temp_output_825_0 = distance( temp_output_2430_0 , float2( 0.5,0.5 ) );
			float Styalised_Lines643 = ( ( 1.0 - pow( saturate( ( distance( i.uv_texcoord , float2( 0.5,0.5 ) ) * 1.6 ) ) , 0.4 ) ) * pow( ( ( ( temp_output_792_0 * pow( saturate( ( temp_output_778_0 * 0.08 ) ) , 1.5 ) ) * ( temp_output_792_0 * ( ( 1.0 - pow( saturate( ( temp_output_778_0 * 0.001 ) ) , 0.05 ) ) * 2.5 ) ) ) + ( ( temp_output_701_0 * pow( saturate( ( temp_output_689_0 * 0.08 ) ) , 1.5 ) ) * ( temp_output_701_0 * ( ( 1.0 - pow( saturate( ( temp_output_689_0 * 0.0002 ) ) , 0.05 ) ) * 2.5 ) ) ) + ( ( temp_output_839_0 * pow( saturate( ( temp_output_825_0 * 0.01 ) ) , 1.0 ) ) * ( temp_output_839_0 * ( ( 1.0 - pow( saturate( ( temp_output_825_0 * 0.0002 ) ) , 0.001 ) ) * 40.0 ) ) ) ) , _LineThreshold ) );
			float temp_output_1499_0 = saturate( ( Styalised_Lines643 - 0.0 ) );
			float temp_output_1505_0 = ( temp_output_1499_0 * _LineIntensity );
			float Lines_Emission_Boost2843 = temp_output_1505_0;
			float2 temp_output_66_0 = ( float2( 1,1 ) / _PupilSize );
			float2 uv_TexCoord70 = i.uv_texcoord * temp_output_66_0 + ( float2( 0.5,0.5 ) + ( temp_output_66_0 / float2( -2,-2 ) ) );
			float2 Pupil_Scale_Logic64 = uv_TexCoord70;
			float2 temp_output_2_0_g120 = ( Pupil_Scale_Logic64 + i.vertexToFrag249 );
			float2 temp_output_11_0_g120 = ( temp_output_2_0_g120 - float2( 0.5,0.5 ) );
			float dotResult12_g120 = dot( temp_output_11_0_g120 , temp_output_11_0_g120 );
			float2 temp_cast_11 = (_EyeRoundness).xx;
			float2 Spherized_Pupil39 = ( temp_output_2_0_g120 + ( temp_output_11_0_g120 * ( dotResult12_g120 * dotResult12_g120 * temp_cast_11 ) ) + float2( 0,0 ) );
			float saferPower319 = abs( saturate( ( distance( Spherized_Pupil39 , float2( 0.5,0.5 ) ) * 0.005 ) ) );
			float3 Center_Color327 = ( ( ( 1.0 - saturate( pow( saferPower319 , 0.1 ) ) ) * _CenterColor ) * _CenterColorIntensity );
			float3 blendOpSrc336 = _BaseColor;
			float3 blendOpDest336 = Center_Color327;
			float3 Base_Colors222 = ( saturate( ( 1.0 - ( 1.0 - blendOpSrc336 ) * ( 1.0 - blendOpDest336 ) ) ));
			float smoothstepResult2301 = smoothstep( 0.0 , 16.0 , -( ( temp_output_2_0_g124 + ( temp_output_11_0_g124 * ( dotResult12_g124 * dotResult12_g124 * temp_cast_2 ) ) + float2( 0,0 ) ).y - 1.5 ));
			float smoothstepResult2321 = smoothstep( 0.0 , 8.0 , ( smoothstepResult2301 * 50.0 ));
			float2 appendResult2293 = (float2(1.0 , ( -0.02 * _Time.y )));
			float2 uv_TexCoord2295 = i.uv_texcoord * float2( 0.8,1 ) + appendResult2293;
			float temp_output_2608_0 = saturate( ( ( ( smoothstepResult2321 * tex2D( _BackgroundNoise, uv_TexCoord2295 ).r ) * 5.0 ) * _CloudNoiseVisibillity ) );
			float3 Cloud_Noise_Sub2371 = ( temp_output_2608_0 * ( 1.0 - _CloudNoiseColor ) );
			float3 Cloud_Noise_add2328 = ( temp_output_2608_0 * _CloudNoiseColor );
			float3 temp_output_12_0_g150 = Cloud_Noise_add2328;
			float dotResult28_g150 = dot( float3(0.2126729,0.7151522,0.072175) , temp_output_12_0_g150 );
			float3 temp_cast_12 = (dotResult28_g150).xxx;
			float temp_output_21_0_g150 = 0.5;
			float3 lerpResult31_g150 = lerp( temp_cast_12 , temp_output_12_0_g150 , temp_output_21_0_g150);
			float3 lerpResult2455 = lerp( ( Base_Colors222 - Cloud_Noise_Sub2371 ) , ( ( _BaseColorIntensity * Base_Colors222 ) + Cloud_Noise_add2328 ) , lerpResult31_g150.x);
			float3 temp_output_2601_0 = ( Lower_Eye_Highlight358 * 0.75 );
			float2 Non_Spherized_Pupil106 = ( Pupil_Scale_Logic64 + Parallax_Logic28 );
			float2 temp_output_2596_0 = ( float2( 1,1 ) / ( _FlowScale * float2( 1.5,1.2 ) ) );
			float2 uv_TexCoord2599 = i.uv_texcoord * temp_output_2596_0 + ( float2( 0.5,0.5 ) + ( temp_output_2596_0 / float2( -2,-2 ) ) );
			float smoothstepResult2604 = smoothstep( 0.0 , 3.5 , ( 1.0 - pow( saturate( ( distance( uv_TexCoord2599 , float2( 0.5,0.5 ) ) * 1.98 ) ) , 0.5 ) ));
			float temp_output_1082_0 = cos( 0.0 );
			float2 _NoiseRotationPoint3 = float2(0.5,0.5);
			float2 break1080 = ( i.uv_texcoord - _NoiseRotationPoint3 );
			float temp_output_1081_0 = sin( 0.0 );
			float2 appendResult1106 = (float2(( ( temp_output_1082_0 * break1080.x ) + ( temp_output_1081_0 * break1080.y ) ) , ( ( break1080.x * temp_output_1081_0 ) - ( temp_output_1082_0 * break1080.y ) )));
			float Scrolling_Noise_Reverse_Logic1475 = (( _ScrollingNoiseReverse )?( ( _FlowSpeed * 0.1 ) ):( ( _FlowSpeed * -0.1 ) ));
			float2 appendResult1110 = (float2(( _Time.y * ( ( Scrolling_Noise_Reverse_Logic1475 + 0.01 ) * -1.0 ) ) , 0.0));
			float2 temp_output_1114_0 = ( ( ( appendResult1106 * ( _FlowNoiseScale * float2( 1,1 ) ) ) + _NoiseRotationPoint3 ) + appendResult1110 );
			float temp_output_922_0 = cos( 0.0 );
			float2 temp_output_2_0_g78 = i.uv_texcoord;
			float2 temp_output_11_0_g78 = ( temp_output_2_0_g78 - float2( 0.5,0.5 ) );
			float dotResult12_g78 = dot( temp_output_11_0_g78 , temp_output_11_0_g78 );
			float2 temp_cast_13 = (0.0).xx;
			float2 _NoiseRotationPoint1 = float2(0.5,0.5);
			float2 break920 = ( ( temp_output_2_0_g78 + ( temp_output_11_0_g78 * ( dotResult12_g78 * dotResult12_g78 * temp_cast_13 ) ) + float2( 0,0 ) ) - _NoiseRotationPoint1 );
			float temp_output_921_0 = sin( 0.0 );
			float2 appendResult929 = (float2(( ( temp_output_922_0 * break920.x ) + ( temp_output_921_0 * break920.y ) ) , ( ( break920.x * temp_output_921_0 ) - ( temp_output_922_0 * break920.y ) )));
			float2 temp_output_930_0 = ( appendResult929 + _NoiseRotationPoint1 );
			float lerpResult1009 = lerp( ( distance( temp_output_930_0 , float2( -0.6,0.5 ) ) * 0.8 ) , ( distance( temp_output_930_0 , float2( 1.6,0.5 ) ) * 0.8 ) , 0.5);
			float temp_output_1013_0 = pow( ( ( 1.0 - lerpResult1009 ) * 6.5 ) , 5.0 );
			float2 break1254 = temp_output_930_0;
			float smoothstepResult1613 = smoothstep( 0.0 , 3.5 , ( break1254.x - 0.2 ));
			float temp_output_1234_0 = cos( 0.0 );
			float2 _NoiseRotationPoint6 = float2(0.5,0.5);
			float2 break1244 = ( i.uv_texcoord - _NoiseRotationPoint6 );
			float temp_output_1233_0 = sin( 0.0 );
			float2 appendResult1240 = (float2(( ( temp_output_1234_0 * break1244.x ) + ( temp_output_1233_0 * break1244.y ) ) , ( ( break1244.x * temp_output_1233_0 ) - ( temp_output_1234_0 * break1244.y ) )));
			float2 appendResult1230 = (float2(( _Time.y * Scrolling_Noise_Reverse_Logic1475 ) , 0.0));
			float2 temp_output_1220_0 = ( ( ( appendResult1240 * ( _FlowNoiseScale * float2( 1,1 ) ) ) + _NoiseRotationPoint6 ) + appendResult1230 );
			float smoothstepResult1617 = smoothstep( 0.0 , 3.5 , ( ( 1.0 - break1254.x ) - 0.2 ));
			float lerpResult955 = lerp( ( distance( temp_output_930_0 , float2( 0.5,-0.6 ) ) * 0.8 ) , ( distance( temp_output_930_0 , float2( 0.5,1.6 ) ) * 0.8 ) , 0.5);
			float temp_output_951_0 = pow( ( ( 1.0 - lerpResult955 ) * 6.5 ) , 5.0 );
			float smoothstepResult1622 = smoothstep( 0.0 , 3.5 , ( ( 1.0 - break1254.y ) - 0.2 ));
			float temp_output_1173_0 = cos( 1.55 );
			float2 _NoiseRotationPoint4 = float2(0.5,0.5);
			float2 break1183 = ( i.uv_texcoord - _NoiseRotationPoint4 );
			float temp_output_1172_0 = sin( 1.55 );
			float2 appendResult1179 = (float2(( ( temp_output_1173_0 * break1183.x ) + ( temp_output_1172_0 * break1183.y ) ) , ( ( break1183.x * temp_output_1172_0 ) - ( temp_output_1173_0 * break1183.y ) )));
			float2 appendResult1169 = (float2(( _Time.y * ( Scrolling_Noise_Reverse_Logic1475 * -1.0 ) ) , 0.0));
			float2 temp_output_1159_0 = ( ( ( appendResult1179 * ( _FlowNoiseScale * float2( 1,1 ) ) ) + _NoiseRotationPoint4 ) + appendResult1169 );
			float smoothstepResult1620 = smoothstep( 0.0 , 3.5 , ( break1254.y - 0.2 ));
			float temp_output_1202_0 = cos( 1.55 );
			float2 _NoiseRotationPoint5 = float2(0.5,0.5);
			float2 break1212 = ( i.uv_texcoord - _NoiseRotationPoint5 );
			float temp_output_1201_0 = sin( 1.55 );
			float2 appendResult1208 = (float2(( ( temp_output_1202_0 * break1212.x ) + ( temp_output_1201_0 * break1212.y ) ) , ( ( break1212.x * temp_output_1201_0 ) - ( temp_output_1202_0 * break1212.y ) )));
			float2 appendResult1198 = (float2(( _Time.y * ( Scrolling_Noise_Reverse_Logic1475 + 0.03 ) ) , 0.0));
			float2 temp_output_1188_0 = ( ( ( appendResult1208 * ( _FlowNoiseScale * float2( 1,1 ) ) ) + _NoiseRotationPoint5 ) + appendResult1198 );
			float temp_output_1282_0 = cos( 0.75 );
			float2 _NoiseRotationPoint9 = float2(0.5,0.5);
			float2 break1283 = ( i.uv_texcoord - _NoiseRotationPoint9 );
			float temp_output_1281_0 = sin( 0.75 );
			float2 appendResult1337 = (float2(( ( temp_output_1282_0 * break1283.x ) + ( temp_output_1281_0 * break1283.y ) ) , ( ( break1283.x * temp_output_1281_0 ) - ( temp_output_1282_0 * break1283.y ) )));
			float2 appendResult1369 = (float2(( _Time.y * ( ( Scrolling_Noise_Reverse_Logic1475 + 0.03 ) * -1.0 ) ) , 0.0));
			float2 temp_output_1379_0 = ( ( ( appendResult1337 * ( _FlowNoiseScale * float2( 1,1 ) ) ) + _NoiseRotationPoint9 ) + appendResult1369 );
			float temp_output_1630_0 = cos( 0.75 );
			float2 temp_output_2_0_g77 = i.uv_texcoord;
			float2 temp_output_11_0_g77 = ( temp_output_2_0_g77 - float2( 0.5,0.5 ) );
			float dotResult12_g77 = dot( temp_output_11_0_g77 , temp_output_11_0_g77 );
			float2 temp_cast_14 = (0.0).xx;
			float2 _NoiseRotationPoint2 = float2(0.5,0.5);
			float2 break1628 = ( ( temp_output_2_0_g77 + ( temp_output_11_0_g77 * ( dotResult12_g77 * dotResult12_g77 * temp_cast_14 ) ) + float2( 0,0 ) ) - _NoiseRotationPoint2 );
			float temp_output_1629_0 = sin( 0.75 );
			float2 appendResult1637 = (float2(( ( temp_output_1630_0 * break1628.x ) + ( temp_output_1629_0 * break1628.y ) ) , ( ( break1628.x * temp_output_1629_0 ) - ( temp_output_1630_0 * break1628.y ) )));
			float2 temp_output_1638_0 = ( appendResult1637 + _NoiseRotationPoint2 );
			float lerpResult1649 = lerp( ( distance( temp_output_1638_0 , float2( -0.6,0.5 ) ) * 0.8 ) , ( distance( temp_output_1638_0 , float2( 1.6,0.5 ) ) * 0.8 ) , 0.5);
			float temp_output_1661_0 = pow( ( ( 1.0 - lerpResult1649 ) * 6.5 ) , 5.0 );
			float2 break1647 = temp_output_1638_0;
			float smoothstepResult1662 = smoothstep( 0.0 , 3.5 , ( break1647.x - 0.2 ));
			float temp_output_1285_0 = cos( 0.75 );
			float2 _NoiseRotationPoint10 = float2(0.5,0.5);
			float2 break1286 = ( i.uv_texcoord - _NoiseRotationPoint10 );
			float temp_output_1284_0 = sin( 0.75 );
			float2 appendResult1341 = (float2(( ( temp_output_1285_0 * break1286.x ) + ( temp_output_1284_0 * break1286.y ) ) , ( ( break1286.x * temp_output_1284_0 ) - ( temp_output_1285_0 * break1286.y ) )));
			float2 appendResult1371 = (float2(( _Time.y * ( Scrolling_Noise_Reverse_Logic1475 + 0.01 ) ) , 0.0));
			float2 temp_output_1380_0 = ( ( ( appendResult1341 * ( _FlowNoiseScale * float2( 1,1 ) ) ) + _NoiseRotationPoint10 ) + appendResult1371 );
			float smoothstepResult1663 = smoothstep( 0.0 , 3.5 , ( ( 1.0 - break1647.x ) - 0.2 ));
			float lerpResult1648 = lerp( ( distance( temp_output_1638_0 , float2( 0.5,-0.6 ) ) * 0.8 ) , ( distance( temp_output_1638_0 , float2( 0.5,1.6 ) ) * 0.8 ) , 0.5);
			float temp_output_1660_0 = pow( ( ( 1.0 - lerpResult1648 ) * 6.5 ) , 5.0 );
			float smoothstepResult1665 = smoothstep( 0.0 , 3.5 , ( ( 1.0 - break1647.y ) - 0.2 ));
			float temp_output_1279_0 = cos( 2.35 );
			float2 _NoiseRotationPoint8 = float2(0.5,0.5);
			float2 break1280 = ( i.uv_texcoord - _NoiseRotationPoint8 );
			float temp_output_1278_0 = sin( 2.35 );
			float2 appendResult1334 = (float2(( ( temp_output_1279_0 * break1280.x ) + ( temp_output_1278_0 * break1280.y ) ) , ( ( break1280.x * temp_output_1278_0 ) - ( temp_output_1279_0 * break1280.y ) )));
			float2 appendResult1367 = (float2(( _Time.y * ( ( Scrolling_Noise_Reverse_Logic1475 + 0.03 ) * -1.0 ) ) , 0.0));
			float2 temp_output_1378_0 = ( ( ( appendResult1334 * ( _FlowNoiseScale * float2( 1,1 ) ) ) + _NoiseRotationPoint8 ) + appendResult1367 );
			float smoothstepResult1664 = smoothstep( 0.0 , 3.5 , ( break1647.y - 0.2 ));
			float temp_output_1276_0 = cos( 2.35 );
			float2 _NoiseRotationPoint7 = float2(0.5,0.5);
			float2 break1277 = ( i.uv_texcoord - _NoiseRotationPoint7 );
			float temp_output_1275_0 = sin( 2.35 );
			float2 appendResult1330 = (float2(( ( temp_output_1276_0 * break1277.x ) + ( temp_output_1275_0 * break1277.y ) ) , ( ( break1277.x * temp_output_1275_0 ) - ( temp_output_1276_0 * break1277.y ) )));
			float2 appendResult1365 = (float2(( _Time.y * Scrolling_Noise_Reverse_Logic1475 ) , 0.0));
			float2 temp_output_1377_0 = ( ( ( appendResult1330 * ( _FlowNoiseScale * float2( 1,1 ) ) ) + _NoiseRotationPoint7 ) + appendResult1365 );
			float Scrolling_Noise_texture895 = ( ( ( ( ( tex2D( _BackgroundNoise, temp_output_1114_0 ).r * saturate( ( temp_output_1013_0 * smoothstepResult1613 ) ) ) + ( tex2D( _BackgroundNoise, temp_output_1220_0 ).r * saturate( ( temp_output_1013_0 * smoothstepResult1617 ) ) ) ) * 8.0 ) + ( ( ( saturate( ( temp_output_951_0 * smoothstepResult1622 ) ) * tex2D( _BackgroundNoise, temp_output_1159_0 ).r ) + ( saturate( ( temp_output_951_0 * smoothstepResult1620 ) ) * tex2D( _BackgroundNoise, temp_output_1188_0 ).r ) ) * 8.0 ) ) + ( ( ( ( tex2D( _BackgroundNoise, temp_output_1379_0 ).r * saturate( ( temp_output_1661_0 * smoothstepResult1662 ) ) ) + ( tex2D( _BackgroundNoise, temp_output_1380_0 ).r * saturate( ( temp_output_1661_0 * smoothstepResult1663 ) ) ) ) * 8.0 ) + ( ( ( saturate( ( temp_output_1660_0 * smoothstepResult1665 ) ) * tex2D( _BackgroundNoise, temp_output_1378_0 ).r ) + ( saturate( ( temp_output_1660_0 * smoothstepResult1664 ) ) * tex2D( _BackgroundNoise, temp_output_1377_0 ).r ) ) * 8.0 ) ) );
			float temp_output_1678_0 = ( smoothstepResult2604 * Scrolling_Noise_texture895 );
			Gradient gradient134 = NewGradient( 0, 4, 2, float4( 1, 1, 1, 0 ), float4( 0.7020309, 0.6994113, 0.6994113, 0.3617609 ), float4( 0.1981132, 0.1981132, 0.1981132, 0.7588311 ), float4( 0, 0, 0, 1 ), 0, 0, 0, 0, float2( 1, 0 ), float2( 1, 1 ), 0, 0, 0, 0, 0, 0 );
			float time107 = 100.0;
			float2 voronoiSmoothId107 = 0;
			float voronoiSmooth107 = 0.8;
			float2 coords107 = i.vertexToFrag258 * 18.0;
			float2 id107 = 0;
			float2 uv107 = 0;
			float voroi107 = voronoi107( coords107, time107, id107, uv107, voronoiSmooth107, voronoiSmoothId107 );
			float temp_output_43_0 = distance( Spherized_Pupil39 , float2( 0.5,0.5 ) );
			float clampResult111 = clamp( ( voroi107 - ( 1.0 - ( temp_output_43_0 * 0.28 ) ) ) , 0.0 , 1.0 );
			float smoothstepResult98 = smoothstep( 0.0 , 8.0 , ( temp_output_43_0 * 2.0 ));
			float clampResult55 = clamp( smoothstepResult98 , 0.0 , 1.0 );
			float smoothstepResult281 = smoothstep( 0.0 , 25.0 , ( 1.0 - ( clampResult111 * clampResult55 ) ));
			float saferPower127 = abs( ( 1.0 - ( temp_output_43_0 * 0.0005 ) ) );
			float smoothstepResult128 = smoothstep( 0.0 , 800.0 , pow( saferPower127 , 350.0 ));
			float clampResult140 = clamp( ( ( ( smoothstepResult281 * 800.0 ) * ( smoothstepResult128 * 2000.0 ) ) * 25.0 ) , 0.0 , 1.0 );
			float Generated_Pupil120 = ( 1.0 - SampleGradient( gradient134, clampResult140 ).r );
			float temp_output_1696_0 = ( ( saturate( ( distance( Non_Spherized_Pupil106 , float2( 0.5,0.5 ) ) * 0.5 ) ) * ( saturate( pow( ( ( _FlowIntensity * 100.0 ) * saturate( temp_output_1678_0 ) ) , _FlowContrast ) ) - ( _FlowContrast * 0.01 ) ) ) - saturate( pow( ( Generated_Pupil120 * 1.0 ) , 3.0 ) ) );
			float3 lerpResult2745 = lerp( saturate( ( lerpResult2455 + temp_output_2601_0 ) ) , ( _FlowColor.rgb * float3( 1,1,1 ) ) , saturate( temp_output_1696_0 ));
			float temp_output_1916_0 = distance( i.uv_texcoord , float2( 0.5,0.5 ) );
			float temp_output_2046_0 = ( 1.0 - pow( saturate( ( temp_output_1916_0 * 3.4 ) ) , 1.5 ) );
			float2 appendResult1748 = (float2(( _ElectricitySpeed * _Time.y ) , ( _Time.y * _ElectricitySpeed )));
			float simpleNoise1751 = SimpleNoise( ( i.uv_texcoord + appendResult1748 )*45.0 );
			float temp_output_1754_0 = saturate( ( pow( simpleNoise1751 , 4.0 ) * 20.0 ) );
			float2 appendResult1758 = (float2(( ( _ElectricitySpeed * _Time.y ) * -1.0 ) , ( ( _Time.y * _ElectricitySpeed ) * 1.0 )));
			float simpleNoise1761 = SimpleNoise( ( i.uv_texcoord + appendResult1758 )*45.0 );
			float temp_output_1764_0 = saturate( ( pow( simpleNoise1761 , 4.0 ) * 20.0 ) );
			float temp_output_2076_0 = ( 0.0 + ( distance( i.uv_texcoord , float2( 0.5,0.5 ) ) * 20.0 ) );
			float temp_output_1807_0 = cos( temp_output_2076_0 );
			float2 _ElectricityRotationCenter = float2(0.5,0.5);
			float2 break1808 = ( i.uv_texcoord - _ElectricityRotationCenter );
			float temp_output_1806_0 = sin( temp_output_2076_0 );
			float2 appendResult1815 = (float2(( ( temp_output_1807_0 * break1808.x ) + ( temp_output_1806_0 * break1808.y ) ) , ( ( break1808.x * temp_output_1806_0 ) - ( temp_output_1807_0 * break1808.y ) )));
			float2 appendResult1781 = (float2(( ( _ElectricitySpeed * _Time.y ) * 1.0 ) , ( ( _Time.y * _ElectricitySpeed ) * -1.0 )));
			float simpleNoise1796 = SimpleNoise( ( i.uv_texcoord + appendResult1781 )*45.0 );
			float temp_output_1792_0 = saturate( ( pow( simpleNoise1796 , 4.0 ) * 20.0 ) );
			float2 appendResult1783 = (float2(( ( _ElectricitySpeed * _Time.y ) * -1.0 ) , ( ( _Time.y * _ElectricitySpeed ) * -1.0 )));
			float simpleNoise1787 = SimpleNoise( ( i.uv_texcoord + appendResult1783 )*45.0 );
			float temp_output_1793_0 = saturate( ( pow( simpleNoise1787 , 4.0 ) * 20.0 ) );
			float lerpResult2085 = lerp( ( ( temp_output_1754_0 * temp_output_1764_0 ) * 2.0 ) , ( 2.0 * ( temp_output_1792_0 * temp_output_1793_0 ) ) , 0.5);
			float temp_output_2096_0 = pow( ( lerpResult2085 + 0.1 ) , 0.6 );
			float2 temp_output_34_0_g131 = ( ( ( ( appendResult1815 + _ElectricityRotationCenter ) + float2( 0,0 ) ) * temp_output_2096_0 ) - float2( 0.5,0.5 ) );
			float2 break39_g131 = temp_output_34_0_g131;
			float2 appendResult50_g131 = (float2(( 1.0 * ( length( temp_output_34_0_g131 ) * 2.0 ) ) , ( ( atan2( break39_g131.x , break39_g131.y ) * ( 1.0 / 6.28318548202515 ) ) * 1.0 )));
			float2 break53_g131 = appendResult50_g131;
			float temp_output_1834_0 = ( distance( i.uv_texcoord , float2( 0.5,0.5 ) ) * ( 20.0 * -1.0 ) );
			float temp_output_1826_0 = cos( temp_output_1834_0 );
			float2 break1827 = ( i.uv_texcoord - _ElectricityRotationCenter );
			float temp_output_1825_0 = sin( temp_output_1834_0 );
			float2 appendResult1839 = (float2(( ( temp_output_1826_0 * break1827.x ) + ( temp_output_1825_0 * break1827.y ) ) , ( ( break1827.x * temp_output_1825_0 ) - ( temp_output_1826_0 * break1827.y ) )));
			float2 temp_output_34_0_g130 = ( ( ( appendResult1839 + _ElectricityRotationCenter ) * temp_output_2096_0 ) - float2( 0.5,0.5 ) );
			float2 break39_g130 = temp_output_34_0_g130;
			float2 appendResult50_g130 = (float2(( 1.0 * ( length( temp_output_34_0_g130 ) * 2.0 ) ) , ( ( atan2( break39_g130.x , break39_g130.y ) * ( 1.0 / 6.28318548202515 ) ) * 1.0 )));
			float2 break53_g130 = appendResult50_g130;
			float2 appendResult2120 = (float2(( _ElectricitySpeed * _Time.y ) , ( _Time.y * _ElectricitySpeed )));
			float simpleNoise2130 = SimpleNoise( ( i.uv_texcoord + appendResult2120 )*35.0 );
			float temp_output_2145_0 = ( pow( simpleNoise2130 , 4.0 ) * 25.0 );
			float2 appendResult2121 = (float2(( ( _ElectricitySpeed * _Time.y ) * -1.0 ) , ( ( _Time.y * _ElectricitySpeed ) * 1.0 )));
			float simpleNoise2129 = SimpleNoise( ( i.uv_texcoord + appendResult2121 )*35.0 );
			float temp_output_2146_0 = ( pow( simpleNoise2129 , 4.0 ) * 25.0 );
			float temp_output_2150_0 = ( 0.0 + ( distance( i.uv_texcoord , float2( 0.5,0.5 ) ) * 20.0 ) );
			float temp_output_2158_0 = cos( temp_output_2150_0 );
			float2 _ElectricityRotationCenter1 = float2(0.5,0.5);
			float2 break2159 = ( i.uv_texcoord - _ElectricityRotationCenter1 );
			float temp_output_2157_0 = sin( temp_output_2150_0 );
			float2 appendResult2181 = (float2(( ( temp_output_2158_0 * break2159.x ) + ( temp_output_2157_0 * break2159.y ) ) , ( ( break2159.x * temp_output_2157_0 ) - ( temp_output_2158_0 * break2159.y ) )));
			float2 appendResult2118 = (float2(( ( _ElectricitySpeed * _Time.y ) * 1.0 ) , ( ( _Time.y * _ElectricitySpeed ) * -1.0 )));
			float simpleNoise2127 = SimpleNoise( ( i.uv_texcoord + appendResult2118 )*35.0 );
			float temp_output_2143_0 = ( pow( simpleNoise2127 , 4.0 ) * 25.0 );
			float2 appendResult2119 = (float2(( ( _ElectricitySpeed * _Time.y ) * -1.0 ) , ( ( _Time.y * _ElectricitySpeed ) * -1.0 )));
			float simpleNoise2128 = SimpleNoise( ( i.uv_texcoord + appendResult2119 )*35.0 );
			float temp_output_2144_0 = ( pow( simpleNoise2128 , 4.0 ) * 25.0 );
			float lerpResult2178 = lerp( ( ( saturate( temp_output_2145_0 ) * saturate( temp_output_2146_0 ) ) * 2.0 ) , ( 2.0 * ( saturate( temp_output_2143_0 ) * saturate( temp_output_2144_0 ) ) ) , 0.5);
			float temp_output_2187_0 = pow( ( lerpResult2178 + 0.5 ) , 0.4 );
			float2 temp_output_34_0_g129 = ( ( ( ( appendResult2181 + _ElectricityRotationCenter1 ) + float2( 0,0 ) ) * temp_output_2187_0 ) - float2( 0.5,0.5 ) );
			float2 break39_g129 = temp_output_34_0_g129;
			float2 appendResult50_g129 = (float2(( 1.0 * ( length( temp_output_34_0_g129 ) * 2.0 ) ) , ( ( atan2( break39_g129.x , break39_g129.y ) * ( 1.0 / 6.28318548202515 ) ) * 1.0 )));
			float2 break53_g129 = appendResult50_g129;
			float temp_output_2156_0 = ( distance( i.uv_texcoord , float2( 0.5,0.5 ) ) * ( 20.0 * -1.0 ) );
			float temp_output_2163_0 = cos( temp_output_2156_0 );
			float2 break2164 = ( i.uv_texcoord - _ElectricityRotationCenter1 );
			float temp_output_2162_0 = sin( temp_output_2156_0 );
			float2 appendResult2182 = (float2(( ( temp_output_2163_0 * break2164.x ) + ( temp_output_2162_0 * break2164.y ) ) , ( ( break2164.x * temp_output_2162_0 ) - ( temp_output_2163_0 * break2164.y ) )));
			float2 temp_output_34_0_g128 = ( ( ( appendResult2182 + _ElectricityRotationCenter1 ) * temp_output_2187_0 ) - float2( 0.5,0.5 ) );
			float2 break39_g128 = temp_output_34_0_g128;
			float2 appendResult50_g128 = (float2(( 1.0 * ( length( temp_output_34_0_g128 ) * 2.0 ) ) , ( ( atan2( break39_g128.x , break39_g128.y ) * ( 1.0 / 6.28318548202515 ) ) * 1.0 )));
			float2 break53_g128 = appendResult50_g128;
			float Electricity1768 = saturate( ( ( ( ( 1.0 - pow( saturate( ( temp_output_1916_0 * 1.8 ) ) , 0.4 ) ) - temp_output_2046_0 ) * pow( ( ( pow( saturate( ( ( temp_output_1754_0 * temp_output_1764_0 ) * 2.0 ) ) , 4.0 ) * pow( pow( saturate( sin( ( break53_g131.y * 15.0 ) ) ) , 0.1 ) , ( _ElectricityThickness * 12.0 ) ) ) + ( pow( pow( saturate( sin( ( 15.0 * break53_g130.y ) ) ) , 0.1 ) , ( _ElectricityThickness * 12.0 ) ) * pow( saturate( ( ( temp_output_1792_0 * temp_output_1793_0 ) * 2.0 ) ) , 4.0 ) ) ) , 1.5 ) ) + ( temp_output_2046_0 * pow( ( ( pow( saturate( ( ( temp_output_2145_0 * temp_output_2146_0 ) * 1.0 ) ) , 4.0 ) * pow( pow( saturate( sin( ( break53_g129.y * 6.0 ) ) ) , 2.0 ) , ( _ElectricityThickness * 5.0 ) ) ) + ( pow( pow( saturate( sin( ( 6.0 * break53_g128.y ) ) ) , 2.0 ) , ( _ElectricityThickness * 5.0 ) ) * pow( saturate( ( ( temp_output_2143_0 * temp_output_2144_0 ) * 1.0 ) ) , 4.0 ) ) ) , 2.0 ) ) ) );
			float3 temp_output_1910_0 = ( ( ( Electricity1768 * saturate( ( ( 1.0 - Generated_Pupil120 ) * 1.0 ) ) ) * _ElectricityIntensity ) * _ElectricityColor );
			float3 lerpResult2718 = lerp( ( lerpResult2745 + temp_output_1910_0 ) , ( _LineColor * temp_output_1499_0 ) , temp_output_1505_0);
			float smoothstepResult2758 = smoothstep( 0.0 , 1.2 , ( ( Generated_Pupil120 * _PupilOpacity ) * 1.5 ));
			float3 temp_cast_15 = (( 1.0 - smoothstepResult2758 )).xxx;
			float3 blendOpSrc352 = lerpResult2718;
			float3 blendOpDest352 = temp_cast_15;
			float2 appendResult2225 = (float2(1.0 , ( _Time.y * ( 1.0 * -0.01 ) )));
			float2 uv2227 = 0;
			float3 unityVoronoy2227 = UnityVoronoi(( i.uv_texcoord + appendResult2225 ),120.0,( _StarsAmount * 4.0 ),uv2227);
			float smoothstepResult2235 = smoothstep( ( _StarsScale * 0.06 ) , 0.0 , unityVoronoy2227.x);
			float2 appendResult2241 = (float2(1.0 , ( _Time.y * ( 1.0 * -0.001 ) )));
			float2 uv2245 = 0;
			float3 unityVoronoy2245 = UnityVoronoi(( Parallax_Logic28 + appendResult2241 ),100.0,( _StarsAmount * 10.0 ),uv2245);
			float smoothstepResult2244 = smoothstep( ( _StarsScale * 0.04 ) , 0.0 , unityVoronoy2245.x);
			float2 appendResult2256 = (float2(1.0 , ( _Time.y * ( 0.0 * -0.001 ) )));
			float2 uv2259 = 0;
			float3 unityVoronoy2259 = UnityVoronoi(( ( Parallax_Logic28 * float2( 3,3 ) ) + appendResult2256 ),100.0,( _StarsAmount * 10.0 ),uv2259);
			float smoothstepResult2260 = smoothstep( ( _StarsScale * 0.04 ) , 0.0 , unityVoronoy2259.x);
			float Stars2246 = ( ( smoothstepResult2235 * 0.8 ) + smoothstepResult2244 + smoothstepResult2260 );
			float3 temp_output_2318_0 = ( ( Stars2246 * _StarsIntensity ) * _StarColor );
			float lerpResult2895 = lerp( ( 1.0 - ( Generated_Pupil120 * 2.0 ) ) , 1.0 , (( _StarsShowupPupil )?( 1.0 ):( 0.0 )));
			float2 temp_output_482_0 = ( float2( 1,1 ) / float2( 0.35,0.225 ) );
			float2 uv_TexCoord490 = i.uv_texcoord * temp_output_482_0 + ( float2( 0.5,0.5 ) + ( temp_output_482_0 / float2( -2,-2 ) ) );
			float2 temp_output_2_0_g135 = uv_TexCoord490;
			float2 temp_cast_16 = (0.0).xx;
			float2 temp_output_11_0_g135 = ( temp_output_2_0_g135 - temp_cast_16 );
			float dotResult12_g135 = dot( temp_output_11_0_g135 , temp_output_11_0_g135 );
			float2 temp_cast_17 = (0.0).xx;
			float3 ase_positionWS = i.worldPos;
			float3 ase_normalWS = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_tangentWS = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float3 ase_bitangentWS = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float3x3 ase_worldToTangent = float3x3( ase_tangentWS, ase_bitangentWS, ase_normalWS );
			float3 ase_viewVectorTS = mul( ase_worldToTangent, ( _WorldSpaceCameraPos.xyz - ase_positionWS ) );
			float2 appendResult485 = (float2(ase_viewVectorTS.x , ase_viewVectorTS.y));
			float smoothstepResult498 = smoothstep( 0.0 , 0.3 , ( 1.0 - distance( ( temp_output_2_0_g135 + ( temp_output_11_0_g135 * ( dotResult12_g135 * dotResult12_g135 * temp_cast_17 ) ) + ( float2( 1.2,1.2 ) + ( appendResult485 * 6.0 ) ) ) , float2( 0.5,0.5 ) ) ));
			float2 temp_output_504_0 = ( float2( 1,1 ) / float2( 0.45,0.3 ) );
			float2 uv_TexCoord512 = i.uv_texcoord * temp_output_504_0 + ( float2( 0.5,0.5 ) + ( temp_output_504_0 / float2( -2,-2 ) ) );
			float2 temp_output_2_0_g136 = uv_TexCoord512;
			float2 temp_cast_18 = (0.0).xx;
			float2 temp_output_11_0_g136 = ( temp_output_2_0_g136 - temp_cast_18 );
			float dotResult12_g136 = dot( temp_output_11_0_g136 , temp_output_11_0_g136 );
			float2 temp_cast_19 = (0.0).xx;
			float2 appendResult507 = (float2(ase_viewVectorTS.x , ase_viewVectorTS.y));
			float smoothstepResult521 = smoothstep( 0.0 , 0.3 , ( 1.0 - distance( ( temp_output_2_0_g136 + ( temp_output_11_0_g136 * ( dotResult12_g136 * dotResult12_g136 * temp_cast_19 ) ) + ( float2( -0.8,1.4 ) + ( appendResult507 * 4.0 ) ) ) , float2( 0.5,0.5 ) ) ));
			float time571 = 996.0;
			float2 voronoiSmoothId571 = 0;
			float2 temp_output_556_0 = ( float2( 1,1 ) / float2( 0.35,0.225 ) );
			float2 uv_TexCoord564 = i.uv_texcoord * temp_output_556_0 + ( float2( 0.5,0.5 ) + ( temp_output_556_0 / float2( -2,-2 ) ) );
			float2 temp_output_2_0_g133 = uv_TexCoord564;
			float2 temp_cast_20 = (0.0).xx;
			float2 temp_output_11_0_g133 = ( temp_output_2_0_g133 - temp_cast_20 );
			float dotResult12_g133 = dot( temp_output_11_0_g133 , temp_output_11_0_g133 );
			float2 temp_cast_21 = (0.0).xx;
			float2 appendResult559 = (float2(ase_viewVectorTS.x , ase_viewVectorTS.y));
			float2 coords571 = ( temp_output_2_0_g133 + ( temp_output_11_0_g133 * ( dotResult12_g133 * dotResult12_g133 * temp_cast_21 ) ) + ( float2( 1.4,0.2 ) + ( appendResult559 * 4.0 ) ) ) * 0.4;
			float2 id571 = 0;
			float2 uv571 = 0;
			float voroi571 = voronoi571( coords571, time571, id571, uv571, 0, voronoiSmoothId571 );
			float smoothstepResult572 = smoothstep( 0.03 , 0.0 , voroi571);
			float smoothstepResult573 = smoothstep( 0.0 , 1.2 , smoothstepResult572);
			float2 temp_output_612_0 = ( float2( 1,1 ) / float2( 0.35,0.225 ) );
			float2 uv_TexCoord620 = i.uv_texcoord * temp_output_612_0 + ( float2( 0.5,0.5 ) + ( temp_output_612_0 / float2( -2,-2 ) ) );
			float2 temp_output_2_0_g134 = uv_TexCoord620;
			float2 temp_cast_22 = (0.0).xx;
			float2 temp_output_11_0_g134 = ( temp_output_2_0_g134 - temp_cast_22 );
			float dotResult12_g134 = dot( temp_output_11_0_g134 , temp_output_11_0_g134 );
			float2 temp_cast_23 = (0.0).xx;
			float2 appendResult615 = (float2(ase_viewVectorTS.x , ase_viewVectorTS.y));
			float2 uv627 = 0;
			float3 unityVoronoy627 = UnityVoronoi(( temp_output_2_0_g134 + ( temp_output_11_0_g134 * ( dotResult12_g134 * dotResult12_g134 * temp_cast_23 ) ) + ( float2( 1.3,-1.6 ) + ( appendResult615 * 3.0 ) ) ),1366.0,0.3,uv627);
			float smoothstepResult628 = smoothstep( 0.3 , 0.0 , pow( unityVoronoy627.x , 1.1 ));
			float time594 = 984.0;
			float2 voronoiSmoothId594 = 0;
			float2 temp_output_579_0 = ( float2( 1,1 ) / float2( 0.35,0.225 ) );
			float2 uv_TexCoord587 = i.uv_texcoord * temp_output_579_0 + ( float2( 0.5,0.5 ) + ( temp_output_579_0 / float2( -2,-2 ) ) );
			float2 temp_output_2_0_g132 = uv_TexCoord587;
			float2 temp_cast_24 = (0.0).xx;
			float2 temp_output_11_0_g132 = ( temp_output_2_0_g132 - temp_cast_24 );
			float dotResult12_g132 = dot( temp_output_11_0_g132 , temp_output_11_0_g132 );
			float2 temp_cast_25 = (0.0).xx;
			float2 appendResult582 = (float2(ase_viewVectorTS.x , ase_viewVectorTS.y));
			float2 coords594 = ( temp_output_2_0_g132 + ( temp_output_11_0_g132 * ( dotResult12_g132 * dotResult12_g132 * temp_cast_25 ) ) + ( float2( -1.2,1 ) + ( appendResult582 * 1.6 ) ) ) * 1.2;
			float2 id594 = 0;
			float2 uv594 = 0;
			float voroi594 = voronoi594( coords594, time594, id594, uv594, 0, voronoiSmoothId594 );
			float smoothstepResult595 = smoothstep( 0.2 , 0.0 , pow( voroi594 , 0.6 ));
			float clampResult603 = clamp( pow( ( distance( i.uv_texcoord , float2( 0.5,0.5 ) ) * 2.4 ) , 4.0 ) , 0.0 , 1.0 );
			float Reflection405 = ( ( ( smoothstepResult498 * 0.15 ) + ( smoothstepResult521 * 0.15 ) ) + ( 0.0 + ( smoothstepResult573 * 0.05 ) + ( smoothstepResult628 * 0.2 ) + ( ( smoothstepResult595 * clampResult603 ) * 0.45 ) ) );
			float3 temp_cast_26 = (smoothstepResult2758).xxx;
			float3 temp_output_12_0_g151 = temp_cast_26;
			float dotResult28_g151 = dot( float3(0.2126729,0.7151522,0.072175) , temp_output_12_0_g151 );
			float3 temp_cast_27 = (dotResult28_g151).xxx;
			float temp_output_21_0_g151 = 0.0;
			float3 lerpResult31_g151 = lerp( temp_cast_27 , temp_output_12_0_g151 , temp_output_21_0_g151);
			float smoothstepResult155 = smoothstep( 0.0 , 25.0 , ( ( temp_output_2_0_g124 + ( temp_output_11_0_g124 * ( dotResult12_g124 * dotResult12_g124 * temp_cast_2 ) ) + float2( 0,0 ) ).y + 1.0 ));
			float Shadow312 = ( pow( saturate( ( smoothstepResult155 * 15.0 ) ) , _ShadowThreshold ) * _ShadowIntensity );
			float3 temp_cast_28 = (saturate( ( 1.0 - Shadow312 ) )).xxx;
			float3 blendOpSrc2488 = ( ( ( blendOpSrc352 + blendOpDest352 - 1.0 ) + ( temp_output_2318_0 * lerpResult2895 ) ) + ( ( Reflection405 * ( _ReflectionIntensity * 1.5 ) ) - ( lerpResult31_g151.x * 0.15 ) ) );
			float3 blendOpDest2488 = temp_cast_28;
			float3 temp_cast_29 = (pow( ( 1.0 - pow( saturate( ( distance( i.uv_texcoord , float2( 0.5,0.5 ) ) * ( _DarkningOutline * 1.98 ) ) ) , 4.0 ) ) , _DarkningOutlineSmoothing )).xxx;
			float3 blendOpSrc2476 = ( blendOpSrc2488 * blendOpDest2488 );
			float3 blendOpDest2476 = temp_cast_29;
			float3 hsvTorgb2704 = RGBToHSV( ( blendOpSrc2476 + blendOpDest2476 - 1.0 ) );
			float mulTime2740 = _Time.y * _HueShiftSpeed;
			float3 hsvTorgb2711 = HSVToRGB( float3(( hsvTorgb2704.x + ( _HueShift + mulTime2740 ) ),( _ColorSaturation * saturate( hsvTorgb2704.y ) ),( hsvTorgb2704.z + 0.0 )) );
			float3 temp_output_2571_0 = saturate( hsvTorgb2711 );
			float3 temp_cast_30 = (_ColorContrast).xxx;
			float Unclamped_Flow2829 = temp_output_1678_0;
			float3 temp_output_12_0_g178 = Center_Color327;
			float dotResult28_g178 = dot( float3(0.2126729,0.7151522,0.072175) , temp_output_12_0_g178 );
			float3 temp_cast_31 = (dotResult28_g178).xxx;
			float temp_output_21_0_g178 = 0.0;
			float3 lerpResult31_g178 = lerp( temp_cast_31 , temp_output_12_0_g178 , temp_output_21_0_g178);
			float2 temp_output_365_0 = ( float2( 1,1 ) / float2( 0.08,0.035 ) );
			float2 uv_TexCoord368 = i.uv_texcoord * temp_output_365_0 + ( float2( 0.5,0.5 ) + ( temp_output_365_0 / float2( -2,-2 ) ) );
			float2 temp_output_2_0_g152 = uv_TexCoord368;
			float2 temp_cast_32 = (0.0).xx;
			float2 temp_output_11_0_g152 = ( temp_output_2_0_g152 - temp_cast_32 );
			float dotResult12_g152 = dot( temp_output_11_0_g152 , temp_output_11_0_g152 );
			float2 temp_cast_33 = (0.0).xx;
			float2 appendResult392 = (float2(ase_viewVectorTS.x , ase_viewVectorTS.y));
			float smoothstepResult401 = smoothstep( 0.0 , 0.3 , ( 1.0 - distance( ( temp_output_2_0_g152 + ( temp_output_11_0_g152 * ( dotResult12_g152 * dotResult12_g152 * temp_cast_33 ) ) + ( float2( 1.15,-5 ) + ( appendResult392 * 14.0 ) ) ) , float2( 0.5,0.5 ) ) ));
			float2 temp_output_457_0 = ( float2( 1,1 ) / float2( 0.055,0.025 ) );
			float2 uv_TexCoord465 = i.uv_texcoord * temp_output_457_0 + ( float2( 0.5,0.5 ) + ( temp_output_457_0 / float2( -2,-2 ) ) );
			float2 temp_output_2_0_g153 = uv_TexCoord465;
			float2 temp_cast_34 = (0.0).xx;
			float2 temp_output_11_0_g153 = ( temp_output_2_0_g153 - temp_cast_34 );
			float dotResult12_g153 = dot( temp_output_11_0_g153 , temp_output_11_0_g153 );
			float2 temp_cast_35 = (0.0).xx;
			float2 appendResult460 = (float2(ase_viewVectorTS.x , ase_viewVectorTS.y));
			float smoothstepResult474 = smoothstep( 0.0 , 0.3 , ( 1.0 - distance( ( temp_output_2_0_g153 + ( temp_output_11_0_g153 * ( dotResult12_g153 * dotResult12_g153 * temp_cast_35 ) ) + ( float2( 1,-3 ) + ( appendResult460 * 7.0 ) ) ) , float2( 0.5,0.5 ) ) ));
			float Reflection_Highlight1703 = ( ( smoothstepResult401 * 1.5 ) + ( smoothstepResult474 * 0.8 ) );
			float mulTime2790 = _Time.y * _PulseSpeed;
			float ifLocalVar2806 = 0;
			if( 0.5 > (( _PulsingToggle )?( 1.0 ):( 0.0 )) )
				ifLocalVar2806 = ( _ColorIntensity + 1.0 );
			else if( 0.5 < (( _PulsingToggle )?( 1.0 ):( 0.0 )) )
				ifLocalVar2806 = ( ( _PulseRange.x + 1.0 ) + ( ( ( sin( mulTime2790 ) + 1.0 ) / 2.0 ) * ( _PulseRange.y + 1.0 ) ) );
			float3 clampResult2624 = clamp( ( ( clampResult2568 * ( ( ( ( ( ( saturate( lerpResult31_g176.x ) * 5.0 * _HighlightEmissionBoost ) + 1.0 ) * ( ( ( saturate( Lines_Emission_Boost2843 ) * 10.0 * _LinesEmissionBoost ) + 1.0 ) * ( pow( temp_output_2571_0 , temp_cast_30 ) * ( ( Unclamped_Flow2829 * 100.0 * _FlowEmissionBoost ) + 1.0 ) ) ) ) * ( ( saturate( lerpResult31_g178.x ) * 25.0 * _CenterColorEmissionBoost ) + 1.0 ) ) * ( ( _ElectricityEmissionBoost * 10.0 * saturate( Electricity1768 ) ) + 1.0 ) ) + ( Reflection_Highlight1703 * ( _ReflectionHighlightIntensity * 0.5 ) ) ) ) * ifLocalVar2806 ) , float3( 0,0,0 ) , float3( 9999,9999,9999 ) );
			o.Emission = clampResult2624;
			float temp_output_1557_0 = saturate( pow( ( 1.0 - saturate( pow( ( distance( i.uv_texcoord , float2( 0.5,0.5 ) ) * ( _Cutoff * 1.98 ) ) , 7.0 ) ) ) , ( _CutoffHardness * 2.0 ) ) );
			float3 temp_cast_36 = (temp_output_1557_0).xxx;
			float3 temp_output_12_0_g179 = ( ( ( temp_output_1910_0 + ( temp_output_1696_0 * 10.0 ) + Cloud_Noise_add2328 ) - Cloud_Noise_Sub2371 ) + temp_output_2601_0 + ( ( smoothstepResult2604 * temp_output_2318_0 ) * float3( 5,5,5 ) ) );
			float dotResult28_g179 = dot( float3(0.2126729,0.7151522,0.072175) , temp_output_12_0_g179 );
			float3 temp_cast_37 = (dotResult28_g179).xxx;
			float temp_output_21_0_g179 = 0.0;
			float3 lerpResult31_g179 = lerp( temp_cast_37 , temp_output_12_0_g179 , temp_output_21_0_g179);
			float3 lerpResult2279 = lerp( temp_cast_36 , ( saturate( ( saturate( lerpResult31_g179 ) + ( Generated_Pupil120 * 20.0 ) ) ) * temp_output_1557_0 ) , _ColorCutoffInfluence);
			o.Alpha = lerpResult2279.x;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "RoboEyeShaderInspector"
}
/*ASEBEGIN
Version=19801
Node;AmplifyShaderEditor.CommentaryNode;30;-37264,-10560;Inherit;False;1424.276;442.5572;;7;28;74;73;72;293;382;380;Parallax Logic;1,0.2877358,0.2877358,1;0;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;293;-37248,-10384;Inherit;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;31;-37280,-11232;Inherit;False;1307.106;520.6938;;6;6;64;66;67;69;70;Pupil Scale;0.4348735,1,0.3726415,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1457;-30848,-5488;Inherit;False;8452;11403;;217;1051;933;988;919;931;920;921;922;923;924;925;926;1066;1158;1187;1219;927;1253;1255;1256;1257;1258;929;930;939;1006;937;1005;1007;1008;946;947;955;1009;1254;1327;1331;1338;1335;1193;1164;1225;1094;914;957;1003;1011;1197;1168;1105;1229;1352;1354;1328;1332;1360;1434;1336;1357;1194;1165;1226;1095;1198;1169;1110;1230;952;1012;1365;1367;1371;1369;1188;1159;1114;1220;1013;951;1377;1378;1379;1380;1015;1014;998;1002;1192;1163;1156;1224;1387;1388;1389;1390;1189;1160;1118;1221;1060;1059;1249;1250;1391;1392;1393;1394;911;1044;1122;1123;1399;1400;1401;1402;1050;1124;1403;1404;1252;899;1405;1406;1251;1407;1433;895;1383;1384;1385;1386;1395;1396;1397;1398;1471;1472;1473;1474;1475;1476;1479;1480;1481;1482;1484;1485;1486;1487;1489;1517;1518;1519;1520;1521;1522;1523;1524;1525;1526;1527;1604;1606;1607;1608;1609;1613;1616;1617;1618;1619;1620;1621;1622;1623;1624;1625;1626;1627;1628;1629;1630;1631;1632;1633;1634;1635;1636;1637;1638;1639;1640;1641;1642;1643;1644;1645;1646;1647;1648;1649;1650;1651;1652;1653;1654;1655;1656;1657;1658;1659;1660;1661;1662;1663;1664;1665;Scrolling Noise Generator;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;2220;-30688,6800;Inherit;False;10804;4294;;19;1926;2101;2049;1915;1916;2043;1917;2044;1918;2045;1919;2046;1920;2219;2041;2042;2040;2048;1768;Electricity Generator;1,1,1,1;0;0
Node;AmplifyShaderEditor.BreakToComponentsNode;72;-36912,-10352;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.Vector2Node;6;-37248,-10992;Inherit;False;Property;_PupilSize;Pupil Size;0;0;Create;True;1;Eye Shape;0;0;False;0;False;0.3,0.34;0.3,0.3;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.CommentaryNode;848;-30864,-9248;Inherit;False;6612.858;3255.651;;14;643;708;751;798;686;1509;1510;1511;1512;1513;1514;1515;2457;2458;Line Generation;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;2101;-30368,8976;Inherit;False;7954;2116;Electricity Generator;116;2217;2216;2215;2214;2213;2212;2211;2210;2209;2208;2207;2206;2205;2204;2203;2202;2201;2200;2199;2198;2197;2196;2195;2194;2193;2192;2191;2190;2189;2188;2187;2186;2185;2184;2183;2182;2181;2180;2179;2178;2177;2176;2175;2174;2173;2172;2171;2170;2169;2168;2167;2166;2165;2164;2163;2162;2161;2160;2159;2158;2157;2156;2155;2154;2153;2152;2151;2150;2149;2148;2147;2146;2145;2144;2143;2142;2141;2140;2139;2138;2137;2136;2135;2134;2133;2132;2131;2130;2129;2128;2127;2126;2125;2124;2123;2122;2121;2120;2119;2118;2117;2116;2115;2114;2113;2112;2111;2110;2109;2108;2107;2106;2105;2104;2103;2102;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1926;-30368,6848;Inherit;False;7954;2116;Electricity Generator;117;1742;1775;1776;1797;1798;1773;1774;1779;1780;1777;1778;1745;1746;1756;1757;1781;1783;1748;1758;1760;1800;1785;1799;1766;1787;1796;1761;1751;1788;1789;1762;1752;1849;1818;1820;1897;1823;1790;1791;1753;1763;1850;1817;1844;1836;1792;1793;1754;1764;1805;1819;1824;1834;1803;1806;1807;1808;1794;1755;1825;1826;1827;1888;1890;1809;1811;1812;1810;1828;1829;1830;1833;1813;1814;1831;1832;1815;1839;1857;1853;1902;1876;1875;1854;1903;1906;1874;1856;1905;1901;1858;1877;1908;1909;1871;1880;1859;1878;1879;1873;1882;1883;2072;2073;2076;2079;2080;2082;2084;2085;2086;2089;2090;2096;2097;2099;2100;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;1623;-30688,3072;Inherit;False;Constant;_Float24;Float 23;23;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1051;-30800,-2768;Inherit;False;Constant;_Float23;Float 23;23;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;73;-36720,-10400;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;66;-37024,-10992;Inherit;False;2;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;686;-30800,-8128;Inherit;False;4944.945;1024.732;Line rendering;49;705;704;703;701;700;702;699;698;697;694;695;696;735;693;691;692;690;689;688;687;2396;2397;2398;2399;2400;2401;2402;2403;2404;2405;2406;2407;2408;2409;2410;2411;2412;2413;2414;2415;2416;2417;2418;2522;2523;2524;2733;2734;2737;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;751;-30816,-9200;Inherit;False;4961.181;1073.437;Line rendering;49;795;794;793;792;791;790;789;788;787;785;784;786;783;782;780;781;779;778;777;776;775;774;772;771;770;769;768;767;766;765;764;763;762;761;760;759;758;757;756;755;754;752;1148;2520;2521;2519;2729;2731;2738;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;798;-30784,-7088;Inherit;False;4936.829;1057.201;Line rendering;49;842;841;840;838;839;837;835;836;834;831;832;833;830;829;827;828;826;825;824;823;822;821;819;818;817;816;815;814;813;812;811;810;808;1146;2422;2423;2424;2425;2426;2427;2428;2429;2430;2525;2526;2527;2735;2736;2739;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;2049;-30640,8928;Inherit;False;Property;_ElectricitySpeed;Electricity Speed;31;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;2102;-30288,9840;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;1742;-30288,7712;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;933;-30512,-2448;Inherit;False;Constant;_NoiseRotationPoint1;Noise Rotation Point;13;0;Create;True;0;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;1624;-30400,3248;Inherit;False;Constant;_NoiseRotationPoint2;Noise Rotation Point;13;0;Create;True;0;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.FunctionNode;1625;-30480,2944;Inherit;True;Spherize;-1;;77;1488bb72d8899174ba0601b595d32b07;0;4;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;988;-30592,-2752;Inherit;True;Spherize;-1;;78;1488bb72d8899174ba0601b595d32b07;0;4;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;74;-36576,-10256;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;382;-36720,-10480;Inherit;False;Property;_ParallaxAmount;Parallax Amount;1;0;Create;True;0;0;0;False;0;False;-0.4;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;67;-36976,-10832;Inherit;False;2;0;FLOAT2;1,1;False;1;FLOAT2;-2,-2;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;2422;-30768,-6864;Inherit;False;Property;_PupilSize;Pupil Size;1;0;Fetch;True;1;Eye Shape;0;0;False;0;False;0.3,0.34;0.3,0.3;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;2396;-30784,-7888;Inherit;False;Property;_PupilSize;Pupil Size;1;0;Fetch;True;1;Eye Shape;0;0;False;0;False;0.3,0.34;0.3,0.3;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;752;-30704,-8992;Inherit;False;Property;_PupilSize;Pupil Size;1;0;Fetch;True;1;Eye Shape;0;0;False;0;False;0.3,0.34;0.3,0.3;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2103;-29792,10592;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2104;-29792,10688;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2105;-29936,10224;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2106;-29936,10320;Inherit;False;2;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2107;-29808,9552;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2108;-29808,9648;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1775;-29792,8464;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1776;-29792,8560;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1797;-29936,8096;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1798;-29936,8192;Inherit;False;2;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1773;-29808,7424;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1774;-29808,7520;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;919;-30224,-2496;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;931;-30480,-2864;Inherit;False;Constant;_NoiseRotationAmount1;Noise Rotation Amount;13;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1626;-30112,3200;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1627;-30368,2832;Inherit;False;Constant;_NoiseRotationAmount2;Noise Rotation Amount;13;0;Create;True;0;0;0;False;0;False;0.75;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;380;-36384,-10336;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;69;-36800,-10832;Inherit;False;2;2;0;FLOAT2;0.5,0.5;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;754;-30448,-9008;Inherit;False;2;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;2397;-30464,-7904;Inherit;False;2;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;2423;-30448,-6880;Inherit;False;2;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2109;-29600,10592;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2110;-29600,10688;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2111;-29760,10224;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2112;-29760,10320;Inherit;False;2;2;0;FLOAT;1;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2113;-29776,9184;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2114;-29776,9280;Inherit;False;2;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2115;-29616,9552;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2116;-29616,9648;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1779;-29600,8464;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1780;-29600,8560;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1777;-29760,8096;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1778;-29760,8192;Inherit;False;2;2;0;FLOAT;1;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1745;-29776,7056;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1746;-29776,7152;Inherit;False;2;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1756;-29616,7424;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1757;-29616,7520;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;920;-30080,-2512;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SinOpNode;921;-30000,-2800;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;922;-30000,-2880;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1628;-29968,3184;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SinOpNode;1629;-29888,2896;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;1630;-29888,2816;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;28;-36112,-10368;Inherit;True;Parallax Logic;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;70;-36656,-10960;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;38;-37264,-9936;Inherit;False;1315.376;478.2994;;7;249;32;39;37;36;34;35;Spherized Pupil Shape;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;2398;-30368,-7776;Inherit;False;2;0;FLOAT2;1,1;False;1;FLOAT2;-2,-2;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;755;-30336,-8880;Inherit;False;2;0;FLOAT2;1,1;False;1;FLOAT2;-2,-2;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;2424;-30384,-6752;Inherit;False;2;0;FLOAT2;1,1;False;1;FLOAT2;-2,-2;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2117;-29504,9936;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;2118;-29584,10240;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;2119;-29424,10624;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;2120;-29600,9200;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;2121;-29440,9584;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1760;-29504,7808;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;1781;-29584,8112;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1783;-29424,8496;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1748;-29600,7072;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1758;-29440,7456;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;923;-29728,-2608;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;924;-29728,-2512;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;925;-29728,-2880;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;926;-29728,-2784;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1631;-29616,3088;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1632;-29616,3184;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1633;-29616,2816;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1634;-29616,2912;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;64;-36240,-10912;Inherit;False;Pupil Scale Logic;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;35;-37216,-9760;Inherit;False;28;Parallax Logic;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1472;-26064,96;Inherit;False;Property;_FlowSpeed;Flow Speed;21;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1256;-30656,3664;Inherit;False;2091.949;820.5483;Scale & Rotation;18;1368;1355;1343;1334;1318;1316;1315;1298;1297;1296;1295;1280;1279;1278;1270;1269;1262;1261;;0.6556604,0.9420733,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1257;-30672,4784;Inherit;False;2091.949;820.5483;Scale & Rotation;18;1366;1362;1342;1330;1317;1314;1313;1294;1293;1292;1291;1277;1276;1275;1268;1267;1260;1259;;0.6556604,0.9420733,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1258;-30656,1312;Inherit;False;2091.949;820.5483;Scale & Rotation;18;1372;1361;1344;1341;1324;1323;1322;1306;1305;1304;1303;1286;1285;1284;1274;1273;1266;1265;;0.6556604,0.9420733,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1187;-30736,-912;Inherit;False;2091.949;820.5483;Scale & Rotation;18;1215;1214;1213;1212;1211;1210;1209;1208;1207;1206;1205;1204;1203;1202;1201;1200;1199;1216;;0.6556604,0.9420733,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1066;-30736,-5440;Inherit;False;2091.949;820.5483;Scale & Rotation;18;1068;1070;1077;1152;1111;1106;1097;1089;1088;1087;1086;1082;1081;1080;1076;1073;1072;1218;;0.6556604,0.9420733,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1158;-30720,-2032;Inherit;False;2091.949;820.5483;Scale & Rotation;18;1186;1185;1184;1183;1182;1181;1180;1179;1178;1177;1176;1175;1174;1173;1172;1171;1170;1217;;0.6556604,0.9420733,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1219;-30720,-4384;Inherit;False;2091.949;820.5483;Scale & Rotation;18;1248;1247;1246;1245;1244;1243;1242;1241;1240;1239;1238;1237;1236;1235;1234;1233;1232;1231;;0.6556604,0.9420733,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1255;-30672,256;Inherit;False;2091.949;820.5483;Scale & Rotation;18;1370;1358;1345;1337;1321;1320;1319;1302;1301;1300;1299;1283;1282;1281;1272;1271;1264;1263;;0.6556604,0.9420733,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2399;-30208,-7776;Inherit;False;2;2;0;FLOAT2;0.5,0.5;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;756;-30176,-8880;Inherit;False;2;2;0;FLOAT2;0.5,0.5;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2425;-30224,-6752;Inherit;False;2;2;0;FLOAT2;0.5,0.5;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2122;-29184,10624;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2123;-29136,10192;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2124;-29120,9552;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2125;-29168,9152;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;2126;-26816,9584;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1800;-29184,8496;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1785;-29136,8064;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1799;-29120,7424;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1766;-29168,7024;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;1818;-26816,7456;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;927;-29568,-2832;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1253;-29552,-2560;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1635;-29456,2864;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1636;-29440,3136;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;34;-37216,-9872;Inherit;False;64;Pupil Scale Logic;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.VertexToFragmentNode;249;-36960,-9728;Inherit;False;False;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1473;-25712,32;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1474;-25712,160;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2400;-30032,-7856;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;2401;-30032,-7936;Inherit;False;28;Parallax Logic;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;757;-30000,-8960;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;758;-30000,-9040;Inherit;False;28;Parallax Logic;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;2427;-30048,-6912;Inherit;False;28;Parallax Logic;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2426;-30048,-6832;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NoiseGeneratorNode;2127;-28800,10208;Inherit;True;Simple;True;False;2;0;FLOAT2;1,1;False;1;FLOAT;35;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;2128;-28800,10576;Inherit;True;Simple;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;35;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;2129;-28816,9536;Inherit;True;Simple;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;35;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;2130;-28816,9168;Inherit;True;Simple;True;False;2;0;FLOAT2;1,1;False;1;FLOAT;35;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2131;-27872,9792;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DistanceOpNode;2132;-26848,9248;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2133;-26768,9984;Inherit;False;Constant;_ElectricityNoiseRotation1;Electricity Noise Rotation;40;0;Create;True;0;0;0;False;0;False;20;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1849;-27872,7664;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DistanceOpNode;1817;-26848,7120;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1820;-26768,7856;Inherit;False;Constant;_ElectricityNoiseRotation;Electricity Noise Rotation;40;0;Create;True;0;0;0;False;0;False;20;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;1796;-28800,8080;Inherit;True;Simple;True;False;2;0;FLOAT2;1,1;False;1;FLOAT;45;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;1787;-28800,8448;Inherit;True;Simple;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;45;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;1761;-28816,7408;Inherit;True;Simple;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;45;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;1751;-28816,7024;Inherit;True;Simple;True;False;2;0;FLOAT2;1,1;False;1;FLOAT;45;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;1259;-30480,5312;Inherit;False;Constant;_NoiseRotationPoint7;Noise Rotation Point;13;0;Create;True;0;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;1260;-30496,5200;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;1261;-30464,4192;Inherit;False;Constant;_NoiseRotationPoint8;Noise Rotation Point;13;0;Create;True;0;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;1262;-30480,4080;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;1265;-30464,1840;Inherit;False;Constant;_NoiseRotationPoint10;Noise Rotation Point;13;0;Create;True;0;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;1266;-30480,1728;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;1199;-30544,-384;Inherit;False;Constant;_NoiseRotationPoint5;Noise Rotation Point;13;0;Create;True;0;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;1200;-30560,-496;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;1170;-30528,-1504;Inherit;False;Constant;_NoiseRotationPoint4;Noise Rotation Point;13;0;Create;True;0;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;1072;-30544,-4912;Inherit;False;Constant;_NoiseRotationPoint3;Noise Rotation Point;13;0;Create;True;0;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;1073;-30560,-5024;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;1231;-30528,-3856;Inherit;False;Constant;_NoiseRotationPoint6;Noise Rotation Point;13;0;Create;True;0;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;1232;-30544,-3968;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;1263;-30480,784;Inherit;False;Constant;_NoiseRotationPoint9;Noise Rotation Point;13;0;Create;True;0;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;1264;-30496,672;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;929;-29424,-2720;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1637;-29312,2976;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1171;-30544,-1616;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;100;-37264,-9280;Inherit;False;849.376;297.2994;;4;106;104;103;101;Non Spherized Pupil Shape;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-37072,-9600;Inherit;False;Property;_EyeRoundness;Eye Roundness;3;0;Fetch;True;0;0;0;False;0;False;50;50;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;36;-36688,-9776;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ToggleSwitchNode;1471;-25408,96;Inherit;False;Property;_ScrollingNoiseReverse;Scrolling Noise Reverse;25;0;Create;True;0;0;0;False;0;False;0;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2402;-29760,-7872;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;2403;-29840,-7728;Inherit;False;Property;_EyeRoundness;Eye Roundness;2;0;Fetch;True;0;0;0;False;0;False;50;50;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;759;-29728,-8976;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;760;-29808,-8832;Inherit;False;Property;_EyeRoundness;Eye Roundness;2;0;Fetch;True;0;0;0;False;0;False;50;50;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2428;-29776,-6848;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;2429;-29856,-6704;Inherit;False;Property;_EyeRoundness;Eye Roundness;2;0;Fetch;True;0;0;0;False;0;False;50;50;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;2134;-28528,10576;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;2135;-28528,10208;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;2136;-28544,9536;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;2137;-28544,9168;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2138;-26544,9632;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2139;-26928,10736;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2140;-26592,9152;Inherit;False;Constant;_Float26;Float 25;44;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2141;-26640,9264;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;2142;-26464,9968;Inherit;False;Constant;_ElectricityRotationCenter1;Electricity Rotation Center;40;0;Create;True;0;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PowerNode;1752;-28544,7040;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;1789;-28528,8080;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;1788;-28528,8448;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;1762;-28544,7408;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1850;-26544,7504;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1897;-26928,8608;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2073;-26592,7024;Inherit;False;Constant;_Float25;Float 25;44;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1819;-26640,7136;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;1823;-26464,7840;Inherit;False;Constant;_ElectricityRotationCenter;Electricity Rotation Center;40;0;Create;True;0;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;2737;-30032,-8016;Inherit;False;Property;_LineRotationSpeed;Line Rotation Speed;52;0;Fetch;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2739;-30048,-6992;Inherit;False;Property;_LineRotationSpeed;Line Rotation Speed;68;0;Fetch;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2738;-30000,-9120;Inherit;False;Property;_LineRotationSpeed;Line Rotation Speed;50;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1267;-30480,4848;Inherit;False;Constant;_NoiseRotationAmount7;Noise Rotation Amount;13;0;Create;True;0;0;0;False;0;False;2.35;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1268;-30144,5184;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1269;-30464,3728;Inherit;False;Constant;_NoiseRotationAmount8;Noise Rotation Amount;13;0;Create;True;0;0;0;False;0;False;2.35;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1270;-30128,4064;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1274;-30128,1712;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1273;-30464,1376;Inherit;False;Constant;_NoiseRotationAmount10;Noise Rotation Amount;13;0;Create;True;0;0;0;False;0;False;0.75;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1210;-30544,-848;Inherit;False;Constant;_NoiseRotationAmount5;Noise Rotation Amount;13;0;Create;True;0;0;0;False;0;False;1.55;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1211;-30208,-512;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1181;-30528,-1968;Inherit;False;Constant;_NoiseRotationAmount4;Noise Rotation Amount;13;0;Create;True;0;0;0;False;0;False;1.55;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1182;-30192,-1632;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1077;-30544,-5376;Inherit;False;Constant;_NoiseRotationAmount3;Noise Rotation Amount;13;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1242;-30528,-4320;Inherit;False;Constant;_NoiseRotationAmount6;Noise Rotation Amount;13;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1243;-30192,-3984;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1271;-30480,320;Inherit;False;Constant;_NoiseRotationAmount9;Noise Rotation Amount;13;0;Create;True;0;0;0;False;0;False;0.75;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1272;-30144,656;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;930;-29248,-2784;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1638;-29136,2912;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1076;-30208,-5040;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;103;-37200,-9104;Inherit;False;28;Parallax Logic;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;104;-37200,-9216;Inherit;False;64;Pupil Scale Logic;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;32;-36496,-9696;Inherit;True;Spherize;-1;;120;1488bb72d8899174ba0601b595d32b07;0;4;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1475;-25072,96;Inherit;False;Scrolling Noise Reverse Logic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;311;-37200,-4368;Inherit;False;5660.926;5707.727;;41;222;330;194;336;221;332;186;362;219;329;220;147;361;142;143;237;2289;2290;2291;2292;2293;2294;2295;2296;2299;2304;2303;2301;2321;2305;2323;2325;2326;2327;2328;2371;2374;2375;2608;2302;2300;Base Color;1,0,0.8790336,1;0;0
Node;AmplifyShaderEditor.Vector2Node;2404;-29536,-7552;Inherit;False;Constant;_RotationPoint3;Rotation Point;13;0;Create;True;0;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.FunctionNode;2405;-29568,-7872;Inherit;True;Spherize;-1;;121;1488bb72d8899174ba0601b595d32b07;0;4;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;808;-29488,-6544;Inherit;False;Constant;_RotationPoint2;Rotation Point;13;0;Create;True;0;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.FunctionNode;762;-29536,-8976;Inherit;True;Spherize;-1;;122;1488bb72d8899174ba0601b595d32b07;0;4;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;2430;-29584,-6848;Inherit;True;Spherize;-1;;123;1488bb72d8899174ba0601b595d32b07;0;4;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;761;-29504,-8656;Inherit;False;Constant;_RotationPoint1;Rotation Point;13;0;Create;True;0;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2143;-28336,10208;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;25;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2144;-28336,10576;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;25;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2145;-28352,9168;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;25;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2146;-28352,9536;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;25;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2147;-26624,10544;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;2148;-26624,10432;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;2149;-26432,9568;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2150;-26448,9248;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1844;-26624,8416;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;1836;-26624,8304;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1805;-26432,7440;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2076;-26448,7120;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1763;-28352,7408;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;20;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1753;-28352,7040;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;20;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1790;-28336,8080;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;20;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1791;-28336,8448;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;20;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;764;-29600,-9152;Inherit;False;Constant;_RotationAmount1;Rotation Amount;13;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;2729;-29584,-9072;Inherit;False;1;0;FLOAT;0.05;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2407;-29728,-8080;Inherit;False;Constant;_RotationAmount3;Rotation Amount;13;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;2733;-29712,-8000;Inherit;False;1;0;FLOAT;0.05;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;811;-29616,-7040;Inherit;False;Constant;_RotationAmount2;Rotation Amount;13;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;2735;-29584,-6960;Inherit;False;1;0;FLOAT;0.05;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;1275;-30000,4912;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;1276;-30000,4832;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1277;-30000,5168;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SinOpNode;1278;-29984,3792;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;1279;-29984,3712;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1280;-29984,4048;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SinOpNode;1284;-29984,1440;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;1285;-29984,1360;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1286;-29984,1696;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SinOpNode;1201;-30064,-784;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;1202;-30064,-864;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1212;-30064,-528;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SinOpNode;1172;-30048,-1904;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;1173;-30048,-1984;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1183;-30048,-1648;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SinOpNode;1233;-30048,-4256;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;1234;-30048,-4336;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1244;-30048,-4000;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SinOpNode;1281;-30000,384;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;1282;-30000,304;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1283;-30000,640;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DistanceOpNode;939;-28560,-3280;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,-0.6;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;1006;-28560,-2944;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;1.6,0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;937;-28560,-3168;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,1.6;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;1005;-28560,-3056;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;-0.6,0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;1639;-28448,2416;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,-0.6;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;1640;-28448,2752;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;1.6,0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;1641;-28448,2528;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,1.6;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;1642;-28448,2640;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;-0.6,0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;1081;-30064,-5312;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;1082;-30064,-5392;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1080;-30064,-5056;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;101;-36864,-9152;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;141;-37280,-8624;Inherit;False;4479.552;3599.069;;29;120;337;135;134;140;132;356;284;129;128;281;127;283;112;125;123;55;111;98;110;107;45;109;2763;108;258;43;99;97;Pupil Generation;0,0,0,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;39;-36176,-9632;Inherit;False;Spherized Pupil;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;2406;-29280,-7648;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;810;-29232,-6640;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;763;-29248,-8752;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;2151;-28160,10208;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2152;-28160,10576;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2153;-28176,9168;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2154;-28176,9536;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;2155;-26336,10752;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2156;-26432,10480;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;2157;-26288,9296;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;2158;-26288,9216;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;2159;-26288,9552;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SaturateNode;1754;-28176,7040;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1764;-28176,7408;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1792;-28160,8080;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1793;-28160,8448;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1824;-26336,8624;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1834;-26432,8352;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;1806;-26288,7168;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;1807;-26288,7088;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1808;-26288,7424;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;2731;-29360,-9120;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2734;-29472,-8016;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2736;-29392,-7008;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;237;-37056,-3200;Inherit;False;Property;_EyeRoundness;Eye Roundness;3;0;Create;True;0;0;0;False;0;False;50;50;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;143;-37088,-3328;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1291;-29728,5104;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1292;-29728,5200;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1293;-29728,4832;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1294;-29728,4928;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1295;-29712,3984;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1296;-29712,4080;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1297;-29712,3712;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1298;-29712,3808;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1303;-29712,1632;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1304;-29712,1728;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1305;-29712,1360;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1306;-29712,1456;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1203;-29792,-592;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1204;-29792,-496;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1205;-29792,-864;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1206;-29792,-768;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1174;-29776,-1712;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1175;-29776,-1616;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1176;-29776,-1984;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1177;-29776,-1888;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1235;-29776,-4064;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1236;-29776,-3968;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1237;-29776,-4336;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1238;-29776,-4240;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1299;-29728,576;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1300;-29728,672;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1301;-29728,304;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1302;-29728,400;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1487;-29824,4624;Inherit;False;1475;Scrolling Noise Reverse Logic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1484;-29728,1216;Inherit;False;1475;Scrolling Noise Reverse Logic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1476;-29968,-4480;Inherit;False;1475;Scrolling Noise Reverse Logic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;946;-28288,-3168;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.8;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;947;-28288,-3280;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.8;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1643;-28176,2528;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.8;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1644;-28176,2416;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.8;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1645;-28176,2640;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.8;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1646;-28176,2752;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.8;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1008;-28288,-3056;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.8;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1007;-28288,-2944;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.8;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1086;-29792,-5120;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1087;-29792,-5024;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1088;-29792,-5392;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1089;-29792,-5296;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;106;-36688,-9200;Inherit;True;Non Spherized Pupil;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;97;-37200,-7952;Inherit;False;39;Spherized Pupil;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;2408;-29136,-7664;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;812;-29088,-6656;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;765;-29104,-8768;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SinOpNode;2409;-29232,-7952;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;2410;-29232,-8032;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;813;-29136,-6944;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;814;-29136,-7024;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;766;-29200,-9072;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;767;-29200,-9152;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2160;-27952,10368;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2161;-27968,9328;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;2162;-26192,10480;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;2163;-26192,10400;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;2164;-26192,10736;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2165;-26016,9488;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2166;-26016,9216;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2167;-26016,9312;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2168;-26016,9584;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2169;-28080,9920;Inherit;False;Constant;_ElectricityDistortionScale1;Electricity Distortion Scale;40;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1794;-27952,8240;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1755;-27968,7200;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1803;-28096,7792;Inherit;False;Constant;_ElectricityDistortionScale;Electricity Distortion Scale;40;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;1825;-26192,8352;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;1826;-26192,8272;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1827;-26192,8608;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1809;-26016,7360;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1811;-26016,7088;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1812;-26016,7184;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1810;-26016,7456;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;142;-36736,-3328;Inherit;True;Spherize;-1;;124;1488bb72d8899174ba0601b595d32b07;0;4;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1313;-29568,4880;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1314;-29552,5152;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1315;-29552,3760;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1316;-29536,4032;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1322;-29552,1408;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1323;-29536,1680;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1207;-29632,-816;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1209;-29616,-544;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1178;-29616,-1936;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1180;-29600,-1664;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1239;-29616,-4288;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1241;-29600,-4016;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1319;-29568,352;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1320;-29552,624;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1481;-29616,-1056;Inherit;False;1475;Scrolling Noise Reverse Logic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1486;-29440,2288;Inherit;False;1475;Scrolling Noise Reverse Logic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1482;-29616,64;Inherit;False;1475;Scrolling Noise Reverse Logic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1604;-29504,4640;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.03;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1607;-29344,1216;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.03;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1609;-29520,-4480;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.01;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1254;-28880,-2688;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.LerpOp;955;-28096,-3216;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1647;-28768,3008;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.LerpOp;1648;-27984,2480;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1649;-27984,2704;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1009;-28096,-2992;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1097;-29632,-5344;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1152;-29616,-5072;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;1324;-29792,1888;Inherit;False;Property;_FlowNoiseScale;Flow Noise Scale;22;1;[Header];Fetch;True;1;Flow;0;0;False;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;1321;-29808,832;Inherit;False;Property;_FlowNoiseScale;Flow Noise Scale;22;1;[Header];Fetch;True;1;Flow;0;0;False;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;1213;-29904,-336;Inherit;False;Property;_FlowNoiseScale;Flow Noise Scale;22;1;[Header];Fetch;True;1;Flow;0;0;False;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;1184;-29888,-1440;Inherit;False;Property;_FlowNoiseScale;Flow Noise Scale;22;1;[Header];Fetch;True;1;Flow;0;0;False;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;1247;-29856,-3808;Inherit;False;Property;_FlowNoiseScale;Flow Noise Scale;22;1;[Header];Fetch;True;1;Flow;0;0;False;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;1068;-29872,-4864;Inherit;False;Property;_FlowNoiseScale;Flow Noise Scale;14;1;[Header];Create;True;1;Flow;0;0;False;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;1318;-29824,4256;Inherit;False;Property;_FlowNoiseScale;Flow Noise Scale;19;1;[Header];Fetch;True;1;Flow;0;0;False;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;1317;-29840,5360;Inherit;False;Property;_FlowNoiseScale;Flow Noise Scale;24;1;[Header];Fetch;True;1;Flow;0;0;False;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;99;-37200,-8128;Inherit;False;106;Non Spherized Pupil;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DistanceOpNode;43;-36688,-7952;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;361;-35872,-3056;Inherit;False;4228.588;2207.233;;15;301;358;1598;1600;299;1700;1601;272;1603;1599;315;195;196;185;2456;Lower Eye Highlight;1,0.9384696,0.7877358,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2411;-28960,-8016;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2412;-28960,-7920;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2413;-28960,-7760;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2414;-28960,-7664;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;815;-28864,-7008;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;816;-28864,-6912;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;817;-28864,-6752;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;818;-28864,-6656;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;768;-28960,-9120;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;769;-28960,-9024;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;770;-28960,-8864;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;771;-28960,-8768;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2170;-27696,9520;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2171;-27632,10256;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2172;-25920,10672;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2173;-25920,10400;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2174;-25920,10496;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2175;-25920,10768;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2176;-25856,9264;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;2177;-25840,9536;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1888;-27696,7392;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1890;-27632,8128;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1828;-25920,8544;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1829;-25920,8272;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1830;-25920,8368;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1833;-25920,8640;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1813;-25856,7136;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1814;-25840,7408;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;147;-36416,-3328;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.Vector2Node;2595;-16656,2800;Inherit;False;Property;_FlowScale;Flow Scale;2;0;Create;True;1;Eye Shape;0;0;False;0;False;1,1;0.3,0.3;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.DynamicAppendNode;1330;-29424,4992;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1334;-29408,3872;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1341;-29408,1520;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1344;-29488,1856;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1208;-29488,-704;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1216;-29584,-352;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1179;-29472,-1824;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1240;-29472,-4176;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1337;-29424,464;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1479;-29248,-4480;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1480;-29520,-3392;Inherit;False;1475;Scrolling Noise Reverse Logic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1217;-29600,-1472;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1248;-29552,-3840;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1521;-29200,-1024;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1345;-29504,800;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1343;-29536,4224;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1342;-29520,5344;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;1489;-29696,5760;Inherit;False;1475;Scrolling Noise Reverse Logic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1527;-29328,4640;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1606;-29104,2304;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.01;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;1327;-29600,5696;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;1331;-29728,4560;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;1338;-29344,2224;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;1193;-29520,0;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;1164;-29520,-1120;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;1225;-29424,-3456;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1485;-29152,1216;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;1335;-29648,1152;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1608;-29232,96;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.03;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;1094;-29872,-4544;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;957;-27920,-3216;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1011;-27920,-2992;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1618;-28576,-2576;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1619;-28592,-2128;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1650;-27808,2480;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1651;-27808,2704;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1652;-28464,3120;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1653;-28480,3568;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1218;-29568,-4896;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1106;-29488,-5232;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.VertexToFragmentNode;258;-36960,-8288;Inherit;False;False;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;108;-36464,-8208;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0.28;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2763;-36944,-8352;Inherit;False;Constant;_Float39;Float 39;72;0;Create;True;0;0;0;False;0;False;0.8;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;329;-37152,-4192;Inherit;False;2351;317;Center Color;12;327;323;325;322;326;321;319;318;317;316;334;411;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;185;-35824,-2496;Inherit;False;2629.065;1092.505;Highlight Pattern;22;172;175;174;173;178;180;166;168;176;171;167;170;184;182;183;181;169;163;165;164;162;161;;0.6745283,0.9035024,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2415;-28800,-7968;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;2416;-28800,-7696;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;819;-28704,-6960;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1146;-28688,-6688;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;772;-28800,-9072;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1148;-28800,-8800;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2178;-27552,9872;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2179;-25760,10448;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;2180;-25744,10720;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;2181;-25632,9376;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;2085;-27440,7744;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1831;-25760,8320;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1832;-25744,8592;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1815;-25632,7248;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;2523;-29072,-7520;Inherit;False;Property;_PupilSize;Pupil Size;1;0;Fetch;True;1;Eye Shape;0;0;False;0;False;0.3,0.34;0.3,0.3;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;2526;-29040,-6512;Inherit;False;Property;_PupilSize;Pupil Size;1;0;Fetch;True;1;Eye Shape;0;0;False;0;False;0.3,0.34;0.3,0.3;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;2520;-29120,-8624;Inherit;False;Property;_PupilSize;Pupil Size;1;0;Fetch;True;1;Eye Shape;0;0;False;0;False;0.3,0.34;0.3,0.3;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.WireNode;220;-35968,-2512;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2600;-16432,2800;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1.5,1.2;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1352;-28928,5728;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1354;-28912,4608;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1355;-29280,4144;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1362;-29296,5264;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1328;-29664,5632;Inherit;False;Constant;_NoiseScrollingspeedX6;Noise Scrolling speed X;22;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1332;-29792,4496;Inherit;False;Constant;_NoiseScrollingspeedX7;Noise Scrolling speed X;22;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1361;-29280,1792;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1360;-28912,2256;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1434;-29408,2160;Inherit;False;Constant;_NoiseScrollingspeedY;Noise Scrolling speed Y;29;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1197;-28992,32;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1214;-29360,-432;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1194;-29584,-64;Inherit;False;Constant;_NoiseScrollingspeedX4;Noise Scrolling speed X;22;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1168;-28976,-1088;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1185;-29344,-1552;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1105;-28992,-4496;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1229;-28976,-3440;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1245;-29344,-3904;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1358;-29296,736;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1357;-28960,1168;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1165;-29584,-1184;Inherit;False;Constant;_NoiseScrollingspeedX3;Noise Scrolling speed X;22;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1226;-29488,-3520;Inherit;False;Constant;_NoiseScrollingspeedX5;Noise Scrolling speed X;22;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1336;-29712,1088;Inherit;False;Constant;_NoiseScrollingspeedX8;Noise Scrolling speed X;22;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1095;-29936,-4608;Inherit;False;Constant;_NoiseScrollingspeedX2;Noise Scrolling speed X;22;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1012;-27728,-2992;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;6.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;952;-27728,-3216;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;6.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1003;-28400,-2800;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1616;-28400,-2576;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;914;-28400,-2352;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1621;-28400,-2128;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1655;-27616,2480;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;6.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1656;-28288,2896;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1657;-28288,3120;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1658;-28288,3344;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1659;-28288,3568;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1654;-27600,2704;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;6.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1070;-29360,-4960;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;109;-36112,-8320;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;-36320,-7952;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.VoronoiNode;107;-36688,-8496;Inherit;True;0;0;1;0;1;False;1;False;True;False;4;0;FLOAT2;0,0;False;1;FLOAT;100;False;2;FLOAT;18;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.DynamicAppendNode;2417;-28672,-7808;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;774;-28688,-8912;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;316;-37120,-4144;Inherit;False;39;Spherized Pupil;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;2182;-25536,10560;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2183;-25328,9376;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2184;-27296,9872;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2086;-27184,7744;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1839;-25536,8432;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2072;-25344,7264;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2524;-28848,-7536;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0.4,0.7;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2527;-28752,-6528;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0.4,0.7;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2521;-28880,-8624;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0.4,0.7;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;821;-28560,-6816;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;172;-35008,-2416;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;2596;-16240,2784;Inherit;False;2;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1365;-28720,5664;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1366;-28800,4992;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1367;-28704,4544;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1368;-28784,3872;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1371;-28704,2192;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1372;-28784,1520;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1198;-28784,-32;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1215;-28864,-704;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1169;-28768,-1152;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1186;-28848,-1824;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1110;-28784,-4560;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1111;-28864,-5232;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1230;-28768,-3504;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1246;-28848,-4176;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1370;-28800,464;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1369;-28752,1104;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SmoothstepOpNode;1613;-28160,-2800;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;3.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;1617;-28160,-2576;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;3.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;1620;-28160,-2352;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;3.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;1622;-28160,-2128;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;3.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;1662;-28048,2896;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;3.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;1663;-28048,3120;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;3.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;1664;-28048,3344;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;3.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;1665;-28048,3568;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;3.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;951;-27552,-3216;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;1013;-27552,-2992;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;1660;-27408,2480;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;1661;-27408,2704;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;110;-35792,-8480;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;98;-35904,-7952;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;8;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2519;-28416,-8816;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DistanceOpNode;317;-36880,-4144;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2185;-25072,9536;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2186;-25280,10480;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;2187;-27040,9872;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;0.4;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2079;-25072,7408;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2082;-25280,8352;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;2096;-26928,7744;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;0.6;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2304;-36144,-688;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2522;-28320,-7728;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2525;-28336,-6736;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.NegateNode;173;-34768,-2416;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;161;-35728,-1744;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;163;-35728,-1808;Inherit;False;Constant;_HSSpeed;HSSpeed;3;0;Create;True;0;0;0;False;0;False;-0.01;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;2597;-16176,2912;Inherit;False;2;0;FLOAT2;1,1;False;1;FLOAT2;-2,-2;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1377;-28400,5248;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1378;-28384,4128;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1380;-28384,1776;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1188;-28464,-448;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1159;-28448,-1568;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1114;-28464,-4976;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1220;-28448,-3920;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1379;-28400,720;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1383;-26768,3472;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1384;-26768,3264;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1385;-26768,2848;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1386;-26768,3056;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1015;-26832,-2032;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1014;-26832,-2240;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;998;-26832,-2656;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1002;-26832,-2448;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;1519;-28416,0;Inherit;True;Property;_BackgroundNoise;Background Noise;26;0;Create;True;0;0;0;False;0;False;d5035bd82086119409755369ed12846d;d5035bd82086119409755369ed12846d;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.ClampOpNode;111;-35520,-8368;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;55;-35664,-7952;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;123;-36432,-7632;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0.0005;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;196;-35824,-1392;Inherit;False;2613.816;520.6842;Highlight Pattern;12;209;207;210;206;205;204;203;202;218;217;216;215;;0.6745283,0.9035024,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2418;-28304,-7936;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;822;-28256,-6928;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;775;-28272,-9040;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;318;-36640,-4144;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0.005;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2188;-25056,10192;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2189;-24976,9824;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2084;-25056,8064;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2080;-24976,7696;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;2289;-35792,0;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2290;-35792,-64;Inherit;False;Constant;_HSSpeed1;HSSpeed;3;0;Create;True;0;0;0;False;0;False;-0.02;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;2299;-35632,-512;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;174;-34560,-2416;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;219;-36096,-1376;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;162;-35456,-1792;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;165;-35456,-1856;Inherit;False;Constant;_Float1;Float 1;3;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2598;-16016,2912;Inherit;False;2;2;0;FLOAT2;0.5,0.5;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1518;-27824,-3808;Inherit;True;Property;_EyeNoiseBackground1;Eye Noise Background;34;0;Create;True;0;0;0;False;0;False;-1;d5035bd82086119409755369ed12846d;d5035bd82086119409755369ed12846d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode;1520;-27808,-1488;Inherit;True;Property;_EyeNoiseBackground2;Eye Noise Background;34;0;Create;True;0;0;0;False;0;False;-1;d5035bd82086119409755369ed12846d;d5035bd82086119409755369ed12846d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode;1522;-27824,-304;Inherit;True;Property;_EyeNoiseBackground3;Eye Noise Background;34;0;Create;True;0;0;0;False;0;False;-1;d5035bd82086119409755369ed12846d;d5035bd82086119409755369ed12846d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode;1523;-27760,768;Inherit;True;Property;_EyeNoiseBackground4;Eye Noise Background;34;0;Create;True;0;0;0;False;0;False;-1;d5035bd82086119409755369ed12846d;d5035bd82086119409755369ed12846d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode;1524;-27712,1872;Inherit;True;Property;_EyeNoiseBackground5;Eye Noise Background;34;0;Create;True;0;0;0;False;0;False;-1;d5035bd82086119409755369ed12846d;d5035bd82086119409755369ed12846d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode;1525;-27744,4256;Inherit;True;Property;_EyeNoiseBackground6;Eye Noise Background;34;0;Create;True;0;0;0;False;0;False;-1;d5035bd82086119409755369ed12846d;d5035bd82086119409755369ed12846d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode;1526;-27760,5312;Inherit;True;Property;_EyeNoiseBackground7;Eye Noise Background;34;0;Create;True;0;0;0;False;0;False;-1;d5035bd82086119409755369ed12846d;d5035bd82086119409755369ed12846d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SaturateNode;1395;-26528,3488;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1396;-26528,3280;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1397;-26496,3024;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1398;-26496,2816;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1060;-26592,-2016;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1059;-26592,-2224;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1249;-26560,-2480;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1250;-26560,-2688;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1517;-27824,-4912;Inherit;True;Property;_EyeNoiseBackground;Eye Noise Background;34;0;Create;True;0;0;0;False;0;False;-1;d5035bd82086119409755369ed12846d;d5035bd82086119409755369ed12846d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.OneMinusNode;125;-35968,-7600;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;112;-35488,-8000;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;195;-34976,-2992;Inherit;False;1766.122;492.3313;Gradient Highlight;12;302;188;189;191;187;154;304;152;151;150;2297;2298;;0.6556604,0.6689438,1,1;0;0
Node;AmplifyShaderEditor.FunctionNode;687;-28080,-8080;Inherit;True;Polar Coordinates;-1;;125;7dab8e02884cf104ebefaa2e788e4162;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;3;FLOAT;1;False;4;FLOAT;1;False;3;FLOAT2;0;FLOAT;55;FLOAT;56
Node;AmplifyShaderEditor.FunctionNode;776;-28096,-9152;Inherit;True;Polar Coordinates;-1;;126;7dab8e02884cf104ebefaa2e788e4162;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;3;FLOAT;1;False;4;FLOAT;1;False;3;FLOAT2;0;FLOAT;55;FLOAT;56
Node;AmplifyShaderEditor.FunctionNode;823;-28080,-7040;Inherit;True;Polar Coordinates;-1;;127;7dab8e02884cf104ebefaa2e788e4162;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;3;FLOAT;1;False;4;FLOAT;1;False;3;FLOAT2;0;FLOAT;55;FLOAT;56
Node;AmplifyShaderEditor.SaturateNode;411;-36416,-4144;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2191;-24768,10176;Inherit;True;Polar Coordinates;-1;;128;7dab8e02884cf104ebefaa2e788e4162;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;3;FLOAT;1;False;4;FLOAT;1;False;3;FLOAT2;0;FLOAT;55;FLOAT;56
Node;AmplifyShaderEditor.FunctionNode;2192;-24704,9744;Inherit;True;Polar Coordinates;-1;;129;7dab8e02884cf104ebefaa2e788e4162;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;3;FLOAT;1;False;4;FLOAT;1;False;3;FLOAT2;0;FLOAT;55;FLOAT;56
Node;AmplifyShaderEditor.RangedFloatNode;2190;-24736,10064;Inherit;False;Constant;_ElectricityAmount1;Electricity Amount;40;0;Create;True;0;0;0;False;0;False;6;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1857;-24736,7936;Inherit;False;Constant;_ElectricityAmount;Electricity Amount;40;0;Create;True;0;0;0;False;0;False;15;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1853;-24768,8048;Inherit;True;Polar Coordinates;-1;;130;7dab8e02884cf104ebefaa2e788e4162;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;3;FLOAT;1;False;4;FLOAT;1;False;3;FLOAT2;0;FLOAT;55;FLOAT;56
Node;AmplifyShaderEditor.FunctionNode;1876;-24704,7616;Inherit;True;Polar Coordinates;-1;;131;7dab8e02884cf104ebefaa2e788e4162;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;3;FLOAT;1;False;4;FLOAT;1;False;3;FLOAT2;0;FLOAT;55;FLOAT;56
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2291;-35520,-48;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2292;-35520,-112;Inherit;False;Constant;_Float31;Float 1;3;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;2300;-35392,-512;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;175;-34288,-2416;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;50;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;362;-35968,-2816;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;164;-35248,-1824;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;218;-35728,-1264;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.8;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2599;-15824,2832;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;911;-26304,-1568;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1044;-26304,-1184;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1399;-26240,4128;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1400;-26240,4512;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1401;-26032,1648;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1402;-26032,2032;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1122;-26080,-4224;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1123;-26080,-3840;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;283;-35312,-8016;Inherit;True;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;127;-35760,-7600;Inherit;False;True;2;0;FLOAT;0;False;1;FLOAT;350;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;632;-36864,2944;Inherit;False;5556;8096;;23;575;404;453;477;500;525;552;608;606;476;475;548;574;630;499;522;597;452;549;550;405;1703;1704;Styalised Reflections;1,1,1,1;0;0
Node;AmplifyShaderEditor.BreakToComponentsNode;688;-27776,-8080;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;777;-27792,-9152;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;824;-27776,-7040;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.PowerNode;319;-36240,-4144;Inherit;True;True;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2193;-27936,10704;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2194;-24416,9792;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;20;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2195;-24432,10208;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;20;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1875;-24416,7664;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;20;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1854;-24432,8080;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;20;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1902;-27936,8576;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;2293;-35312,-80;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SmoothstepOpNode;2301;-35184,-512;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;16;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;180;-34048,-2192;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;150;-34960,-2736;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;166;-35008,-1872;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;0.8,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NegateNode;215;-35488,-1264;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;168;-35168,-1680;Inherit;True;Property;_HighlightNoise;Highlight Noise;48;0;Create;True;0;0;0;False;0;False;9933c1731f83c4047b096969ec99f7ef;9933c1731f83c4047b096969ec99f7ef;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.DistanceOpNode;1673;-15472,2832;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1050;-25984,-1328;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1403;-25920,4368;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1404;-25712,1888;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1124;-25760,-3984;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;281;-35072,-8000;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;25;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;128;-35472,-7616;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;800;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;575;-36816,10016;Inherit;False;2521.178;990.2557;Reflection random Highlight Generation;11;592;591;589;588;577;576;601;603;600;604;607;;0.7959278,0.6462264,1,1;0;0
Node;AmplifyShaderEditor.DistanceOpNode;689;-28032,-7488;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;690;-27632,-8064;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;40;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;779;-27648,-9136;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;70;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;825;-28032,-6448;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;826;-27632,-7024;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;50;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;778;-28048,-8560;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;321;-36016,-4144;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;2196;-26976,11008;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2197;-27968,9024;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;2198;-24240,9792;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;2199;-24256,10208;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1915;-22320,8976;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SinOpNode;1874;-24240,7664;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;1856;-24256,8080;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1903;-26976,8880;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1906;-27968,6896;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2295;-35072,-128;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;0.8,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2302;-34912,-512;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;50;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;2294;-35200,144;Inherit;True;Property;_BackgroundNoise;Background Noise;4;0;Fetch;True;0;0;0;False;0;False;d5035bd82086119409755369ed12846d;9933c1731f83c4047b096969ec99f7ef;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RangedFloatNode;170;-34528,-1984;Inherit;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;0;False;0;False;0.4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;171;-34528,-2048;Inherit;False;Constant;_Float2;Float 2;4;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;178;-34352,-2176;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;151;-34816,-2736;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;167;-34704,-1712;Inherit;True;Property;_TextureSample0;Texture Sample 0;3;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SmoothstepOpNode;216;-35280,-1264;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1674;-15280,2832;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;1.98;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1252;-25504,-3760;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;8;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;899;-25552,-1536;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;8;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1405;-25456,2112;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;8;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1406;-25488,4160;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;8;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;129;-35200,-7616;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2000;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;284;-34864,-8000;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;800;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;552;-36816,8000;Inherit;False;2521.178;990.2557;Reflection random Highlight Generation;6;569;568;566;565;554;553;;0.7959278,0.6462264,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;608;-36816,9008;Inherit;False;2521.178;990.2557;Reflection random Highlight Generation;6;625;624;622;621;610;609;;0.7959278,0.6462264,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;477;-36816,4992;Inherit;False;2521.178;990.2557;Reflection Highlight Generation;6;494;492;491;480;479;478;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;500;-36816,6000;Inherit;False;2521.178;990.2557;Reflection Highlight Generation;6;517;516;514;513;502;501;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;576;-36768,10064;Inherit;False;1064;347;Reflection Highlight Scale;5;587;584;581;579;578;;0.261256,1,0.1745283,1;0;0
Node;AmplifyShaderEditor.SinOpNode;692;-27408,-8064;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;781;-27424,-9136;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;828;-27408,-7024;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;780;-27776,-8464;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0.001;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;691;-27760,-7392;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0.0002;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;827;-27760,-6352;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0.0002;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;326;-35792,-4064;Inherit;False;Property;_CenterColor;Center Color;15;0;Create;True;0;0;0;False;0;False;0.9859011,0.4009434,1,0;0,0,0,0;True;False;0;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.OneMinusNode;334;-35856,-4144;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2100;-24688,8928;Inherit;False;Property;_ElectricityThickness;Electricity Thickness;32;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2200;-24112,10816;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2201;-24128,9152;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2202;-24064,10208;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2203;-24064,9824;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1858;-24064,8080;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1877;-24064,7696;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1901;-24112,8688;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;1916;-22000,8976;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2296;-34768,32;Inherit;True;Property;_TextureSample1;Texture Sample 0;3;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SmoothstepOpNode;2321;-34640,-480;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;8;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1905;-24128,7024;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;169;-34288,-1872;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SmoothstepOpNode;176;-34256,-2096;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;207;-34480,-1024;Inherit;False;Constant;_Float6;Float 0;4;0;Create;True;0;0;0;False;0;False;0.4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;209;-34480,-1088;Inherit;False;Constant;_Float7;Float 2;4;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;152;-34624,-2736;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;6;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;217;-35008,-1264;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;50;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1675;-15056,2832;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1251;-25088,-2832;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1407;-25024,2864;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;356;-34640,-7792;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;100;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;553;-36768,8048;Inherit;False;1064;347;Reflection Highlight Scale;5;564;561;558;556;555;;0.261256,1,0.1745283,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;577;-36656,10464;Inherit;False;893.1289;473;Eye Highlight offset;6;590;586;585;583;582;580;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;609;-36768,9056;Inherit;False;1064;347;Reflection Highlight Scale;5;620;617;614;612;611;;0.261256,1,0.1745283,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;478;-36768,5040;Inherit;False;1064;347;Reflection Highlight Scale;5;490;487;484;482;481;;0.261256,1,0.1745283,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;501;-36768,6048;Inherit;False;1064;347;Reflection Highlight Scale;5;512;509;506;504;503;;0.261256,1,0.1745283,1;0;0
Node;AmplifyShaderEditor.Vector2Node;578;-36720,10144;Inherit;False;Constant;_ReflectionHighlightSize6;Reflection Highlight Size;2;0;Create;True;0;0;0;False;0;False;0.35,0.225;0.3,0.3;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SaturateNode;693;-27552,-7392;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;735;-27216,-8064;Inherit;False;True;2;0;FLOAT;0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;782;-27568,-8464;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;829;-27552,-6352;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;783;-27232,-9136;Inherit;False;True;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;830;-27200,-7024;Inherit;False;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;322;-35504,-4144;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;325;-35504,-4032;Inherit;False;Property;_CenterColorIntensity;Center Color Intensity;16;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2204;-23872,10816;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2205;-23888,9152;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2209;-23968,10352;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2208;-23984,9920;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;2206;-23904,9760;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;2207;-23888,10208;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2043;-21808,9088;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;3.4;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2090;-24032,7792;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;12;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2089;-24080,8320;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;12;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1908;-23872,8688;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1909;-23888,7024;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;2097;-23904,7632;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;2099;-23888,8080;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1917;-21808,8848;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;1.8;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2303;-34352,-224;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;181;-34016,-1904;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;183;-33968,-1984;Inherit;False;Constant;_Float3;Float 3;4;0;Create;True;0;0;0;False;0;False;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;202;-34240,-1072;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SmoothstepOpNode;210;-34208,-1296;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;304;-34400,-2720;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;1676;-14896,2832;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1433;-23824,-80;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;132;-34384,-7872;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;25;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;554;-36656,8448;Inherit;False;893.1289;473;Eye Highlight offset;6;567;563;562;560;559;557;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;610;-36656,9456;Inherit;False;893.1289;473;Eye Highlight offset;6;623;619;618;616;615;613;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;479;-36656,5440;Inherit;False;893.1289;473;Eye Highlight offset;6;493;489;488;486;485;483;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;502;-36656,6448;Inherit;False;893.1289;473;Eye Highlight offset;6;515;511;510;508;507;505;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;579;-36320,10128;Inherit;False;2;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ViewVectorNode;580;-36592,10672;Inherit;False;Tangent;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector2Node;555;-36720,8128;Inherit;False;Constant;_ReflectionHighlightSize5;Reflection Highlight Size;2;0;Create;True;0;0;0;False;0;False;0.35,0.225;0.3,0.3;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;611;-36720,9136;Inherit;False;Constant;_ReflectionHighlightSize7;Reflection Highlight Size;2;0;Create;True;0;0;0;False;0;False;0.35,0.225;0.3,0.3;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;481;-36720,5120;Inherit;False;Constant;_ReflectionHighlightSize2;Reflection Highlight Size;2;0;Create;True;0;0;0;False;0;False;0.35,0.225;0.3,0.3;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;503;-36720,6128;Inherit;False;Constant;_ReflectionHighlightSize3;Reflection Highlight Size;2;0;Create;True;0;0;0;False;0;False;0.45,0.3;0.3,0.3;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PowerNode;696;-27376,-7392;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;0.05;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;695;-27056,-8064;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;25;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;694;-27760,-7616;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0.08;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;786;-27072,-9136;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;25;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;784;-27392,-8464;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;0.05;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;833;-27024,-7024;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;25;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;785;-27776,-8688;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0.08;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;832;-27760,-6576;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0.01;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;831;-27376,-6352;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;0.001;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;323;-35280,-4144;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PowerNode;2210;-23664,10816;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;2211;-23712,9152;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;2212;-23712,9792;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;50;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;2213;-23712,10208;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;50;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2044;-21568,9088;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;1878;-23712,7664;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;50;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;1859;-23712,8080;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;50;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1918;-21584,8736;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;1871;-23664,8688;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;1880;-23712,7024;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2305;-34032,-224;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2325;-34048,0;Inherit;False;Property;_CloudNoiseVisibillity;Cloud Noise Visibillity;12;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;182;-33664,-1952;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;203;-33968,-1104;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;204;-33920,-1184;Inherit;False;Constant;_Float5;Float 3;4;0;Create;True;0;0;0;False;0;False;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;154;-34240,-2736;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;187;-34256,-2928;Inherit;False;Property;_HighlightColor;Highlight Color;6;1;[HDR];Create;True;0;0;0;False;0;False;0.768116,0,1,0;0.04370499,0,1,0;True;False;0;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.OneMinusNode;1677;-14576,2832;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;2276;-24000,-7312;Inherit;False;3828;1296;;38;2221;2223;2247;2224;2226;2248;2253;2225;2228;2264;2238;2239;2240;2254;2255;2229;2269;2265;2241;2261;2256;2262;2227;2270;2243;2258;2266;2267;2235;2245;2259;2271;2273;2236;2244;2260;2237;2246;Stars;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;895;-22672,-80;Inherit;False;Scrolling Noise texture;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;140;-34112,-7712;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GradientNode;134;-34368,-7536;Inherit;False;0;4;2;1,1,1,0;0.7020309,0.6994113,0.6994113,0.3617609;0.1981132,0.1981132,0.1981132,0.7588311;0,0,0,1;1,0;1,1;0;1;OBJECT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;581;-36272,10288;Inherit;False;2;0;FLOAT2;1,1;False;1;FLOAT2;-2,-2;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;582;-36304,10688;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;583;-36400,10800;Float;False;Constant;_ViewDirectionImpact6;View Direction Impact;13;0;Create;True;0;0;0;False;0;False;1.6;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;556;-36320,8112;Inherit;False;2;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ViewVectorNode;557;-36592,8656;Inherit;False;Tangent;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleDivideOpNode;612;-36320,9120;Inherit;False;2;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ViewVectorNode;613;-36592,9664;Inherit;False;Tangent;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleDivideOpNode;482;-36320,5104;Inherit;False;2;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ViewVectorNode;483;-36592,5648;Inherit;False;Tangent;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleDivideOpNode;504;-36320,6112;Inherit;False;2;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ViewVectorNode;505;-36592,6656;Inherit;False;Tangent;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode;1509;-25744,-8224;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;697;-27536,-7616;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;698;-26816,-8064;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;200;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;699;-27104,-7392;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;788;-26832,-9136;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;200;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;789;-27120,-8464;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;834;-27536,-6576;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;836;-27104,-6352;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;835;-26784,-7024;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;300;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;787;-27552,-8688;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;327;-35040,-4144;Inherit;True;Center Color;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2214;-23360,9808;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2215;-23360,10304;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;2045;-21408,9088;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1879;-23360,7696;Inherit;True;2;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1873;-23360,8176;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;1919;-21408,8848;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;0.4;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2323;-33664,-224;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;184;-33408,-1952;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;205;-33616,-1152;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;189;-34000,-2736;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;191;-33808,-2592;Inherit;False;Property;_HighlightIntensity;Highlight Intensity;7;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2298;-34032,-2656;Inherit;False;Property;_HighlightThreshold;Highlight Threshold;8;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2456;-33280,-2592;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0.5,0.5,5;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;897;-14672,3248;Inherit;False;895;Scrolling Noise texture;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;2604;-14288,2848;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;3.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2221;-23952,-6912;Inherit;False;Constant;_StarScrollingspeed;Star Scrolling speed;44;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GradientSampleNode;135;-33936,-7536;Inherit;True;2;0;OBJECT;;False;1;FLOAT;0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;584;-36096,10288;Inherit;False;2;2;0;FLOAT2;0.5,0.5;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;585;-36096,10688;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;586;-36192,10544;Inherit;False;Constant;_EyeHighlightPlacement6;Eye Highlight Placement;13;0;Create;True;0;0;0;False;0;False;-1.2,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleDivideOpNode;558;-36272,8272;Inherit;False;2;0;FLOAT2;1,1;False;1;FLOAT2;-2,-2;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;559;-36304,8672;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;560;-36400,8784;Float;False;Constant;_ViewDirectionImpact5;View Direction Impact;13;0;Create;True;0;0;0;False;0;False;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;614;-36272,9280;Inherit;False;2;0;FLOAT2;1,1;False;1;FLOAT2;-2,-2;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;615;-36304,9680;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;616;-36400,9792;Float;False;Constant;_ViewDirectionImpact7;View Direction Impact;13;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;484;-36272,5264;Inherit;False;2;0;FLOAT2;1,1;False;1;FLOAT2;-2,-2;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;485;-36304,5664;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;486;-36400,5776;Float;False;Constant;_ViewDirectionImpact2;View Direction Impact;13;0;Create;True;0;0;0;False;0;False;6;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;506;-36272,6272;Inherit;False;2;0;FLOAT2;1,1;False;1;FLOAT2;-2,-2;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;507;-36304,6672;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;508;-36400,6784;Float;False;Constant;_ViewDirectionImpact3;View Direction Impact;13;0;Create;True;0;0;0;False;0;False;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;1510;-25488,-8224;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;702;-26896,-7408;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;700;-27360,-7616;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;701;-26656,-8064;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;790;-26912,-8480;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;792;-26672,-9136;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;839;-26624,-7024;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;838;-27360,-6576;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;791;-27376,-8688;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;837;-26896,-6368;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;40;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;332;-34064,-3712;Inherit;False;327;Center Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2216;-22944,10160;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;2046;-21088,9088;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1882;-22944,8032;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2608;-33328,-224;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2327;-33408,-48;Inherit;False;Property;_CloudNoiseColor;Cloud Noise Color;11;0;Create;True;0;0;0;False;0;False;0.5754717,0.5754717,0.5754717,0;0,0.156469,0.735849,0;True;False;0;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.ColorNode;186;-34096,-3632;Inherit;False;Property;_BaseColor;Base Color;4;0;Create;True;1;Base Colors;0;0;False;0;False;0,0.373857,1,0;1,0,0,0;True;False;0;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.WireNode;315;-33168,-1968;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;206;-33360,-1152;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1603;-32832,-2368;Inherit;False;Property;_Highlight2Intensity;Highlight 2 Intensity;10;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;302;-33600,-2688;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;2297;-33776,-2784;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;301;-32992,-2640;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT3;0.75,0.75,0.75;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;1920;-21088,8848;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1467;-13712,2864;Inherit;False;Property;_FlowIntensity;Flow Intensity;23;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1678;-13744,3104;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;2223;-23920,-6976;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2247;-23584,-6944;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-0.01;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;337;-33584,-7536;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;587;-35952,10160;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;588;-35712,10544;Float;False;Constant;_Float19;Float 8;14;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;589;-35712,10480;Float;False;Constant;_Float20;Float 4;14;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;590;-35904,10640;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;607;-35712,10784;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;561;-36096,8272;Inherit;False;2;2;0;FLOAT2;0.5,0.5;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;562;-36096,8672;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;563;-36208,8528;Inherit;False;Constant;_EyeHighlightPlacement5;Eye Highlight Placement;13;0;Create;True;0;0;0;False;0;False;1.4,0.2;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;617;-36096,9280;Inherit;False;2;2;0;FLOAT2;0.5,0.5;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;618;-36096,9680;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;619;-36192,9536;Inherit;False;Constant;_EyeHighlightPlacement7;Eye Highlight Placement;13;0;Create;True;0;0;0;False;0;False;1.3,-1.6;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;487;-36096,5264;Inherit;False;2;2;0;FLOAT2;0.5,0.5;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;488;-36096,5664;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;489;-36192,5520;Inherit;False;Constant;_EyeHighlightPlacement2;Eye Highlight Placement;13;0;Create;True;0;0;0;False;0;False;1.2,1.2;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;509;-36096,6272;Inherit;False;2;2;0;FLOAT2;0.5,0.5;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;510;-36096,6672;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;511;-36192,6528;Inherit;False;Constant;_EyeHighlightPlacement3;Eye Highlight Placement;13;0;Create;True;0;0;0;False;0;False;-0.8,1.4;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1511;-25312,-8224;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;1.6;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;703;-26336,-7840;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;704;-26336,-7616;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;793;-26352,-8912;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;794;-26352,-8688;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;840;-26336,-6800;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;841;-26336,-6576;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;336;-33728,-3664;Inherit;True;Screen;True;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PowerNode;2217;-22672,10160;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;2219;-20896,8896;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;1883;-22672,8032;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2326;-32944,-320;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;2374;-33184,16;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;1599;-32944,-1264;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;272;-32800,-2800;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;1601;-32672,-2576;Inherit;False;Property;_Highlight2Color;Highlight 2 Color;9;0;Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1700;-32608,-2368;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;188;-33472,-2944;Inherit;True;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;1679;-13488,3104;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1580;-13456,2928;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;100;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2224;-23296,-7024;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2226;-23280,-7120;Inherit;False;Constant;_Float27;Float 27;44;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2248;-23552,-6688;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-0.001;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2253;-23552,-6368;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-0.001;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;120;-33328,-7536;Float;True;Generated Pupil;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;591;-35088,10352;Inherit;False;756;384;Shape Drawing;4;595;594;593;631;;0,0,0,1;0;0
Node;AmplifyShaderEditor.FunctionNode;592;-35392,10480;Inherit;False;Spherize;-1;;132;1488bb72d8899174ba0601b595d32b07;0;4;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DistanceOpNode;600;-35472,10784;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;564;-35952,8144;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;565;-35712,8528;Float;False;Constant;_Float17;Float 8;14;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;566;-35712,8464;Float;False;Constant;_Float18;Float 4;14;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;567;-35904,8624;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;620;-35952,9152;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;621;-35712,9536;Float;False;Constant;_Float21;Float 8;14;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;622;-35712,9472;Float;False;Constant;_Float22;Float 4;14;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;623;-35904,9632;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;490;-35952,5136;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;491;-35712,5520;Float;False;Constant;_Float11;Float 8;14;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;492;-35712,5456;Float;False;Constant;_Float12;Float 4;14;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;493;-35904,5616;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;512;-35952,6144;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;513;-35712,6528;Float;False;Constant;_Float13;Float 8;14;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;514;-35712,6464;Float;False;Constant;_Float14;Float 4;14;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;515;-35904,6624;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;1512;-25088,-8224;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;705;-26096,-7696;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;795;-26112,-8768;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;842;-26096,-6656;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;222;-33312,-3728;Inherit;False;Base Colors;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2042;-20768,9264;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2041;-20688,8816;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2328;-32384,-240;Inherit;False;Cloud Noise add;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2375;-32944,-80;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;299;-32576,-2960;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1600;-32368,-2544;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0.2,0.2,0.2;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1666;-12912,2192;Inherit;False;120;Generated Pupil;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1572;-13200,3024;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1537;-13712,2384;Inherit;True;106;Non Spherized Pupil;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1495;-12784,2656;Inherit;False;Property;_FlowContrast;Flow Contrast;24;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;2225;-23072,-7088;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2228;-23088,-7264;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2264;-22592,-6720;Inherit;False;Property;_StarsAmount;Stars Amount;34;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2238;-23952,-6736;Inherit;False;28;Parallax Logic;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2239;-23280,-6624;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2240;-23264,-6720;Inherit;False;Constant;_Float28;Float 27;44;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2254;-23280,-6240;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2255;-23264,-6336;Inherit;False;Constant;_Float29;Float 27;44;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;568;-35088,8336;Inherit;False;756;384;Shape Drawing;4;573;572;571;570;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;624;-35088,9344;Inherit;False;756;384;Shape Drawing;4;628;627;626;854;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;480;-35088,5328;Inherit;False;756;384;Shape Drawing;4;498;497;496;495;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;516;-35088,6336;Inherit;False;756;384;Shape Drawing;4;521;520;519;518;;0,0,0,1;0;0
Node;AmplifyShaderEditor.FunctionNode;569;-35392,8464;Inherit;False;Spherize;-1;;133;1488bb72d8899174ba0601b595d32b07;0;4;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;601;-35168,10784;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2.4;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;625;-35392,9472;Inherit;False;Spherize;-1;;134;1488bb72d8899174ba0601b595d32b07;0;4;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;494;-35392,5456;Inherit;False;Spherize;-1;;135;1488bb72d8899174ba0601b595d32b07;0;4;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;517;-35392,6464;Inherit;False;Spherize;-1;;136;1488bb72d8899174ba0601b595d32b07;0;4;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.VoronoiNode;594;-35040,10464;Inherit;False;0;0;1;0;1;False;1;False;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;984;False;2;FLOAT;1.2;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.PowerNode;1513;-24912,-8224;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;0.4;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;708;-25584,-7712;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2458;-25584,-7568;Inherit;False;Property;_LineThreshold;Line Threshold;19;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2040;-20528,9056;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2371;-32384,-112;Inherit;False;Cloud Noise Sub;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1598;-32224,-2976;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1668;-12688,2192;Inherit;False;FLOAT;1;0;FLOAT;0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DistanceOpNode;1535;-13328,2384;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;2583;-12432,3072;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2448;-13040,528;Inherit;False;2328;Cloud Noise add;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2450;-13104,304;Inherit;True;222;Base Colors;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;2285;-13104,192;Inherit;False;Property;_BaseColorIntensity;Base Color Intensity;5;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;221;-35664,-3424;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2229;-22768,-7120;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;2269;-21744,-6752;Inherit;False;Property;_StarsScale;Stars Scale;35;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2265;-22304,-6928;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;2241;-23056,-6688;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;2261;-22960,-6832;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;2256;-23056,-6304;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2262;-23008,-6416;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;3,3;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;570;-35040,8368;Inherit;False;Constant;_RefHSmoothing5;RefH Smoothing;13;0;Create;True;0;0;0;False;0;False;0.03;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;604;-34944,10784;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;593;-35040,10384;Inherit;False;Constant;_RefHSmoothing6;RefH Smoothing;13;0;Create;True;0;0;0;False;0;False;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VoronoiNode;571;-35040,8448;Inherit;False;0;0;1;0;1;False;1;False;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;996;False;2;FLOAT;0.4;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.VoronoiNode;627;-35040,9456;Inherit;True;0;0;1;0;1;False;1;True;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;1366;False;2;FLOAT;0.3;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.DistanceOpNode;495;-35040,5472;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;518;-35040,6480;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;631;-34800,10512;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;0.6;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1514;-24592,-8224;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;2457;-25360,-7728;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2048;-20336,9056;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;358;-31920,-2960;Inherit;False;Lower Eye Highlight;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1669;-12400,2256;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1536;-13072,2384;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2590;-12176,3040;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1671;-12560,2192;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2449;-12560,736;Inherit;False;Saturation;-1;;150;4f383aa3b2a7ef640be83276d286e709;1,51,0;2;12;FLOAT3;0,0,0;False;21;FLOAT;0.5;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2451;-13040,608;Inherit;False;2371;Cloud Noise Sub;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2284;-12848,224;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1576;-12592,2752;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.01;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;194;-34080,-4256;Inherit;False;2067.858;397.4734;Shadow;10;149;307;305;308;158;306;156;155;310;312;Shadow;0,0,0,1;0;0
Node;AmplifyShaderEditor.WireNode;330;-34512,-3952;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VoronoiNode;2227;-22096,-7104;Inherit;True;0;0;1;0;1;False;1;True;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;120;False;2;FLOAT;3;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.SimpleAddOpNode;2243;-22752,-6704;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2258;-22752,-6320;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2266;-22320,-6640;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2267;-22320,-6304;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2270;-21504,-6960;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.06;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;572;-34832,8480;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;603;-34752,10784;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;595;-34576,10496;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;626;-34704,9376;Inherit;False;Constant;_RefHSmoothing7;RefH Smoothing;13;0;Create;True;0;0;0;False;0;False;0.3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;854;-34800,9504;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;496;-34784,5472;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;497;-34800,5392;Inherit;False;Constant;_RefHSmoothing2;RefH Smoothing;13;0;Create;True;0;0;0;False;0;False;0.3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;520;-34800,6400;Inherit;False;Constant;_RefHSmoothing3;RefH Smoothing;13;0;Create;True;0;0;0;False;0;False;0.3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;519;-34784,6480;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1515;-24976,-7712;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1768;-20128,9072;Inherit;False;Electricity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;1687;-12144,2320;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2585;-12848,2384;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1575;-12368,2768;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1925;-12176,1792;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;360;-11424,864;Inherit;False;358;Lower Eye Highlight;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;2602;-11328,928;Inherit;False;Constant;_Float35;Float 35;66;0;Create;True;0;0;0;False;0;False;0.75;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;2452;-12368,736;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleSubtractOpNode;2453;-12432,512;Inherit;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2454;-12432,304;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;310;-33984,-4064;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;2235;-21312,-7104;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0.05;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VoronoiNode;2245;-22080,-6704;Inherit;True;0;0;1;0;1;False;1;True;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;100;False;2;FLOAT;10;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.VoronoiNode;2259;-22080,-6320;Inherit;True;0;0;1;0;1;False;1;True;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;100;False;2;FLOAT;10;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2271;-21472,-6656;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.04;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2273;-21488,-6336;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.04;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;573;-34560,8480;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;628;-34576,9488;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;498;-34576,5472;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;521;-34576,6480;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;606;-34096,10640;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.125;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;338;-10816,-208;Inherit;True;120;Generated Pupil;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2696;-10880,-272;Inherit;False;Property;_PupilOpacity;Pupil Opacity;49;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;643;-24512,-7712;Inherit;False;Styalised Lines;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1701;-11952,2448;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1574;-12080,2624;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1770;-12016,1584;Inherit;False;1768;Electricity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2088;-11888,1728;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2601;-11136,832;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;2455;-12112,448;Inherit;True;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SmoothstepOpNode;155;-33760,-4176;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;25;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2236;-20960,-6944;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0.8;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;2244;-21296,-6704;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0.04;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;2260;-21296,-6320;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0.04;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;630;-34112,9360;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;574;-34112,8480;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.05;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;499;-34144,5328;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.15;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;522;-34128,6336;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.15;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;597;-33840,10496;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.45;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2757;-10432,32;Inherit;False;Constant;_Float36;Float 36;72;0;Create;True;0;0;0;False;0;False;1.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2695;-10448,-160;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1696;-11760,2560;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1922;-11632,1600;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;359;-10992,576;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;1493;-11888,2048;Inherit;False;Property;_FlowColor;Flow Color;20;0;Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.GetLocalVarNode;645;-11648,48;Inherit;False;643;Styalised Lines;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;156;-33488,-4176;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;15;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2237;-20704,-6608;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1912;-11408,1648;Inherit;True;Property;_ElectricityIntensity;Electricity Intensity;29;0;Create;True;0;0;0;False;0;False;0;20;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;549;-33424,8880;Inherit;True;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1704;-33664,5792;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2756;-10240,-16;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2759;-10240,144;Inherit;False;Constant;_Float37;Float 37;72;0;Create;True;0;0;0;False;0;False;1.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1911;-10864,1472;Inherit;False;Property;_ElectricityColor;Electricity Color;30;0;Create;True;0;0;0;False;0;False;0.6196079,0.8686028,1,0;0,0,0,0;True;False;0;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1771;-10992,1344;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;25;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2747;-10768,672;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;2746;-10736,912;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2748;-11536,1936;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;1,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1498;-11072,128;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;306;-33152,-4032;Inherit;False;Property;_ShadowThreshold;Shadow Threshold;14;0;Create;True;0;0;0;False;0;False;1.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;158;-33200,-4176;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2246;-20416,-6608;Inherit;False;Stars;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2891;-10464,1280;Inherit;False;120;Generated Pupil;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2897;-10400,1344;Inherit;False;Constant;_Float40;Float 40;81;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;550;-32544,6864;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;2758;-10016,80;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1910;-10832,1248;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;2745;-10560,672;Inherit;True;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;1499;-10848,160;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1502;-11072,-32;Inherit;False;Property;_LineColor;Line Color;17;0;Create;True;1;Center Lines;0;0;False;0;False;1,1,1,0;0,0,0,0;True;False;0;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.RangedFloatNode;1503;-11040,352;Inherit;False;Property;_LineIntensity;Line Intensity;18;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;308;-32752,-4032;Inherit;False;Property;_ShadowIntensity;Shadow Intensity;13;0;Create;True;0;0;0;False;0;False;5;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;305;-32912,-4144;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2467;-10864,-608;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2481;-10896,-464;Inherit;False;Property;_DarkningOutline;Darkning Outline;45;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2252;-10496,1088;Inherit;False;2246;Stars;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2275;-10496,1152;Inherit;False;Property;_StarsIntensity;Stars Intensity;37;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2896;-10240,1280;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;405;-31584,6880;Inherit;False;Reflection;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;409;-9888,-192;Inherit;False;Property;_ReflectionIntensity;Reflection Intensity;27;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2883;-9728,80;Inherit;False;Saturation;-1;;151;4f383aa3b2a7ef640be83276d286e709;1,51,0;2;12;FLOAT3;0,0,0;False;21;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1913;-10224,576;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1504;-10624,144;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1505;-10704,352;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;307;-32512,-4144;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;2468;-10544,-608;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2480;-10672,-464;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1.98;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2274;-10272,1040;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2319;-10304,1136;Inherit;False;Property;_StarColor;Star Color;33;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;False;0;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.OneMinusNode;2894;-10096,1280;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;2892;-10240,1376;Inherit;False;Property;_StarsShowupPupil;Stars Showup Pupil;61;0;Create;True;0;0;0;False;0;False;1;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;407;-9856,-256;Inherit;False;405;Reflection;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1739;-9616,-144;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2762;-9488,240;Inherit;False;Constant;_Float38;Float 38;72;0;Create;True;0;0;0;False;0;False;0.15;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;2884;-9536,96;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.LerpOp;2718;-9936,560;Inherit;True;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;357;-9760,288;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;312;-32288,-4144;Inherit;False;Shadow;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2469;-10384,-608;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;1.98;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2318;-10048,1008;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;2895;-9824,1264;Inherit;True;3;0;FLOAT;1;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;408;-9312,-160;Inherit;True;2;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2761;-9312,176;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;352;-9584,560;Inherit;True;LinearBurn;False;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;404;-36816,2992;Inherit;False;2517.965;977.4098;Reflection Highlight Generation;6;398;412;413;403;397;387;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;453;-36816,3984;Inherit;False;2521.178;990.2557;Reflection Highlight Generation;6;470;469;467;466;455;454;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;2470;-10160,-608;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;314;-9488,896;Inherit;False;312;Shadow;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2890;-9824,960;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;2760;-9120,192;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2251;-9280,608;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;2489;-9280,896;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;387;-36784,3040;Inherit;False;1064;347;Reflection Highlight Scale;5;365;366;367;368;364;;0.261256,1,0.1745283,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;454;-36768,4032;Inherit;False;1064;347;Reflection Highlight Scale;5;465;462;459;457;456;;0.261256,1,0.1745283,1;0;0
Node;AmplifyShaderEditor.PowerNode;2479;-9968,-608;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;397;-36672,3440;Inherit;False;893.1289;473;Eye Highlight offset;6;394;395;396;393;392;414;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;455;-36656,4432;Inherit;False;893.1289;473;Eye Highlight offset;6;468;464;463;461;460;458;;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector2Node;364;-36736,3120;Inherit;False;Constant;_ReflectionHighlightSize;Reflection Highlight Size;2;0;Create;True;0;0;0;False;0;False;0.08,0.035;0.3,0.3;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;456;-36720,4112;Inherit;False;Constant;_ReflectionHighlightSize1;Reflection Highlight Size;2;0;Create;True;0;0;0;False;0;False;0.055,0.025;0.3,0.3;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.OneMinusNode;2477;-9744,-608;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2482;-9840,-384;Inherit;False;Property;_DarkningOutlineSmoothing;Darkning Outline Smoothing;44;0;Create;True;0;0;0;False;0;False;0.25;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2879;-9104,896;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2886;-8949.308,640.5216;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;365;-36336,3104;Inherit;False;2;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ViewVectorNode;414;-36608,3648;Inherit;False;Tangent;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleDivideOpNode;457;-36320,4096;Inherit;False;2;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ViewVectorNode;458;-36592,4640;Inherit;False;Tangent;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PowerNode;2478;-9456,-544;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;2488;-8512,672;Inherit;True;Multiply;False;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;2742;-7264,192;Inherit;False;Property;_HueShiftSpeed;Hue Shift Speed;51;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;366;-36288,3264;Inherit;False;2;0;FLOAT2;1,1;False;1;FLOAT2;-2,-2;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;392;-36320,3664;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;394;-36416,3776;Float;False;Constant;_ViewDirectionImpact;View Direction Impact;13;0;Create;True;0;0;0;False;0;False;14;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;459;-36272,4256;Inherit;False;2;0;FLOAT2;1,1;False;1;FLOAT2;-2,-2;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;460;-36304,4656;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;461;-36400,4768;Float;False;Constant;_ViewDirectionImpact1;View Direction Impact;13;0;Create;True;0;0;0;False;0;False;7;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;2476;-8192,560;Inherit;True;LinearBurn;False;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;2703;-7120,256;Inherit;False;Property;_HueShift;Hue Shift;50;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;2740;-7024,176;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;367;-36112,3264;Inherit;False;2;2;0;FLOAT2;0.5,0.5;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;393;-36112,3664;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;396;-36208,3520;Inherit;False;Constant;_EyeHighlightPlacement;Eye Highlight Placement;13;0;Create;True;0;0;0;False;0;False;1.15,-5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;462;-36096,4256;Inherit;False;2;2;0;FLOAT2;0.5,0.5;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;463;-36096,4656;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;464;-36192,4512;Inherit;False;Constant;_EyeHighlightPlacement1;Eye Highlight Placement;13;0;Create;True;0;0;0;False;0;False;1,-3;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RGBToHSVNode;2704;-7120,448;Inherit;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;2283;-7024,336;Inherit;False;Property;_ColorSaturation;Color Saturation;36;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2741;-6768,224;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;368;-35968,3136;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;413;-35728,3520;Float;False;Constant;_Float8;Float 8;14;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;412;-35728,3456;Float;False;Constant;_Float4;Float 4;14;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;395;-35920,3616;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;465;-35952,4128;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;466;-35712,4512;Float;False;Constant;_Float9;Float 8;14;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;467;-35712,4448;Float;False;Constant;_Float10;Float 4;14;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;468;-35904,4608;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;2713;-6784,496;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2705;-6464,160;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;403;-35104,3328;Inherit;False;756;384;Shape Drawing;4;399;400;401;402;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;469;-35088,4320;Inherit;False;756;384;Shape Drawing;4;474;473;472;471;;0,0,0,1;0;0
Node;AmplifyShaderEditor.FunctionNode;398;-35408,3456;Inherit;False;Spherize;-1;;152;1488bb72d8899174ba0601b595d32b07;0;4;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;470;-35392,4448;Inherit;False;Spherize;-1;;153;1488bb72d8899174ba0601b595d32b07;0;4;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2829;-13296.17,3394.386;Inherit;False;Unclamped Flow;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;2843;-10576,512;Inherit;False;Lines Emission Boost;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2710;-6464,576;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2848;-5328,-544;Inherit;False;358;Lower Eye Highlight;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2889;-6464,368;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;399;-35056,3472;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;471;-35040,4464;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2560;-3392,-592;Inherit;False;FetchLightmapValue;46;;167;43de3d4ae59f645418fdd020d1b8e78e;1,23,1;0;1;FLOAT3;0
Node;AmplifyShaderEditor.HSVToRGBNode;2711;-6112,384;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;2834;-6000,-16;Inherit;False;2829;Unclamped Flow;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2851;-5072,-512;Inherit;False;Saturation;-1;;176;4f383aa3b2a7ef640be83276d286e709;1,51,0;2;12;FLOAT3;0,0,0;False;21;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2859;-5296,480;Inherit;False;327;Center Color;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;2836;-6000,144;Inherit;False;Property;_FlowEmissionBoost;Flow Emission Boost;60;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;2840;-5808,-320;Inherit;False;2843;Lines Emission Boost;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;402;-34816,3392;Inherit;False;Constant;_RefHSmoothing;RefH Smoothing;13;0;Create;True;0;0;0;False;0;False;0.3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;473;-34800,4384;Inherit;False;Constant;_RefHSmoothing1;RefH Smoothing;13;0;Create;True;0;0;0;False;0;False;0.3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;472;-34784,4464;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;400;-34800,3472;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2564;-3088,-592;Inherit;False;Saturation;-1;;177;4f383aa3b2a7ef640be83276d286e709;1,51,0;2;12;FLOAT3;0,0,0;False;21;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;2571;-5840,368;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1529;-5824,496;Inherit;False;Property;_ColorContrast;Color Contrast;39;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2835;-5760,80;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;100;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;2852;-4880,-464;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.FunctionNode;2860;-5011.388,389.0787;Inherit;False;Saturation;-1;;178;4f383aa3b2a7ef640be83276d286e709;1,51,0;2;12;FLOAT3;0,0,0;False;21;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;2844;-5520,-288;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2842;-5680,-128;Inherit;False;Property;_LinesEmissionBoost;Lines Emission Boost;56;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2589;-10288,2320;Inherit;False;Constant;_Float34;Float 34;65;0;Create;True;0;0;0;False;0;False;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;401;-34592,3472;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;474;-34576,4464;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1553;-5568,2416;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2465;-5440,2624;Inherit;False;Property;_Cutoff;Cutoff;41;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2794;-3168,944;Inherit;False;Property;_PulseSpeed;Pulse Speed;53;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;2565;-2896,-576;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;2837;-5488,80;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2849;-4736,-432;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;2861;-4848,384;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;2847;-4992,-336;Inherit;False;Property;_HighlightEmissionBoost;Highlight Emission Boost;58;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2841;-5344,-208;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;10;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;2880;-5584,560;Inherit;True;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2588;-10192,2144;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;476;-34128,3616;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;475;-34144,4320;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.8;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;1548;-5312,2416;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2466;-5248,2624;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1.98;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;2790;-2992,944;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2566;-2736,-544;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;2438;-2800,-448;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2831;-5344,32;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;2856;-4704,384;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2846;-4608,-320;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;5;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2858;-4864,544;Inherit;False;Property;_CenterColorEmissionBoost;Center Color Emission Boost;59;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2839;-5072,-208;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2586;-9936,1968;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2615;-9776,1840;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;2863;-4272,704;Inherit;False;1768;Electricity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;452;-33728,3872;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2563;-2592,-464;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1549;-5024,2416;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;1.98;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;2789;-2800,944;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;2459;-2832,-336;Inherit;False;Property;_UnlitToggle;Unlit Toggle;43;0;Create;True;0;0;0;False;0;False;0;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2845;-4384,-192;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2838;-4880,16;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2855;-4528,464;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;25;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2864;-3984,704;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2865;-4032,416;Inherit;False;Property;_ElectricityEmissionBoost;Electricity Emission Boost;57;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;2603;-9840,2128;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2616;-9520,1856;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;5,5,5;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1703;-33376,3920;Inherit;False;Reflection Highlight;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2572;-2448,-384;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;2317;-4768,2416;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;7;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2801;-2656,944;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2556;-2704,-672;Inherit;False;Constant;_Float32;Float 32;67;0;Create;True;0;0;0;False;0;False;0.0001;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2557;-2768,-240;Inherit;False;Constant;_Float33;Float 33;67;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2850;-4336,-16;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2854;-4256,464;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1737;-2720,320;Inherit;False;Property;_ReflectionHighlightIntensity;Reflection Highlight Intensity;28;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2866;-3760,464;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;10;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;2804;-2672,704;Inherit;False;Property;_PulseRange;Pulse Range;55;0;Create;True;0;0;0;False;0;False;1,2;1,2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;2605;-9584,2128;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ConditionalIfNode;2555;-2240,-400;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1697;-4768,2192;Inherit;False;120;Generated Pupil;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1560;-4864,1936;Inherit;True;Saturation;-1;;179;4f383aa3b2a7ef640be83276d286e709;1,51,0;2;12;FLOAT3;0,0,0;False;21;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;2287;-4704,2256;Inherit;False;Constant;_Float30;Float 30;50;0;Create;True;0;0;0;False;0;False;20;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;2320;-4608,2416;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2307;-4608,2672;Inherit;False;Property;_CutoffHardness;Cutoff Hardness;42;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;2802;-2512,944;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2853;-3856,-16;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1706;-2528,240;Inherit;False;1703;Reflection Highlight;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2867;-3488,464;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1738;-2432,320;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2874;-2384,832;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2558;-1888,-400;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1558;-4480,1968;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2286;-4448,2176;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1556;-4448,2416;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2309;-4352,2672;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1531;-2208,592;Inherit;False;Property;_ColorIntensity;Color Intensity;38;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2803;-2192,880;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1736;-2224,240;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2862;-3408,-16;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2873;-2336,704;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;2568;-1552,-288;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1698;-4224,2016;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PowerNode;1554;-4160,2416;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;3.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2805;-1952,768;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1705;-1952,-32;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2872;-1896.254,567.0328;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;2807;-1968,672;Inherit;False;Property;_PulsingToggle;Pulsing Toggle;54;0;Create;True;0;0;0;False;0;False;0;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;525;-36816,7008;Inherit;False;2521.178;990.2557;Reflection random Highlight Generation;6;542;541;539;538;527;526;;0.7959278,0.6462264,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2439;-1328,-64;Inherit;False;2;2;0;FLOAT;1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;2288;-3968,2032;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;1557;-3840,2400;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;2806;-1552,576;Inherit;False;False;5;0;FLOAT;0.5;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;526;-36768,7056;Inherit;False;1064;347;Reflection Highlight Scale;5;537;534;531;529;528;;0.261256,1,0.1745283,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;527;-36656,7456;Inherit;False;893.1289;473;Eye Highlight offset;6;540;536;535;533;532;530;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;541;-35088,7344;Inherit;False;756;384;Shape Drawing;4;546;545;547;551;;0,0,0,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2464;-1072,96;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1550;-3744,2096;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;1.25;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;2281;-3616,2384;Inherit;False;Property;_ColorCutoffInfluence;Color Cutoff Influence;40;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;1528;-5600,352;Inherit;True;2;1;COLOR;0,0,0,0;False;0;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;2624;-672,96;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;9999,9999,9999;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;149;-34000,-4176;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.05;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;528;-36720,7136;Inherit;False;Constant;_ReflectionHighlightSize4;Reflection Highlight Size;2;0;Create;True;0;0;0;False;0;False;0.35,0.225;0.3,0.3;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleDivideOpNode;529;-36320,7120;Inherit;False;2;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ViewVectorNode;530;-36592,7664;Inherit;False;Tangent;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleDivideOpNode;531;-36272,7280;Inherit;False;2;0;FLOAT2;1,1;False;1;FLOAT2;-2,-2;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;532;-36304,7680;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;533;-36400,7792;Float;False;Constant;_ViewDirectionImpact4;View Direction Impact;13;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;534;-36096,7280;Inherit;False;2;2;0;FLOAT2;0.5,0.5;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;535;-36096,7680;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;536;-36192,7536;Inherit;False;Constant;_EyeHighlightPlacement4;Eye Highlight Placement;13;0;Create;True;0;0;0;False;0;False;-0.4,-0.4;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;537;-35952,7152;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;538;-35712,7536;Float;False;Constant;_Float15;Float 8;14;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;539;-35712,7472;Float;False;Constant;_Float16;Float 4;14;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;540;-35904,7632;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;542;-35392,7472;Inherit;False;Spherize;-1;;180;1488bb72d8899174ba0601b595d32b07;0;4;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;545;-35040,7376;Inherit;False;Constant;_RefHSmoothing4;RefH Smoothing;13;0;Create;True;0;0;0;False;0;False;0.05;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VoronoiNode;547;-35040,7456;Inherit;False;0;0;1;0;1;False;1;False;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;994;False;2;FLOAT;0.4;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.SmoothstepOpNode;546;-34832,7488;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;551;-34560,7488;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;548;-34128,7472;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2279;-3360,2080;Inherit;True;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1506;-11232,32;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1496;-11408,-112;Inherit;False;FLOAT;1;0;FLOAT;0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;1500;-11648,-80;Inherit;False;120;Generated Pupil;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;1387;-27760,5584;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;1388;-27744,4464;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;1391;-27440,5584;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;0.6;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;1392;-27424,4464;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;0.6;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;1390;-27744,2112;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;1394;-27424,2112;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1.3;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;1192;-27824,-112;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;1189;-27504,-112;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;0.6;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;1163;-27808,-1232;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;1156;-27824,-4640;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;1224;-27808,-3584;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;1389;-27760,1056;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;1393;-27440,1056;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;0.6;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;1160;-27488,-1232;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;0.6;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;1221;-27488,-3584;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;0.6;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;1118;-27504,-4640;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;0.6;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;3;RoboEyeShaderInspector;0;0;Unlit;RoboCap/Robos Eye Shader V1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;1;False;;0;False;;False;0;False;;0;False;;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;2;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;72;0;293;0
WireConnection;73;0;72;0
WireConnection;73;1;72;1
WireConnection;66;1;6;0
WireConnection;1625;4;1623;0
WireConnection;988;4;1051;0
WireConnection;74;0;73;0
WireConnection;74;1;72;2
WireConnection;67;0;66;0
WireConnection;2103;0;2049;0
WireConnection;2103;1;2102;0
WireConnection;2104;0;2102;0
WireConnection;2104;1;2049;0
WireConnection;2105;0;2049;0
WireConnection;2105;1;2102;0
WireConnection;2106;0;2102;0
WireConnection;2106;1;2049;0
WireConnection;2107;0;2049;0
WireConnection;2107;1;2102;0
WireConnection;2108;0;2102;0
WireConnection;2108;1;2049;0
WireConnection;1775;0;2049;0
WireConnection;1775;1;1742;0
WireConnection;1776;0;1742;0
WireConnection;1776;1;2049;0
WireConnection;1797;0;2049;0
WireConnection;1797;1;1742;0
WireConnection;1798;0;1742;0
WireConnection;1798;1;2049;0
WireConnection;1773;0;2049;0
WireConnection;1773;1;1742;0
WireConnection;1774;0;1742;0
WireConnection;1774;1;2049;0
WireConnection;919;0;988;0
WireConnection;919;1;933;0
WireConnection;1626;0;1625;0
WireConnection;1626;1;1624;0
WireConnection;380;0;382;0
WireConnection;380;1;74;0
WireConnection;69;1;67;0
WireConnection;754;1;752;0
WireConnection;2397;1;2396;0
WireConnection;2423;1;2422;0
WireConnection;2109;0;2103;0
WireConnection;2110;0;2104;0
WireConnection;2111;0;2105;0
WireConnection;2112;0;2106;0
WireConnection;2113;0;2049;0
WireConnection;2113;1;2102;0
WireConnection;2114;0;2102;0
WireConnection;2114;1;2049;0
WireConnection;2115;0;2107;0
WireConnection;2116;0;2108;0
WireConnection;1779;0;1775;0
WireConnection;1780;0;1776;0
WireConnection;1777;0;1797;0
WireConnection;1778;0;1798;0
WireConnection;1745;0;2049;0
WireConnection;1745;1;1742;0
WireConnection;1746;0;1742;0
WireConnection;1746;1;2049;0
WireConnection;1756;0;1773;0
WireConnection;1757;0;1774;0
WireConnection;920;0;919;0
WireConnection;921;0;931;0
WireConnection;922;0;931;0
WireConnection;1628;0;1626;0
WireConnection;1629;0;1627;0
WireConnection;1630;0;1627;0
WireConnection;28;0;380;0
WireConnection;70;0;66;0
WireConnection;70;1;69;0
WireConnection;2398;0;2397;0
WireConnection;755;0;754;0
WireConnection;2424;0;2423;0
WireConnection;2118;0;2111;0
WireConnection;2118;1;2112;0
WireConnection;2119;0;2109;0
WireConnection;2119;1;2110;0
WireConnection;2120;0;2113;0
WireConnection;2120;1;2114;0
WireConnection;2121;0;2115;0
WireConnection;2121;1;2116;0
WireConnection;1781;0;1777;0
WireConnection;1781;1;1778;0
WireConnection;1783;0;1779;0
WireConnection;1783;1;1780;0
WireConnection;1748;0;1745;0
WireConnection;1748;1;1746;0
WireConnection;1758;0;1756;0
WireConnection;1758;1;1757;0
WireConnection;923;0;920;0
WireConnection;923;1;921;0
WireConnection;924;0;922;0
WireConnection;924;1;920;1
WireConnection;925;0;922;0
WireConnection;925;1;920;0
WireConnection;926;0;921;0
WireConnection;926;1;920;1
WireConnection;1631;0;1628;0
WireConnection;1631;1;1629;0
WireConnection;1632;0;1630;0
WireConnection;1632;1;1628;1
WireConnection;1633;0;1630;0
WireConnection;1633;1;1628;0
WireConnection;1634;0;1629;0
WireConnection;1634;1;1628;1
WireConnection;64;0;70;0
WireConnection;2399;1;2398;0
WireConnection;756;1;755;0
WireConnection;2425;1;2424;0
WireConnection;2122;0;2117;0
WireConnection;2122;1;2119;0
WireConnection;2123;0;2117;0
WireConnection;2123;1;2118;0
WireConnection;2124;0;2117;0
WireConnection;2124;1;2121;0
WireConnection;2125;0;2117;0
WireConnection;2125;1;2120;0
WireConnection;2126;0;2117;0
WireConnection;1800;0;1760;0
WireConnection;1800;1;1783;0
WireConnection;1785;0;1760;0
WireConnection;1785;1;1781;0
WireConnection;1799;0;1760;0
WireConnection;1799;1;1758;0
WireConnection;1766;0;1760;0
WireConnection;1766;1;1748;0
WireConnection;1818;0;1760;0
WireConnection;927;0;925;0
WireConnection;927;1;926;0
WireConnection;1253;0;923;0
WireConnection;1253;1;924;0
WireConnection;1635;0;1633;0
WireConnection;1635;1;1634;0
WireConnection;1636;0;1631;0
WireConnection;1636;1;1632;0
WireConnection;249;0;35;0
WireConnection;1473;0;1472;0
WireConnection;1474;0;1472;0
WireConnection;2400;0;2397;0
WireConnection;2400;1;2399;0
WireConnection;757;0;754;0
WireConnection;757;1;756;0
WireConnection;2426;0;2423;0
WireConnection;2426;1;2425;0
WireConnection;2127;0;2123;0
WireConnection;2128;0;2122;0
WireConnection;2129;0;2124;0
WireConnection;2130;0;2125;0
WireConnection;2131;0;2117;0
WireConnection;2132;0;2126;0
WireConnection;1849;0;1760;0
WireConnection;1817;0;1818;0
WireConnection;1796;0;1785;0
WireConnection;1787;0;1800;0
WireConnection;1761;0;1799;0
WireConnection;1751;0;1766;0
WireConnection;929;0;927;0
WireConnection;929;1;1253;0
WireConnection;1637;0;1635;0
WireConnection;1637;1;1636;0
WireConnection;36;0;34;0
WireConnection;36;1;249;0
WireConnection;1471;0;1473;0
WireConnection;1471;1;1474;0
WireConnection;2402;0;2401;0
WireConnection;2402;1;2400;0
WireConnection;759;0;758;0
WireConnection;759;1;757;0
WireConnection;2428;0;2427;0
WireConnection;2428;1;2426;0
WireConnection;2134;0;2128;0
WireConnection;2135;0;2127;0
WireConnection;2136;0;2129;0
WireConnection;2137;0;2130;0
WireConnection;2138;0;2131;0
WireConnection;2141;0;2132;0
WireConnection;2141;1;2133;0
WireConnection;1752;0;1751;0
WireConnection;1789;0;1796;0
WireConnection;1788;0;1787;0
WireConnection;1762;0;1761;0
WireConnection;1850;0;1849;0
WireConnection;1819;0;1817;0
WireConnection;1819;1;1820;0
WireConnection;1268;0;1260;0
WireConnection;1268;1;1259;0
WireConnection;1270;0;1262;0
WireConnection;1270;1;1261;0
WireConnection;1274;0;1266;0
WireConnection;1274;1;1265;0
WireConnection;1211;0;1200;0
WireConnection;1211;1;1199;0
WireConnection;1182;0;1171;0
WireConnection;1182;1;1170;0
WireConnection;1243;0;1232;0
WireConnection;1243;1;1231;0
WireConnection;1272;0;1264;0
WireConnection;1272;1;1263;0
WireConnection;930;0;929;0
WireConnection;930;1;933;0
WireConnection;1638;0;1637;0
WireConnection;1638;1;1624;0
WireConnection;1076;0;1073;0
WireConnection;1076;1;1072;0
WireConnection;32;2;36;0
WireConnection;32;4;37;0
WireConnection;1475;0;1471;0
WireConnection;2405;2;2402;0
WireConnection;2405;4;2403;0
WireConnection;762;2;759;0
WireConnection;762;4;760;0
WireConnection;2430;2;2428;0
WireConnection;2430;4;2429;0
WireConnection;2143;0;2135;0
WireConnection;2144;0;2134;0
WireConnection;2145;0;2137;0
WireConnection;2146;0;2136;0
WireConnection;2147;0;2133;0
WireConnection;2148;0;2139;0
WireConnection;2149;0;2138;0
WireConnection;2149;1;2142;0
WireConnection;2150;0;2140;0
WireConnection;2150;1;2141;0
WireConnection;1844;0;1820;0
WireConnection;1836;0;1897;0
WireConnection;1805;0;1850;0
WireConnection;1805;1;1823;0
WireConnection;2076;0;2073;0
WireConnection;2076;1;1819;0
WireConnection;1763;0;1762;0
WireConnection;1753;0;1752;0
WireConnection;1790;0;1789;0
WireConnection;1791;0;1788;0
WireConnection;2729;0;2738;0
WireConnection;2733;0;2737;0
WireConnection;2735;0;2739;0
WireConnection;1275;0;1267;0
WireConnection;1276;0;1267;0
WireConnection;1277;0;1268;0
WireConnection;1278;0;1269;0
WireConnection;1279;0;1269;0
WireConnection;1280;0;1270;0
WireConnection;1284;0;1273;0
WireConnection;1285;0;1273;0
WireConnection;1286;0;1274;0
WireConnection;1201;0;1210;0
WireConnection;1202;0;1210;0
WireConnection;1212;0;1211;0
WireConnection;1172;0;1181;0
WireConnection;1173;0;1181;0
WireConnection;1183;0;1182;0
WireConnection;1233;0;1242;0
WireConnection;1234;0;1242;0
WireConnection;1244;0;1243;0
WireConnection;1281;0;1271;0
WireConnection;1282;0;1271;0
WireConnection;1283;0;1272;0
WireConnection;939;0;930;0
WireConnection;1006;0;930;0
WireConnection;937;0;930;0
WireConnection;1005;0;930;0
WireConnection;1639;0;1638;0
WireConnection;1640;0;1638;0
WireConnection;1641;0;1638;0
WireConnection;1642;0;1638;0
WireConnection;1081;0;1077;0
WireConnection;1082;0;1077;0
WireConnection;1080;0;1076;0
WireConnection;101;0;104;0
WireConnection;101;1;103;0
WireConnection;39;0;32;0
WireConnection;2406;0;2405;0
WireConnection;2406;1;2404;0
WireConnection;810;0;2430;0
WireConnection;810;1;808;0
WireConnection;763;0;762;0
WireConnection;763;1;761;0
WireConnection;2151;0;2143;0
WireConnection;2152;0;2144;0
WireConnection;2153;0;2145;0
WireConnection;2154;0;2146;0
WireConnection;2155;0;2139;0
WireConnection;2155;1;2142;0
WireConnection;2156;0;2148;0
WireConnection;2156;1;2147;0
WireConnection;2157;0;2150;0
WireConnection;2158;0;2150;0
WireConnection;2159;0;2149;0
WireConnection;1754;0;1753;0
WireConnection;1764;0;1763;0
WireConnection;1792;0;1790;0
WireConnection;1793;0;1791;0
WireConnection;1824;0;1897;0
WireConnection;1824;1;1823;0
WireConnection;1834;0;1836;0
WireConnection;1834;1;1844;0
WireConnection;1806;0;2076;0
WireConnection;1807;0;2076;0
WireConnection;1808;0;1805;0
WireConnection;2731;0;764;0
WireConnection;2731;1;2729;0
WireConnection;2734;0;2407;0
WireConnection;2734;1;2733;0
WireConnection;2736;0;811;0
WireConnection;2736;1;2735;0
WireConnection;1291;0;1277;0
WireConnection;1291;1;1275;0
WireConnection;1292;0;1276;0
WireConnection;1292;1;1277;1
WireConnection;1293;0;1276;0
WireConnection;1293;1;1277;0
WireConnection;1294;0;1275;0
WireConnection;1294;1;1277;1
WireConnection;1295;0;1280;0
WireConnection;1295;1;1278;0
WireConnection;1296;0;1279;0
WireConnection;1296;1;1280;1
WireConnection;1297;0;1279;0
WireConnection;1297;1;1280;0
WireConnection;1298;0;1278;0
WireConnection;1298;1;1280;1
WireConnection;1303;0;1286;0
WireConnection;1303;1;1284;0
WireConnection;1304;0;1285;0
WireConnection;1304;1;1286;1
WireConnection;1305;0;1285;0
WireConnection;1305;1;1286;0
WireConnection;1306;0;1284;0
WireConnection;1306;1;1286;1
WireConnection;1203;0;1212;0
WireConnection;1203;1;1201;0
WireConnection;1204;0;1202;0
WireConnection;1204;1;1212;1
WireConnection;1205;0;1202;0
WireConnection;1205;1;1212;0
WireConnection;1206;0;1201;0
WireConnection;1206;1;1212;1
WireConnection;1174;0;1183;0
WireConnection;1174;1;1172;0
WireConnection;1175;0;1173;0
WireConnection;1175;1;1183;1
WireConnection;1176;0;1173;0
WireConnection;1176;1;1183;0
WireConnection;1177;0;1172;0
WireConnection;1177;1;1183;1
WireConnection;1235;0;1244;0
WireConnection;1235;1;1233;0
WireConnection;1236;0;1234;0
WireConnection;1236;1;1244;1
WireConnection;1237;0;1234;0
WireConnection;1237;1;1244;0
WireConnection;1238;0;1233;0
WireConnection;1238;1;1244;1
WireConnection;1299;0;1283;0
WireConnection;1299;1;1281;0
WireConnection;1300;0;1282;0
WireConnection;1300;1;1283;1
WireConnection;1301;0;1282;0
WireConnection;1301;1;1283;0
WireConnection;1302;0;1281;0
WireConnection;1302;1;1283;1
WireConnection;946;0;937;0
WireConnection;947;0;939;0
WireConnection;1643;0;1641;0
WireConnection;1644;0;1639;0
WireConnection;1645;0;1642;0
WireConnection;1646;0;1640;0
WireConnection;1008;0;1005;0
WireConnection;1007;0;1006;0
WireConnection;1086;0;1080;0
WireConnection;1086;1;1081;0
WireConnection;1087;0;1082;0
WireConnection;1087;1;1080;1
WireConnection;1088;0;1082;0
WireConnection;1088;1;1080;0
WireConnection;1089;0;1081;0
WireConnection;1089;1;1080;1
WireConnection;106;0;101;0
WireConnection;2408;0;2406;0
WireConnection;812;0;810;0
WireConnection;765;0;763;0
WireConnection;2409;0;2734;0
WireConnection;2410;0;2734;0
WireConnection;813;0;2736;0
WireConnection;814;0;2736;0
WireConnection;766;0;2731;0
WireConnection;767;0;2731;0
WireConnection;2160;0;2151;0
WireConnection;2160;1;2152;0
WireConnection;2161;0;2153;0
WireConnection;2161;1;2154;0
WireConnection;2162;0;2156;0
WireConnection;2163;0;2156;0
WireConnection;2164;0;2155;0
WireConnection;2165;0;2159;0
WireConnection;2165;1;2157;0
WireConnection;2166;0;2158;0
WireConnection;2166;1;2159;0
WireConnection;2167;0;2157;0
WireConnection;2167;1;2159;1
WireConnection;2168;0;2158;0
WireConnection;2168;1;2159;1
WireConnection;1794;0;1792;0
WireConnection;1794;1;1793;0
WireConnection;1755;0;1754;0
WireConnection;1755;1;1764;0
WireConnection;1825;0;1834;0
WireConnection;1826;0;1834;0
WireConnection;1827;0;1824;0
WireConnection;1809;0;1808;0
WireConnection;1809;1;1806;0
WireConnection;1811;0;1807;0
WireConnection;1811;1;1808;0
WireConnection;1812;0;1806;0
WireConnection;1812;1;1808;1
WireConnection;1810;0;1807;0
WireConnection;1810;1;1808;1
WireConnection;142;2;143;0
WireConnection;142;4;237;0
WireConnection;1313;0;1293;0
WireConnection;1313;1;1294;0
WireConnection;1314;0;1291;0
WireConnection;1314;1;1292;0
WireConnection;1315;0;1297;0
WireConnection;1315;1;1298;0
WireConnection;1316;0;1295;0
WireConnection;1316;1;1296;0
WireConnection;1322;0;1305;0
WireConnection;1322;1;1306;0
WireConnection;1323;0;1303;0
WireConnection;1323;1;1304;0
WireConnection;1207;0;1205;0
WireConnection;1207;1;1206;0
WireConnection;1209;0;1203;0
WireConnection;1209;1;1204;0
WireConnection;1178;0;1176;0
WireConnection;1178;1;1177;0
WireConnection;1180;0;1174;0
WireConnection;1180;1;1175;0
WireConnection;1239;0;1237;0
WireConnection;1239;1;1238;0
WireConnection;1241;0;1235;0
WireConnection;1241;1;1236;0
WireConnection;1319;0;1301;0
WireConnection;1319;1;1302;0
WireConnection;1320;0;1299;0
WireConnection;1320;1;1300;0
WireConnection;1604;0;1487;0
WireConnection;1607;0;1484;0
WireConnection;1609;0;1476;0
WireConnection;1254;0;930;0
WireConnection;955;0;947;0
WireConnection;955;1;946;0
WireConnection;1647;0;1638;0
WireConnection;1648;0;1644;0
WireConnection;1648;1;1643;0
WireConnection;1649;0;1645;0
WireConnection;1649;1;1646;0
WireConnection;1009;0;1008;0
WireConnection;1009;1;1007;0
WireConnection;1097;0;1088;0
WireConnection;1097;1;1089;0
WireConnection;1152;0;1086;0
WireConnection;1152;1;1087;0
WireConnection;43;0;97;0
WireConnection;2411;0;2410;0
WireConnection;2411;1;2408;0
WireConnection;2412;0;2409;0
WireConnection;2412;1;2408;1
WireConnection;2413;0;2408;0
WireConnection;2413;1;2409;0
WireConnection;2414;0;2410;0
WireConnection;2414;1;2408;1
WireConnection;815;0;814;0
WireConnection;815;1;812;0
WireConnection;816;0;813;0
WireConnection;816;1;812;1
WireConnection;817;0;812;0
WireConnection;817;1;813;0
WireConnection;818;0;814;0
WireConnection;818;1;812;1
WireConnection;768;0;767;0
WireConnection;768;1;765;0
WireConnection;769;0;766;0
WireConnection;769;1;765;1
WireConnection;770;0;765;0
WireConnection;770;1;766;0
WireConnection;771;0;767;0
WireConnection;771;1;765;1
WireConnection;2170;0;2161;0
WireConnection;2170;1;2169;0
WireConnection;2171;0;2169;0
WireConnection;2171;1;2160;0
WireConnection;2172;0;2164;0
WireConnection;2172;1;2162;0
WireConnection;2173;0;2163;0
WireConnection;2173;1;2164;0
WireConnection;2174;0;2162;0
WireConnection;2174;1;2164;1
WireConnection;2175;0;2163;0
WireConnection;2175;1;2164;1
WireConnection;2176;0;2166;0
WireConnection;2176;1;2167;0
WireConnection;2177;0;2165;0
WireConnection;2177;1;2168;0
WireConnection;1888;0;1755;0
WireConnection;1888;1;1803;0
WireConnection;1890;0;1803;0
WireConnection;1890;1;1794;0
WireConnection;1828;0;1827;0
WireConnection;1828;1;1825;0
WireConnection;1829;0;1826;0
WireConnection;1829;1;1827;0
WireConnection;1830;0;1825;0
WireConnection;1830;1;1827;1
WireConnection;1833;0;1826;0
WireConnection;1833;1;1827;1
WireConnection;1813;0;1811;0
WireConnection;1813;1;1812;0
WireConnection;1814;0;1809;0
WireConnection;1814;1;1810;0
WireConnection;147;0;142;0
WireConnection;1330;0;1313;0
WireConnection;1330;1;1314;0
WireConnection;1334;0;1315;0
WireConnection;1334;1;1316;0
WireConnection;1341;0;1322;0
WireConnection;1341;1;1323;0
WireConnection;1344;0;1324;0
WireConnection;1208;0;1207;0
WireConnection;1208;1;1209;0
WireConnection;1216;0;1213;0
WireConnection;1179;0;1178;0
WireConnection;1179;1;1180;0
WireConnection;1240;0;1239;0
WireConnection;1240;1;1241;0
WireConnection;1337;0;1319;0
WireConnection;1337;1;1320;0
WireConnection;1479;0;1609;0
WireConnection;1217;0;1184;0
WireConnection;1248;0;1247;0
WireConnection;1521;0;1481;0
WireConnection;1345;0;1321;0
WireConnection;1343;0;1318;0
WireConnection;1342;0;1317;0
WireConnection;1527;0;1604;0
WireConnection;1606;0;1486;0
WireConnection;1485;0;1607;0
WireConnection;1608;0;1482;0
WireConnection;957;0;955;0
WireConnection;1011;0;1009;0
WireConnection;1618;0;1254;0
WireConnection;1619;0;1254;1
WireConnection;1650;0;1648;0
WireConnection;1651;0;1649;0
WireConnection;1652;0;1647;0
WireConnection;1653;0;1647;1
WireConnection;1218;0;1068;0
WireConnection;1106;0;1097;0
WireConnection;1106;1;1152;0
WireConnection;258;0;99;0
WireConnection;108;0;43;0
WireConnection;2415;0;2411;0
WireConnection;2415;1;2412;0
WireConnection;2416;0;2413;0
WireConnection;2416;1;2414;0
WireConnection;819;0;815;0
WireConnection;819;1;816;0
WireConnection;1146;0;817;0
WireConnection;1146;1;818;0
WireConnection;772;0;768;0
WireConnection;772;1;769;0
WireConnection;1148;0;770;0
WireConnection;1148;1;771;0
WireConnection;2178;0;2170;0
WireConnection;2178;1;2171;0
WireConnection;2179;0;2173;0
WireConnection;2179;1;2174;0
WireConnection;2180;0;2172;0
WireConnection;2180;1;2175;0
WireConnection;2181;0;2176;0
WireConnection;2181;1;2177;0
WireConnection;2085;0;1888;0
WireConnection;2085;1;1890;0
WireConnection;1831;0;1829;0
WireConnection;1831;1;1830;0
WireConnection;1832;0;1828;0
WireConnection;1832;1;1833;0
WireConnection;1815;0;1813;0
WireConnection;1815;1;1814;0
WireConnection;220;0;147;1
WireConnection;2600;0;2595;0
WireConnection;1352;0;1327;0
WireConnection;1352;1;1489;0
WireConnection;1354;0;1331;0
WireConnection;1354;1;1527;0
WireConnection;1355;0;1334;0
WireConnection;1355;1;1343;0
WireConnection;1362;0;1330;0
WireConnection;1362;1;1342;0
WireConnection;1361;0;1341;0
WireConnection;1361;1;1344;0
WireConnection;1360;0;1338;0
WireConnection;1360;1;1606;0
WireConnection;1197;0;1193;0
WireConnection;1197;1;1608;0
WireConnection;1214;0;1208;0
WireConnection;1214;1;1216;0
WireConnection;1168;0;1164;0
WireConnection;1168;1;1521;0
WireConnection;1185;0;1179;0
WireConnection;1185;1;1217;0
WireConnection;1105;0;1094;0
WireConnection;1105;1;1479;0
WireConnection;1229;0;1225;0
WireConnection;1229;1;1480;0
WireConnection;1245;0;1240;0
WireConnection;1245;1;1248;0
WireConnection;1358;0;1337;0
WireConnection;1358;1;1345;0
WireConnection;1357;0;1335;0
WireConnection;1357;1;1485;0
WireConnection;1012;0;1011;0
WireConnection;952;0;957;0
WireConnection;1003;0;1254;0
WireConnection;1616;0;1618;0
WireConnection;914;0;1254;1
WireConnection;1621;0;1619;0
WireConnection;1655;0;1650;0
WireConnection;1656;0;1647;0
WireConnection;1657;0;1652;0
WireConnection;1658;0;1647;1
WireConnection;1659;0;1653;0
WireConnection;1654;0;1651;0
WireConnection;1070;0;1106;0
WireConnection;1070;1;1218;0
WireConnection;109;0;108;0
WireConnection;45;0;43;0
WireConnection;107;0;258;0
WireConnection;107;3;2763;0
WireConnection;2417;0;2415;0
WireConnection;2417;1;2416;0
WireConnection;774;0;772;0
WireConnection;774;1;1148;0
WireConnection;2182;0;2179;0
WireConnection;2182;1;2180;0
WireConnection;2183;0;2181;0
WireConnection;2183;1;2142;0
WireConnection;2184;0;2178;0
WireConnection;2086;0;2085;0
WireConnection;1839;0;1831;0
WireConnection;1839;1;1832;0
WireConnection;2072;0;1815;0
WireConnection;2072;1;1823;0
WireConnection;2524;0;2523;0
WireConnection;2527;0;2526;0
WireConnection;2521;0;2520;0
WireConnection;821;0;819;0
WireConnection;821;1;1146;0
WireConnection;172;0;220;0
WireConnection;2596;1;2600;0
WireConnection;1365;0;1352;0
WireConnection;1365;1;1328;0
WireConnection;1366;0;1362;0
WireConnection;1366;1;1259;0
WireConnection;1367;0;1354;0
WireConnection;1367;1;1332;0
WireConnection;1368;0;1355;0
WireConnection;1368;1;1261;0
WireConnection;1371;0;1360;0
WireConnection;1371;1;1434;0
WireConnection;1372;0;1361;0
WireConnection;1372;1;1265;0
WireConnection;1198;0;1197;0
WireConnection;1198;1;1194;0
WireConnection;1215;0;1214;0
WireConnection;1215;1;1199;0
WireConnection;1169;0;1168;0
WireConnection;1169;1;1165;0
WireConnection;1186;0;1185;0
WireConnection;1186;1;1170;0
WireConnection;1110;0;1105;0
WireConnection;1110;1;1095;0
WireConnection;1111;0;1070;0
WireConnection;1111;1;1072;0
WireConnection;1230;0;1229;0
WireConnection;1230;1;1226;0
WireConnection;1246;0;1245;0
WireConnection;1246;1;1231;0
WireConnection;1370;0;1358;0
WireConnection;1370;1;1263;0
WireConnection;1369;0;1357;0
WireConnection;1369;1;1336;0
WireConnection;1613;0;1003;0
WireConnection;1617;0;1616;0
WireConnection;1620;0;914;0
WireConnection;1622;0;1621;0
WireConnection;1662;0;1656;0
WireConnection;1663;0;1657;0
WireConnection;1664;0;1658;0
WireConnection;1665;0;1659;0
WireConnection;951;0;952;0
WireConnection;1013;0;1012;0
WireConnection;1660;0;1655;0
WireConnection;1661;0;1654;0
WireConnection;110;0;107;0
WireConnection;110;1;109;0
WireConnection;98;0;45;0
WireConnection;2519;0;774;0
WireConnection;2519;1;2521;0
WireConnection;317;0;316;0
WireConnection;2185;0;2183;0
WireConnection;2186;0;2182;0
WireConnection;2186;1;2142;0
WireConnection;2187;0;2184;0
WireConnection;2079;0;2072;0
WireConnection;2082;0;1839;0
WireConnection;2082;1;1823;0
WireConnection;2096;0;2086;0
WireConnection;2304;0;147;1
WireConnection;2522;0;2417;0
WireConnection;2522;1;2524;0
WireConnection;2525;0;821;0
WireConnection;2525;1;2527;0
WireConnection;173;0;172;0
WireConnection;2597;0;2596;0
WireConnection;1377;0;1366;0
WireConnection;1377;1;1365;0
WireConnection;1378;0;1368;0
WireConnection;1378;1;1367;0
WireConnection;1380;0;1372;0
WireConnection;1380;1;1371;0
WireConnection;1188;0;1215;0
WireConnection;1188;1;1198;0
WireConnection;1159;0;1186;0
WireConnection;1159;1;1169;0
WireConnection;1114;0;1111;0
WireConnection;1114;1;1110;0
WireConnection;1220;0;1246;0
WireConnection;1220;1;1230;0
WireConnection;1379;0;1370;0
WireConnection;1379;1;1369;0
WireConnection;1383;0;1660;0
WireConnection;1383;1;1665;0
WireConnection;1384;0;1660;0
WireConnection;1384;1;1664;0
WireConnection;1385;0;1661;0
WireConnection;1385;1;1662;0
WireConnection;1386;0;1661;0
WireConnection;1386;1;1663;0
WireConnection;1015;0;951;0
WireConnection;1015;1;1622;0
WireConnection;1014;0;951;0
WireConnection;1014;1;1620;0
WireConnection;998;0;1013;0
WireConnection;998;1;1613;0
WireConnection;1002;0;1013;0
WireConnection;1002;1;1617;0
WireConnection;111;0;110;0
WireConnection;55;0;98;0
WireConnection;123;0;43;0
WireConnection;2418;0;2522;0
WireConnection;2418;1;2404;0
WireConnection;822;0;2525;0
WireConnection;822;1;808;0
WireConnection;775;0;2519;0
WireConnection;775;1;761;0
WireConnection;318;0;317;0
WireConnection;2188;0;2186;0
WireConnection;2188;1;2187;0
WireConnection;2189;0;2185;0
WireConnection;2189;1;2187;0
WireConnection;2084;0;2082;0
WireConnection;2084;1;2096;0
WireConnection;2080;0;2079;0
WireConnection;2080;1;2096;0
WireConnection;2299;0;2304;0
WireConnection;174;0;173;0
WireConnection;219;0;147;1
WireConnection;162;0;163;0
WireConnection;162;1;161;0
WireConnection;2598;1;2597;0
WireConnection;1518;0;1519;0
WireConnection;1518;1;1220;0
WireConnection;1520;0;1519;0
WireConnection;1520;1;1159;0
WireConnection;1522;0;1519;0
WireConnection;1522;1;1188;0
WireConnection;1523;0;1519;0
WireConnection;1523;1;1379;0
WireConnection;1524;0;1519;0
WireConnection;1524;1;1380;0
WireConnection;1525;0;1519;0
WireConnection;1525;1;1378;0
WireConnection;1526;0;1519;0
WireConnection;1526;1;1377;0
WireConnection;1395;0;1383;0
WireConnection;1396;0;1384;0
WireConnection;1397;0;1386;0
WireConnection;1398;0;1385;0
WireConnection;1060;0;1015;0
WireConnection;1059;0;1014;0
WireConnection;1249;0;1002;0
WireConnection;1250;0;998;0
WireConnection;1517;0;1519;0
WireConnection;1517;1;1114;0
WireConnection;125;0;123;0
WireConnection;112;0;111;0
WireConnection;112;1;55;0
WireConnection;687;1;2418;0
WireConnection;776;1;775;0
WireConnection;823;1;822;0
WireConnection;411;0;318;0
WireConnection;2191;1;2188;0
WireConnection;2192;1;2189;0
WireConnection;1853;1;2084;0
WireConnection;1876;1;2080;0
WireConnection;2291;0;2290;0
WireConnection;2291;1;2289;0
WireConnection;2300;0;2299;0
WireConnection;175;0;174;0
WireConnection;362;0;147;1
WireConnection;164;0;165;0
WireConnection;164;1;162;0
WireConnection;218;0;219;0
WireConnection;2599;0;2596;0
WireConnection;2599;1;2598;0
WireConnection;911;0;1060;0
WireConnection;911;1;1520;1
WireConnection;1044;0;1059;0
WireConnection;1044;1;1522;1
WireConnection;1399;0;1395;0
WireConnection;1399;1;1525;1
WireConnection;1400;0;1396;0
WireConnection;1400;1;1526;1
WireConnection;1401;0;1523;1
WireConnection;1401;1;1398;0
WireConnection;1402;0;1524;1
WireConnection;1402;1;1397;0
WireConnection;1122;0;1517;1
WireConnection;1122;1;1250;0
WireConnection;1123;0;1518;1
WireConnection;1123;1;1249;0
WireConnection;283;1;112;0
WireConnection;127;0;125;0
WireConnection;688;0;687;0
WireConnection;777;0;776;0
WireConnection;824;0;823;0
WireConnection;319;0;411;0
WireConnection;2193;0;2143;0
WireConnection;2193;1;2144;0
WireConnection;2194;0;2192;56
WireConnection;2194;1;2190;0
WireConnection;2195;0;2190;0
WireConnection;2195;1;2191;56
WireConnection;1875;0;1876;56
WireConnection;1875;1;1857;0
WireConnection;1854;0;1857;0
WireConnection;1854;1;1853;56
WireConnection;1902;0;1792;0
WireConnection;1902;1;1793;0
WireConnection;2293;0;2292;0
WireConnection;2293;1;2291;0
WireConnection;2301;0;2300;0
WireConnection;180;0;175;0
WireConnection;150;0;362;0
WireConnection;166;1;164;0
WireConnection;215;0;218;0
WireConnection;1673;0;2599;0
WireConnection;1050;0;911;0
WireConnection;1050;1;1044;0
WireConnection;1403;0;1399;0
WireConnection;1403;1;1400;0
WireConnection;1404;0;1401;0
WireConnection;1404;1;1402;0
WireConnection;1124;0;1122;0
WireConnection;1124;1;1123;0
WireConnection;281;0;283;0
WireConnection;128;0;127;0
WireConnection;689;0;2405;0
WireConnection;690;0;688;1
WireConnection;779;0;777;1
WireConnection;825;0;2430;0
WireConnection;826;0;824;1
WireConnection;778;0;762;0
WireConnection;321;0;319;0
WireConnection;2196;0;2193;0
WireConnection;2197;0;2145;0
WireConnection;2197;1;2146;0
WireConnection;2198;0;2194;0
WireConnection;2199;0;2195;0
WireConnection;1874;0;1875;0
WireConnection;1856;0;1854;0
WireConnection;1903;0;1902;0
WireConnection;1906;0;1754;0
WireConnection;1906;1;1764;0
WireConnection;2295;1;2293;0
WireConnection;2302;0;2301;0
WireConnection;178;0;180;0
WireConnection;151;0;150;0
WireConnection;167;0;168;0
WireConnection;167;1;166;0
WireConnection;216;0;215;0
WireConnection;1674;0;1673;0
WireConnection;1252;0;1124;0
WireConnection;899;0;1050;0
WireConnection;1405;0;1404;0
WireConnection;1406;0;1403;0
WireConnection;129;0;128;0
WireConnection;284;0;281;0
WireConnection;692;0;690;0
WireConnection;781;0;779;0
WireConnection;828;0;826;0
WireConnection;780;0;778;0
WireConnection;691;0;689;0
WireConnection;827;0;825;0
WireConnection;334;0;321;0
WireConnection;2200;0;2196;0
WireConnection;2201;0;2197;0
WireConnection;2202;0;2199;0
WireConnection;2203;0;2198;0
WireConnection;1858;0;1856;0
WireConnection;1877;0;1874;0
WireConnection;1901;0;1903;0
WireConnection;1916;0;1915;0
WireConnection;2296;0;2294;0
WireConnection;2296;1;2295;0
WireConnection;2321;0;2302;0
WireConnection;1905;0;1906;0
WireConnection;169;0;167;5
WireConnection;169;1;171;0
WireConnection;169;2;170;0
WireConnection;176;0;178;0
WireConnection;152;0;151;0
WireConnection;217;0;216;0
WireConnection;1675;0;1674;0
WireConnection;1251;0;1252;0
WireConnection;1251;1;899;0
WireConnection;1407;0;1405;0
WireConnection;1407;1;1406;0
WireConnection;356;0;284;0
WireConnection;356;1;129;0
WireConnection;693;0;691;0
WireConnection;735;0;692;0
WireConnection;782;0;780;0
WireConnection;829;0;827;0
WireConnection;783;0;781;0
WireConnection;830;0;828;0
WireConnection;322;0;334;0
WireConnection;322;1;326;0
WireConnection;2204;0;2200;0
WireConnection;2205;0;2201;0
WireConnection;2209;0;2100;0
WireConnection;2208;0;2100;0
WireConnection;2206;0;2203;0
WireConnection;2207;0;2202;0
WireConnection;2043;0;1916;0
WireConnection;2090;0;2100;0
WireConnection;2089;0;2100;0
WireConnection;1908;0;1901;0
WireConnection;1909;0;1905;0
WireConnection;2097;0;1877;0
WireConnection;2099;0;1858;0
WireConnection;1917;0;1916;0
WireConnection;2303;0;2321;0
WireConnection;2303;1;2296;1
WireConnection;181;0;176;0
WireConnection;181;1;169;0
WireConnection;202;0;167;5
WireConnection;202;1;209;0
WireConnection;202;2;207;0
WireConnection;210;0;217;0
WireConnection;304;0;152;0
WireConnection;1676;0;1675;0
WireConnection;1433;0;1251;0
WireConnection;1433;1;1407;0
WireConnection;132;0;356;0
WireConnection;579;1;578;0
WireConnection;696;0;693;0
WireConnection;695;0;735;0
WireConnection;694;0;689;0
WireConnection;786;0;783;0
WireConnection;784;0;782;0
WireConnection;833;0;830;0
WireConnection;785;0;778;0
WireConnection;832;0;825;0
WireConnection;831;0;829;0
WireConnection;323;0;322;0
WireConnection;323;1;325;0
WireConnection;2210;0;2204;0
WireConnection;2211;0;2205;0
WireConnection;2212;0;2206;0
WireConnection;2212;1;2208;0
WireConnection;2213;0;2207;0
WireConnection;2213;1;2209;0
WireConnection;2044;0;2043;0
WireConnection;1878;0;2097;0
WireConnection;1878;1;2090;0
WireConnection;1859;0;2099;0
WireConnection;1859;1;2089;0
WireConnection;1918;0;1917;0
WireConnection;1871;0;1908;0
WireConnection;1880;0;1909;0
WireConnection;2305;0;2303;0
WireConnection;182;0;181;0
WireConnection;182;1;183;0
WireConnection;203;0;210;0
WireConnection;203;1;202;0
WireConnection;154;0;304;0
WireConnection;1677;0;1676;0
WireConnection;895;0;1433;0
WireConnection;140;0;132;0
WireConnection;581;0;579;0
WireConnection;582;0;580;1
WireConnection;582;1;580;2
WireConnection;556;1;555;0
WireConnection;612;1;611;0
WireConnection;482;1;481;0
WireConnection;504;1;503;0
WireConnection;697;0;694;0
WireConnection;698;0;695;0
WireConnection;699;0;696;0
WireConnection;788;0;786;0
WireConnection;789;0;784;0
WireConnection;834;0;832;0
WireConnection;836;0;831;0
WireConnection;835;0;833;0
WireConnection;787;0;785;0
WireConnection;327;0;323;0
WireConnection;2214;0;2211;0
WireConnection;2214;1;2212;0
WireConnection;2215;0;2213;0
WireConnection;2215;1;2210;0
WireConnection;2045;0;2044;0
WireConnection;1879;0;1880;0
WireConnection;1879;1;1878;0
WireConnection;1873;0;1859;0
WireConnection;1873;1;1871;0
WireConnection;1919;0;1918;0
WireConnection;2323;0;2305;0
WireConnection;2323;1;2325;0
WireConnection;184;0;182;0
WireConnection;205;0;203;0
WireConnection;205;1;204;0
WireConnection;189;0;154;0
WireConnection;2456;0;187;0
WireConnection;2604;0;1677;0
WireConnection;135;0;134;0
WireConnection;135;1;140;0
WireConnection;584;1;581;0
WireConnection;585;0;582;0
WireConnection;585;1;583;0
WireConnection;558;0;556;0
WireConnection;559;0;557;1
WireConnection;559;1;557;2
WireConnection;614;0;612;0
WireConnection;615;0;613;1
WireConnection;615;1;613;2
WireConnection;484;0;482;0
WireConnection;485;0;483;1
WireConnection;485;1;483;2
WireConnection;506;0;504;0
WireConnection;507;0;505;1
WireConnection;507;1;505;2
WireConnection;1510;0;1509;0
WireConnection;702;0;699;0
WireConnection;700;0;697;0
WireConnection;701;0;698;0
WireConnection;790;0;789;0
WireConnection;792;0;788;0
WireConnection;839;0;835;0
WireConnection;838;0;834;0
WireConnection;791;0;787;0
WireConnection;837;0;836;0
WireConnection;2216;0;2214;0
WireConnection;2216;1;2215;0
WireConnection;2046;0;2045;0
WireConnection;1882;0;1879;0
WireConnection;1882;1;1873;0
WireConnection;2608;0;2323;0
WireConnection;315;0;184;0
WireConnection;206;0;205;0
WireConnection;302;0;191;0
WireConnection;2297;0;189;0
WireConnection;2297;1;2298;0
WireConnection;301;0;191;0
WireConnection;301;2;2456;0
WireConnection;1920;0;1919;0
WireConnection;1678;0;2604;0
WireConnection;1678;1;897;0
WireConnection;2247;0;2221;0
WireConnection;337;0;135;1
WireConnection;587;0;579;0
WireConnection;587;1;584;0
WireConnection;590;0;586;0
WireConnection;590;1;585;0
WireConnection;561;1;558;0
WireConnection;562;0;559;0
WireConnection;562;1;560;0
WireConnection;617;1;614;0
WireConnection;618;0;615;0
WireConnection;618;1;616;0
WireConnection;487;1;484;0
WireConnection;488;0;485;0
WireConnection;488;1;486;0
WireConnection;509;1;506;0
WireConnection;510;0;507;0
WireConnection;510;1;508;0
WireConnection;1511;0;1510;0
WireConnection;703;0;701;0
WireConnection;703;1;700;0
WireConnection;704;0;701;0
WireConnection;704;1;702;0
WireConnection;793;0;792;0
WireConnection;793;1;791;0
WireConnection;794;0;792;0
WireConnection;794;1;790;0
WireConnection;840;0;839;0
WireConnection;840;1;838;0
WireConnection;841;0;839;0
WireConnection;841;1;837;0
WireConnection;336;0;186;0
WireConnection;336;1;332;0
WireConnection;2217;0;2216;0
WireConnection;2219;0;1920;0
WireConnection;2219;1;2046;0
WireConnection;1883;0;1882;0
WireConnection;2326;0;2608;0
WireConnection;2326;1;2327;0
WireConnection;2374;0;2327;0
WireConnection;1599;0;206;0
WireConnection;272;0;315;0
WireConnection;272;1;301;0
WireConnection;1700;0;1603;0
WireConnection;188;0;187;0
WireConnection;188;1;2297;0
WireConnection;188;2;302;0
WireConnection;1679;0;1678;0
WireConnection;1580;0;1467;0
WireConnection;2224;0;2223;0
WireConnection;2224;1;2247;0
WireConnection;2248;0;2221;0
WireConnection;120;0;337;0
WireConnection;592;2;587;0
WireConnection;592;3;589;0
WireConnection;592;4;588;0
WireConnection;592;5;590;0
WireConnection;600;0;607;0
WireConnection;564;0;556;0
WireConnection;564;1;561;0
WireConnection;567;0;563;0
WireConnection;567;1;562;0
WireConnection;620;0;612;0
WireConnection;620;1;617;0
WireConnection;623;0;619;0
WireConnection;623;1;618;0
WireConnection;490;0;482;0
WireConnection;490;1;487;0
WireConnection;493;0;489;0
WireConnection;493;1;488;0
WireConnection;512;0;504;0
WireConnection;512;1;509;0
WireConnection;515;0;511;0
WireConnection;515;1;510;0
WireConnection;1512;0;1511;0
WireConnection;705;0;703;0
WireConnection;705;1;704;0
WireConnection;795;0;793;0
WireConnection;795;1;794;0
WireConnection;842;0;840;0
WireConnection;842;1;841;0
WireConnection;222;0;336;0
WireConnection;2042;0;2046;0
WireConnection;2042;1;2217;0
WireConnection;2041;0;2219;0
WireConnection;2041;1;1883;0
WireConnection;2328;0;2326;0
WireConnection;2375;0;2608;0
WireConnection;2375;1;2374;0
WireConnection;299;0;188;0
WireConnection;299;1;272;0
WireConnection;1600;0;1599;0
WireConnection;1600;1;1601;5
WireConnection;1600;2;1700;0
WireConnection;1572;0;1580;0
WireConnection;1572;1;1679;0
WireConnection;2225;0;2226;0
WireConnection;2225;1;2224;0
WireConnection;2239;0;2223;0
WireConnection;2239;1;2248;0
WireConnection;2254;0;2223;0
WireConnection;2254;1;2253;0
WireConnection;569;2;564;0
WireConnection;569;3;566;0
WireConnection;569;4;565;0
WireConnection;569;5;567;0
WireConnection;601;0;600;0
WireConnection;625;2;620;0
WireConnection;625;3;622;0
WireConnection;625;4;621;0
WireConnection;625;5;623;0
WireConnection;494;2;490;0
WireConnection;494;3;492;0
WireConnection;494;4;491;0
WireConnection;494;5;493;0
WireConnection;517;2;512;0
WireConnection;517;3;514;0
WireConnection;517;4;513;0
WireConnection;517;5;515;0
WireConnection;594;0;592;0
WireConnection;1513;0;1512;0
WireConnection;708;0;795;0
WireConnection;708;1;705;0
WireConnection;708;2;842;0
WireConnection;2040;0;2041;0
WireConnection;2040;1;2042;0
WireConnection;2371;0;2375;0
WireConnection;1598;0;299;0
WireConnection;1598;1;1600;0
WireConnection;1668;0;1666;0
WireConnection;1535;0;1537;0
WireConnection;2583;0;1572;0
WireConnection;2583;1;1495;0
WireConnection;221;0;147;1
WireConnection;2229;0;2228;0
WireConnection;2229;1;2225;0
WireConnection;2265;0;2264;0
WireConnection;2241;0;2240;0
WireConnection;2241;1;2239;0
WireConnection;2261;0;2238;0
WireConnection;2256;0;2255;0
WireConnection;2256;1;2254;0
WireConnection;2262;0;2238;0
WireConnection;604;0;601;0
WireConnection;571;0;569;0
WireConnection;627;0;625;0
WireConnection;495;0;494;0
WireConnection;518;0;517;0
WireConnection;631;0;594;0
WireConnection;1514;0;1513;0
WireConnection;2457;0;708;0
WireConnection;2457;1;2458;0
WireConnection;2048;0;2040;0
WireConnection;358;0;1598;0
WireConnection;1669;0;1668;0
WireConnection;1536;0;1535;0
WireConnection;2590;0;2583;0
WireConnection;1671;0;1668;0
WireConnection;2449;12;2448;0
WireConnection;2284;0;2285;0
WireConnection;2284;1;2450;0
WireConnection;1576;0;1495;0
WireConnection;330;0;221;0
WireConnection;2227;0;2229;0
WireConnection;2227;2;2265;0
WireConnection;2243;0;2261;0
WireConnection;2243;1;2241;0
WireConnection;2258;0;2262;0
WireConnection;2258;1;2256;0
WireConnection;2266;0;2264;0
WireConnection;2267;0;2264;0
WireConnection;2270;0;2269;0
WireConnection;572;0;571;0
WireConnection;572;1;570;0
WireConnection;603;0;604;0
WireConnection;595;0;631;0
WireConnection;595;1;593;0
WireConnection;854;0;627;0
WireConnection;496;0;495;0
WireConnection;519;0;518;0
WireConnection;1515;0;1514;0
WireConnection;1515;1;2457;0
WireConnection;1768;0;2048;0
WireConnection;1687;0;1669;0
WireConnection;2585;0;1536;0
WireConnection;1575;0;2590;0
WireConnection;1575;1;1576;0
WireConnection;1925;0;1671;0
WireConnection;2452;0;2449;0
WireConnection;2453;0;2450;0
WireConnection;2453;1;2451;0
WireConnection;2454;0;2284;0
WireConnection;2454;1;2448;0
WireConnection;310;0;330;0
WireConnection;2235;0;2227;0
WireConnection;2235;1;2270;0
WireConnection;2245;0;2243;0
WireConnection;2245;2;2266;0
WireConnection;2259;0;2258;0
WireConnection;2259;2;2267;0
WireConnection;2271;0;2269;0
WireConnection;2273;0;2269;0
WireConnection;573;0;572;0
WireConnection;628;0;854;0
WireConnection;628;1;626;0
WireConnection;498;0;496;0
WireConnection;498;2;497;0
WireConnection;521;0;519;0
WireConnection;521;2;520;0
WireConnection;606;0;595;0
WireConnection;606;1;603;0
WireConnection;643;0;1515;0
WireConnection;1701;0;1687;0
WireConnection;1574;0;2585;0
WireConnection;1574;1;1575;0
WireConnection;2088;0;1925;0
WireConnection;2601;0;360;0
WireConnection;2601;1;2602;0
WireConnection;2455;0;2453;0
WireConnection;2455;1;2454;0
WireConnection;2455;2;2452;0
WireConnection;155;0;310;0
WireConnection;2236;0;2235;0
WireConnection;2244;0;2245;0
WireConnection;2244;1;2271;0
WireConnection;2260;0;2259;0
WireConnection;2260;1;2273;0
WireConnection;630;0;628;0
WireConnection;574;0;573;0
WireConnection;499;0;498;0
WireConnection;522;0;521;0
WireConnection;597;0;606;0
WireConnection;2695;0;338;0
WireConnection;2695;1;2696;0
WireConnection;1696;0;1574;0
WireConnection;1696;1;1701;0
WireConnection;1922;0;1770;0
WireConnection;1922;1;2088;0
WireConnection;359;0;2455;0
WireConnection;359;1;2601;0
WireConnection;156;0;155;0
WireConnection;2237;0;2236;0
WireConnection;2237;1;2244;0
WireConnection;2237;2;2260;0
WireConnection;549;1;574;0
WireConnection;549;2;630;0
WireConnection;549;3;597;0
WireConnection;1704;0;499;0
WireConnection;1704;1;522;0
WireConnection;2756;0;2695;0
WireConnection;2756;1;2757;0
WireConnection;1771;0;1922;0
WireConnection;1771;1;1912;0
WireConnection;2747;0;359;0
WireConnection;2746;0;1696;0
WireConnection;2748;0;1493;5
WireConnection;1498;0;645;0
WireConnection;158;0;156;0
WireConnection;2246;0;2237;0
WireConnection;550;0;1704;0
WireConnection;550;1;549;0
WireConnection;2758;0;2756;0
WireConnection;2758;2;2759;0
WireConnection;1910;0;1771;0
WireConnection;1910;1;1911;0
WireConnection;2745;0;2747;0
WireConnection;2745;1;2748;0
WireConnection;2745;2;2746;0
WireConnection;1499;0;1498;0
WireConnection;305;0;158;0
WireConnection;305;1;306;0
WireConnection;2896;0;2891;0
WireConnection;2896;1;2897;0
WireConnection;405;0;550;0
WireConnection;2883;12;2758;0
WireConnection;1913;0;2745;0
WireConnection;1913;1;1910;0
WireConnection;1504;0;1502;0
WireConnection;1504;1;1499;0
WireConnection;1505;0;1499;0
WireConnection;1505;1;1503;0
WireConnection;307;0;305;0
WireConnection;307;1;308;0
WireConnection;2468;0;2467;0
WireConnection;2480;0;2481;0
WireConnection;2274;0;2252;0
WireConnection;2274;1;2275;0
WireConnection;2894;0;2896;0
WireConnection;1739;0;409;0
WireConnection;2884;0;2883;0
WireConnection;2718;0;1913;0
WireConnection;2718;1;1504;0
WireConnection;2718;2;1505;0
WireConnection;357;0;2758;0
WireConnection;312;0;307;0
WireConnection;2469;0;2468;0
WireConnection;2469;1;2480;0
WireConnection;2318;0;2274;0
WireConnection;2318;1;2319;0
WireConnection;2895;0;2894;0
WireConnection;2895;2;2892;0
WireConnection;408;0;407;0
WireConnection;408;1;1739;0
WireConnection;2761;0;2884;0
WireConnection;2761;1;2762;0
WireConnection;352;0;2718;0
WireConnection;352;1;357;0
WireConnection;2470;0;2469;0
WireConnection;2890;0;2318;0
WireConnection;2890;1;2895;0
WireConnection;2760;0;408;0
WireConnection;2760;1;2761;0
WireConnection;2251;0;352;0
WireConnection;2251;1;2890;0
WireConnection;2489;0;314;0
WireConnection;2479;0;2470;0
WireConnection;2477;0;2479;0
WireConnection;2879;0;2489;0
WireConnection;2886;0;2251;0
WireConnection;2886;1;2760;0
WireConnection;365;1;364;0
WireConnection;457;1;456;0
WireConnection;2478;0;2477;0
WireConnection;2478;1;2482;0
WireConnection;2488;0;2886;0
WireConnection;2488;1;2879;0
WireConnection;366;0;365;0
WireConnection;392;0;414;1
WireConnection;392;1;414;2
WireConnection;459;0;457;0
WireConnection;460;0;458;1
WireConnection;460;1;458;2
WireConnection;2476;0;2488;0
WireConnection;2476;1;2478;0
WireConnection;2740;0;2742;0
WireConnection;367;1;366;0
WireConnection;393;0;392;0
WireConnection;393;1;394;0
WireConnection;462;1;459;0
WireConnection;463;0;460;0
WireConnection;463;1;461;0
WireConnection;2704;0;2476;0
WireConnection;2741;0;2703;0
WireConnection;2741;1;2740;0
WireConnection;368;0;365;0
WireConnection;368;1;367;0
WireConnection;395;0;396;0
WireConnection;395;1;393;0
WireConnection;465;0;457;0
WireConnection;465;1;462;0
WireConnection;468;0;464;0
WireConnection;468;1;463;0
WireConnection;2713;0;2704;2
WireConnection;2705;0;2704;1
WireConnection;2705;1;2741;0
WireConnection;398;2;368;0
WireConnection;398;3;412;0
WireConnection;398;4;413;0
WireConnection;398;5;395;0
WireConnection;470;2;465;0
WireConnection;470;3;467;0
WireConnection;470;4;466;0
WireConnection;470;5;468;0
WireConnection;2829;0;1678;0
WireConnection;2843;0;1505;0
WireConnection;2710;0;2704;3
WireConnection;2889;0;2283;0
WireConnection;2889;1;2713;0
WireConnection;399;0;398;0
WireConnection;471;0;470;0
WireConnection;2711;0;2705;0
WireConnection;2711;1;2889;0
WireConnection;2711;2;2710;0
WireConnection;2851;12;2848;0
WireConnection;472;0;471;0
WireConnection;400;0;399;0
WireConnection;2564;12;2560;0
WireConnection;2571;0;2711;0
WireConnection;2835;0;2834;0
WireConnection;2835;2;2836;0
WireConnection;2852;0;2851;0
WireConnection;2860;12;2859;0
WireConnection;2844;0;2840;0
WireConnection;401;0;400;0
WireConnection;401;2;402;0
WireConnection;474;0;472;0
WireConnection;474;2;473;0
WireConnection;2565;0;2564;0
WireConnection;2837;0;2835;0
WireConnection;2849;0;2852;0
WireConnection;2861;0;2860;0
WireConnection;2841;0;2844;0
WireConnection;2841;2;2842;0
WireConnection;2880;0;2571;0
WireConnection;2880;1;1529;0
WireConnection;2588;0;1696;0
WireConnection;2588;1;2589;0
WireConnection;476;0;401;0
WireConnection;475;0;474;0
WireConnection;1548;0;1553;0
WireConnection;2466;0;2465;0
WireConnection;2790;0;2794;0
WireConnection;2566;0;2565;0
WireConnection;2831;0;2880;0
WireConnection;2831;1;2837;0
WireConnection;2856;0;2861;0
WireConnection;2846;0;2849;0
WireConnection;2846;2;2847;0
WireConnection;2839;0;2841;0
WireConnection;2586;0;1910;0
WireConnection;2586;1;2588;0
WireConnection;2586;2;2448;0
WireConnection;2615;0;2604;0
WireConnection;2615;1;2318;0
WireConnection;452;0;476;0
WireConnection;452;1;475;0
WireConnection;2563;0;2566;0
WireConnection;2563;1;2438;2
WireConnection;1549;0;1548;0
WireConnection;1549;1;2466;0
WireConnection;2789;0;2790;0
WireConnection;2845;0;2846;0
WireConnection;2838;0;2839;0
WireConnection;2838;1;2831;0
WireConnection;2855;0;2856;0
WireConnection;2855;2;2858;0
WireConnection;2864;0;2863;0
WireConnection;2603;0;2586;0
WireConnection;2603;1;2451;0
WireConnection;2616;0;2615;0
WireConnection;1703;0;452;0
WireConnection;2572;0;2563;0
WireConnection;2572;1;2459;0
WireConnection;2317;0;1549;0
WireConnection;2801;0;2789;0
WireConnection;2850;0;2845;0
WireConnection;2850;1;2838;0
WireConnection;2854;0;2855;0
WireConnection;2866;0;2865;0
WireConnection;2866;2;2864;0
WireConnection;2605;0;2603;0
WireConnection;2605;1;2601;0
WireConnection;2605;2;2616;0
WireConnection;2555;0;2556;0
WireConnection;2555;1;2572;0
WireConnection;2555;2;2557;0
WireConnection;2555;4;2572;0
WireConnection;1560;12;2605;0
WireConnection;2320;0;2317;0
WireConnection;2802;0;2801;0
WireConnection;2853;0;2850;0
WireConnection;2853;1;2854;0
WireConnection;2867;0;2866;0
WireConnection;1738;0;1737;0
WireConnection;2874;0;2804;2
WireConnection;2558;0;2555;0
WireConnection;1558;0;1560;0
WireConnection;2286;0;1697;0
WireConnection;2286;1;2287;0
WireConnection;1556;0;2320;0
WireConnection;2309;0;2307;0
WireConnection;2803;0;2802;0
WireConnection;2803;1;2874;0
WireConnection;1736;0;1706;0
WireConnection;1736;1;1738;0
WireConnection;2862;0;2853;0
WireConnection;2862;1;2867;0
WireConnection;2873;0;2804;1
WireConnection;2568;0;2558;0
WireConnection;1698;0;1558;0
WireConnection;1698;1;2286;0
WireConnection;1554;0;1556;0
WireConnection;1554;1;2309;0
WireConnection;2805;0;2873;0
WireConnection;2805;1;2803;0
WireConnection;1705;0;2862;0
WireConnection;1705;1;1736;0
WireConnection;2872;0;1531;0
WireConnection;2439;0;2568;0
WireConnection;2439;1;1705;0
WireConnection;2288;0;1698;0
WireConnection;1557;0;1554;0
WireConnection;2806;1;2807;0
WireConnection;2806;2;2872;0
WireConnection;2806;4;2805;0
WireConnection;2464;0;2439;0
WireConnection;2464;1;2806;0
WireConnection;1550;0;2288;0
WireConnection;1550;1;1557;0
WireConnection;1528;1;2571;0
WireConnection;1528;0;1529;0
WireConnection;2624;0;2464;0
WireConnection;529;1;528;0
WireConnection;531;0;529;0
WireConnection;532;0;530;1
WireConnection;532;1;530;2
WireConnection;534;1;531;0
WireConnection;535;0;532;0
WireConnection;535;1;533;0
WireConnection;537;0;529;0
WireConnection;537;1;534;0
WireConnection;540;0;536;0
WireConnection;540;1;535;0
WireConnection;542;2;537;0
WireConnection;542;3;539;0
WireConnection;542;4;538;0
WireConnection;542;5;540;0
WireConnection;547;0;542;0
WireConnection;546;0;547;0
WireConnection;546;1;545;0
WireConnection;551;0;546;0
WireConnection;548;0;551;0
WireConnection;2279;0;1557;0
WireConnection;2279;1;1550;0
WireConnection;2279;2;2281;0
WireConnection;1506;0;1496;0
WireConnection;1496;0;1500;0
WireConnection;1387;0;1377;0
WireConnection;1388;0;1378;0
WireConnection;1391;0;1387;0
WireConnection;1392;0;1388;0
WireConnection;1390;0;1380;0
WireConnection;1394;0;1390;0
WireConnection;1192;0;1188;0
WireConnection;1189;0;1192;0
WireConnection;1163;0;1159;0
WireConnection;1156;0;1114;0
WireConnection;1224;0;1220;0
WireConnection;1389;0;1379;0
WireConnection;1393;0;1389;0
WireConnection;1160;0;1163;0
WireConnection;1221;0;1224;0
WireConnection;1118;0;1156;0
WireConnection;0;2;2624;0
WireConnection;0;9;2279;0
ASEEND*/
//CHKSM=780FC801938FC1161A6B7EC4CA1745FE7F0EF6CE