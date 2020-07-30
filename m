Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14559C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 11:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDE2C2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 11:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596108028;
	bh=t41Y67WswJDQsOulqgSqBi6v7IHdoYCB9FR6582zK6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r2RbXsqzbFCeCXmQpQcBdhTalq+AVeeuhBtrDybT1qITWRSMRBd6q7Ts1Q9ssk1kH
	 OuXsPjAnbUwYPJdQMM8klqKmY9zFcjmT9ZTBc2B3UQ0s3b+CjmZHfqIUEl359S9p5k
	 ug+EaCSMHLlSrR+RJnCtZwZPFF7boDi2lzZOk0bc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgG3LU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 07:20:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgG3LU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 07:20:26 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.177.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFFC32074B;
        Thu, 30 Jul 2020 11:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596108025;
        bh=t41Y67WswJDQsOulqgSqBi6v7IHdoYCB9FR6582zK6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UIT0fxHbSe1nk6d4+dy0GwaTup0VUagKznZ7bGlhkJLxdeUk7XPl5kIlq7/hxT4xe
         2nHG+aFlF697Y/p3zGf1p2mDLVOUNwJld/yk84iH+JG02+kc2UYmhkhy+Du6TObyZX
         K56RK71chKO5BeyjYIz9EHWIafTeXAUeXW+sG/d4=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 607C440E7E; Thu, 30 Jul 2020 08:20:22 -0300 (-03)
Date:   Thu, 30 Jul 2020 08:20:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [perf] Explicitly use python[3]-[config]
Message-ID: <20200730112022.GE424218@kernel.org>
References: <CA+icZUXiz52bk+8bbLTuYCDLqoF9zLiV6NEjzPRgodu3FzCFLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUXiz52bk+8bbLTuYCDLqoF9zLiV6NEjzPRgodu3FzCFLg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 30, 2020 at 12:06:55PM +0200, Sedat Dilek escreveu:
> Hi,
> 
> I wanted to have some detailed numbers for building a Linux-kernel
> with GNU-eco-system means GNU/gcc-10 and GNU/binutils-2,35 VS.
> LLVM/Clang with its utils version 11.0.0-rc1.
> 
> Arnd recommended me to use "perf stat make ...".

from tools/perf/Makefile.perf

# Define NO_LIBPYTHON to disable python script extension.
#
# Define PYTHON to point to the python binary if the default
# `python' is not correct; for example: PYTHON=python2
#
# Define PYTHON_CONFIG to point to the python-config binary if
# the default `$(PYTHON)-config' is not correct.


Try:

  $ make -C tools/perf PYTHON=python3 install-bin
  make: Entering directory '/home/acme/git/perf/tools/perf'
    BUILD:   Doing 'make -j8' parallel build
  
  Auto-detecting system features:
  ...                         dwarf: [ on  ]
  ...            dwarf_getlocations: [ on  ]
  ...                         glibc: [ on  ]
  ...                          gtk2: [ on  ]
  ...                        libbfd: [ on  ]
  ...                        libcap: [ on  ]
  ...                        libelf: [ on  ]
  ...                       libnuma: [ on  ]
  ...        numa_num_possible_cpus: [ on  ]
  ...                       libperl: [ on  ]
  ...                     libpython: [ on  ]
  ...                     libcrypto: [ on  ]
  ...                     libunwind: [ on  ]
  ...            libdw-dwarf-unwind: [ on  ]
  ...                          zlib: [ on  ]
  ...                          lzma: [ on  ]
  ...                     get_cpuid: [ on  ]
  ...                           bpf: [ on  ]
  ...                        libaio: [ on  ]
  ...                       libzstd: [ on  ]
  ...        disassembler-four-args: [ on  ]
  
    CC       builtin-bench.o
    CC       jvmti/libjvmti.o
    CC       builtin-annotate.o
    <SNIP>
    LD       util/perf-in.o
    LD       perf-in.o
    LINK     perf
    INSTALL  binaries
    INSTALL  tests
    INSTALL  perf-read-vdso32
    INSTALL  libperf-jvmti.so
    INSTALL  libexec
    INSTALL  bpf-headers
    INSTALL  bpf-examples
    INSTALL  perf-archive
    INSTALL  perf-with-kcore
    INSTALL  strace/groups
    INSTALL  perl-scripts
    INSTALL  python-scripts
    INSTALL  perf_completion-script
    INSTALL  perf-tip
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
  $ perf -vv
  perf version 5.8.rc4.g0a569391c06e
                   dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
      dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                   glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
                    gtk2: [ on  ]  # HAVE_GTK2_SUPPORT
           syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                  libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
                  libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
                 libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
  numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
                 libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
               libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
                libslang: [ on  ]  # HAVE_SLANG_SUPPORT
               libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
               libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
      libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                    zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                    lzma: [ on  ]  # HAVE_LZMA_SUPPORT
               get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                     bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
                     aio: [ on  ]  # HAVE_AIO_SUPPORT
                    zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
  $
  $ ldd ~/bin/perf | grep python
  	libpython3.8.so.1.0 => /lib64/libpython3.8.so.1.0 (0x00007f37f65ba000)
  $
 
> First, I tried to build it out of tools/perf from linux.git:
> 
> MAKE_OPTS="HOSTCC=clang-11 HOSTCXX=clang++-11 HOSTLD=ld.lld-11
> HOSTAR=llvm-ar-11 CC=clang-11 LD=ld.lld-11 AR=llvm-ar-11 NM=llvm-nm-11
> OBJCOPY=llvm-objcopy-11 OBJDUMP=llvm-objdump-11 OBJSIZE=llvm-size-11
> READELF=llvm-readelf-11 STRIP=llvm-strip-11 LLVM_IAS=1"
> 
> LC_ALL=C make V=1 $MAKE_OPTS -C tools/ perf 2>&1 | tee ../build-perf.txt
> 
> That showed me - it is building against libpython2.
> 
> As python3 is now default for Debian/unstable (and AFAICS
> Debian/testing) I wanted to build explicitly against libpython3 at its
> python3-config.
> 
> This needs some hacks like (furthermore I do not want CID in my version-string):

Shouldn't be needed, see above, and yes, we need to make python3 be the
default.

my debian:experimental test build container has:

perfbuilder@8b7dacb5bb86:/$ cat /etc/debian_version
bullseye/sid
perfbuilder@8b7dacb5bb86:/$ clang -v
clang version 9.0.1-13
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/9
Found candidate GCC installation: /usr/lib/gcc/x86_64-linux-gnu/9
Selected GCC installation: /usr/bin/../lib/gcc/x86_64-linux-gnu/9
Candidate multilib: .;@m64
Selected multilib: .;@m64
perfbuilder@8b7dacb5bb86:/$

I'll see why it is not yet at clang 11...

Last test build was yesterday:

[root@quaco ~]# grep "CC=clang" dm.log/debian\:experimental
+ make ARCH= CROSS_COMPILE= EXTRA_CFLAGS= -C /git/linux/tools/perf O=/tmp/build/perf CC=clang
+ make ARCH= CROSS_COMPILE= EXTRA_CFLAGS= NO_LIBELF=1 -C /git/linux/tools/perf O=/tmp/build/perf CC=clang
+ make ARCH= CROSS_COMPILE= EXTRA_CFLAGS= NO_LIBBPF=1 -C /git/linux/tools/perf O=/tmp/build/perf CC=clang
[root@quaco ~]#

Those build without problems, after a fix for building libtraceevent
with binutils 2.35, that you'll probably need, its at:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=tmp.perf/core&id=0a569391c06ee73a132eb395b23b2fe823138835

Please let me know if you need further help.

- Arnaldo
 
> $ cat ~/src/linux-kernel/perf.diff
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 513633809c81..b4da50754b19 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -225,12 +225,13 @@ endif
>  # python[2][-config] in weird combinations but always preferring
>  # python2 and python2-config as per pep-0394. If we catch a
>  # python[-config] in version 3, the version check will kill it.
> -PYTHON2 := $(if $(call get-executable,python2),python2,python)
> -override PYTHON := $(call get-executable-or-default,PYTHON,$(PYTHON2))
> -PYTHON2_CONFIG := \
> +# XXX: Explicitly use python3[-config]. -dileks
> +PYTHON3 := $(if $(call get-executable,python3),python3,python)
> +override PYTHON := $(call get-executable-or-default,PYTHON,$(PYTHON3))
> +PYTHON3_CONFIG := \
>    $(if $(call get-executable,$(PYTHON)-config),$(PYTHON)-config,python-config)
>  override PYTHON_CONFIG := \
> -  $(call get-executable-or-default,PYTHON_CONFIG,$(PYTHON2_CONFIG))
> +  $(call get-executable-or-default,PYTHON_CONFIG,$(PYTHON3_CONFIG))
> 
>  grep-libs  = $(filter -l%,$(1))
>  strip-libs  = $(filter-out -l%,$(1))
> diff --git a/tools/perf/util/PERF-VERSION-GEN b/tools/perf/util/PERF-VERSION-GEN
> index 59241ff342be..eed9be9a13de 100755
> --- a/tools/perf/util/PERF-VERSION-GEN
> +++ b/tools/perf/util/PERF-VERSION-GEN
> @@ -28,6 +28,8 @@ if test -z "$TAG"
>  then
>         TAG=$(MAKEFLAGS= make -sC ../.. kernelversion)
>  fi
> +# XXX: Do not use Git Commit-ID (CID) in version string. -dileks
> +CID=
>  VN="$TAG$CID"
>  if test -n "$CID"
>  then
> 
> In Debian/unstable libpython-dev:amd64 is version 2.7.17-2 and thus
> ships appropriate python[2]-config.
> 
> What are your recommendations to build explicitly against python3 and
> its python3-config (here: Debian ships python3 version 3.8.5)?
> 
> I can send you my build-perf.txt if needed (approx. 830kiB).
> 
> Thanks.
> 
> Regards,
> - Sedat -
> 
> [1] https://github.com/ClangBuiltLinux/linux/issues/1086#issuecomment-665540053
> 
> P.S.: Uninstall all python2 dev packages and replace them via python3
> dev packages.
> 
> # diff -uprN packages_0518.txt packages_0519.txt | egrep '^[+|-]ii'
> -ii libpython-dev:amd64 2.7.17-2
> -ii libpython2-dev:amd64 2.7.17-2
> -ii libpython2.7-dev:amd64 2.7.18-1
> +ii libpython3-dev:amd64 3.8.2-3
> +ii libpython3.8-dev:amd64 3.8.5-1
> +ii libunwind-dev:amd64 1.2.1-11
> +ii libzstd-dev:amd64 1.4.5+dfsg-3
> +ii lz4 1.9.2-2
> -ii python-dev 2.7.17-2
> -ii python2-dev 2.7.17-2
> -ii python2.7-dev 2.7.18-1
> +ii python3-dev 3.8.2-3
> +ii python3.8-dev 3.8.5-1
> +ii systemtap-sdt-dev 4.3-1
> 
> - EOT -

-- 

- Arnaldo
