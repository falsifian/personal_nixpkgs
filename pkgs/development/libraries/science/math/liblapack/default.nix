{ stdenv, fetchurl, gfortran, atlas, cmake, python, shared ? false }:
let 
  atlasMaybeShared = if shared then atlas.override {shared=true;} else atlas;
  usedLibExtension = if shared then ".so" else ".a";
in
stdenv.mkDerivation {
  name = "liblapack-3.4.0";
  src = fetchurl {
    url = "http://www.netlib.org/lapack/lapack-3.4.0.tgz";
    sha256 = "1sf30v1ps5icg67dvw5sbx5yhypx13am470gqg2f7l04f3wrw4x7";
  };

  propagatedBuildInputs = [ atlasMaybeShared ];
  buildInputs = [ gfortran cmake ];
  buildNativeInputs = [ python ];

  cmakeFlags = [
    "-DUSE_OPTIMIZED_BLAS=ON"
    "-DBLAS_ATLAS_f77blas_LIBRARY=${atlasMaybeShared}/lib/libf77blas${usedLibExtension}"
    "-DBLAS_ATLAS_atlas_LIBRARY=${atlasMaybeShared}/lib/libatlas${usedLibExtension}"
    "-DCMAKE_Fortran_FLAGS=-fPIC"
  ]
  ++ (stdenv.lib.optional shared "-DBUILD_SHARED_LIBS=ON")
  ;

  doCheck = ! shared;

  checkPhase = "
    sed -i 's,^#!.*,#!${python}/bin/python,' lapack_testing.py
    ctest
  ";

  enableParallelBuilding = true;

  passthru = {
    blas = atlas;
  };

  meta = {
    description = "Linear Algebra PACKage";
    license = "revised-BSD";
    homepage = "http://www.netlib.org/lapack/";
  };
}
