Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AC6C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E49BC20838
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zZ/6Ye+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731997AbgGaI7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 04:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731964AbgGaI7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 04:59:44 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E61C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 01:59:44 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id m18so6758840vkk.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 01:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z8Xu+FX3vlXULJTWcBGUe7ReMn74wRDKFVBN6S82qMg=;
        b=zZ/6Ye+e0Pem9PtWM44VX1wITKYBKMV3+aR2XFHBPQkaWs8cNwAU7x62RXKIZpsXA2
         axfBSBahQAfdpFGp1K4Qnfyf8n8W4Xe4h1R1D5ZLuyNWfCbqNPGcwBRVl42X1xR4QIYJ
         PG1/jPDmFcquDb4JOe6nfIRcyJ39DJaGlCkFe2/9xOTwUwJtLNf6/AGAWAO12F2eW/ln
         qhIY0dLLVQl0i6P+KYcaEXFHp6F9oAjx94LkyCtzSWh9nHuBGulu4fT/rLQJgYiQpPkZ
         KbsbSjymzOD9OMwgu5aGje/16uiDTfHxpvGSkL9EM+ek3V22CpTckwRwB++F9/wbyLj/
         29ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z8Xu+FX3vlXULJTWcBGUe7ReMn74wRDKFVBN6S82qMg=;
        b=YUj+x5xFI3uA1BoGeiW8XkQ04cMx0IVUHRcx1Gim+ReGP0fPdCK3yKuM/eei+QBXtq
         4nlu+oEgCrs9ktKzPSuY3ZHC9NkXVVdMHhKa0+2DzoKQAnfeJdvj1arMmmOnKQZnR/JF
         u4dk+a7yLCCLYyJ3PNaVUqXpZmJJZYwlNxJCuFVDHGRn2lLWioQpXyd/+9V53/8AM8Bk
         Z8XPXWx8w05ObiOZEY49CbvMBsbbSZNp+64wVWWAZGmsU1zUoKWhcqQZFVGjZfISKd9G
         X1YtEzKSt4dumGYQwjQHHFt63+8ErNJKNL72Gtkewq4oR0v6tjGvRiMJSwfYnoZ3Apmo
         Cb8w==
X-Gm-Message-State: AOAM532HMjMjjzWmMAV9Y0MtvYf+Xt9Tmqvftge9UETuvUJnPu2dtqQU
        kBxIFUJH7kL+a4coczGNXUmipJkdTKR2xI8EZhvGhg==
X-Google-Smtp-Source: ABdhPJyw8jEYGmDmw9BgpnFafNjFLXk3E+ITQh4G53dONHiKLj2/HaIo+lf0O/dvghtjcTHPVpgxFnqHAc/qQPLhEvQ=
X-Received: by 2002:a1f:a20c:: with SMTP id l12mr1943048vke.94.1596185983081;
 Fri, 31 Jul 2020 01:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200730074420.533211699@linuxfoundation.org>
In-Reply-To: <20200730074420.533211699@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 31 Jul 2020 14:29:31 +0530
Message-ID: <CA+G9fYtLSsoX1RXZ8jAw4+vjaii46RiCJL0bjepghq4JSpZw9A@mail.gmail.com>
Subject: Re: [PATCH 5.7 00/20] 5.7.12-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jul 2020 at 13:35, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.7.12 release.
> There are 20 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 01 Aug 2020 07:44:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.7.12-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.7.12-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.7.y
git commit: 3d6db9c814407889db6cd20aba0aabe36e463171
git describe: v5.7.11-21-g3d6db9c81440
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.7-oe/bui=
ld/v5.7.11-21-g3d6db9c81440

No regressions (compared to build v5.7.10-199-g3d6db9c81440)

No fixes (compared to build v5.7.10-199-g3d6db9c81440)

Ran 36182 total tests in the following environments and test suites.

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
* kselftest
* kselftest/drivers
* kselftest/filesystems
* kselftest/net
* linux-log-parser
* ltp-commands-tests
* ltp-containers-tests
* ltp-controllers-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* perf
* v4l2-compliance
* kvm-unit-tests
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-sched-tests
* ltp-open-posix-tests
* network-basic-tests
* igt-gpu-tools
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-native/drivers
* kselftest-vsyscall-mode-native/filesystems
* kselftest-vsyscall-mode-native/net
* kselftest-vsyscall-mode-none
* kselftest-vsyscall-mode-none/drivers
* kselftest-vsyscall-mode-none/filesystems
* kselftest-vsyscall-mode-none/net

--=20
Linaro LKFT
https://lkft.linaro.org
