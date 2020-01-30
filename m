Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E963C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 12:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30831206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 12:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MHxtAm+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgA3MnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 07:43:18 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35958 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbgA3MnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 07:43:17 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200130124315euoutp01b65f63a40c830f5fe3565e1c078e79ff~uqrDSjgfH2917629176euoutp01N
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 12:43:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200130124315euoutp01b65f63a40c830f5fe3565e1c078e79ff~uqrDSjgfH2917629176euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580388195;
        bh=u0T3trcPCRl0Q7vpugRvojgpgGpIu2Bq4V1J0AMOTPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MHxtAm+uTrPEFIVYoldBzRr56lj+GEDAIbv3Ow+rYaQ/lu2pPsuFCkckC1gY//1XV
         Lb88x8vRNlaaF1uekGHmET1wntNOu7TYKleb5qOAIdBTsLjVYNF6h1k2JT1n9eFKma
         4u5PP42l09A2I7Bnfx7eNGOphNOQ+5V2uhujDt6k=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200130124314eucas1p2c80c56755ba2cef935be2df307bd9666~uqrCZJUEQ1245412454eucas1p2S;
        Thu, 30 Jan 2020 12:43:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 47.EF.60679.26FC23E5; Thu, 30
        Jan 2020 12:43:14 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200130124314eucas1p11a244e77c9c5f583832832313ba93335~uqrBv1Vko0693106931eucas1p1h;
        Thu, 30 Jan 2020 12:43:14 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200130124314eusmtrp1a13fac857b1f591d7fd28be841b5bf62~uqrBvOOo92256022560eusmtrp1C;
        Thu, 30 Jan 2020 12:43:14 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-33-5e32cf627fef
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F3.6D.07950.16FC23E5; Thu, 30
        Jan 2020 12:43:13 +0000 (GMT)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20200130124313eusmtip1a712638181fb4d06a893d2a4f974e23f~uqrBmpkPc2123221232eusmtip1l;
        Thu, 30 Jan 2020 12:43:13 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
        =?UTF-8?q?Mateusz=20Mo=C5=9Bcicki?= 
        <m.moscicki2@partner.samsung.com>
Subject: [RFC PATCH 3/4] Add tools/hsinit
Date:   Thu, 30 Jan 2020 13:42:32 +0100
Message-Id: <20200130124233.4006-3-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130124233.4006-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42LZduzned2k80ZxBgd2aFncPLSC0WLT42us
        Fpd3zWGzmHF+H5PFrecPGR1YPTYvqfc4+G4Pk0ffllWMHp83yQWwRHHZpKTmZJalFunbJXBl
        LP0ZWfCnpuLQlt/sDYzvUrsYOTkkBEwker6uY+pi5OIQEljBKLH4zHw2COcLo8SpDzNZIZzP
        jBLzfjYxdjFygLU0P6yDiC9nlNj+bhYzhPOcUWLCrM1MIHPZBBwl+peeYAWxRQSyJSZ//AK2
        g1mgg1Fi58YTYEXCApoSF45NYwSxWQRUJbpbnoHZvAJWEvceTGOBOFBe4nzvOnYQm1PAWuLj
        6t+sEDWCEidnPgGr4RfQkljTdB3MZgaqb946G+wiCYHp7BKHm+cwQwxykfj1fAfUUGGJV8e3
        sEPYMhKnJ/ewQLxWLzF5khlEbw+jxLY5P6DqrSXunPvFBlLDDHT0+l36EGFHiX3v3rNBtPJJ
        3HgrCHECn8SkbdOZIcK8Eh1tQhDVKhLr+vdADZSS6H21gnECo9IsJM/MQvLALIRdCxiZVzGK
        p5YW56anFhvlpZbrFSfmFpfmpesl5+duYgQmktP/jn/ZwbjrT9IhRgEORiUeXo8zRnFCrIll
        xZW5hxglOJiVRHhFXQ3jhHhTEiurUovy44tKc1KLDzFKc7AoifMaL3oZKySQnliSmp2aWpBa
        BJNl4uCUamBktljJoi1uHp51T37XbgcVXjPRqH9+/2Su26yqnOv1W2hpn6lpxa4rNe65uQcm
        XmPfb5XyYXVc/KO4A6sf/DKLOlzwaoZLxNZz/E9lJn4X2NH36cebN4/+Z1ndfJnPkCVzfx4D
        1ytRlncxR07F1n1g+ZWbF3eLY1fTTC2Ru8f8Go9stv1r9fC5EktxRqKhFnNRcSIAr+VNUCAD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xu7qJ543iDHYftLG4eWgFo8Wmx9dY
        LS7vmsNmMeP8PiaLW88fMjqwemxeUu9x8N0eJo++LasYPT5vkgtgidKzKcovLUlVyMgvLrFV
        ija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLWPozsuBPTcWhLb/ZGxjfpXYx
        cnBICJhIND+s62Lk4hASWMoosWDrE2aIuJTEyrnpXYycQKawxJ9rXWwQNU8ZJVYs/MwMkmAT
        cJToX3qCFcQWEciVuHboKDtIEbNAB6PEzo0nmEASwgKaEheOTWMEsVkEVCW6W56B2bwCVhL3
        HkxjgdggL3G+dx07iM0pYC3xcfVvsKFCAtkSXXteQdULSpyc+YQF5DhmAXWJ9fOEQML8AloS
        a5qug41hBhrTvHU28wRGoVlIOmYhdMxCUrWAkXkVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZG
        YNRsO/Zzyw7GrnfBhxgFOBiVeHg9zhjFCbEmlhVX5h5ilOBgVhLhFXU1jBPiTUmsrEotyo8v
        Ks1JLT7EaAr05kRmKdHkfGBE55XEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0tSC2C
        6WPi4JRqYFxt1c64UvOSipL5a1m1LQ4rnT7++LLOSs3l2JpHXC3r+X9+MeZb/3k/i3TUNWVz
        plJj3s44iegJBvKawYurHlxu2lv322v71SptbVdvpmaXi6L+91eaL+aSzYivrnfzS5lff+wR
        +/qDgesD460iX73Vv1BmFn895K3Kvhd2gs5KfzpKZI75K7EUZyQaajEXFScCAM3VG0ywAgAA
X-CMS-MailID: 20200130124314eucas1p11a244e77c9c5f583832832313ba93335
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200130124314eucas1p11a244e77c9c5f583832832313ba93335
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200130124314eucas1p11a244e77c9c5f583832832313ba93335
References: <20200130123934.3900-1-l.stelmach@samsung.com>
        <20200130124233.4006-1-l.stelmach@samsung.com>
        <CGME20200130124314eucas1p11a244e77c9c5f583832832313ba93335@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Co-authored by M.Mościcki and Ł.Stelmach.

Signed-off-by: Mateusz Mościcki <m.moscicki2@partner.samsung.com>
Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 tools/hsinit/Makefile.am       |  29 ++++
 tools/hsinit/README.org        |  56 ++++++
 tools/hsinit/bootstrap         |   7 +
 tools/hsinit/configure.ac      | 128 ++++++++++++++
 tools/hsinit/hsinit.c          | 299 +++++++++++++++++++++++++++++++++
 tools/hsinit/vendor/.gitignore |   5 +
 tools/hsinit/vendor/SHA256SUMS |   2 +
 7 files changed, 526 insertions(+)
 create mode 100644 tools/hsinit/Makefile.am
 create mode 100644 tools/hsinit/README.org
 create mode 100755 tools/hsinit/bootstrap
 create mode 100644 tools/hsinit/configure.ac
 create mode 100644 tools/hsinit/hsinit.c
 create mode 100644 tools/hsinit/vendor/.gitignore
 create mode 100644 tools/hsinit/vendor/SHA256SUMS

diff --git tools/hsinit/Makefile.am tools/hsinit/Makefile.am
new file mode 100644
index 000000000000..3c8b3cff1b64
--- /dev/null
+++ tools/hsinit/Makefile.am
@@ -0,0 +1,29 @@
+INITRAMFS_DIR = ./initramfs
+
+bin_PROGRAMS=hsinit
+hsinit_LDFLAGS = $(ENABLE_STATIC)
+hsinit_SOURCES = hsinit.c
+hsinit_LINK = $(CCLD) $(hsinit_CFLAGS) $(CFLAGS) $(hsinit_LDFLAGS) \
+        $(LDFLAGS) -o $@
+
+
+data_DATA = initramfs.cpio.xz
+
+CPIO = @CPIO@
+CPIO_FLAGS = -o --format=newc
+
+XZ=@XZ@
+XZ_FLAGS = --check=crc32 --lzma2=dict=1MiB -f -k
+
+ENABLE_STATIC = @ENABLE_STATIC@
+
+%.xz : %
+	xz $(XZ_FLAGS) $<
+
+initramfs.cpio: hsinit
+	for d in bin dev etc lib mnt proc root sbin sys; do \
+		mkdir -p $(INITRAMFS_DIR)/$$d; \
+	done
+	cp $< $(INITRAMFS_DIR)/init
+	cd $(INITRAMFS_DIR); find . -print0 | cpio --null $(CPIO_FLAGS) > ../$@
+
diff --git tools/hsinit/README.org tools/hsinit/README.org
new file mode 100644
index 000000000000..2874781b5e70
--- /dev/null
+++ tools/hsinit/README.org
@@ -0,0 +1,56 @@
+* hsinit
+
+  hsinit is a minimal init program for boot/loader (a.k.a. k-boot) on
+  Odroid XU4 and other platforms with limited size of bootloader
+  image. (1MiB on Odroid XU4). Its sole purpose is to unpack the rest
+  of the initramfs image from an archive pointed by the 'hs' parameter
+  in /proc/cmdline. For example:
+
+#+BEGIN_EXAMPLE:
+      hs=/dev/mmcblk1p6:uroot.cpio.gz
+#+END_EXAMPLE
+
+  will make hsinit mount /dev/mmcblk1p6 and unpack the content of
+  uroot.cpio.gz onto initramfs. Please note that unlike the old initrd
+  initramfs hasn't got fixed size and is much more suitable for hsinit
+  to work with.
+
+* Building hsinit
+
+  The basic way to build hsinit on a host system is
+
+#+BEGIN_SRC sh
+  ./bootstrap && ./configure && make
+#+END_SRC
+
+  The only direct dependency of hsinit is [[https://libarchive.org/][libarchive]], which, however,
+  needs at least zlib to support reasonable compression. You use
+  libarchive and libz packaged for your system or download appropriate
+  archives into the vendor directory (see vendor/SHA256SUMS) and the
+  libraries shall be built automatically.
+
+* Building for musl
+
+  While it is possible to build hsinit for the host system (e.g. x86)
+  and link it dynamically, it makes little sens. Most of the time you
+  will want to compile to for different CPU and link it statically against
+  a C library other than GNU C Library to make the binary small enough
+  to fit the image.
+
+  To cross-compile hsinit for ARM and link it statically against musl
+  run the following command.
+
+#+BEGIN_SRC sh
+  ./bootstrap && \
+    MUSL_DIR=/usr/lib/arm-linux-musleabi/ \
+    GCC_CROSS_DIR=/usr/lib/gcc-cross/arm-linux-gnueabi/8/ \
+    CPPFLAGS='-nostdinc -isystem /usr/include/arm-linux-musleabi/' \
+    CFLAGS='-mthumb -Os -ffunction-sections -fdata-sections' \
+    LIBARCHIVE_CPP_FLAGS=-I/usr/include/arm-linux-musleabi/ \
+    LIBARCHIVE_C_FLAGS=$CFLAGS \
+    ZLIB_C_FLAGS=$CFLAGS \
+    LDFLAGS="-nostdlib -L${MUSL_DIR}/ -L${GCC_CROSS_DIR}/ ${MUSL_DIR}/crt1.o  ${MUSL_DIR}/crti.o  ${GCC_CROSS_DIR}/crtbegin.o -Wl,--gc-sections -Wl,--start-group  ${GCC_CROSS_DIR}/libgcc.a  ${GCC_CROSS_DIR}/libgcc_eh.a -Wl,--end-group ${GCC_CROSS_DIR}/crtend.o  ${MUSL_DIR}/crtn.o -s"  \
+    LIBS="-lc -lgcc"
+  ./configure --enable-local-libraries --host=arm-linux-gnueabi --enable-static && \
+  make
+#+END_SRC
diff --git tools/hsinit/bootstrap tools/hsinit/bootstrap
new file mode 100755
index 000000000000..d3e9fbc8a6c3
--- /dev/null
+++ tools/hsinit/bootstrap
@@ -0,0 +1,7 @@
+#!/bin/sh
+
+set -x -e
+#aclocal
+#autoheader
+#autoconf
+autoreconf -i -f -v
diff --git tools/hsinit/configure.ac tools/hsinit/configure.ac
new file mode 100644
index 000000000000..135f53354c9a
--- /dev/null
+++ tools/hsinit/configure.ac
@@ -0,0 +1,128 @@
+dnl
+dnl configure.ac for hsinit
+dnl
+
+AC_PREREQ(2.69)
+AC_INIT(hsinit, 1.0.0)
+AC_CONFIG_SRCDIR([./hsinit.c])
+AC_CONFIG_AUX_DIR([build-aux])
+AM_INIT_AUTOMAKE([foreign])
+AC_CONFIG_HEADERS([config.h])
+AC_LANG(C)
+AC_PROG_CC
+PKG_PROG_PKG_CONFIG
+
+dnl -- Prepare for cross-compilation
+AC_CANONICAL_HOST
+if test "${build}" != "${host}" ; then
+        AC_CHECK_PROGS(BUILD_CC, [${build_alias}-gcc ${build}-gcc gcc])
+        AC_CHECK_PROGS(BUILD_LD, [${build_alias}-ld ${build}-ld ld])
+        AC_CHECK_PROGS(HOST_CC, [${host_alias}-gcc ${host}-gcc gcc])
+        AC_CHECK_PROGS(HOST_LD, [${host_alias}-ld ${host}-ld ld])
+else
+        BUILD_CC="$CC"
+        BUILD_LD="$LD"
+
+        HOST_CC="$CC"
+        HOST_LD="$LD"
+fi
+
+
+AC_ARG_ENABLE(local-libraries,
+  AS_HELP_STRING([--enable-local-libraries],[Build and use local versions of libarchive and zlib]),
+  ENABLE_LOCAL_LIBS=yes)
+
+AC_ARG_ENABLE(static,
+  AS_HELP_STRING([--enable-static], [Build static binary]),
+  ENABLE_STATIC=-static)
+
+AC_ARG_VAR(ZLIB_C_FLAGS, [CFLAGS for local zlib compilation])
+AC_ARG_VAR(ZLIB_CPP_FLAGS, [CPPFLAGS for local zlib compilation])
+AC_ARG_VAR(ZLIB_LD_FLAGS, [LDFLAGS for local zlib compilation])
+AC_ARG_VAR(LIBARCHIVE_C_FLAGS, [CFLAGS for local libarchive compilation])
+AC_ARG_VAR(LIBARCHIVE_CPP_FLAGS, [CPPFLAGS for local libarchive compilation])
+AC_ARG_VAR(LIBARCHIVE_LD_FLAGS, [LDFLAGS for local libarchive compilation])
+
+AC_SUBST(ENABLE_STATIC)
+AC_SUBST(HOST_CFLAGS, ["$CFLAGS"])
+AC_SUBST(HOST_CPPFLAGS, ["$CPPFLAGS"])
+AC_SUBST(HOST_LDFLAGS, ["$LDFLAGS"])
+
+AC_PATH_PROG(CPIO, cpio)
+AC_PATH_PROG(XZ, xz)
+AC_PATH_PROG(SHA256SUM, sha256sum)
+
+
+AS_IF([test -n "${ENABLE_LOCAL_LIBS}"],
+  AC_MSG_CHECKING([for local libraries])
+  AS_IF([cd $srcdir/vendor && $SHA256SUM -c SHA256SUMS --quiet && cd - > /dev/null],
+        AC_MSG_RESULT([ok]),
+        AC_MSG_ERROR([error])))
+AS_IF([test -n "${ENABLE_LOCAL_LIBS}" && /bin/true],
+  pushd vendor
+  mkdir -p libs
+  zlib_archive=$(grep -o zlib-.* SHA256SUMS)
+  zlib_dir=${zlib_archive%.tar.gz}
+  AC_MSG_NOTICE([Building ${zlib_dir}])
+  rm -rf "$zlib_dir"
+  tar -xf "$zlib_archive"
+  cd "$zlib_dir"
+  CFLAGS="${ZLIB_C_FLAGS}" \
+  CPPFLAGS="${ZLIB_CPP_FLAGS}" \
+  LDFLAGS="${ZLIB_LD_FLAGS}" \
+  CROSS_PREFIX="${host_alias:-${host}}-" ./configure ${ENABLE_STATIC:+--static} --prefix=$(pwd)/../libs
+  make -j8 install
+
+  cd ..
+  
+  libarchive_archive=$(grep -o libarchive-.* SHA256SUMS)
+  libarchive_dir=${libarchive_archive%.tar.gz}
+  rm -rf "$libarchive_dir"
+  tar -xf "$libarchive_archive"
+  cd $libarchive_dir
+
+  PKG_CONFIG_PATH=$(pwd)/../libs/lib/pkgconfig
+  CFLAGS="${LIBARCHIVE_C_FLAGS}" \
+  CPPFLAGS="${LIBARCHIVE_CPP_FLAGS}" \
+  LDFLAGS="${LIBARCHIVE_LD_FLAGS}" \
+  ./configure --host=${host_alias:-${host}} \
+  ${ENABLE_STATIC:+--enable-static --disable-shared} \
+  --prefix=$(pwd)/../libs \
+  --disable-bsdtar \
+  --disable-bsdcat \
+  --disable-bsdcpio \
+  --disable-xattr \
+  --disable-acl \
+  --disable-shared \
+  --disable-largefile \
+  --without-bz2lib \
+  --without-iconv \
+  --without-lz4  \
+  --without-lzma \
+  --without-lzo2 \
+  --without-cng     \
+  --without-nettle \
+  --without-openssl \
+  --without-xml2    \
+  --without-expat
+  make -j8 install
+  popd
+)
+
+AS_IF([test -n "${ENABLE_LOCAL_LIBS}"],
+  export PKG_CONFIG_PATH=$(pwd)/vendor/libs/lib/pkgconfig/
+)
+AS_IF([test -n "$ENABLE_STATIC"],
+  [PKG_CHECK_MODULES_STATIC([LIBARCHIVE], [libarchive])],
+  [PKG_CHECK_MODULES([LIBARCHIVE], [libarchive])])
+
+CFLAGS="$CFLAGS $LIBARCHIVE_CFLAGS"
+LIBS="$LIBS $LIBARCHIVE_LIBS"
+
+dnl ---Output
+AC_OUTPUT([Makefile])
+
+echo
+echo Host CC: $HOST_CC
+echo Build CC: $BUILD_CC
+echo
diff --git tools/hsinit/hsinit.c tools/hsinit/hsinit.c
new file mode 100644
index 000000000000..8332c06b8501
--- /dev/null
+++ tools/hsinit/hsinit.c
@@ -0,0 +1,299 @@
+#include <stdlib.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <sys/mount.h>
+#include <sys/types.h>
+#include <limits.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <errno.h>
+#include <string.h>
+#include <archive.h>
+#include <archive_entry.h>
+#include <dirent.h>
+
+
+#define COMMAND_LINE_SIZE 512
+#define PARAM_NAME "hs"
+
+/*
+ * Based on examples:
+ * https://github.com/libarchive/libarchive/wiki/Examples
+ */
+int copy_data(struct archive *ar, struct archive *aw)
+{
+	int r;
+	const void *buff;
+	size_t size;
+	int64_t offset;
+
+	for (;;) {
+		r = archive_read_data_block(ar, &buff, &size, &offset);
+		if (r == ARCHIVE_EOF)
+			return (ARCHIVE_OK);
+		if (r < ARCHIVE_OK)
+			return (r);
+		r = archive_write_data_block(aw, buff, size, offset);
+		if (r < ARCHIVE_OK) {
+			printf("%s\n", archive_error_string(aw));
+			return (r);
+		}
+	}
+}
+
+static int extract(const char *filename)
+{
+	struct archive *a;
+	struct archive *ext;
+	struct archive_entry *entry;
+	int flags;
+	int r;
+
+	flags = ARCHIVE_EXTRACT_TIME;
+	flags |= ARCHIVE_EXTRACT_PERM;
+	flags |= ARCHIVE_EXTRACT_ACL;
+	flags |= ARCHIVE_EXTRACT_FFLAGS;
+
+	a = archive_read_new();
+	archive_read_support_format_cpio(a);
+	archive_read_support_filter_gzip(a);
+	ext = archive_write_disk_new();
+	archive_write_disk_set_options(ext, flags);
+	archive_write_disk_set_standard_lookup(ext);
+
+	if ((r = archive_read_open_filename(a, filename, 10240)))
+		return -1;
+
+	for (;;) {
+		r = archive_read_next_header(a, &entry);
+		if (r == ARCHIVE_EOF)
+			break;
+		if (r < ARCHIVE_OK)
+			printf("%s\n", archive_error_string(a));
+		if (r < ARCHIVE_WARN)
+			return -1;
+		r = archive_write_header(ext, entry);
+		if (r < ARCHIVE_OK)
+			printf("%s\n", archive_error_string(ext));
+		else if (archive_entry_size(entry) > 0) {
+			r = copy_data(a, ext);
+			if (r < ARCHIVE_OK)
+				printf("%s\n", archive_error_string(ext));
+			if (r < ARCHIVE_WARN)
+				return -1;
+		}
+
+		r = archive_write_finish_entry(ext);
+
+		if (r < ARCHIVE_OK)
+			printf("%s\n", archive_error_string(ext));
+		if (r < ARCHIVE_WARN)
+			return -1;
+	}
+
+	archive_read_close(a);
+	archive_read_free(a);
+	archive_write_close(ext);
+	archive_write_free(ext);
+
+	return 1;
+}
+
+int mount_sysfs()
+{
+	return mount("none", "/sys", "sysfs", MS_NOEXEC |
+					MS_RELATIME | MS_NODEV | MS_NOSUID, NULL);
+}
+
+int mount_procfs()
+{
+	return mount("none", "/proc", "proc", MS_NOEXEC |
+					MS_RELATIME | MS_NODEV | MS_NOSUID, NULL);
+}
+
+int mount_devfs()
+{
+	return mount("none", "/dev", "devtmpfs", MS_NOEXEC |
+					MS_RELATIME | MS_NOSUID, NULL);
+}
+
+int mount_storage(char *device)
+{
+	char BUFF[256];
+	sprintf(BUFF, "%s", device);
+	// mount("/dev/sdb6", "/mnt", "vfat", MS_RDONLY, NULL) = 0
+	return mount(BUFF, "/mnt", "vfat", 0, NULL);
+}
+
+void ls(char *dir)
+{
+	DIR *d = NULL;
+	struct dirent *de;
+
+	d = opendir(dir);
+
+	if (d == NULL) {
+		printf("Error opening directory: %s\n", dir);
+		return;
+	}
+
+	printf("Reading %s\n", dir);
+	while ((de = readdir(d)) != NULL) {
+		printf("%s\n", de->d_name);
+	}
+	printf("\n");
+}
+
+int umount_storage()
+{
+	return umount("/mnt");
+}
+
+int read_cmd_params(char *buff)
+{
+	int fd = open("/proc/cmdline", O_RDONLY);
+	if (fd < 0) {
+		printf("Open /proc/cmdline error: %s", strerror(errno));
+		return fd;
+	}
+
+	int readed = read(fd, buff, COMMAND_LINE_SIZE-1);
+
+	if (readed >= 0)
+		buff[readed] = '\0';
+	return readed;
+}
+
+/*
+ * Get param=value from /proc/cmdline
+ */
+const char *find_param(const char *cmdline, const char *param_name, char *value)
+{
+	const char *cur = cmdline;
+	bool in_quote = false;
+	bool begin = true;
+	int param_name_len = strlen(param_name);
+	int i, length;
+
+	while (*cur != '\0') {
+		if (begin) {
+			for (i = 0; *(param_name+i) != '\0' &&
+			     *(cur + i) == *(param_name+i); i++);
+
+			if (i == param_name_len && (*(cur+i) == '=')) {
+				cur += i+1;
+				break;
+			}
+			begin = false;
+		}
+
+		if (*cur == '\"')
+			in_quote = !in_quote;
+
+		if (!in_quote && *cur == ' ')
+			begin = true;
+
+		cur++;
+	}
+
+	if (*cur > 0) {
+		for (i = 0; *(cur+i) != ' ' && *(cur+i) != '\0' && *(cur+i) != '\n'; i++);
+		length = i > (COMMAND_LINE_SIZE - 1) ? (COMMAND_LINE_SIZE - 1) : i;
+		memcpy(value, cur, length);
+		value[length] = '\0';
+	}
+	return cur;
+}
+
+int parse_cmdline(const char *cmdline, char *device, char *dest)
+{
+	char value[COMMAND_LINE_SIZE];
+	const char *res = find_param(cmdline, PARAM_NAME, value);
+
+	if (*res == 0) {
+		printf("hs param not found\n");
+		return 0;
+	}
+
+	char *r = strtok(value, ":");
+	if (r == NULL) {
+		printf("Wrong sh parameter format\n");
+		return -1;
+	}
+
+	strncpy(device, r, NAME_MAX);
+
+	r = strtok(NULL, ":");
+	if (r == NULL) {
+		printf("Wrong hs parameter format\n");
+		return -1;
+	}
+
+	strncpy(dest, r, NAME_MAX);
+
+	return 1;
+}
+
+int main(void)
+{
+	char params[COMMAND_LINE_SIZE];
+	char device[NAME_MAX];
+	char initramfs_fn[NAME_MAX];
+	char full_irfs_file[PATH_MAX];
+
+	printf("Hello...\n");
+
+	if (mount_sysfs() < 0) {
+		printf("Mount sysfs error: %s\n", strerror(errno));
+		exit(1);
+	}
+
+	if (mount_procfs() < 0) {
+		printf("Mount procfs error: %s\n", strerror(errno));
+		exit(1);
+	}
+
+	if (mount_devfs() < 0) {
+		printf("Mount devfs error: %s\n", strerror(errno));
+		exit(1);
+	}
+
+	printf("Sleep zzZZ...\n");
+	sleep(1);
+	printf("Wake up :)\n");
+
+	ls("/dev");
+
+	if (read_cmd_params(params) < 0) {
+		printf("Read cmd_params error: %s\n", strerror(errno));
+		exit(1);
+	}
+
+	if (parse_cmdline(params, device, initramfs_fn) <= 0)
+		exit(1);
+
+	if (mount_storage(device) < 0) {
+		printf("Mount %s error: %s\n", device, strerror(errno));
+		exit(1);
+	}
+
+	sprintf(full_irfs_file, "/mnt/%s", initramfs_fn);
+
+	if (extract(full_irfs_file) <= 0) {
+		printf("Extract error: %s\n", strerror(errno));
+		exit(1);
+	}
+
+	umount_storage();
+
+	/*if (execl("/bin/busybox", "sh", NULL) <= 0)*/
+		/*printf("Execl error: %s\n", strerror(errno));*/
+
+	printf("Init...\n");
+
+	if (execl("/init", "/init", (char *)NULL) <= 0)
+		printf("Execl error: %s\n", strerror(errno));
+
+	return 0;
+}
diff --git tools/hsinit/vendor/.gitignore tools/hsinit/vendor/.gitignore
new file mode 100644
index 000000000000..07a4d737cb87
--- /dev/null
+++ tools/hsinit/vendor/.gitignore
@@ -0,0 +1,5 @@
+/zlib-*/
+/libarchive-*/
+/libs/
+/libarchive-*.tar.gz
+/zlib-*.tar.gz
diff --git tools/hsinit/vendor/SHA256SUMS tools/hsinit/vendor/SHA256SUMS
new file mode 100644
index 000000000000..fd42c44ba948
--- /dev/null
+++ tools/hsinit/vendor/SHA256SUMS
@@ -0,0 +1,2 @@
+c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1  zlib-1.2.11.tar.gz
+ed2dbd6954792b2c054ccf8ec4b330a54b85904a80cef477a1c74643ddafa0ce  libarchive-3.3.2.tar.gz
-- 
2.20.1

