// Made with Amplify Shader Editor v1.9.8.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "RoboCap/Flowers"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
		_Intensity("Intensity", Float) = 1
		_XZDistortion("XZ Distortion", Float) = 1
		_YDistortion("Y Distortion", Float) = 1
		[ToggleUI]_IsonParticle("Is on Particle", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		ZWrite Off
		Blend SrcAlpha One
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.5
		#define ASE_VERSION 19801
		#pragma surface surf Standard keepalpha noshadow vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
		};

		uniform float _IsonParticle;
		uniform float _XZDistortion;
		uniform float _YDistortion;
		uniform float4 _Color;
		uniform float _Intensity;


		float3 mod3D289( float3 x ) { return x - floor( x / 289.0 ) * 289.0; }

		float4 mod3D289( float4 x ) { return x - floor( x / 289.0 ) * 289.0; }

		float4 permute( float4 x ) { return mod3D289( ( x * 34.0 + 1.0 ) * x ); }

		float4 taylorInvSqrt( float4 r ) { return 1.79284291400159 - r * 0.85373472095314; }

		float snoise( float3 v )
		{
			const float2 C = float2( 1.0 / 6.0, 1.0 / 3.0 );
			float3 i = floor( v + dot( v, C.yyy ) );
			float3 x0 = v - i + dot( i, C.xxx );
			float3 g = step( x0.yzx, x0.xyz );
			float3 l = 1.0 - g;
			float3 i1 = min( g.xyz, l.zxy );
			float3 i2 = max( g.xyz, l.zxy );
			float3 x1 = x0 - i1 + C.xxx;
			float3 x2 = x0 - i2 + C.yyy;
			float3 x3 = x0 - 0.5;
			i = mod3D289( i);
			float4 p = permute( permute( permute( i.z + float4( 0.0, i1.z, i2.z, 1.0 ) ) + i.y + float4( 0.0, i1.y, i2.y, 1.0 ) ) + i.x + float4( 0.0, i1.x, i2.x, 1.0 ) );
			float4 j = p - 49.0 * floor( p / 49.0 );  // mod(p,7*7)
			float4 x_ = floor( j / 7.0 );
			float4 y_ = floor( j - 7.0 * x_ );  // mod(j,N)
			float4 x = ( x_ * 2.0 + 0.5 ) / 7.0 - 1.0;
			float4 y = ( y_ * 2.0 + 0.5 ) / 7.0 - 1.0;
			float4 h = 1.0 - abs( x ) - abs( y );
			float4 b0 = float4( x.xy, y.xy );
			float4 b1 = float4( x.zw, y.zw );
			float4 s0 = floor( b0 ) * 2.0 + 1.0;
			float4 s1 = floor( b1 ) * 2.0 + 1.0;
			float4 sh = -step( h, 0.0 );
			float4 a0 = b0.xzyw + s0.xzyw * sh.xxyy;
			float4 a1 = b1.xzyw + s1.xzyw * sh.zzww;
			float3 g0 = float3( a0.xy, h.x );
			float3 g1 = float3( a0.zw, h.y );
			float3 g2 = float3( a1.xy, h.z );
			float3 g3 = float3( a1.zw, h.w );
			float4 norm = taylorInvSqrt( float4( dot( g0, g0 ), dot( g1, g1 ), dot( g2, g2 ), dot( g3, g3 ) ) );
			g0 *= norm.x;
			g1 *= norm.y;
			g2 *= norm.z;
			g3 *= norm.w;
			float4 m = max( 0.6 - float4( dot( x0, x0 ), dot( x1, x1 ), dot( x2, x2 ), dot( x3, x3 ) ), 0.0 );
			m = m* m;
			m = m* m;
			float4 px = float4( dot( x0, g0 ), dot( x1, g1 ), dot( x2, g2 ), dot( x3, g3 ) );
			return 42.0 * dot( m, px);
		}


		//https://www.shadertoy.com/view/XdXGW8
		float2 GradientNoiseDir( float2 x )
		{
			const float2 k = float2( 0.3183099, 0.3678794 );
			x = x * k + k.yx;
			return -1.0 + 2.0 * frac( 16.0 * k * frac( x.x * x.y * ( x.x + x.y ) ) );
		}
		
		float GradientNoise( float2 UV, float Scale )
		{
			float2 p = UV * Scale;
			float2 i = floor( p );
			float2 f = frac( p );
			float2 u = f * f * ( 3.0 - 2.0 * f );
			return lerp( lerp( dot( GradientNoiseDir( i + float2( 0.0, 0.0 ) ), f - float2( 0.0, 0.0 ) ),
					dot( GradientNoiseDir( i + float2( 1.0, 0.0 ) ), f - float2( 1.0, 0.0 ) ), u.x ),
					lerp( dot( GradientNoiseDir( i + float2( 0.0, 1.0 ) ), f - float2( 0.0, 1.0 ) ),
					dot( GradientNoiseDir( i + float2( 1.0, 1.0 ) ), f - float2( 1.0, 1.0 ) ), u.x ), u.y );
		}


		float2 voronoihash133( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi133( float2 v, float time, inout float2 id, inout float2 mr, float smoothness, inout float2 smoothId )
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
			 		float2 o = voronoihash133( n + g );
					o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = f - g - o;
					float d = 0.805 * pow( ( pow( abs( r.x ), 3.19 ) + pow( abs( r.y ), 3.19 ) ), 0.313 );
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


		float2 voronoihash163( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi163( float2 v, float time, inout float2 id, inout float2 mr, float smoothness, inout float2 smoothId )
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
			 		float2 o = voronoihash163( n + g );
					o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = f - g - o;
					float d = 0.805 * pow( ( pow( abs( r.x ), 3.19 ) + pow( abs( r.y ), 3.19 ) ), 0.313 );
			 		if( d<F1 ) {
			 			F2 = F1;
			 			F1 = d; mg = g; mr = r; id = o;
			 		} else if( d<F2 ) {
			 			F2 = d;
			
			 		}
			 	}
			}
			return (F2 + F1) * 0.5;
		}


		float2 voronoihash204( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi204( float2 v, float time, inout float2 id, inout float2 mr, float smoothness, inout float2 smoothId )
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
			 		float2 o = voronoihash204( n + g );
					o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = f - g - o;
					float d = 0.805 * pow( ( pow( abs( r.x ), 3.19 ) + pow( abs( r.y ), 3.19 ) ), 0.313 );
			 		if( d<F1 ) {
			 			F2 = F1;
			 			F1 = d; mg = g; mr = r; id = o;
			 		} else if( d<F2 ) {
			 			F2 = d;
			
			 		}
			 	}
			}
			return (F2 + F1) * 0.5;
		}


		float2 voronoihash256( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi256( float2 v, float time, inout float2 id, inout float2 mr, float smoothness, inout float2 smoothId )
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
			 		float2 o = voronoihash256( n + g );
					o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = f - g - o;
					float d = 0.805 * pow( ( pow( abs( r.x ), 3.19 ) + pow( abs( r.y ), 3.19 ) ), 0.313 );
			 		if( d<F1 ) {
			 			F2 = F1;
			 			F1 = d; mg = g; mr = r; id = o;
			 		} else if( d<F2 ) {
			 			F2 = d;
			
			 		}
			 	}
			}
			return (F2 + F1) * 0.5;
		}


		float2 voronoihash255( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi255( float2 v, float time, inout float2 id, inout float2 mr, float smoothness, inout float2 smoothId )
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
			 		float2 o = voronoihash255( n + g );
					o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = f - g - o;
					float d = 0.805 * pow( ( pow( abs( r.x ), 3.19 ) + pow( abs( r.y ), 3.19 ) ), 0.313 );
			 		if( d<F1 ) {
			 			F2 = F1;
			 			F1 = d; mg = g; mr = r; id = o;
			 		} else if( d<F2 ) {
			 			F2 = d;
			
			 		}
			 	}
			}
			return (F2 + F1) * 0.5;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 appendResult339 = (float2(( 0.15 * _Time.y ) , ( 0.2 * _Time.y )));
			float simplePerlin3D342 = snoise( float3( ( ( v.texcoord.xy + appendResult339 ) * float2( 1,1 ) ) ,  0.0 ) );
			float3 appendResult386 = (float3(simplePerlin3D342 , 0.0 , 0.0));
			float2 appendResult355 = (float2(( -0.15 * _Time.y ) , ( 0.2 * _Time.y )));
			float simplePerlin3D358 = snoise( float3( ( ( v.texcoord.xy + appendResult355 ) * float2( 1,1 ) ) ,  0.0 ) );
			float3 appendResult394 = (float3(0.0 , 0.0 , simplePerlin3D358));
			float3 lerpResult395 = lerp( appendResult386 , appendResult394 , float3( 0.5,0,0.5 ));
			float2 appendResult366 = (float2(( -0.15 * _Time.y ) , ( 0.2 * _Time.y )));
			float simplePerlin3D370 = snoise( float3( ( ( v.texcoord.xy + appendResult366 ) * float2( 1,1 ) ) ,  0.0 ) );
			simplePerlin3D370 = simplePerlin3D370*0.5 + 0.5;
			float3 appendResult385 = (float3(0.0 , simplePerlin3D370 , 0.0));
			float3 temp_output_346_0 = ( ( ( ( lerpResult395 * _XZDistortion ) + ( appendResult385 * _YDistortion ) ) * ( pow( v.texcoord.xy.y , 2.5 ) * 0.5 ) ) * float3( 0.01,0.01,0.01 ) );
			float3 ase_positionWS = mul( unity_ObjectToWorld, v.vertex );
			float3 ase_positionOS = v.vertex.xyz;
			v.vertex.xyz += ( ( (( _IsonParticle )?( 0.0 ):( 1.0 )) * temp_output_346_0 ) + ( ( 1.0 - (( _IsonParticle )?( 0.0 ):( 1.0 )) ) * ( ( temp_output_346_0 - ase_positionWS ) + ase_positionOS ) ) );
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float blendOpSrc33 = i.uv_texcoord.x;
			float blendOpDest33 = 0.5;
			float2 appendResult66 = (float2(1.0 , ( 0.2 * ( 1.0 - _Time.y ) )));
			float gradientNoise45 = GradientNoise(( ( i.uv_texcoord + appendResult66 ) * float2( 1,0.3 ) ),5.0);
			gradientNoise45 = gradientNoise45*0.5 + 0.5;
			float saferPower47 = abs( gradientNoise45 );
			float saferPower100 = abs( ( ( 1.0 - i.uv_texcoord.y ) / 2.0 ) );
			float temp_output_102_0 = ( saturate( pow( saferPower100 , 3.0 ) ) * 10.0 );
			float2 appendResult141 = (float2(1.0 , ( 0.1 * _Time.y )));
			float simplePerlin3D129 = snoise( float3( ( ( i.uv_texcoord + appendResult141 ) * float2( 1,0.4 ) ) ,  0.0 )*3.0 );
			simplePerlin3D129 = simplePerlin3D129*0.5 + 0.5;
			float time133 = 0.0;
			float2 voronoiSmoothId133 = 0;
			float2 appendResult126 = (float2(1.0 , ( 0.2 * ( 1.0 - _Time.y ) )));
			float2 coords133 = ( ( i.uv_texcoord + appendResult126 ) * float2( 1,0.4 ) ) * 3.0;
			float2 id133 = 0;
			float2 uv133 = 0;
			float fade133 = 0.5;
			float voroi133 = 0;
			float rest133 = 0;
			for( int it133 = 0; it133 <2; it133++ ){
			voroi133 += fade133 * voronoi133( coords133, time133, id133, uv133, 0,voronoiSmoothId133 );
			rest133 += fade133;
			coords133 *= 2;
			fade133 *= 0.5;
			}//Voronoi133
			voroi133 /= rest133;
			float saferPower130 = abs( voroi133 );
			float saferPower182 = abs( ( ( 1.0 - i.uv_texcoord.y ) / 3.0 ) );
			float2 appendResult160 = (float2(( 0.15 * _Time.y ) , ( 0.2 * _Time.y )));
			float simplePerlin3D166 = snoise( float3( ( ( i.uv_texcoord + appendResult160 ) * float2( 1,0.4 ) ) ,  0.0 )*2.0 );
			simplePerlin3D166 = simplePerlin3D166*0.5 + 0.5;
			float time163 = 0.0;
			float2 voronoiSmoothId163 = 0;
			float2 appendResult156 = (float2(1.0 , ( 0.3 * ( 1.0 - _Time.y ) )));
			float2 coords163 = ( ( i.uv_texcoord + appendResult156 ) * float2( 1,0.4 ) ) * 4.0;
			float2 id163 = 0;
			float2 uv163 = 0;
			float fade163 = 0.5;
			float voroi163 = 0;
			float rest163 = 0;
			for( int it163 = 0; it163 <2; it163++ ){
			voroi163 += fade163 * voronoi163( coords163, time163, id163, uv163, 0,voronoiSmoothId163 );
			rest163 += fade163;
			coords163 *= 2;
			fade163 *= 0.5;
			}//Voronoi163
			voroi163 /= rest163;
			float saferPower165 = abs( voroi163 );
			float saferPower206 = abs( ( ( 1.0 - i.uv_texcoord.y ) / 3.0 ) );
			float2 appendResult198 = (float2(( -0.15 * _Time.y ) , ( 0.2 * _Time.y )));
			float simplePerlin3D207 = snoise( float3( ( ( i.uv_texcoord + appendResult198 ) * float2( 1,0.4 ) ) ,  0.0 )*2.0 );
			simplePerlin3D207 = simplePerlin3D207*0.5 + 0.5;
			float time204 = 0.0;
			float2 voronoiSmoothId204 = 0;
			float2 appendResult193 = (float2(1.0 , ( 0.3 * ( 1.0 - _Time.y ) )));
			float2 coords204 = ( ( i.uv_texcoord + appendResult193 ) * float2( 1,0.4 ) ) * 4.0;
			float2 id204 = 0;
			float2 uv204 = 0;
			float fade204 = 0.5;
			float voroi204 = 0;
			float rest204 = 0;
			for( int it204 = 0; it204 <2; it204++ ){
			voroi204 += fade204 * voronoi204( coords204, time204, id204, uv204, 0,voronoiSmoothId204 );
			rest204 += fade204;
			coords204 *= 2;
			fade204 *= 0.5;
			}//Voronoi204
			voroi204 /= rest204;
			float saferPower205 = abs( voroi204 );
			float lerpResult214 = lerp( ( ( saturate( pow( saferPower182 , 2.5 ) ) * 100.0 ) * ( pow( simplePerlin3D166 , 3.0 ) * ( pow( saferPower165 , 5.0 ) * 10.0 ) ) ) , ( ( saturate( pow( saferPower206 , 2.5 ) ) * 100.0 ) * ( pow( simplePerlin3D207 , 3.0 ) * ( pow( saferPower205 , 5.0 ) * 10.0 ) ) ) , 0.5);
			float saferPower258 = abs( ( ( 1.0 - i.uv_texcoord.y ) / 3.0 ) );
			float2 appendResult242 = (float2(( 0.05 * _Time.y ) , ( 0.1 * _Time.y )));
			float simplePerlin3D259 = snoise( float3( ( ( i.uv_texcoord + appendResult242 ) * float2( 1,0.4 ) ) ,  0.0 )*3.0 );
			simplePerlin3D259 = simplePerlin3D259*0.5 + 0.5;
			float time256 = 0.0;
			float2 voronoiSmoothId256 = 0;
			float2 appendResult233 = (float2(1.0 , ( 0.2 * ( 1.0 - _Time.y ) )));
			float2 coords256 = ( ( i.uv_texcoord + appendResult233 ) * float2( 1,0.4 ) ) * 5.0;
			float2 id256 = 0;
			float2 uv256 = 0;
			float fade256 = 0.5;
			float voroi256 = 0;
			float rest256 = 0;
			for( int it256 = 0; it256 <2; it256++ ){
			voroi256 += fade256 * voronoi256( coords256, time256, id256, uv256, 0,voronoiSmoothId256 );
			rest256 += fade256;
			coords256 *= 2;
			fade256 *= 0.5;
			}//Voronoi256
			voroi256 /= rest256;
			float saferPower257 = abs( voroi256 );
			float saferPower261 = abs( ( ( 1.0 - i.uv_texcoord.y ) / 3.0 ) );
			float2 appendResult244 = (float2(( -0.05 * _Time.y ) , ( 0.1 * _Time.y )));
			float simplePerlin3D262 = snoise( float3( ( ( i.uv_texcoord + appendResult244 ) * float2( 1,0.4 ) ) ,  0.0 )*3.0 );
			simplePerlin3D262 = simplePerlin3D262*0.5 + 0.5;
			float time255 = 0.0;
			float2 voronoiSmoothId255 = 0;
			float2 appendResult237 = (float2(1.0 , ( 0.2 * ( 1.0 - _Time.y ) )));
			float2 coords255 = ( ( i.uv_texcoord + appendResult237 ) * float2( 1,0.4 ) ) * 5.0;
			float2 id255 = 0;
			float2 uv255 = 0;
			float fade255 = 0.5;
			float voroi255 = 0;
			float rest255 = 0;
			for( int it255 = 0; it255 <2; it255++ ){
			voroi255 += fade255 * voronoi255( coords255, time255, id255, uv255, 0,voronoiSmoothId255 );
			rest255 += fade255;
			coords255 *= 2;
			fade255 *= 0.5;
			}//Voronoi255
			voroi255 /= rest255;
			float saferPower260 = abs( voroi255 );
			float lerpResult275 = lerp( ( ( saturate( pow( saferPower258 , 2.0 ) ) * 100.0 ) * ( pow( simplePerlin3D259 , 3.0 ) * ( pow( saferPower257 , 6.0 ) * 10.0 ) ) ) , ( ( saturate( pow( saferPower261 , 2.0 ) ) * 100.0 ) * ( pow( simplePerlin3D262 , 3.0 ) * ( pow( saferPower260 , 6.0 ) * 10.0 ) ) ) , 0.5);
			float blendOpSrc307 = i.uv_texcoord.x;
			float blendOpDest307 = 0.6;
			float blendOpSrc311 = ( 1.0 - i.uv_texcoord.x );
			float blendOpDest311 = 0.6;
			float lerpResult316 = lerp( ( pow( ( saturate( ( blendOpSrc307 + blendOpDest307 - 1.0 ) )) , 10.0 ) * 6000.0 ) , ( pow( ( saturate( ( blendOpSrc311 + blendOpDest311 - 1.0 ) )) , 10.0 ) * 6000.0 ) , 0.5);
			float temp_output_172_0 = ( saturate( ( saturate( ( ( ( saturate( ( ( ( pow( ( 1.0 - i.uv_texcoord.y ) , 2.0 ) * pow( ( 1.0 - ( saturate( abs( blendOpSrc33 - blendOpDest33 ) )) ) , 100.0 ) * ( pow( saferPower47 , 3.5 ) * 0.7 ) ) * 3.0 ) + saturate( temp_output_102_0 ) ) ) + saturate( ( saturate( ( temp_output_102_0 * 10.0 ) ) * ( saturate( pow( simplePerlin3D129 , 3.0 ) ) * ( saturate( pow( saferPower130 , 4.0 ) ) * 15.0 ) ) ) ) ) + saturate( lerpResult214 ) ) + saturate( lerpResult275 ) ) ) - lerpResult316 ) ) * _Intensity );
			o.Emission = ( _Color * temp_output_172_0 ).rgb;
			o.Alpha = temp_output_172_0;
		}

		ENDCG
	}
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19801
Node;AmplifyShaderEditor.CommentaryNode;280;-9504,784;Inherit;False;3319;1875;Comment;59;150;185;151;152;186;187;154;177;178;153;155;188;189;190;191;192;156;157;158;176;193;194;195;196;159;160;197;198;161;162;180;199;200;201;164;181;202;203;204;163;165;182;166;205;206;207;183;210;168;209;208;167;169;211;184;212;171;213;214;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleTimeNode;63;-8624,-640;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;122;-8736,368;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;279;-9232,2880;Inherit;False;3319;1875;Comment;58;217;218;219;220;221;222;223;224;226;227;228;229;230;231;232;225;233;235;236;237;239;240;234;241;242;243;244;245;246;247;248;249;250;251;253;254;255;256;252;259;262;258;261;263;264;265;266;267;268;269;270;271;272;273;274;275;260;257;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;65;-8608,-752;Inherit;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;0;False;0;False;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;69;-8432,-656;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;148;-8512,384;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;123;-8720,256;Inherit;False;Constant;_Float1;Float 0;1;0;Create;True;0;0;0;False;0;False;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;150;-9328,1616;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;185;-9296,2528;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;-8256,-736;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;25;-8992,-1232;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;137;-8864,-48;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;125;-8368,272;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;138;-8848,-160;Inherit;False;Constant;_Float2;Float 0;1;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;217;-9056,3712;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;218;-9024,4624;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;151;-9312,1504;Inherit;False;Constant;_Float3;Float 0;1;0;Create;True;0;0;0;False;0;False;0.3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;152;-9104,1632;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;186;-9280,2416;Inherit;False;Constant;_Float6;Float 0;1;0;Create;True;0;0;0;False;0;False;0.3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;187;-9072,2544;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;66;-8064,-768;Inherit;False;FLOAT2;4;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;101;-7872,-576;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;126;-8176,240;Inherit;False;FLOAT2;4;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;131;-8176,0;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;140;-8496,-144;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;219;-9040,3600;Inherit;False;Constant;_Float9;Float 0;1;0;Create;True;0;0;0;False;0;False;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;220;-8832,3728;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;221;-9008,4512;Inherit;False;Constant;_Float10;Float 0;1;0;Create;True;0;0;0;False;0;False;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;222;-8800,4640;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;154;-8960,1520;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;188;-8928,2432;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;189;-9408,1984;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;190;-9392,1888;Inherit;False;Constant;_Float7;Float 0;1;0;Create;True;0;0;0;False;0;False;-0.15;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;191;-9424,2176;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;192;-9408,2112;Inherit;False;Constant;_Float8;Float 0;1;0;Create;True;0;0;0;False;0;False;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;177;-9440,1072;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;178;-9424,976;Inherit;False;Constant;_Float5;Float 0;1;0;Create;True;0;0;0;False;0;False;0.15;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;155;-9440,1200;Inherit;False;Constant;_Float4;Float 0;1;0;Create;True;0;0;0;False;0;False;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;153;-9456,1264;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;62;-7920,-864;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;99;-7712,-496;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;127;-7904,144;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;141;-8304,-176;Inherit;False;FLOAT2;4;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;223;-8688,3616;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;224;-9168,3168;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;226;-9184,3360;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;227;-9168,3296;Inherit;False;Constant;_Float12;Float 0;1;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;228;-8656,4528;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;229;-9136,4080;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;230;-9120,3984;Inherit;False;Constant;_Float13;Float 0;1;0;Create;True;0;0;0;False;0;False;-0.05;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;231;-9152,4272;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;232;-9136,4208;Inherit;False;Constant;_Float14;Float 0;1;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;225;-9152,3072;Inherit;False;Constant;_Float11;Float 0;1;0;Create;True;0;0;0;False;0;False;0.05;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;156;-8768,1488;Inherit;False;FLOAT2;4;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;193;-8736,2400;Inherit;False;FLOAT2;4;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;194;-8736,2160;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;195;-9072,2080;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;196;-9120,1936;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;157;-8768,1248;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;158;-9104,1168;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;176;-9152,1024;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;349;-4464,784;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;350;-4448,688;Inherit;False;Constant;_Float18;Float 0;1;0;Create;True;0;0;0;False;0;False;-0.15;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;351;-4432,896;Inherit;False;Constant;_Float19;Float 0;1;0;Create;True;0;0;0;False;0;False;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;352;-4448,976;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;67;-7712,-848;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,0.3;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;112;-7536,-496;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;143;-8016,-208;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;128;-7696,160;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,0.4;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;233;-8496,3584;Inherit;False;FLOAT2;4;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;235;-8832,3264;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;236;-8880,3120;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;237;-8464,4496;Inherit;False;FLOAT2;4;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;239;-8800,4176;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;240;-8848,4032;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;234;-8544,3792;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;159;-8496,1392;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;197;-8464,2304;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;198;-8864,1984;Inherit;False;FLOAT2;4;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;160;-8896,1072;Inherit;False;FLOAT2;4;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;333;-4032,-48;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;334;-4016,-144;Inherit;False;Constant;_Float16;Float 0;1;0;Create;True;0;0;0;False;0;False;0.15;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;335;-4032,80;Inherit;False;Constant;_Float17;Float 0;1;0;Create;True;0;0;0;False;0;False;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;343;-4048,144;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;363;-4016,1280;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;364;-4000,1184;Inherit;False;Constant;_Float20;Float 0;1;0;Create;True;0;0;0;False;0;False;-0.15;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;371;-3984,1392;Inherit;False;Constant;_Float21;Float 0;1;0;Create;True;0;0;0;False;0;False;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;372;-4000,1472;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;353;-4128,880;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;354;-4176,736;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;42;-7792,-1312;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;33;-7680,-1120;Inherit;True;Difference;True;3;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;45;-7552,-800;Inherit;True;Gradient;True;False;2;0;FLOAT2;1,1;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;100;-7376,-496;Inherit;False;True;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;144;-7808,-192;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,0.4;False;1;FLOAT2;0
Node;AmplifyShaderEditor.VoronoiNode;133;-7472,96;Inherit;True;0;4;3.19;0;2;False;1;False;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;3;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.SimpleAddOpNode;241;-8224,3488;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;242;-8624,3168;Inherit;False;FLOAT2;4;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;243;-8192,4400;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;244;-8592,4080;Inherit;False;FLOAT2;4;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;162;-8288,1408;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,0.4;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;180;-8416,832;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;199;-8576,1952;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;200;-8256,2320;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,0.4;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;201;-8384,1744;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;161;-8608,1040;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;337;-3696,48;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;338;-3744,-96;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;362;-3680,1376;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;365;-3728,1232;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;355;-3920,784;Inherit;False;FLOAT2;4;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;383;-3968,640;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;48;-7408,-1120;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;41;-7504,-1344;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;47;-7296,-800;Inherit;True;True;2;0;FLOAT;0;False;1;FLOAT;3.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;118;-7184,-496;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;129;-7440,-240;Inherit;True;Simplex3D;True;False;2;0;FLOAT3;1,1,0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;130;-7264,128;Inherit;True;True;2;0;FLOAT;0;False;1;FLOAT;4;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;245;-8336,3136;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;246;-8016,3504;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,0.4;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;247;-8144,2928;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;248;-8304,4048;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;249;-7984,4416;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,0.4;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;250;-8112,3840;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;181;-8240,832;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;202;-8368,1968;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,0.4;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;203;-8208,1744;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.VoronoiNode;204;-8032,2256;Inherit;True;0;4;3.19;3;2;False;1;False;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;4;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.VoronoiNode;163;-8064,1344;Inherit;True;0;4;3.19;3;2;False;1;False;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;4;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;164;-8400,1056;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,0.4;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;339;-3488,-48;Inherit;False;FLOAT2;4;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;384;-3536,-176;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;366;-3472,1280;Inherit;False;FLOAT2;4;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;382;-3552,1152;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;356;-3632,752;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;49;-7216,-1104;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;100;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;44;-7312,-1344;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;278;-7072,-800;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0.7;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;102;-6976,-496;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;146;-7136,-160;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;326;-7008,128;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;251;-8128,3152;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,0.4;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;253;-8096,4064;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,0.4;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;254;-7936,3840;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;252;-7968,2928;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.VoronoiNode;255;-7760,4352;Inherit;True;0;4;3.19;3;2;False;1;False;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;5;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.VoronoiNode;256;-7792,3440;Inherit;True;0;4;3.19;3;2;False;1;False;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;5;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.PowerNode;182;-8080,832;Inherit;False;True;2;0;FLOAT;0;False;1;FLOAT;2.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;206;-8048,1744;Inherit;False;True;2;0;FLOAT;0;False;1;FLOAT;2.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;207;-8000,1920;Inherit;True;Simplex3D;True;False;2;0;FLOAT3;1,1,0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;165;-7856,1376;Inherit;True;True;2;0;FLOAT;0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;205;-7824,2288;Inherit;True;True;2;0;FLOAT;0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;166;-8032,1008;Inherit;True;Simplex3D;True;False;2;0;FLOAT3;1,1,0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;340;-3200,-80;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;368;-3184,1248;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;357;-3424,768;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-6896,-1040;Inherit;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;149;-6736,-352;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;325;-6960,-112;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;136;-6832,64;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;15;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;258;-7808,2928;Inherit;False;True;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;261;-7776,3840;Inherit;False;True;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;260;-7552,4384;Inherit;True;True;2;0;FLOAT;0;False;1;FLOAT;6;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;257;-7584,3472;Inherit;True;True;2;0;FLOAT;0;False;1;FLOAT;6;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;259;-7760,3104;Inherit;True;Simplex3D;True;False;2;0;FLOAT3;1,1,0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;262;-7728,4016;Inherit;True;Simplex3D;True;False;2;0;FLOAT3;1,1,0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;183;-7888,832;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;210;-7856,1744;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;168;-7584,1328;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;209;-7552,2240;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;208;-7696,2000;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;167;-7728,1088;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;341;-2992,-64;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;369;-3024,1248;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;358;-3264,768;Inherit;True;Simplex3D;False;False;2;0;FLOAT3;1,1,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;215;-6640,-1024;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;145;-6608,-80;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;327;-6528,-288;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;263;-7616,2928;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;264;-7584,3840;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;265;-7312,3424;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;266;-7280,4336;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;267;-7424,4096;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;268;-7456,3184;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;169;-7280,1184;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;211;-7248,2096;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;184;-7680,832;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;100;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;212;-7648,1744;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;100;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;331;-6736,-464;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;342;-2832,-64;Inherit;True;Simplex3D;False;False;2;0;FLOAT3;1,1,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;370;-2816,1264;Inherit;True;Simplex3D;True;False;2;0;FLOAT3;1,1,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;394;-2896,688;Inherit;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;302;-6032,-1040;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;135;-6320,-192;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;97;-6304,-688;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;269;-7008,3280;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;270;-6976,4192;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;271;-7408,2928;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;100;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;272;-7376,3840;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;100;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;171;-6976,1072;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;213;-6944,1984;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;386;-2480,-16;Inherit;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;385;-2478.142,1245.698;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;315;-5856,-800;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;323;-6064,-832;Inherit;False;Constant;_Float15;Float 15;2;0;Create;True;0;0;0;False;0;False;0.6;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;328;-6064,-544;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;319;-6096,-256;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;273;-6704,3168;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;274;-6672,4080;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;214;-6448,1504;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;381;-2219.487,832.1563;Inherit;False;Property;_XZDistortion;XZ Distortion;3;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;379;-2160,1264;Inherit;False;Property;_YDistortion;Y Distortion;4;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;347;-1808,1216;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;395;-2064,544;Inherit;True;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0.5,0,0.5;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BlendOpsNode;307;-5696,-1008;Inherit;True;LinearBurn;True;3;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;311;-5696,-784;Inherit;True;LinearBurn;True;3;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;134;-5936,-400;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;275;-6176,3616;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;329;-5792,32;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;378;-1952,1104;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PowerNode;375;-1504,1136;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;2.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;380;-1840,672;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PowerNode;308;-5424,-1008;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;313;-5424,-784;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;179;-5568,-160;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;330;-5472,160;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;361;-1328,1056;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;392;-1613.856,813.6059;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;277;-5328,-160;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;314;-5168,-784;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;6000;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;309;-5168,-1008;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;6000;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;348;-1200,784;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;318;-5072,-144;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;316;-4928,-816;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;397;-784,1136;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;346;-832,784;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0.01,0.01,0.01;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ToggleSwitchNode;403;-1312,560;Inherit;False;Property;_IsonParticle;Is on Particle;5;0;Create;True;0;0;0;False;0;False;0;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;321;-4944,-336;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;398;-336,1072;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PosVertexDataNode;399;-240,1296;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;322;-4720,-320;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;332;-1344,176;Inherit;False;Property;_Intensity;Intensity;2;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;400;-192,960;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;406;-352,704;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;301;-1248,-240;Inherit;False;Property;_Color;Color;0;0;Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;172;-1088,16;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;407;-96,752;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;405;-432,560;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;300;-832,-112;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;408;-208,496;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;3;AmplifyShaderEditor.MaterialInspector;0;0;Standard;RoboCap/Flowers;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;2;False;;0;False;;False;0;False;;0;False;;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;False;8;5;False;;1;False;;0;5;False;;1;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;17;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;69;0;63;0
WireConnection;148;0;122;0
WireConnection;64;0;65;0
WireConnection;64;1;69;0
WireConnection;125;0;123;0
WireConnection;125;1;148;0
WireConnection;152;0;150;0
WireConnection;187;0;185;0
WireConnection;66;1;64;0
WireConnection;101;0;25;2
WireConnection;126;1;125;0
WireConnection;140;0;138;0
WireConnection;140;1;137;0
WireConnection;220;0;217;0
WireConnection;222;0;218;0
WireConnection;154;0;151;0
WireConnection;154;1;152;0
WireConnection;188;0;186;0
WireConnection;188;1;187;0
WireConnection;62;0;25;0
WireConnection;62;1;66;0
WireConnection;99;0;101;0
WireConnection;127;0;131;0
WireConnection;127;1;126;0
WireConnection;141;1;140;0
WireConnection;223;0;219;0
WireConnection;223;1;220;0
WireConnection;228;0;221;0
WireConnection;228;1;222;0
WireConnection;156;1;154;0
WireConnection;193;1;188;0
WireConnection;195;0;192;0
WireConnection;195;1;191;0
WireConnection;196;0;190;0
WireConnection;196;1;189;0
WireConnection;158;0;155;0
WireConnection;158;1;153;0
WireConnection;176;0;178;0
WireConnection;176;1;177;0
WireConnection;67;0;62;0
WireConnection;112;0;99;0
WireConnection;143;0;131;0
WireConnection;143;1;141;0
WireConnection;128;0;127;0
WireConnection;233;1;223;0
WireConnection;235;0;227;0
WireConnection;235;1;226;0
WireConnection;236;0;225;0
WireConnection;236;1;224;0
WireConnection;237;1;228;0
WireConnection;239;0;232;0
WireConnection;239;1;231;0
WireConnection;240;0;230;0
WireConnection;240;1;229;0
WireConnection;159;0;157;0
WireConnection;159;1;156;0
WireConnection;197;0;194;0
WireConnection;197;1;193;0
WireConnection;198;0;196;0
WireConnection;198;1;195;0
WireConnection;160;0;176;0
WireConnection;160;1;158;0
WireConnection;353;0;351;0
WireConnection;353;1;352;0
WireConnection;354;0;350;0
WireConnection;354;1;349;0
WireConnection;42;0;25;2
WireConnection;33;0;25;1
WireConnection;45;0;67;0
WireConnection;100;0;112;0
WireConnection;144;0;143;0
WireConnection;133;0;128;0
WireConnection;241;0;234;0
WireConnection;241;1;233;0
WireConnection;242;0;236;0
WireConnection;242;1;235;0
WireConnection;243;0;234;0
WireConnection;243;1;237;0
WireConnection;244;0;240;0
WireConnection;244;1;239;0
WireConnection;162;0;159;0
WireConnection;180;0;25;2
WireConnection;199;0;194;0
WireConnection;199;1;198;0
WireConnection;200;0;197;0
WireConnection;201;0;25;2
WireConnection;161;0;157;0
WireConnection;161;1;160;0
WireConnection;337;0;335;0
WireConnection;337;1;343;0
WireConnection;338;0;334;0
WireConnection;338;1;333;0
WireConnection;362;0;371;0
WireConnection;362;1;372;0
WireConnection;365;0;364;0
WireConnection;365;1;363;0
WireConnection;355;0;354;0
WireConnection;355;1;353;0
WireConnection;48;0;33;0
WireConnection;41;0;42;0
WireConnection;47;0;45;0
WireConnection;118;0;100;0
WireConnection;129;0;144;0
WireConnection;130;0;133;0
WireConnection;245;0;234;0
WireConnection;245;1;242;0
WireConnection;246;0;241;0
WireConnection;247;0;234;2
WireConnection;248;0;234;0
WireConnection;248;1;244;0
WireConnection;249;0;243;0
WireConnection;250;0;234;2
WireConnection;181;0;180;0
WireConnection;202;0;199;0
WireConnection;203;0;201;0
WireConnection;204;0;200;0
WireConnection;163;0;162;0
WireConnection;164;0;161;0
WireConnection;339;0;338;0
WireConnection;339;1;337;0
WireConnection;366;0;365;0
WireConnection;366;1;362;0
WireConnection;356;0;383;0
WireConnection;356;1;355;0
WireConnection;49;0;48;0
WireConnection;44;0;41;0
WireConnection;278;0;47;0
WireConnection;102;0;118;0
WireConnection;146;0;129;0
WireConnection;326;0;130;0
WireConnection;251;0;245;0
WireConnection;253;0;248;0
WireConnection;254;0;250;0
WireConnection;252;0;247;0
WireConnection;255;0;249;0
WireConnection;256;0;246;0
WireConnection;182;0;181;0
WireConnection;206;0;203;0
WireConnection;207;0;202;0
WireConnection;165;0;163;0
WireConnection;205;0;204;0
WireConnection;166;0;164;0
WireConnection;340;0;384;0
WireConnection;340;1;339;0
WireConnection;368;0;382;0
WireConnection;368;1;366;0
WireConnection;357;0;356;0
WireConnection;40;0;44;0
WireConnection;40;1;49;0
WireConnection;40;2;278;0
WireConnection;149;0;102;0
WireConnection;325;0;146;0
WireConnection;136;0;326;0
WireConnection;258;0;252;0
WireConnection;261;0;254;0
WireConnection;260;0;255;0
WireConnection;257;0;256;0
WireConnection;259;0;251;0
WireConnection;262;0;253;0
WireConnection;183;0;182;0
WireConnection;210;0;206;0
WireConnection;168;0;165;0
WireConnection;209;0;205;0
WireConnection;208;0;207;0
WireConnection;167;0;166;0
WireConnection;341;0;340;0
WireConnection;369;0;368;0
WireConnection;358;0;357;0
WireConnection;215;0;40;0
WireConnection;145;0;325;0
WireConnection;145;1;136;0
WireConnection;327;0;149;0
WireConnection;263;0;258;0
WireConnection;264;0;261;0
WireConnection;265;0;257;0
WireConnection;266;0;260;0
WireConnection;267;0;262;0
WireConnection;268;0;259;0
WireConnection;169;0;167;0
WireConnection;169;1;168;0
WireConnection;211;0;208;0
WireConnection;211;1;209;0
WireConnection;184;0;183;0
WireConnection;212;0;210;0
WireConnection;331;0;102;0
WireConnection;342;0;341;0
WireConnection;370;0;369;0
WireConnection;394;2;358;0
WireConnection;135;0;327;0
WireConnection;135;1;145;0
WireConnection;97;0;215;0
WireConnection;97;1;331;0
WireConnection;269;0;268;0
WireConnection;269;1;265;0
WireConnection;270;0;267;0
WireConnection;270;1;266;0
WireConnection;271;0;263;0
WireConnection;272;0;264;0
WireConnection;171;0;184;0
WireConnection;171;1;169;0
WireConnection;213;0;212;0
WireConnection;213;1;211;0
WireConnection;386;0;342;0
WireConnection;385;1;370;0
WireConnection;315;0;302;1
WireConnection;328;0;97;0
WireConnection;319;0;135;0
WireConnection;273;0;271;0
WireConnection;273;1;269;0
WireConnection;274;0;272;0
WireConnection;274;1;270;0
WireConnection;214;0;171;0
WireConnection;214;1;213;0
WireConnection;395;0;386;0
WireConnection;395;1;394;0
WireConnection;307;0;302;1
WireConnection;307;1;323;0
WireConnection;311;0;315;0
WireConnection;311;1;323;0
WireConnection;134;0;328;0
WireConnection;134;1;319;0
WireConnection;275;0;273;0
WireConnection;275;1;274;0
WireConnection;329;0;214;0
WireConnection;378;0;385;0
WireConnection;378;1;379;0
WireConnection;375;0;347;2
WireConnection;380;0;395;0
WireConnection;380;1;381;0
WireConnection;308;0;307;0
WireConnection;313;0;311;0
WireConnection;179;0;134;0
WireConnection;179;1;329;0
WireConnection;330;0;275;0
WireConnection;361;0;375;0
WireConnection;392;0;380;0
WireConnection;392;1;378;0
WireConnection;277;0;179;0
WireConnection;277;1;330;0
WireConnection;314;0;313;0
WireConnection;309;0;308;0
WireConnection;348;0;392;0
WireConnection;348;1;361;0
WireConnection;318;0;277;0
WireConnection;316;0;309;0
WireConnection;316;1;314;0
WireConnection;346;0;348;0
WireConnection;321;0;318;0
WireConnection;321;1;316;0
WireConnection;398;0;346;0
WireConnection;398;1;397;0
WireConnection;322;0;321;0
WireConnection;400;0;398;0
WireConnection;400;1;399;0
WireConnection;406;0;403;0
WireConnection;172;0;322;0
WireConnection;172;1;332;0
WireConnection;407;0;406;0
WireConnection;407;1;400;0
WireConnection;405;0;403;0
WireConnection;405;1;346;0
WireConnection;300;0;301;0
WireConnection;300;1;172;0
WireConnection;408;0;405;0
WireConnection;408;1;407;0
WireConnection;0;2;300;0
WireConnection;0;9;172;0
WireConnection;0;11;408;0
ASEEND*/
//CHKSM=83616D305EAC8DB39B27A6DBD1B76DCE874CB10F