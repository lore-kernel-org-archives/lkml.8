Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2428AC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5FB921655
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583780030;
	bh=dz2ltX61FLJsnuQoPDCkE+3b8y0hvBuwOOYYzNY678c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nTScQzaeEwrBBkXWqvf5TRGVfCsZMLSLD7+95BmdTa6S3LFGHDI3nEqxMEX4hwGil
	 ys3xQf0kFSSYoqdnbeQo2t92uQRFjzI2woD0XyMy6mi0wSFRo1LW0TQYkThTCp47P8
	 tDPWbvVfw948DC9XTHXPL/J53Oc3/B1+Optx4TYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgCISxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 14:53:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbgCISxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 14:53:47 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FCF220663;
        Mon,  9 Mar 2020 18:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583780026;
        bh=dz2ltX61FLJsnuQoPDCkE+3b8y0hvBuwOOYYzNY678c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fWFjQDXz/tUOTOceKt9kRGJrhJR+RVBovEfNDJD/aZ+mo2EiBPebNfCaPzkYQsdG3
         lbwFE3X5V5CAF+e7D69a2z3U2jvsFHFzslbVGyNPPk38zPM7uKDZoorq/oi7KxsLAW
         MdYgDbBN211fw2A7vdvAXpHef3uNZW0fm//b9zfE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ilie Halip <ilie.halip@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux@googlegroups.com
Subject: [PATCH 3/6] perf python: Fix clang detection when using CC=clang-version
Date:   Mon,  9 Mar 2020 15:53:20 -0300
Message-Id: <20200309185323.22583-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200309185323.22583-1-acme@kernel.org>
References: <20200309185323.22583-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilie Halip <ilie.halip@gmail.com>

Currently, the setup.py script detects the clang compiler only when invoked
with CC=3Dclang. But when using a specific version (e.g. CC=3Dclang-11), th=
is
doesn't work correctly and wrong compiler flags are set, leading to build
errors.

To properly detect clang, invoke the compiler with -v and check the output.
The first line should start with "clang version ...".

Committer testing:

  $ make CC=3Dclang-9 O=3D/tmp/build/perf -C tools/perf install-bin
  <SNIP>
  $ readelf -wi /tmp/build/perf/python/perf.cpython-37m-x86_64-linux-gnu.so=
 | grep DW_AT_producer | head -1
    <c>   DW_AT_producer    : (indirect string, offset: 0x0): clang version=
 9.0.1 (Fedora 9.0.1-2.fc31) /usr/bin/clang-9 -Wno-unused-result -Wsign-com=
pare -D DYNAMIC_ANNOTATIONS_ENABLED=3D1 -D NDEBUG -O2 -g -pipe -Wall -Werro=
r=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -fe=
xceptions -fstack-protector-strong -grecord-command-line -m64 -mtune=3Dgene=
ric -fasynchronous-unwind-tables -fcf-protection=3Dfull -D _GNU_SOURCE -fPI=
C -fwrapv -Wbad-function-cast -Wdeclaration-after-statement -Wformat-securi=
ty -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -Wn=
ested-externs -Wno-system-headers -Wold-style-definition -Wpacked -Wredunda=
nt-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwrite=
-strings -Wformat -Wshadow -D HAVE_ARCH_X86_64_SUPPORT -I /tmp/build/perf/a=
rch/x86/include/generated -D HAVE_SYSCALL_TABLE_SUPPORT -D HAVE_PERF_REGS_S=
UPPORT -D HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET -Werror -O3 -fno-omit-frame-=
pointer -ggdb3 -funwind-tables -Wall -Wextra -std=3Dgnu99 -fstack-protector=
-all -D _FORTIFY_SOURCE=3D2 -D _LARGEFILE64_SOURCE -D _FILE_OFFSET_BITS=3D6=
4 -D _GNU_SOURCE -I /home/acme/git/perf/tools/lib/perf/include -I /home/acm=
e/git/perf/tools/perf/util/include -I /home/acme/git/perf/tools/perf/arch/x=
86/include -I /home/acme/git/perf/tools/include/ -I /home/acme/git/perf/too=
ls/arch/x86/include/uapi -I /home/acme/git/perf/tools/include/uapi -I /home=
/acme/git/perf/tools/arch/x86/include/ -I /home/acme/git/perf/tools/arch/x8=
6/ -I /tmp/build/perf//util -I /tmp/build/perf/ -I /home/acme/git/perf/tool=
s/perf/util -I /home/acme/git/perf/tools/perf -I /home/acme/git/perf/tools/=
lib/ -D HAVE_PTHREAD_ATTR_SETAFFINITY_NP -D HAVE_PTHREAD_BARRIER -D HAVE_EV=
ENTFD -D HAVE_GET_CURRENT_DIR_NAME -D HAVE_GETTID -D HAVE_DWARF_GETLOCATION=
S_SUPPORT -D HAVE_GLIBC_SUPPORT -D HAVE_AIO_SUPPORT -D HAVE_SCHED_GETCPU_SU=
PPORT -D HAVE_SETNS_SUPPORT -D HAVE_LIBELF_SUPPORT -D HAVE_LIBELF_MMAP_SUPP=
ORT -D HAVE_ELF_GETPHDRNUM_SUPPORT -D HAVE_GELF_GETNOTE_SUPPORT -D HAVE_ELF=
_GETSHDRSTRNDX_SUPPORT -D HAVE_DWARF_SUPPORT -D HAVE_LIBBPF_SUPPORT -D HAVE=
_BPF_PROLOGUE -D HAVE_SDT_EVENT -D HAVE_JITDUMP -D HAVE_DWARF_UNWIND_SUPPOR=
T -D NO_LIBUNWIND_DEBUG_FRAME -D HAVE_LIBUNWIND_SUPPORT -D HAVE_LIBCRYPTO_S=
UPPORT -D HAVE_SLANG_SUPPORT -D HAVE_GTK2_SUPPORT -D NO_LIBPERL -D HAVE_TIM=
ERFD_SUPPORT -D HAVE_LIBPYTHON_SUPPORT -D HAVE_CPLUS_DEMANGLE_SUPPORT -D HA=
VE_LIBBFD_SUPPORT -D HAVE_ZLIB_SUPPORT -D HAVE_LZMA_SUPPORT -D HAVE_ZSTD_SU=
PPORT -D HAVE_LIBCAP_SUPPORT -D HAVE_BACKTRACE_SUPPORT -D HAVE_LIBNUMA_SUPP=
ORT -D HAVE_KVM_STAT_SUPPORT -D DISASM_FOUR_ARGS_SIGNATURE -D HAVE_LIBBABEL=
TRACE_SUPPORT -D HAVE_AUXTRACE_SUPPORT -D HAVE_JVMTI_CMLR -I /tmp/build/per=
f/ -fPIC -I util/include -I /usr/include/python3.7m -c /home/acme/git/perf/=
tools/perf/util/python.c -o /tmp/build/perf/python_ext_build/tmp/home/acme/=
git/perf/tools/perf/util/python.o -Wbad-function-cast -Wdeclaration-after-s=
tatement -Wformat-security -Wformat-y2k -Winit-self -Wmissing-declarations =
-Wmissing-prototypes -Wnested-externs -Wno-system-headers -Wold-style-defin=
ition -Wpacked -Wredundant-decls -Wstrict-prototypes -Wswitch-default -Wswi=
tch-enum -Wundef -Wwrite-strings -Wformat -Wshadow -D HAVE_ARCH_X86_64_SUPP=
ORT -I /tmp/build/perf/arch/x86/include/generated -D HAVE_SYSCALL_TABLE_SUP=
PORT -D HAVE_PERF_REGS_SUPPORT -D HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET -Wer=
ror -O3 -fno-omit-frame-pointer -ggdb3 -funwind-tables -Wall -Wextra -std=
=3Dgnu99 -fstack-protector-all -D _FORTIFY_SOURCE=3D2 -D _LARGEFILE64_SOURC=
E -D _FILE_OFFSET_BITS=3D64 -D _GNU_SOURCE -I /home/acme/git/perf/tools/lib=
/perf/include -I /home/acme/git/perf/tools/perf/util/include -I /home/acme/=
git/perf/tools/perf/arch/x86/include -I /home/acme/git/perf/tools/include/ =
-I /home/acme/git/perf/tools/arch/x86/include/uapi -I /home/acme/git/perf/t=
ools/include/uapi -I /home/acme/git/perf/tools/arch/x86/include/ -I /home/a=
cme/git/perf/tools/arch/x86/ -I /tmp/build/perf//util -I /tmp/build/perf/ -=
I /home/acme/git/perf/tools/perf/util -I /home/acme/git/perf/tools/perf -I =
/home/acme/git/perf/tools/lib/ -D HAVE_PTHREAD_ATTR_SETAFFINITY_NP -D HAVE_=
PTHREAD_BARRIER -D HAVE_EVENTFD -D HAVE_GET_CURRENT_DIR_NAME -D HAVE_GETTID=
 -D HAVE_DWARF_GETLOCATIONS_SUPPORT -D HAVE_GLIBC_SUPPORT -D HAVE_AIO_SUPPO=
RT -D HAVE_SCHED_GETCPU_SUPPORT -D HAVE_SETNS_SUPPORT -D HAVE_LIBELF_SUPPOR=
T -D HAVE_LIBELF_MMAP_SUPPORT -D HAVE_ELF_GETPHDRNUM_SUPPORT -D HAVE_GELF_G=
ETNOTE_SUPPORT -D HAVE_ELF_GETSHDRSTRNDX_SUPPORT -D HAVE_DWARF_SUPPORT -D H=
AVE_LIBBPF_SUPPORT -D HAVE_BPF_PROLOGUE -D HAVE_SDT_EVENT -D HAVE_JITDUMP -=
D HAVE_DWARF_UNWIND_SUPPORT -D NO_LIBUNWIND_DEBUG_FRAME -D HAVE_LIBUNWIND_S=
UPPORT -D HAVE_LIBCRYPTO_SUPPORT -D HAVE_SLANG_SUPPORT -D HAVE_GTK2_SUPPORT=
 -D NO_LIBPERL -D HAVE_TIMERFD_SUPPORT -D HAVE_LIBPYTHON_SUPPORT -D HAVE_CP=
LUS_DEMANGLE_SUPPORT -D HAVE_LIBBFD_SUPPORT -D HAVE_ZLIB_SUPPORT -D HAVE_LZ=
MA_SUPPORT -D HAVE_ZSTD_SUPPORT -D HAVE_LIBCAP_SUPPORT -D HAVE_BACKTRACE_SU=
PPORT -D HAVE_LIBNUMA_SUPPORT -D HAVE_KVM_STAT_SUPPORT -D DISASM_FOUR_ARGS_=
SIGNATURE -D HAVE_LIBBABELTRACE_SUPPORT -D HAVE_AUXTRACE_SUPPORT -D HAVE_JV=
MTI_CMLR -I /tmp/build/perf/ -fno-strict-aliasing -Wno-write-strings -Wno-u=
nused-parameter -Wno-redundant-decls
  $

And here is how tools/perf/util/setup.py checks if the used clang has
options that the distro specific python extension building compiler
defaults:

  if cc_is_clang:
      from distutils.sysconfig import get_config_vars
      vars =3D get_config_vars()
      for var in ('CFLAGS', 'OPT'):
          vars[var] =3D sub("-specs=3D[^ ]+", "", vars[var])
          if not clang_has_option("-mcet"):
              vars[var] =3D sub("-mcet", "", vars[var])
          if not clang_has_option("-fcf-protection"):
              vars[var] =3D sub("-fcf-protection", "", vars[var])
          if not clang_has_option("-fstack-clash-protection"):
              vars[var] =3D sub("-fstack-clash-protection", "", vars[var])
          if not clang_has_option("-fstack-protector-strong"):
              vars[var] =3D sub("-fstack-protector-strong", "", vars[var])

So "-fcf-protection=3Dfull" is used, clang-9 has this option and thus it
was kept, the perf python extension was built with it and the build
completed successfully.

Link: https://github.com/ClangBuiltLinux/linux/issues/903
Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Igor Lubashev <ilubashe@akamai.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: clang-built-linux@googlegroups.com
Link: http://lore.kernel.org/lkml/20200309085618.14307-1-ilie.halip@gmail.c=
om
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/setup.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index aa344a163eaf..8a065a6f9713 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -2,11 +2,13 @@ from os import getenv
 from subprocess import Popen, PIPE
 from re import sub
=20
+cc =3D getenv("CC")
+cc_is_clang =3D b"clang version" in Popen([cc, "-v"], stderr=3DPIPE).stder=
r.readline()
+
 def clang_has_option(option):
-    return [o for o in Popen(['clang', option], stderr=3DPIPE).stderr.read=
lines() if b"unknown argument" in o] =3D=3D [ ]
+    return [o for o in Popen([cc, option], stderr=3DPIPE).stderr.readlines=
() if b"unknown argument" in o] =3D=3D [ ]
=20
-cc =3D getenv("CC")
-if cc =3D=3D "clang":
+if cc_is_clang:
     from distutils.sysconfig import get_config_vars
     vars =3D get_config_vars()
     for var in ('CFLAGS', 'OPT'):
@@ -40,7 +42,7 @@ class install_lib(_install_lib):
 cflags =3D getenv('CFLAGS', '').split()
 # switch off several checks (need to be at the end of cflags list)
 cflags +=3D ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-pa=
rameter', '-Wno-redundant-decls' ]
-if cc !=3D "clang":
+if not cc_is_clang:
     cflags +=3D ['-Wno-cast-function-type' ]
=20
 src_perf  =3D getenv('srctree') + '/tools/perf'
--=20
2.21.1

