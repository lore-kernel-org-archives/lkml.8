Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CF2C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DFD520784
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSZQi8GY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbgCaQEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:04:09 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36115 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731335AbgCaQEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:04:07 -0400
Received: by mail-qt1-f196.google.com with SMTP id m33so18770675qtb.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 09:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h3lashHytM69riBJIUhVExzPLa6j948U2YdodKEKKiA=;
        b=VSZQi8GY3QIsXykC8iEDjNnuJChvxDjeXbODbXyAuH7nNL7tlq5bb5MoQEkn1LbrCh
         TJeWJknA9u3HELhLL1YuNaCCyM4aqmKdHwpVPqIecMwg5E8gVzRmCpwPI8CxrbBED0ER
         5EX/xYQoc/kwvd1uCB0ph1X61z/X8D3KOfAJLaA9aydsUKKWvo34m9DOGN0fAESVuvbT
         oaATMtMdl9HHOednKu7z4lDIEmXbHXU64rGUVNiPzxUdIpb/y/cPS8YFTiqeSu/eC9cB
         zbzMzzbtqVPrL2Yb715C6TlhgwqVFPurXGxqlHgDYZ4tr/njhEPkuvAGW1QuCtFBOtxj
         8gHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h3lashHytM69riBJIUhVExzPLa6j948U2YdodKEKKiA=;
        b=kEycJ1TFwf7U8hcN3vmpoZEapvLTj7QuS1pfSr9joYpUgLXF4wnuRe5Odqc84q52LA
         nsvfKejGa7C7hXjBA3eR6hpbKizxilp2nf1zyrndXbbnSqknOMkGpvozHUpX1/yqSrsQ
         h71ML7g3xwqoyqVtFvnd3Ct2hmtmmTpEDKAdw/c5JhCSPrhNdTgNfGWlO+wGcKr9ehzT
         3fdthtbRM+ZY6BwwIEbVy//fCwo8/uiwq8MuFp+TgOTSzbJNX1DRQSt8SdaT9FFCVpdG
         0qPuuax14uOkuntNtUQuzxL+xYInX1/0i8n3qck0uQYGXeqFrR9MdToP+Xy7G3rCa4i9
         CuBw==
X-Gm-Message-State: ANhLgQ0k3uxH5UjmzGhpjGttyP3dv4QtVVrQ8ko51RaeAxzm8MExzC+a
        3c1RGXNW9iFpX/yA+3xYCLHuvrR2
X-Google-Smtp-Source: ADFU+vsDg5zdhzdXHbQj7rtOLeTx2rtX2v+3oPyFzaASnZfGjPcGY0SGH78HhHaqpcnOT4peBtAI7Q==
X-Received: by 2002:aed:2625:: with SMTP id z34mr5988774qtc.276.1585670646580;
        Tue, 31 Mar 2020 09:04:06 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id h3sm13386873qto.1.2020.03.31.09.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 09:04:05 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C1E7B409A3; Tue, 31 Mar 2020 13:04:03 -0300 (-03)
Date:   Tue, 31 Mar 2020 13:04:03 -0300
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH 6/9] perf record: Support synthesizing cgroup events
Message-ID: <20200331160403.GE4576@kernel.org>
References: <20200325124536.2800725-1-namhyung@kernel.org>
 <20200325124536.2800725-7-namhyung@kernel.org>
 <20200330163058.GC4576@kernel.org>
 <20200330164312.GD4576@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330164312.GD4576@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 30, 2020 at 01:43:12PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Mar 30, 2020 at 01:30:58PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Mar 25, 2020 at 09:45:33PM +0900, Namhyung Kim escreveu:
> > > Synthesize cgroup events by iterating cgroup filesystem directories.
> > > The cgroup event only saves the portion of cgroup path after the mount
> > > point and the cgroup id (which actually is a file handle).
> > 
> > Breaks the build on alpine linux (musl libc):
> > 
> >   CC       /tmp/build/perf/util/srccode.o
> >   CC       /tmp/build/perf/util/synthetic-events.o
> > util/synthetic-events.c: In function 'perf_event__synthesize_cgroup':
> > util/synthetic-events.c:427:22: error: field 'fh' has incomplete type
> >    struct file_handle fh;
> >                       ^
> > util/synthetic-events.c:441:6: error: implicit declaration of function 'name_to_handle_at' [-Werror=implicit-function-declaration]
> >   if (name_to_handle_at(AT_FDCWD, path, &handle.fh, &mount_id, 0) < 0) {
> >       ^
> > util/synthetic-events.c:441:2: error: nested extern declaration of 'name_to_handle_at' [-Werror=nested-externs]
> >   if (name_to_handle_at(AT_FDCWD, path, &handle.fh, &mount_id, 0) < 0) {
> >   ^
> >   CC       /tmp/build/perf/util/data.o
> > cc1: all warnings being treated as errors
> > mv: can't rename '/tmp/build/perf/util/.synthetic-events.o.tmp': No such file or directory
> > 
> > 
> > I'm trying to fix
> 
> musl libc up to 1.2.21 (IIRC) lacks name_to_handle_at and its structs,
> then from the one that is in alpine linux 3.10 the error changes to:
> 
>   CC       /tmp/build/perf/util/cloexec.o
> util/synthetic-events.c:427:22: error: field 'fh' with variable sized type 'struct file_handle' not at the end of a struct or class is a GNU
>       extension [-Werror,-Wgnu-variable-sized-type-not-at-end]
>                 struct file_handle fh;
>                                    ^
> 1 error generated.
> mv: can't rename '/tmp/build/perf/util/.synthetic-events.o.tmp': No such file or directory
> make[4]: *** [/git/linux/tools/build/Makefile.build:97: /tmp/build/perf/util/synthetic-events.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [/git/linux/tools/build/Makefile.build:139: util] Error 2
> make[2]: *** [Makefile.perf:617: /tmp/build/perf/perf-in.o] Error 2
> make[1]: *** [Makefile.perf:225: sub-make] Error 2
> make: *** [Makefile:70: all] Error 2
> make: Leaving directory '/git/linux/tools/perf'
> + exit 1
> [root@quaco ~]#
> 
> So probably we'll need a feature test to catch this and do some
> workaround or disable the feature on such systems, providing some
> warning.
> 
> I left the container build tests running to see if some other system has
> problems with this, perhaps the ones with uCLibc or some older glibc,
> we'll see.
> 
> So far all the alpine versions failed with the above problems and ALT
> Linux p8 and p9 built without problems.

  13   129.90 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2), clang version 3.6.2 (tags/RELEASE_362/final)
  14   192.36 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6), clang version 7.0.1 (Amazon Linux 2 7.0.1-1.amzn2.0.2)
  15    16.02 android-ndk:r12b-arm          : FAIL arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  16    16.35 android-ndk:r15c-arm          : FAIL arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  17    13.42 centos:5                      : FAIL gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  18    18.39 centos:6                      : FAIL gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  19    54.36 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39)
  20   215.20 centos:8                      : Ok   gcc (GCC) 8.3.1 20190507 (Red Hat 8.3.1-4), clang version 8.0.1 (Red Hat 8.0.1-1.module_el8.1.0+215+a01033fb)
  21    54.41 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 9.2.1 20200214 gcc_9_2_0_release-615-g7866f9ebf1, clang version 9.0.1 
  22   139.44 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2, Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
  23   153.99 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516, clang version 3.8.1-24 (tags/RELEASE_381/final)
  24   157.00 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0, clang version 7.0.1-8 (tags/RELEASE_701/final)
  25   170.15 debian:experimental           : Ok   gcc (Debian 9.2.1-28) 9.2.1 20200203, clang version 8.0.1-7 (tags/RELEASE_801/final)
  26    28.45 debian:experimental-x-arm64   : FAIL aarch64-linux-gnu-gcc (Debian 8.3.0-19) 8.3.0

This one was something else, and I bet the other arm64 were the same
  thing:

  CC       /tmp/build/perf/tests/parse-events.o
arch/arm64/util/machine.c: In function 'arch__symbols__fixup_end':
arch/arm64/util/machine.c:19:7: error: implicit declaration of function 'strchr' [-Werror=implicit-function-declaration]
  if ((strchr(p->name, '[') && strchr(c->name, '[') == NULL) ||
       ^~~~~~
arch/arm64/util/machine.c:19:7: error: incompatible implicit declaration of built-in function 'strchr' [-Werror]
arch/arm64/util/machine.c:19:7: note: include '<string.h>' or provide a declaration of 'strchr'
arch/arm64/util/machine.c:6:1:
+#include <string.h>
 
arch/arm64/util/machine.c:19:7:
  if ((strchr(p->name, '[') && strchr(c->name, '[') == NULL) ||
       ^~~~~~
cc1: all warnings being treated as errors
mv: cannot stat '/tmp/build/perf/arch/arm64/util/.machine.o.tmp': No such file or directory
make[6]: *** [/git/linux/tools/build/Makefile.build:97: /tmp/build/perf/arch/arm64/util/machine.o] Error 1


  27    60.23 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.3.0-19) 8.3.0
  28    54.38 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 9.2.1-24) 9.2.1 20200117
  29    60.29 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 9.2.1-8) 9.2.1 20190909
  30    51.92 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  31    54.05 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6), clang version 3.5.0 (tags/RELEASE_350/final)
  32   142.15 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6), clang version 3.7.0 (tags/RELEASE_370/final)
  33   160.24 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1), clang version 3.8.1 (tags/RELEASE_381/final)
  34    20.46 fedora:24-x-ARC-uClibc        : FAIL arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  35   161.31 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1), clang version 3.9.1 (tags/RELEASE_391/final)
  36   182.38 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2), clang version 4.0.1 (tags/RELEASE_401/final)
  37   178.68 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6), clang version 5.0.2 (tags/RELEASE_502/final)
  38   199.12 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 6.0.1 (tags/RELEASE_601/final)
  39   209.86 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 7.0.1 (Fedora 7.0.1-6.fc29)
  40   213.17 fedora:30                     : Ok   gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1), clang version 8.0.0 (Fedora 8.0.0-3.fc30)
  41    53.64 fedora:30-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225
  42    20.78 fedora:30-x-ARC-uClibc        : FAIL arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225

Same thing as with fedora:24-x-ARC-uClibc:

  CC       /tmp/build/perf/util/tsc.o
util/synthetic-events.c: In function 'perf_event__synthesize_cgroup':
util/synthetic-events.c:427:22: error: field 'fh' has incomplete type
   struct file_handle fh;
                      ^~
util/synthetic-events.c:441:6: error: implicit declaration of function 'name_to_handle_at' [-Werror=implicit-function-declaration]
  if (name_to_handle_at(AT_FDCWD, path, &handle.fh, &mount_id, 0) < 0) {
      ^~~~~~~~~~~~~~~~~
util/synthetic-events.c:441:6: error: nested extern declaration of 'name_to_handle_at' [-Werror=nested-externs]
  CC       /tmp/build/perf/util/cloexec.o
  CC       /tmp/build/perf/util/call-path.o
cc1: all warnings being treated as errors


  43   215.94 fedora:31                     : Ok   gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1), clang version 9.0.1 (Fedora 9.0.1-2.fc31)
  44   181.57 fedora:32                     : Ok   gcc (GCC) 10.0.1 20200216 (Red Hat 10.0.1-0.8), clang version 10.0.0 (Fedora 10.0.0-0.1.rc2.fc32)
  45   185.19 fedora:rawhide                : Ok   gcc (GCC) 10.0.1 20200216 (Red Hat 10.0.1-0.8), clang version 10.0.0 (Fedora 10.0.0-0.3.rc2.fc33)
  46    62.84 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 9.2.0-r2 p3) 9.2.0
  47   139.89 mageia:5                      : Ok   gcc (GCC) 4.9.2, clang version 3.5.2 (tags/RELEASE_352/final)
  48   165.42 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0, clang version 3.9.1 (tags/RELEASE_391/final)
  49   217.63 mageia:7                      : Ok   gcc (Mageia 8.3.1-0.20190524.1.mga7) 8.3.1 20190524, clang version 8.0.0 (Mageia 8.0.0-1.mga7)
  50   221.42 manjaro:latest                : Ok   gcc (GCC) 9.2.0, clang version 9.0.0 (tags/RELEASE_900/final)
  51   219.95 openmandriva:cooker           : Ok   gcc (GCC) 10.0.0 20200216 (OpenMandriva), clang version 10.0.0 
  52   188.84 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190424 [gcc-7-branch revision 270538], clang version 5.0.1 (tags/RELEASE_501/final 312548)
  53   206.42 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0, clang version 7.0.1 (tags/RELEASE_701/final 349238)
  54   205.61 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.0, clang version 7.0.1 (tags/RELEASE_701/final 349238)
  55   183.74 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5, clang version 3.8.0 (tags/RELEASE_380/final 262553)
  56   195.58 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 9.2.1 20200128 [revision 83f65674e78d97d27537361de1a9d74067ff228d], clang version 9.0.1 
  57    18.33 oraclelinux:6                 : FAIL gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  58    52.69 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39.0.3)
  59   218.36 oraclelinux:8                 : Ok   gcc (GCC) 8.3.1 20190507 (Red Hat 8.3.1-4.5.0.5), clang version 8.0.1 (Red Hat 8.0.1-1.0.1.module+el8.1.0+5428+345cee14)
  60    45.57 ubuntu:12.04                  : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3, Ubuntu clang version 3.0-6ubuntu3 (tags/RELEASE_30/final) (based on LLVM 3.0)
  61    54.51 ubuntu:14.04                  : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4
  62   151.39 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609, clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
  63    47.30 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  64    24.91 ubuntu:16.04-x-arm64          : FAIL aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609

  Same thing as with debian experimental cross build, will fix this one


  CC       /tmp/build/perf/bench/mem-functions.o
  CC       /tmp/build/perf/tests/parse-events.o
arch/arm64/util/machine.c: In function 'arch__symbols__fixup_end':
arch/arm64/util/machine.c:19:7: error: implicit declaration of function 'strchr' [-Werror=implicit-function-declaration]
  if ((strchr(p->name, '[') && strchr(c->name, '[') == NULL) ||
       ^
arch/arm64/util/machine.c:19:7: error: incompatible implicit declaration of built-in function 'strchr' [-Werror]
arch/arm64/util/machine.c:19:7: note: include '<string.h>' or provide a declaration of 'strchr'
cc1: all warnings being treated as errors
  MKDIR    /tmp/build/perf/ui/
mv: cannot stat '/tmp/build/perf/arch/arm64/util/.machine.o.tmp': No such file or directory
/git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/perf/arch/arm64/util/machine.o' failed
make[6]: *** [/tmp/build/perf/arch/arm64/util/machine.o] Error 1
  CC       /tmp/build/perf/ui/setup.o
/git/linux/tools/build/Makefile.build:139: recipe for target 'util' failed
make[5]: *** [util] Error 2
/git/linux/tools/build/Makefile.build:139: recipe for target 'arm64' failed
make[4]: *** [arm64] Error 2
/git/linux/tools/build/Makefile.build:139: recipe for target 'arch' failed
make[3]: *** [arch] Error 2
make[3]: *** Waiting for unfinished jobs....


  65    47.00 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  66    48.04 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  67    47.52 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  68    46.10 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  69   182.60 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0, clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
  70    50.66 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1) 7.4.0
  71    26.81 ubuntu:18.04-x-arm64          : FAIL aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1) 7.4.0
  72    38.36 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  73    50.79 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  74    57.69 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  75    56.70 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  76   147.10 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  77    43.49 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  78    52.88 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  79    45.57 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  80   168.41 ubuntu:18.10                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1~18.10.1) 8.3.0, clang version 7.0.0-3 (tags/RELEASE_700/final)
  81   177.55 ubuntu:19.04                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0, clang version 8.0.0-3 (tags/RELEASE_800/final)
  82    45.12 ubuntu:19.04-x-alpha          : Ok   alpha-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
  83    28.06 ubuntu:19.04-x-arm64          : FAIL aarch64-linux-gnu-gcc (Ubuntu/Linaro 8.3.0-6ubuntu1) 8.3.0
  84    43.21 ubuntu:19.04-x-hppa           : Ok   hppa-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
  85   147.65 ubuntu:19.10                  : FAIL gcc (Ubuntu 9.2.1-9ubuntu2) 9.2.1 20191008, clang version 9.0.0-2 (tags/RELEASE_900/final)

This should be something else, will check.
