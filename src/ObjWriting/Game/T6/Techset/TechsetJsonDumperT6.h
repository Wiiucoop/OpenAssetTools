#pragma once

#include "Dumping/AbstractAssetDumper.h"
#include "Game/T6/T6.h"

namespace techset
{
    // Dumps the full compiled technique set (techniques, passes, shader args, vertex decl) as a raw
    // JSON round-trip, separate from DumperT6's human-readable/recompilable technique source dump.
    // Used by the custom-map material pipeline to reload technique sets byte-for-byte.
    class JsonDumperT6 final : public AbstractAssetDumper<T6::AssetTechniqueSet>
    {
        static void DumpPixelShader(const AssetDumpingContext& context, const T6::MaterialPixelShader* pixelShader);
        static void DumpVertexShader(const AssetDumpingContext& context, const T6::MaterialVertexShader* vertexShader);

    protected:
        void DumpAsset(AssetDumpingContext& context, const XAssetInfo<T6::AssetTechniqueSet::Type>& asset) override;
    };
} // namespace techset
