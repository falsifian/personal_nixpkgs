{ cabal, cairo, gtk2hsBuildtools, libc, mtl, pkgconfig, zlib }:

cabal.mkDerivation (self: {
  pname = "cairo";
  version = "0.12.3";
  sha256 = "0kgy6907vs41ws51dwqv6lwvfnvmgd1mns12cxzsifmli1jglswd";
  buildDepends = [ mtl ];
  buildTools = [ gtk2hsBuildtools ];
  extraLibraries = [ cairo libc pkgconfig zlib ];
  pkgconfigDepends = [ cairo ];
  meta = {
    homepage = "http://projects.haskell.org/gtk2hs/";
    description = "Binding to the Cairo library";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = [ self.stdenv.lib.maintainers.andres ];
  };
})
