{ stdenv, fetchurl, fetchpatch, pkgconfig, bison, flex, unixODBC
, openssl, openldap, cyrus_sasl, kerberos, expat, SDL, libdv, libv4l, alsaLib }:

stdenv.mkDerivation rec {
  name = "ptlib-2.10.11";

  src = fetchurl {
    url = "mirror://gnome/sources/ptlib/2.10/${name}.tar.xz";
    sha256 = "1jf27mjz8vqnclhrhrpn7niz4c177kcjbd1hc7vn65ihcqfz05rs";
  };

  NIX_CFLAGS_COMPILE = "-std=gnu++98";

  buildInputs = [ pkgconfig bison flex unixODBC openssl openldap
                  cyrus_sasl kerberos expat SDL libdv libv4l alsaLib ];

  enableParallelBuilding = true;

  patches = [
    ./bison.patch
    ./sslv3.patch
    (fetchpatch { url = http://sources.debian.net/data/main/p/ptlib/2.10.11~dfsg-2.1/debian/patches/gcc-5_support;
      sha256 = "0pf2yj0150r4cnc6nv65mclrm3dillqh1xjk7m6gsjnk9b96i5d4";
    })
  ];

  meta = with stdenv.lib; {
    description = "Portable Tools from OPAL VoIP";
    maintainers = [ maintainers.raskin ];
    platforms = platforms.linux;
  };

  passthru = {
    updateInfo = {
      downloadPage = "http://ftp.gnome.org/sources/ptlib/";
    };
  };
}

