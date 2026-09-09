# Building this fork (BSP / custom-map branch)

This is checked out at commit `f1298747` ("V1 release of custom map code"),
predating [dac9438](https://github.com/LJW-Dev/OpenAssetTools/commit/dac9438)
which switched the custom-map format from FBX to glTF. This tree still uses
FBX via [ufbx](https://github.com/ufbx/ufbx).

## Is the build process different from regular OpenAssetTools?

**No — same steps as upstream OAT:**

1. Clone this repo with Git (don't download a zip — submodules require a real
   git repo).
2. Windows: run `generate.bat`. This clones submodules and generates
   `build/OpenAssetTools.sln` via Premake.
3. Open `build/OpenAssetTools.sln` in **Visual Studio 2022** (or build via
   `MSBuild build/OpenAssetTools.sln -p:Configuration=Release -p:Platform=Win32`).
4. Binaries land in `build/bin/<Debug|Release>_x86` (or `_x64`).

See the main [README.md](README.md#building-oat) for the full generic
instructions — they still apply as-is.

## What's different under the hood

At the exact `f1298747` commit, the custom-map source code already referenced
two thirdparty dependencies that were **not yet wired into the Premake
scripts** — a clean `generate.bat` + build would fail even though the
"V1 release" commit message suggests it was working:

- **`gsc-tool` (xsk)** — [ScriptCompileT6.cpp](src/ObjLoading/Game/T6/Script/ScriptCompileT6.cpp)
  links directly against `xsk::arc::t6::pc` classes for GSC script compiling.
  The submodule was present in `.gitmodules` but no `.lua` file built it.
- **`ufbx`** — used for FBX mesh loading in the custom-map linker. Not
  registered as a submodule or wired into Premake at all at this commit
  (it was added properly a few commits later, at `c9aa8e3`).

This fork adds:

- `thirdparty/gsc-tool.lua` — builds gsc-tool's `xsk-utils`, `xsk-arc`, and
  `xsk-gsc` static libs and links them into `ObjLoading`. Notably includes
  `/Zc:__cplusplus` for MSVC — without it, MSVC misreports `__cplusplus` to
  gsc-tool's Bison-generated parser, which then picks pre-C++11 copy
  semantics for move-only types and fails to compile.
- `thirdparty/ufbx.lua` + the `ufbx` submodule, pinned to the same commit
  used later in this branch's history (`13b5df8`).
- A one-line fix in
  [CustomMapLinker.h](src/ObjLoading/Game/T6/CustomMap/CustomMapLinker.h) —
  `LoadMaterialAsJson` expects a `std::istream&`; the custom-map code was
  passing a `nlohmann::json` object directly, which doesn't compile. Wrapped
  it in a `std::istringstream`.

None of this changes runtime behavior — it only makes the commit buildable
via the same standard Premake/MSVC workflow as any other OAT checkout.

## Branches

- `MAIN-oatbspV1` — this fixed `f1298747` snapshot (default branch).
- `oatbspUpdate` — currently identical to `MAIN-oatbspV1`; reserved for
  follow-up work.
