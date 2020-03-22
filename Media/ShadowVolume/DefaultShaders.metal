struct RasterizerData
{
  float4 pos [[position]];
  float2 uv;
};

struct Vertex
{
  float3 pos [[ attribute(0) ]];
  float2 uv [[ attribute(8) ]];
};

vertex RasterizerData default_vp(Vertex in [[stage_in]],
                                 constant metal::float4x4& texMtx [[buffer(CONST_SLOT_START)]])
{
  RasterizerData out;
  out.pos = float4(in.pos, 1);
  out.uv = (texMtx * float4(in.uv,1,1)).xy;
  return out;
}

fragment half4 default_fp(RasterizerData in [[stage_in]],
                          metal::texture2d<half> tex [[texture(0)]],
                          metal::sampler s [[sampler(0)]])
{
  return tex.sample(s, in.uv);
}