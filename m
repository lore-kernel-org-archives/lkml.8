Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C55C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B717620722
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tPsjZH6u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgCYOH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:07:26 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:39638 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgCYOH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 10:07:26 -0400
Received: by mail-lj1-f177.google.com with SMTP id i20so2585339ljn.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 07:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=DiPRZWoRa3lk/XExUnZi97Qb2rC0wdBFYoFDDD3DuDU=;
        b=tPsjZH6u2MPpcRRBhaOlSJpoKbNNphbkMpXQkpwGlUx/rNrxQCqE9R8GhA2TO1cnLQ
         os0bDQgi0HkHwSb4mcdD6J5/4Y3uz26mCcQOdm4ybPYKrbnBJz0TUxjswmv1evulTwj3
         CyGcQKsC1gyNEy1SWdf9PZJ37SFtngmh6Vxtky4nhMS9GBdbgosra15D64WNKWMaDWC0
         p5lmG+30/7D8sZryN5Boyn62x6Yg3gQTQ4eJwrHN3Mp6MaD6iw5S3wTNma2Fopj6XMIm
         4LXKc/D09CTw5riV3BoEtug2aCimsG8otep2b1U5wW8RN6aI5+oDIF7Mio/jsYIjslWH
         JZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=DiPRZWoRa3lk/XExUnZi97Qb2rC0wdBFYoFDDD3DuDU=;
        b=FWF/50HLydJXBUz65gK/05/tC7552635FAG2sW56S2UqOmPJm2tcKkswfPHn0FI07Q
         5OqspNf1LIGR8W6QVkJ5XPBZj0UFQUrVBwTQ8mTNwSSBV6DNKihrbqn8dKylWHBqnvBf
         PRUtfcM0/YuCf9bgb41NKLcw4ksEDTCu9q2cK4MQzZUVgpZYOzEg3+mW6flyptWqI4f5
         fjDuO9wGlMgEWIzTJgvSfcrVKi1O59rl5doJB6LBXaPKLIMSpIQx7FfHjxYKxtMh9l9p
         CroVruStlZczyjtJcU1z7SFEMboC8Q0OH+tG3CkGLdqH5umPBMMGNktnY4p1fXqD0YhZ
         sYMA==
X-Gm-Message-State: AGi0PuYqnX/XF1zslcHczFArJJytgLqLWZSATyDfg7UnDKyfs7helg3C
        TFPL2RZBBdpV2NGim6B8Cb0K/nR55go7hbHYvRFmdwG//K6QJQ==
X-Google-Smtp-Source: ADFU+vuu1FOsc42Ge8euBCx7Sux5WuLHcShxtchIUplsgCJfTCdDFsLNTiSoE4eTUhRtSRo27HUxllre+ibfJLQi6c0=
X-Received: by 2002:a2e:a495:: with SMTP id h21mr2098422lji.123.1585145241766;
 Wed, 25 Mar 2020 07:07:21 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 25 Mar 2020 19:37:10 +0530
Message-ID: <CA+G9fYtiroQnpwGu4oLA=ChmS==XGpmAAqB_Oa9nrXC3vQ0xsQ@mail.gmail.com>
Subject: tools: Perf: build failed on linux next
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     lkft-triage@lists.linaro.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        jolsa@redhat.com, Namhyung Kim <namhyung@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Leo Yan <leo.yan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf build broken on Linux next and mainline on x86_64.

find: unknown predicate `-m64/arch'
Try 'find --help' for more information.
  HOSTCC   /srv/oe/build/tmp-lkft-glibc/work/intel_corei7_64-linaro-linux/perf/1.0-r9/perf-1.0/pmu-events/json.o
  LD       /srv/oe/build/tmp-lkft-glibc/work/intel_corei7_64-linaro-linux/perf/1.0-r9/perf-1.0/libperf-in.o
x86_64-linaro-linux-gcc: warning: '-x c' after last input file has no effect
  GEN      perf-archive
  AR       /srv/oe/build/tmp-lkft-glibc/work/intel_corei7_64-linaro-linux/perf/1.0-r9/perf-1.0/libperf.a
  GEN      perf-with-kcore
x86_64-linaro-linux-gcc: error: unrecognized command line option
'-m64/include/uapi/asm-generic/errno.h'
x86_64-linaro-linux-gcc: fatal error: no input files
compilation terminated.
  HOSTCC   /srv/oe/build/tmp-lkft-glibc/work/intel_corei7_64-linaro-linux/perf/1.0-r9/perf-1.0/pmu-events/jevents.o
  MKDIR    /srv/oe/build/tmp-lkft-glibc/work/intel_corei7_64-linaro-linux/perf/1.0-r9/perf-1.0/pmu-events/
x86_64-linaro-linux-gcc: warning: '-x c' after last input file has no effect
  HOSTCC   /srv/oe/build/tmp-lkft-glibc/work/intel_corei7_64-linaro-linux/perf/1.0-r9/perf-1.0/pmu-events/jsmn.o
x86_64-linaro-linux-gcc: error: unrecognized command line option
'-m64/include/uapi/asm-generic/errno.h'
x86_64-linaro-linux-gcc: fatal error: no input files
compilation terminated.
make[3]: Nothing to be done for
'/srv/oe/build/tmp-lkft-glibc/work/intel_corei7_64-linaro-linux/perf/1.0-r9/perf-1.0/plugins/libtraceevent-dynamic-list'.
  GEN      /srv/oe/build/tmp-lkft-glibc/work/intel_corei7_64-linaro-linux/perf/1.0-r9/perf-1.0/python/perf.so
Traceback (most recent call last):
  File "util/setup.py", line 6, in <module>
    cc_is_clang = b"clang version" in Popen([cc, "-v"],
stderr=PIPE).stderr.readline()
  File "/srv/oe/build/tmp-lkft-glibc/work/intel_corei7_64-linaro-linux/perf/1.0-r9/recipe-sysroot-native/usr/lib/python2.7/subprocess.py",
line 394, in __init__
    errread, errwrite)
  File "/srv/oe/build/tmp-lkft-glibc/work/intel_corei7_64-linaro-linux/perf/1.0-r9/recipe-sysroot-native/usr/lib/python2.7/subprocess.py",
line 1047, in _execute_child
    raise child_exception
OSError: [Errno 2] No such file or directory
cp: cannot stat
'/srv/oe/build/tmp-lkft-glibc/work/intel_corei7_64-linaro-linux/perf/1.0-r9/perf-1.0/python_ext_build/lib/perf*.so':
No such file or directory
Makefile.perf:590: recipe for target
'/srv/oe/build/tmp-lkft-glibc/work/intel_corei7_64-linaro-linux/perf/1.0-r9/perf-1.0/python/perf.so'
failed
make[2]: *** [/srv/oe/build/tmp-lkft-glibc/work/intel_corei7_64-linaro-linux/perf/1.0-r9/perf-1.0/python/perf.so]
Error 1
make[2]: *** Waiting for unfinished jobs....

ref:
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-next/DISTRO=lkft,MACHINE=intel-corei7-64,label=docker-lkft/733/consoleText

-- 
Linaro LKFT
https://lkft.linaro.org
