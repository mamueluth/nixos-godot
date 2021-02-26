{ stdenv,
  lib,
  autoPatchelfHook,
  fetchFromGitHub,
  unzip,
  alsaLib, libXcursor, libXinerama, libXrandr, libXrender, libX11, libXi,
  libpulseaudio, libGL,
}:

stdenv.mkDerivation rec {
  pname = "godot-bin";
  version = "3.2.3";

  src = fetchFromGitHub {
    owner  = "godotengine";
    repo   = "godot";
    rev    = "${version}-stable";
    sha256 = "19vrp5lhyvxbm6wjxzn28sn3i0s8j08ca7nani8l1nrhvlc8wi0v";
  };

  nativeBuildInputs = [autoPatchelfHook unzip];

  buildInputs = [
    alsaLib
    libXcursor
    libXinerama
    libXrandr
    libXrender
    libX11
    libXi
    libpulseaudio
    libGL
  ];

  unpackCmd = "tar -xf $curSrc --directory source";
  installPhase = ''
    mkdir -p $out/bin
    install -m 0755 Godot_v${version}-stable_x11.64 $out/bin/godot
  '';

  meta = {
    homepage    = "https://godotengine.org";
    description = "Free and Open Source 2D and 3D game engine";
    license     = stdenv.lib.licenses.mit;
    platforms   = [ "i686-linux" "x86_64-linux" ];
    maintainers = [ stdenv.lib.maintainers.twey ];
  };
}
