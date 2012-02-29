{ fetchgit, buildPythonPackage, ssl }:

buildPythonPackage {
  name = "offlineimap-6.4.0";

  src = fetchgit {
    url = "https://github.com/nicolas33/offlineimap.git";
    rev = "c1120c9158f273fe691f89b9eefc34b2623d5a7a";  # 6.4.0 release
  };

  propagatedBuildInputs = [ ssl ];

  doCheck = false;

  # Copied from applications/graphics/jbrout, to avoid the following error message:
  #   File "/nix/store/vzpvrymynp4n93bznxha6hadj0ww68vx-python-2.7.1/lib/python2.7/zipfile.py", line 348, in FileHeader
  #     len(filename), len(extra))
  # struct.error: ushort format requires 0 <= number <= USHRT_MAX
  preConfigure = ''
    find | xargs touch
  '';

  patches = [ ./detect_ssl.patch ];

  meta = {
    description = "IMAP to local files bridge";
    homepage = "http://software.complete.org/software/projects/show/offlineimap";
    license = "GPLv2+";
  };
}
