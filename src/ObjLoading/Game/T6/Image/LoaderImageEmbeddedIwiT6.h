#pragma once

#include "Asset/IAssetCreator.h"
#include "Game/T6/T6.h"
#include "SearchPath/ISearchPath.h"
#include "Utils/MemoryManager.h"

#include <memory>

namespace image
{
    // Loads T6 images embedded directly from a raw .iwi file instead of relying on the game's
    // original streaming cache. Needed for custom-map textures, which are not part of that cache.
    std::unique_ptr<AssetCreator<T6::AssetImage>> CreateLoaderEmbeddedIwiT6(MemoryManager& memory, ISearchPath& searchPath);
} // namespace image
