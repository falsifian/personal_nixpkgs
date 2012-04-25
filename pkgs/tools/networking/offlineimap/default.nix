{ fetchgit, buildPythonPackage }:

buildPythonPackage {
  name = "offlineimap-6.5.3.1x";

  src = fetchgit {
    url = "https://github.com/spaetz/offlineimap.git";
    rev = "895e709bf23eea3b8f546f240317580e34251cf3";  # upstream cert_fingerprint fix
  };

  doCheck = false;

  # Copied from applications/graphics/jbrout, to avoid the following error message:
  #   File "/nix/store/vzpvrymynp4n93bznxha6hadj0ww68vx-python-2.7.1/lib/python2.7/zipfile.py", line 348, in FileHeader
  #     len(filename), len(extra))
  # struct.error: ushort format requires 0 <= number <= USHRT_MAX
  preConfigure = ''
    find | xargs touch
  '';

  patches = [ ];

  meta = {
    description = "IMAP to local files bridge";
    homepage = "http://software.complete.org/software/projects/show/offlineimap";
    license = "GPLv2+";
  };
}
