Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3BAC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D8A2076E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VEGGqsW1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgCXSoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:44:07 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45596 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbgCXSoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 14:44:07 -0400
Received: by mail-lj1-f195.google.com with SMTP id t17so9094845ljc.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 11:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=+jVSh0GZNYjjL8qPVkNQAfbpStZNbkEzCOkySKLF+dI=;
        b=VEGGqsW1igSJSs8bb2dyuPVbFPmzXLWLZABrk5ZJs7H1uHr7HwSUyn/zYWZdki0bQZ
         W7fmYdxJa/RJwR2Tno+elXwz/TGe1kKJIxH043Cyg0kFtyupyaOSUG74E9WFgUBabOvx
         SJVd3d1XAJnkPk7adwlMu19W+OO9XUGVnMIhQhbPDWVkzls0YFUg4H77Q2frbQRP44U/
         wirjYXQECUNDVHdS152tyjWy9bI+KE0nF5rD99VifXWRZ+VTPHEPQloDGI24xM/9ki7y
         Aog6X6+OCPxUdlSGw2CClhhX2qXf57ttFk8ccvBMQEnHxebdIJ3/N4XTDiIHUt0fNemv
         un9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=+jVSh0GZNYjjL8qPVkNQAfbpStZNbkEzCOkySKLF+dI=;
        b=YpftlKwLSKehy3Jx3CDS94ABt/oeKWuPcZIpoCiOhWGFxAHK+KopiND24WEyHkh86F
         Uz2Wexr4rNnDKzAx8wQWpY9dp7jHzTcpey5FKK67uXqGLNAuJlot5+pTK2nFA9NfbcKJ
         n8sL93xu7XeVst3fwIs7Gdj15+T1iSOkUi1BRIFPP69xB2V0Ey5vq3KaQtM8wJcLFkIt
         PO0P4zm6aeUSVGofItw0A84AqMl0n7FYALHHgFf5xlJc5aAymV5qYORJ9UwKc4R9JzBV
         9oUQ+V8tZlKOMVlyKaSV01td0ol15BAQkd4vAipc3AJNaexDPPHhe4M1yrALP7ccz6to
         MF8g==
X-Gm-Message-State: ANhLgQ2RHLaqkDSgWzmXPdff0HdhbqfSnPSVFDsknTrofBwBo6uHePjj
        23PZEMP5s5ai5HdTYOaY4js8Zpxoy5STPF2v68QV78MUmAzLgA==
X-Google-Smtp-Source: ADFU+vuudqhzW2W5Y2ONF1nO1NPd4FwtzbqR7XknTifF3WpVw0XEssWjKMAFa6pKDVtA+EoMR9+sLjP9/aFQcmm7UkU=
X-Received: by 2002:a2e:990b:: with SMTP id v11mr18654941lji.243.1585075445092;
 Tue, 24 Mar 2020 11:44:05 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 25 Mar 2020 00:13:53 +0530
Message-ID: <CA+G9fYvKfCktcnFYCA23V6gCV7j3YK01SAYr-X9yn0We7eV8bg@mail.gmail.com>
Subject: perf build failed on mainline
To:     open list <linux-kernel@vger.kernel.org>
Cc:     lkft-triage@lists.linaro.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Leo Yan <leo.yan@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf build failed on Linux mainline kernel for arm, arm64, i386 and x86_64.

perf build failure log on x86_64:
-------------------------------------------
| find: unknown predicate `-m64/arch'
| Try 'find --help' for more information.
| x86_64-linaro-linux-gcc: warning: '-x c' after last input file has no effect
| x86_64-linaro-linux-gcc: error: unrecognized command line option
'-m64/include/uapi/asm-generic/errno.h'
| x86_64-linaro-linux-gcc: fatal error: no input files
| compilation terminated.
|   MKDIR    /srv/oe/build/tmp-lkft-glibc/work/intel_corei7_64-linaro-linux/perf/1.0-r9/perf-1.0/pmu-events/
|   GEN      perf-archive
|   GEN      perf-with-kcore
|   MKDIR    /srv/oe/build/tmp-lkft-glibc/work/intel_corei7_64-linaro-linux/perf/1.0-r9/perf-1.0/pmu-events/
|   HOSTCC   /srv/oe/build/tmp-lkft-glibc/work/intel_corei7_64-linaro-linux/perf/1.0-r9/perf-1.0/pmu-events/jevents.o
|   HOSTCC   /srv/oe/build/tmp-lkft-glibc/work/intel_corei7_64-linaro-linux/perf/1.0-r9/perf-1.0/pmu-events/json.o
| x86_64-linaro-linux-gcc: warning: '-x c' after last input file has no effect
|   LD       /srv/oe/build/tmp-lkft-glibc/work/intel_corei7_64-linaro-linux/perf/1.0-r9/perf-1.0/libsubcmd-in.o
|   HOSTCC   /srv/oe/build/tmp-lkft-glibc/work/intel_corei7_64-linaro-linux/perf/1.0-r9/perf-1.0/pmu-events/jsmn.o
| x86_64-linaro-linux-gcc: error: unrecognized command line option
'-m64/include/uapi/asm-generic/errno.h'
| x86_64-linaro-linux-gcc: fatal error: no input files
| compilation terminated.

| make[3]: Nothing to be done for
'/srv/oe/build/tmp-lkft-glibc/work/intel_corei7_64-linaro-linux/perf/1.0-r9/perf-1.0/plugins/libtraceevent-dynamic-list'.
|   GEN      /srv/oe/build/tmp-lkft-glibc/work/intel_corei7_64-linaro-linux/perf/1.0-r9/perf-1.0/python/perf.so
| Traceback (most recent call last):
|   File "util/setup.py", line 6, in <module>
|     cc_is_clang = b"clang version" in Popen([cc, "-v"],
stderr=PIPE).stderr.readline()
|   File "/srv/oe/build/tmp-lkft-glibc/work/intel_corei7_64-linaro-linux/perf/1.0-r9/recipe-sysroot-native/usr/lib/python2.7/subprocess.py",
line 394, in __init__
|     errread, errwrite)
|   File "/srv/oe/build/tmp-lkft-glibc/work/intel_corei7_64-linaro-linux/perf/1.0-r9/recipe-sysroot-native/usr/lib/python2.7/subprocess.py",
line 1047, in _execute_child
|     raise child_exception
| OSError: [Errno 2] No such file or directory
| cp: cannot stat
'/srv/oe/build/tmp-lkft-glibc/work/intel_corei7_64-linaro-linux/perf/1.0-r9/perf-1.0/python_ext_build/lib/perf*.so':
No such file or directory
| Makefile.perf:590: recipe for target
'/srv/oe/build/tmp-lkft-glibc/work/intel_corei7_64-linaro-linux/perf/1.0-r9/perf-1.0/python/perf.so'
failed

ref:
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-mainline/DISTRO=lkft,MACHINE=intel-corei7-64,label=docker-lkft/2544/consoleText

-- 
Linaro LKFT
https://lkft.linaro.org
