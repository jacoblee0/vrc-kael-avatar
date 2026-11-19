// Made with Amplify Shader Editor v1.9.8.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "RoboCap/Butterflies"
{
	Properties
	{
		_FlapStetch("Flap Strength", Float) = 0.01
		_Flappingspeed("Flapping speed", Float) = 1
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_BaseColor("Base Color", Color) = (1,1,1)
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_TextureSample2("Texture Sample 2", 2D) = "white" {}
		[Toggle(_EMISSIONUSEBASECOLOR_ON)] _EmissionUseBaseColor("Emission Use BaseColor", Float) = 0
		_EmissionStrength("Emission Strength", Float) = 0
		_EmissionColor("Emission Color", Color) = (1,1,1)
		_Alphaamount("Alpha amount", Float) = 1
		_Flapwidth("Flap width", Float) = 1.4
		_WingtoBodySmoothness("Wing to Body Smoothness", Range( 0 , 1)) = 0.5
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		Blend SrcAlpha OneMinusSrcAlpha , SrcAlpha OneMinusSrcAlpha
		
		AlphaToMask On
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.5
		#pragma dynamic_branch _EMISSIONUSEBASECOLOR_ON
		#define ASE_VERSION 19801
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform float _Flappingspeed;
		uniform float _Flapwidth;
		uniform float _FlapStetch;
		uniform float _WingtoBodySmoothness;
		uniform sampler2D _TextureSample1;
		uniform float4 _TextureSample1_ST;
		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform float3 _BaseColor;
		uniform sampler2D _TextureSample2;
		uniform float4 _TextureSample2_ST;
		uniform float3 _EmissionColor;
		uniform float _EmissionStrength;
		uniform float _Alphaamount;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float temp_output_148_0 = ( _Flappingspeed * (0.5 + (v.texcoord1.xy.y - 0.0) * (10.0 - 0.5) / (1.0 - 0.0)) );
			float temp_output_40_0 = sin( temp_output_148_0 );
			float temp_output_52_0 = saturate( ( ( 1.0 - v.texcoord.xy.x ) - 0.5 ) );
			float temp_output_53_0 = saturate( ( v.texcoord.xy.x - 0.5 ) );
			float lerpResult55 = lerp( temp_output_52_0 , temp_output_53_0 , 0.5);
			float temp_output_58_0 = ( pow( lerpResult55 , _Flapwidth ) * _FlapStetch );
			float3 appendResult44 = (float3(0.0 , (( temp_output_58_0 * -1.0 ) + (0.0 - 0.0) * (temp_output_58_0 - ( temp_output_58_0 * -1.0 )) / (1.0 - 0.0)) , 0.0));
			float3 appendResult84 = (float3(0.0 , 0.0 , 0.0));
			float lerpResult175 = lerp( ( 1.0 - temp_output_52_0 ) , ( 1.0 - temp_output_53_0 ) , 0.5);
			float3 appendResult177 = (float3(0.0 , ( pow( saturate( pow( lerpResult175 , ( _Flapwidth * 25.0 ) ) ) , _WingtoBodySmoothness ) * ( _FlapStetch * 0.01 ) ) , 0.0));
			float3 ase_positionWS = mul( unity_ObjectToWorld, v.vertex );
			float3 ase_positionOS = v.vertex.xyz;
			v.vertex.xyz += ( ( ( ( temp_output_40_0 * appendResult44 ) + ( ( cos( ( 0.0 * ( temp_output_148_0 * 2.0 ) ) ) * appendResult84 ) + ( temp_output_40_0 * appendResult177 ) ) ) - ase_positionWS ) + ase_positionOS );
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TextureSample1 = i.uv_texcoord * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
			o.Normal = tex2D( _TextureSample1, uv_TextureSample1 ).rgb;
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float4 tex2DNode60 = tex2D( _TextureSample0, uv_TextureSample0 );
			o.Albedo = ( ( tex2DNode60 * float4( _BaseColor , 0.0 ) ) * i.vertexColor ).rgb;
			float2 uv_TextureSample2 = i.uv_texcoord * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
			float4 dynamicSwitch63 = ( float4 )0;
			UNITY_BRANCH if ( _EMISSIONUSEBASECOLOR_ON )
			{
				dynamicSwitch63 = tex2DNode60;
			}
			else
			{
				dynamicSwitch63 = tex2D( _TextureSample2, uv_TextureSample2 );
			}
			o.Emission = ( ( ( dynamicSwitch63 * float4( _EmissionColor , 0.0 ) ) * _EmissionStrength ) * i.vertexColor ).rgb;
			o.Alpha = ( ( tex2DNode60.a * _Alphaamount ) * i.vertexColor.a );
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			AlphaToMask Off
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.5
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
				half4 color : COLOR0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				o.color = v.color;
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.vertexColor = IN.color;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19801
Node;AmplifyShaderEditor.TextureCoordinatesNode;8;-4544,1408;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;49;-4240,1376;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;50;-4080,1344;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;48;-4080,1552;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;52;-3872,1344;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;53;-3872,1552;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;72;-3584,1680;Inherit;False;Property;_Flapwidth;Flap width;11;0;Create;True;0;0;0;False;0;False;1.4;1.4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;174;-4080,848;Inherit;True;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;173;-4080,640;Inherit;True;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;160;-3040,192;Inherit;False;1;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;175;-3756.947,756.3101;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;180;-3597.907,1028.109;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;25;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;55;-3632,1440;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;38;-2736,128;Inherit;False;Property;_Flappingspeed;Flapping speed;1;0;Create;True;0;0;0;False;0;False;1;8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;162;-2704,240;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0.5;False;4;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;176;-3504,752;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;50;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;56;-3344,1440;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;148;-2400,224;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;59;-3328,1360;Inherit;False;Property;_FlapStetch;Flap Strength;0;0;Create;False;0;0;0;False;0;False;0.01;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;183;-3232,752;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;187;-3536,640;Inherit;False;Property;_WingtoBodySmoothness;Wing to Body Smoothness;12;0;Create;True;0;0;0;False;0;False;0.5;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;58;-3024,1440;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;95;-2176,368;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;191;-3056,640;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;179;-3200,880;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.01;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-2656,1488;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;87;-1984,368;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;178;-2720,752;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;20;-2352,1440;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;40;-1824,192;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;94;-1808,384;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;84;-2048,544;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;177;-1776,704;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;60;-1760,-1472;Inherit;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;0;False;0;False;-1;None;da7fe2e3c4e2ffb4da429e421ab21ef7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode;62;-2032,-688;Inherit;True;Property;_TextureSample2;Texture Sample 2;6;0;Create;True;0;0;0;False;0;False;-1;None;da7fe2e3c4e2ffb4da429e421ab21ef7;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.DynamicAppendNode;44;-1488,912;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;86;-1696,480;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;171;-1520,656;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;63;-1408,-400;Inherit;False;Property;_EmissionUseBaseColor;Emission Use BaseColor;7;0;Create;True;0;0;0;False;0;False;2;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;69;-1280,-544;Inherit;False;Property;_EmissionColor;Emission Color;9;0;Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;False;0;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-1232,832;Inherit;True;2;2;0;FLOAT;0.1;False;1;FLOAT3;0.01,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;172;-1224.681,583.3771;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;67;-1376,-1584;Inherit;False;Property;_BaseColor;Base Color;4;0;Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;False;0;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;68;-992,-368;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;65;-1056,-448;Inherit;False;Property;_EmissionStrength;Emission Strength;8;0;Create;True;0;0;0;False;0;False;0;1.91;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;92;-672,576;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldPosInputsNode;138;-832,880;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;71;-688,144;Inherit;False;Property;_Alphaamount;Alpha amount;10;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;-1168,-1248;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;-768,-240;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;166;-923.6008,-46.61023;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;168;-400,-608;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;139;-528,640;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PosVertexDataNode;133;-432,864;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;169;-416,176;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;70;-448,48;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;83;-3888,1264;Inherit;False;Constant;_Float0;Float 0;12;0;Create;True;0;0;0;False;0;False;1.7;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;81;-3664,1184;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;82;-3584,1296;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;79;-3408,1072;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;78;-3168,1184;Inherit;False;2;2;0;FLOAT;0.12;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;-2960,992;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;61;-2016,-1056;Inherit;True;Property;_TextureSample1;Texture Sample 1;5;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;165;-569.6008,-62.61023;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;167;-240,-224;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;170;-197.6008,155.3898;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;41;-336,688;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;0;Standard;RoboCap/Butterflies;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;;0;False;;False;0;False;;0;False;;False;0;Custom;0.5;True;True;0;True;Transparent;;AlphaTest;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;2;5;False;;10;False;;2;5;False;;10;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;3;-1;-1;-1;0;True;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;49;0;8;1
WireConnection;50;0;49;0
WireConnection;48;0;8;1
WireConnection;52;0;50;0
WireConnection;53;0;48;0
WireConnection;174;1;53;0
WireConnection;173;1;52;0
WireConnection;175;0;173;0
WireConnection;175;1;174;0
WireConnection;180;0;72;0
WireConnection;55;0;52;0
WireConnection;55;1;53;0
WireConnection;162;0;160;2
WireConnection;176;0;175;0
WireConnection;176;1;180;0
WireConnection;56;0;55;0
WireConnection;56;1;72;0
WireConnection;148;0;38;0
WireConnection;148;1;162;0
WireConnection;183;0;176;0
WireConnection;58;0;56;0
WireConnection;58;1;59;0
WireConnection;95;0;148;0
WireConnection;191;0;183;0
WireConnection;191;1;187;0
WireConnection;179;0;59;0
WireConnection;21;0;58;0
WireConnection;87;1;95;0
WireConnection;178;0;191;0
WireConnection;178;1;179;0
WireConnection;20;3;21;0
WireConnection;20;4;58;0
WireConnection;40;0;148;0
WireConnection;94;0;87;0
WireConnection;177;1;178;0
WireConnection;44;1;20;0
WireConnection;86;0;94;0
WireConnection;86;1;84;0
WireConnection;171;0;40;0
WireConnection;171;1;177;0
WireConnection;63;1;62;0
WireConnection;63;0;60;0
WireConnection;32;0;40;0
WireConnection;32;1;44;0
WireConnection;172;0;86;0
WireConnection;172;1;171;0
WireConnection;68;0;63;0
WireConnection;68;1;69;0
WireConnection;92;0;32;0
WireConnection;92;1;172;0
WireConnection;66;0;60;0
WireConnection;66;1;67;0
WireConnection;64;0;68;0
WireConnection;64;1;65;0
WireConnection;139;0;92;0
WireConnection;139;1;138;0
WireConnection;70;0;60;4
WireConnection;70;1;71;0
WireConnection;81;0;52;0
WireConnection;81;1;83;0
WireConnection;82;0;53;0
WireConnection;82;1;83;0
WireConnection;79;0;81;0
WireConnection;79;1;82;0
WireConnection;78;1;59;0
WireConnection;73;0;79;0
WireConnection;73;1;78;0
WireConnection;165;0;64;0
WireConnection;165;1;166;0
WireConnection;167;0;66;0
WireConnection;167;1;168;0
WireConnection;170;0;70;0
WireConnection;170;1;169;4
WireConnection;41;0;139;0
WireConnection;41;1;133;0
WireConnection;0;0;167;0
WireConnection;0;1;61;0
WireConnection;0;2;165;0
WireConnection;0;9;170;0
WireConnection;0;11;41;0
ASEEND*/
//CHKSM=9856897548F4BDACC2F1198ECBC2F2965125F5B9