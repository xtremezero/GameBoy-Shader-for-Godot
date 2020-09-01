shader_type canvas_item;

void fragment(){
	
	vec2 uv = vec2(UV.x,UV.y);
	vec4 frag = texture(TEXTURE,UV);
	float bwfrag = (frag.r+frag.g+frag.b)/3.;
	
	
	//////// OTHER DITHERING STYLES ///////////////
	//bool dither_a = bool(int((1.-uv.x*-1.)/TEXTURE_PIXEL_SIZE.x+(uv.y*-1.)/TEXTURE_PIXEL_SIZE.y)%2==0);
	//dither_a= dither_a || bool(int(uv.x/TEXTURE_PIXEL_SIZE.x+uv.y/TEXTURE_PIXEL_SIZE.y)%2==0);
	//////////////////////////////////////////////
	//bool dither_b = bool(int(uv.x/TEXTURE_PIXEL_SIZE.x + uv.y/TEXTURE_PIXEL_SIZE.y)%2==0);
	///////////////////////////////////////////////
	bool highindx = bool(int(uv.x/TEXTURE_PIXEL_SIZE.x)%2==0) || bool(int(uv.y/TEXTURE_PIXEL_SIZE.y)%2==0);
	
	const float B = 0f; //Black
	const float BG= 0.35f; //Dark Grey
	const float WG= 0.7f;  //Light Grey
	const float W = 1f; // White
	
	if (bwfrag <0.1)
		bwfrag = B;	//BLACK
	
	else if (bwfrag > 0.1 &&  bwfrag <= 0.2)
		bwfrag = float(highindx) * BG;
	
	else if (bwfrag > 0.2 &&  bwfrag <= 0.3)
		bwfrag = float(!highindx) * BG;
	
	else if (bwfrag > 0.3 &&  bwfrag <= 0.4)
		bwfrag = float(BG);	//BlackGrey
		
	else if (bwfrag > 0.4 &&  bwfrag <= 0.5)
		bwfrag = BG+ float(highindx) * (WG-BG); 
	
	else if (bwfrag > 0.5 &&  bwfrag <= 0.6)
		bwfrag = BG+ float(!highindx)* (WG-BG);
	
	else if (bwfrag > 0.6 &&  bwfrag <= 0.7)
		bwfrag = float(WG);	//WhiteGrey
	
	else if (bwfrag > 0.7 &&  bwfrag <= 0.8)
		bwfrag = WG+ float(!highindx) * (W-WG);
	
	else if (bwfrag > 0.8 &&  bwfrag <= 0.9)
		bwfrag = WG+ float(highindx) * (W-WG);
	
	else if (bwfrag >0.9)
		bwfrag = float(W);	//White
	
	
	COLOR = vec4(vec3(bwfrag),1);
	
	}
