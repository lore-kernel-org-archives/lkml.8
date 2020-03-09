Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA216C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B246B20675
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hccoAcm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgCINFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 09:05:19 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:38585 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgCINFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 09:05:19 -0400
Received: by mail-qt1-f172.google.com with SMTP id e20so6875950qto.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 06:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bCkrqFSza+GuAgjgOIEFqDUZgMNcJ9GnqqKHuJSixwQ=;
        b=hccoAcm3G5LmZlNvlC28c9sQAWLcAJTbrfuAdLtcHvz8tjRKXxQv2NYmMcsdMliVGC
         fH2T4bRQPZEUYyT4hkAyL2niWEqMVtAJqoSqRmh+uOJokK5TYDM4jvGs+lTRYfVwVxTu
         stXD3xp5aoTF00eWan21eQ/8R1HQAhwUYHZcN2q86fLfUwgKqxwjd9nblYeOyIenQmnd
         Bxns+VPCdAhv6IAH1zRn4yi9efU6Z0S9L/WZvojscUerwYHdPRnyTBDzaNJbnvJ4mLRf
         73Ea6YIqRfAKHZdB7WGTs1emenhACyqwRe0nwekx5Mm+0SxxeZvDWwwHJhI6obb2TxUI
         rkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bCkrqFSza+GuAgjgOIEFqDUZgMNcJ9GnqqKHuJSixwQ=;
        b=bW88ae23Kzm1qRvp/igBQPHoqrXLHkd1cKFo8Rtozox0eAp6Y8YMm5ElZtOIdW8fkp
         ZM3rdUNYR8kYxFOylTJ2jV/8/8m92UGzpJKYpjqKmIzJr/bGXklSjOzKS6fTFg72J8xW
         hmchfCtICG75QIk7ErdLnRZS6EIRSizaAVgwpjBrivNehzDc2Ps1V3CEsJqA2VMvWHaQ
         9lagXN5oSiV7sE0uLUa+OmuggSwl820AupY0SScQwYEAdh9YVuhGElbjUOZ+bNM9rv26
         LFSQpYNKbU9Ejpz6vJwg21ujx0wrT19jyNf6FKv1IXg2zoiTD6yBMp1B2Pu83DnSx3Ig
         8MEA==
X-Gm-Message-State: ANhLgQ05r9oomJ4sEmy/K/AiVfXHrL8kRbFuaddcALxfC7ZzfYnnprUm
        hSQPLZka9r7nLt65MP/Tgkg=
X-Google-Smtp-Source: ADFU+vvq9NMLZGi/3Ef3Go2wYxcS3FYvemBUoPJfjOgal2XIN9MK8L8ao61Fkn4cXIJWlTKFvoCNnA==
X-Received: by 2002:ac8:a83:: with SMTP id d3mr14614338qti.228.1583759116960;
        Mon, 09 Mar 2020 06:05:16 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id i28sm23190789qtc.57.2020.03.09.06.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 06:05:16 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 73FB140009; Mon,  9 Mar 2020 10:05:12 -0300 (-03)
Date:   Mon, 9 Mar 2020 10:05:12 -0300
To:     Ilie Halip <ilie.halip@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Igor Lubashev <ilubashe@akamai.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] perf python: better clang detection
Message-ID: <20200309130512.GA32666@kernel.org>
References: <20200309085618.14307-1-ilie.halip@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200309085618.14307-1-ilie.halip@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 09, 2020 at 10:56:17AM +0200, Ilie Halip escreveu:
> Currently, the setup.py script detects the clang compiler only when invok=
ed
> with CC=3Dclang. But when using a specific version (e.g. CC=3Dclang-11), =
this
> doesn't work correctly and wrong compiler flags are set, leading to build
> errors.
>=20
> To properly detect clang, invoke the compiler with -v and check the outpu=
t.
> The first line should start with "clang version ...".
>=20
> Link: https://github.com/ClangBuiltLinux/linux/issues/903
> Signed-off-by: Ilie Halip <ilie.halip@gmail.com>

Thanks, tested, added the testing performed (see below) to the cset
message and applied,

- Arnaldo

commit a7ffd416d80497f03d1f62c0b330cff76a86d5ad
Author: Ilie Halip <ilie.halip@gmail.com>
Date:   Mon Mar 9 10:56:17 2020 +0200

    perf python: Fix clang detection when using CC=3Dclang-version
   =20
    Currently, the setup.py script detects the clang compiler only when inv=
oked
    with CC=3Dclang. But when using a specific version (e.g. CC=3Dclang-11)=
, this
    doesn't work correctly and wrong compiler flags are set, leading to bui=
ld
    errors.
   =20
    To properly detect clang, invoke the compiler with -v and check the out=
put.
    The first line should start with "clang version ...".
   =20
    Committer testing:
   =20
      $ make CC=3Dclang-9 O=3D/tmp/build/perf -C tools/perf install-bin
      <SNIP>
      $ readelf -wi /tmp/build/perf/python/perf.cpython-37m-x86_64-linux-gn=
u.so | grep DW_AT_producer | head -1
        <c>   DW_AT_producer    : (indirect string, offset: 0x0): clang ver=
sion 9.0.1 (Fedora 9.0.1-2.fc31) /usr/bin/clang-9 -Wno-unused-result -Wsign=
-compare -D DYNAMIC_ANNOTATIONS_ENABLED=3D1 -D NDEBUG -O2 -g -pipe -Wall -W=
error=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS=
 -fexceptions -fstack-protector-strong -grecord-command-line -m64 -mtune=3D=
generic -fasynchronous-unwind-tables -fcf-protection=3Dfull -D _GNU_SOURCE =
-fPIC -fwrapv -Wbad-function-cast -Wdeclaration-after-statement -Wformat-se=
curity -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes=
 -Wnested-externs -Wno-system-headers -Wold-style-definition -Wpacked -Wred=
undant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Ww=
rite-strings -Wformat -Wshadow -D HAVE_ARCH_X86_64_SUPPORT -I /tmp/build/pe=
rf/arch/x86/include/generated -D HAVE_SYSCALL_TABLE_SUPPORT -D HAVE_PERF_RE=
GS_SUPPORT -D HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET -Werror -O3 -fno-omit-fr=
ame-pointer -ggdb3 -funwind-tables -Wall -Wextra -std=3Dgnu99 -fstack-prote=
ctor-all -D _FORTIFY_SOURCE=3D2 -D _LARGEFILE64_SOURCE -D _FILE_OFFSET_BITS=
=3D64 -D _GNU_SOURCE -I /home/acme/git/perf/tools/lib/perf/include -I /home=
/acme/git/perf/tools/perf/util/include -I /home/acme/git/perf/tools/perf/ar=
ch/x86/include -I /home/acme/git/perf/tools/include/ -I /home/acme/git/perf=
/tools/arch/x86/include/uapi -I /home/acme/git/perf/tools/include/uapi -I /=
home/acme/git/perf/tools/arch/x86/include/ -I /home/acme/git/perf/tools/arc=
h/x86/ -I /tmp/build/perf//util -I /tmp/build/perf/ -I /home/acme/git/perf/=
tools/perf/util -I /home/acme/git/perf/tools/perf -I /home/acme/git/perf/to=
ols/lib/ -D HAVE_PTHREAD_ATTR_SETAFFINITY_NP -D HAVE_PTHREAD_BARRIER -D HAV=
E_EVENTFD -D HAVE_GET_CURRENT_DIR_NAME -D HAVE_GETTID -D HAVE_DWARF_GETLOCA=
TIONS_SUPPORT -D HAVE_GLIBC_SUPPORT -D HAVE_AIO_SUPPORT -D HAVE_SCHED_GETCP=
U_SUPPORT -D HAVE_SETNS_SUPPORT -D HAVE_LIBELF_SUPPORT -D HAVE_LIBELF_MMAP_=
SUPPORT -D HAVE_ELF_GETPHDRNUM_SUPPORT -D HAVE_GELF_GETNOTE_SUPPORT -D HAVE=
_ELF_GETSHDRSTRNDX_SUPPORT -D HAVE_DWARF_SUPPORT -D HAVE_LIBBPF_SUPPORT -D =
HAVE_BPF_PROLOGUE -D HAVE_SDT_EVENT -D HAVE_JITDUMP -D HAVE_DWARF_UNWIND_SU=
PPORT -D NO_LIBUNWIND_DEBUG_FRAME -D HAVE_LIBUNWIND_SUPPORT -D HAVE_LIBCRYP=
TO_SUPPORT -D HAVE_SLANG_SUPPORT -D HAVE_GTK2_SUPPORT -D NO_LIBPERL -D HAVE=
_TIMERFD_SUPPORT -D HAVE_LIBPYTHON_SUPPORT -D HAVE_CPLUS_DEMANGLE_SUPPORT -=
D HAVE_LIBBFD_SUPPORT -D HAVE_ZLIB_SUPPORT -D HAVE_LZMA_SUPPORT -D HAVE_ZST=
D_SUPPORT -D HAVE_LIBCAP_SUPPORT -D HAVE_BACKTRACE_SUPPORT -D HAVE_LIBNUMA_=
SUPPORT -D HAVE_KVM_STAT_SUPPORT -D DISASM_FOUR_ARGS_SIGNATURE -D HAVE_LIBB=
ABELTRACE_SUPPORT -D HAVE_AUXTRACE_SUPPORT -D HAVE_JVMTI_CMLR -I /tmp/build=
/perf/ -fPIC -I util/include -I /usr/include/python3.7m -c /home/acme/git/p=
erf/tools/perf/util/python.c -o /tmp/build/perf/python_ext_build/tmp/home/a=
cme/git/perf/tools/perf/util/python.o -Wbad-function-cast -Wdeclaration-aft=
er-statement -Wformat-security -Wformat-y2k -Winit-self -Wmissing-declarati=
ons -Wmissing-prototypes -Wnested-externs -Wno-system-headers -Wold-style-d=
efinition -Wpacked -Wredundant-decls -Wstrict-prototypes -Wswitch-default -=
Wswitch-enum -Wundef -Wwrite-strings -Wformat -Wshadow -D HAVE_ARCH_X86_64_=
SUPPORT -I /tmp/build/perf/arch/x86/include/generated -D HAVE_SYSCALL_TABLE=
_SUPPORT -D HAVE_PERF_REGS_SUPPORT -D HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET =
-Werror -O3 -fno-omit-frame-pointer -ggdb3 -funwind-tables -Wall -Wextra -s=
td=3Dgnu99 -fstack-protector-all -D _FORTIFY_SOURCE=3D2 -D _LARGEFILE64_SOU=
RCE -D _FILE_OFFSET_BITS=3D64 -D _GNU_SOURCE -I /home/acme/git/perf/tools/l=
ib/perf/include -I /home/acme/git/perf/tools/perf/util/include -I /home/acm=
e/git/perf/tools/perf/arch/x86/include -I /home/acme/git/perf/tools/include=
/ -I /home/acme/git/perf/tools/arch/x86/include/uapi -I /home/acme/git/perf=
/tools/include/uapi -I /home/acme/git/perf/tools/arch/x86/include/ -I /home=
/acme/git/perf/tools/arch/x86/ -I /tmp/build/perf//util -I /tmp/build/perf/=
 -I /home/acme/git/perf/tools/perf/util -I /home/acme/git/perf/tools/perf -=
I /home/acme/git/perf/tools/lib/ -D HAVE_PTHREAD_ATTR_SETAFFINITY_NP -D HAV=
E_PTHREAD_BARRIER -D HAVE_EVENTFD -D HAVE_GET_CURRENT_DIR_NAME -D HAVE_GETT=
ID -D HAVE_DWARF_GETLOCATIONS_SUPPORT -D HAVE_GLIBC_SUPPORT -D HAVE_AIO_SUP=
PORT -D HAVE_SCHED_GETCPU_SUPPORT -D HAVE_SETNS_SUPPORT -D HAVE_LIBELF_SUPP=
ORT -D HAVE_LIBELF_MMAP_SUPPORT -D HAVE_ELF_GETPHDRNUM_SUPPORT -D HAVE_GELF=
_GETNOTE_SUPPORT -D HAVE_ELF_GETSHDRSTRNDX_SUPPORT -D HAVE_DWARF_SUPPORT -D=
 HAVE_LIBBPF_SUPPORT -D HAVE_BPF_PROLOGUE -D HAVE_SDT_EVENT -D HAVE_JITDUMP=
 -D HAVE_DWARF_UNWIND_SUPPORT -D NO_LIBUNWIND_DEBUG_FRAME -D HAVE_LIBUNWIND=
_SUPPORT -D HAVE_LIBCRYPTO_SUPPORT -D HAVE_SLANG_SUPPORT -D HAVE_GTK2_SUPPO=
RT -D NO_LIBPERL -D HAVE_TIMERFD_SUPPORT -D HAVE_LIBPYTHON_SUPPORT -D HAVE_=
CPLUS_DEMANGLE_SUPPORT -D HAVE_LIBBFD_SUPPORT -D HAVE_ZLIB_SUPPORT -D HAVE_=
LZMA_SUPPORT -D HAVE_ZSTD_SUPPORT -D HAVE_LIBCAP_SUPPORT -D HAVE_BACKTRACE_=
SUPPORT -D HAVE_LIBNUMA_SUPPORT -D HAVE_KVM_STAT_SUPPORT -D DISASM_FOUR_ARG=
S_SIGNATURE -D HAVE_LIBBABELTRACE_SUPPORT -D HAVE_AUXTRACE_SUPPORT -D HAVE_=
JVMTI_CMLR -I /tmp/build/perf/ -fno-strict-aliasing -Wno-write-strings -Wno=
-unused-parameter -Wno-redundant-decls
      $
   =20
    And here is how tools/perf/util/setup.py checks if the used clang has
    options that the distro specific python extension building compiler
    defaults:
   =20
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
                  vars[var] =3D sub("-fstack-clash-protection", "", vars[va=
r])
              if not clang_has_option("-fstack-protector-strong"):
                  vars[var] =3D sub("-fstack-protector-strong", "", vars[va=
r])
   =20
    So "-fcf-protection=3Dfull" is used, clang-9 has this option and thus it
    was kept, the perf python extension was built with it and the build
    completed successfully.
   =20
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
    Link: http://lore.kernel.org/lkml/20200309085618.14307-1-ilie.halip@gma=
il.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

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
