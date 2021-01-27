IS_MUSL=$(ldd --version 2>&1 | grep musl)
if [ $? -eq 0 ] && [ "$IS_MUSL" ]; then
echo "Do not use static libgit2 on MUSL C"
else
URL="https://r-lib.github.io/gert/libgit2-1.1.0.x86_64_linux.tar.gz"
${R_HOME}/bin/R --no-echo -q -e "curl::curl_download('$URL','bundle.tar.gz')"
tar xzf bundle.tar.gz && rm -f bundle.tar.gz
PKG_CFLAGS="-DSTATIC_LIBGIT2 -I${PWD}/libgit2/include"
PKG_LIBS="-L${PWD}/libgit2/lib -lgit2 -lrt -lpthread -lssh2 -lssl -lcrypto -ldl -lpcre -lz"
HAVE_STATIC_LIBGIT2=TRUE
fi

