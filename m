Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269D5C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02C082166E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c2RRApqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgEAVtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 17:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgEAVty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:49:54 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5738DC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 14:49:54 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id l11so4899752lfc.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 14:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ppgaHl6cSgNWAC/eU/OoA0QTmOCWQ6geVBF21oFi/iU=;
        b=c2RRApqWRYey+5q+fGhivtgpZLBoNYYVSxsgYqDukBcT1pC+X1l3QiEIU+npLlu8Km
         sZmlrIrtLYAy158atE7AiqJwC7WsI0zUvtiWtZiwKtzHbKLd8fZ4JQwyaweWWeXQKG7L
         WZg2hHNlEQgRxMu51oPmydWLeYKGwBZ4d8gUoHzDOmcNJeMwCA89L/UHHrldbI3SKawv
         xGFvoSeZeEHRZsIoBLAG0emC7vdYc37Hp9OrODT0goJwdP2L331VqB+SNhk/U80nDUOV
         LdRD12m8rhrswcVa0869pGgj2jIxCja9zFLC3nDZalLFWwp0OiCgiQA824N2wwpynW6U
         DgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ppgaHl6cSgNWAC/eU/OoA0QTmOCWQ6geVBF21oFi/iU=;
        b=IGMCptB6St4IMFh5wvhAualXbt/I7mwa421n1etcVlxdXaJv8d8FzBz0vBZmGvcCd2
         Xu5v7AlrzbEt9AlLRLekj8e67tjP55b/vV1m3urHFFfnr1L2NoJCArPJVHgv2qTkn3sI
         aDoVa8kvlXGUbIzR0waaI3YJ6CueztDYBAjxZCrWJLf/9whlh31+/kMbnoaTyXhsK1mK
         Xu5ReQM08ZBgqdHw+IRzxWX3o+o/UT3YkWIv51NUiVZ9YTipJ02dG0bPqhRtwHVqnIgZ
         RzQhx0Eiw8YOzwSjvwxU956x0Nudz9cqIHwKIHqA9YKHjPHZW4xc/gRYJMLYaFQixZwv
         9vzw==
X-Gm-Message-State: AGi0PubE4la2NmGtYmfEG8TfTsEZROQ9yizm9ykhkDz3SRw3ycjY3qb9
        V7lvu5J4ne446SQeSSecJ8rWJs4cKS5fSGLRtHswTVTcZ0xhGA==
X-Google-Smtp-Source: APiQypLowFKPTc8b0ADJ+W6+ScqnSj9D8IkjQm01RGC+zP/cUNAk+b7iBtMPM4oIYlaPgd8tmQ9M4XmTb/mI3GYR5Fw=
X-Received: by 2002:a19:40d2:: with SMTP id n201mr3327092lfa.82.1588369792597;
 Fri, 01 May 2020 14:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200501131524.004332640@linuxfoundation.org>
In-Reply-To: <20200501131524.004332640@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 2 May 2020 03:19:40 +0530
Message-ID: <CA+G9fYtikBkBLyV0_yZua7GDpZCmTooZOCuE9xdkE62J_Gtk2A@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/83] 5.4.37-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 May 2020 at 19:08, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.37 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 03 May 2020 13:12:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.37-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.4.37-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: becd7d89321d9b96617ee5a99498213c703be541
git describe: v5.4.36-84-gbecd7d89321d
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/bui=
ld/v5.4.36-84-gbecd7d89321d

No regressions (compared to build v5.4.36)

No fixes (compared to build v5.4.36)


Ran 28653 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c
- hi6220-hikey
- i386
- juno-r2
- juno-r2-compat
- juno-r2-kasan
- nxp-ls2088
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15
- x86
- x86-kasan

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* install-android-platform-tools-r2800
* libgpiod
* linux-log-parser
* ltp-commands-tests
* ltp-containers-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-math-tests
* perf
* kselftest
* kselftest/drivers
* kselftest/filesystems
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* network-basic-tests
* v4l2-compliance
* kselftest/net
* kselftest/networking
* ltp-fs-tests
* ltp-open-posix-tests
* ltp-syscalls-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-native/drivers
* kselftest-vsyscall-mode-native/filesystems
* kselftest-vsyscall-mode-native/net
* kselftest-vsyscall-mode-native/networking
* kselftest-vsyscall-mode-none
* kselftest-vsyscall-mode-none/drivers
* kselftest-vsyscall-mode-none/filesystems
* kselftest-vsyscall-mode-none/net
* kselftest-vsyscall-mode-none/networking

--=20
Linaro LKFT
https://lkft.linaro.org
