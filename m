Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B61C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 453B520759
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qw2Y7GPz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730853AbgF3HUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730637AbgF3HUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:20:03 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AECC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:20:03 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f8so8960010ljc.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Vx+bktY88yN1DvPoXEuGvm00CANlOXwakGCi9dazwYc=;
        b=Qw2Y7GPzBmCMTBmuRC7mN6k5TBliujq1dQ+M9LzBbaSPFc7X0iIsZxmZaUVzOm9Tzk
         ImM2Fn7fUNJDubghC8f4jS/CiNE++57SiEyIrpLOIfkYVW2Km7fSdabrbeROVxg/qMFG
         SeLdZ8ZkC56zmHaG7VvoXBfgzCW8zIhFgklbUtMiggJfKcTnW3kwgZoMyqvSfywiqL60
         z3PFc0RYIRL+LOtBjRHnjb2U3lVjmhrxBQ2xBOE/Tml/CuQcGKshuEPLtDLe85DlHcin
         2L6wUNJ/V2Fn1pcynk0brpRRp+bDN0IjkngQzng9wuxoG0YHR++s9nH5ZQHJEV/kqx2s
         nBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vx+bktY88yN1DvPoXEuGvm00CANlOXwakGCi9dazwYc=;
        b=q4Z/8r9SM3KmbAcSY32jKHvEIZJKC4j4b5thwNRLdtV82YY0kRXt8Np0NA3Bw6PQBm
         aF3MJ5WdZqliyeKVap3oRwhDa5dl2iKTgbsuG3UBd3YkLNGno3UcVoXiND3JOXenm2ff
         DTJ2niNBT7kkFymxkhF5VQyoemqZ/TcWbhA21ar4Vd5JYP/HkBjPMxGWQjCXlSWmoZ6e
         u5w96iixdr42AxzTAGMrOmAo5Eq9AYAUS+AGFnO4NR9UYcE+Y5ylzUfg9Ty4dLqLOvV8
         ghRusD+KZt+g+iRWRZYSInqjMMlFL+p4dI+zJE31QkYMWZ2zTi1RuQN7H12ssXWFCmF5
         gfbw==
X-Gm-Message-State: AOAM5329h47pgrmVE1c4irRVtm1lTZcppTn5jaZUzwieXWCL1rKGBVi0
        WUj1w3gC24BygshYZYPsnlNWfie/DiKFtZkNZIHfjQ==
X-Google-Smtp-Source: ABdhPJxtq/onlnBNSXVbWeg4Ga0r62C3dLuD/Kf3TuslGIQyDyz0m7pr0lvBamePIyU0uVcaFt6aMs9VanlR5pN4mYk=
X-Received: by 2002:a2e:b054:: with SMTP id d20mr9306783ljl.55.1593501601810;
 Tue, 30 Jun 2020 00:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200629153806.2494953-1-sashal@kernel.org>
In-Reply-To: <20200629153806.2494953-1-sashal@kernel.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 30 Jun 2020 12:49:50 +0530
Message-ID: <CA+G9fYtmPtr+OWv0XASquDb=wcLTXwREQzpmzZuqwctjP1RmJA@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/78] 4.14.186-rc1 review
To:     Sasha Levin <sashal@kernel.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020 at 21:08, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 4.14.186 release.
> There are 78 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 01 Jul 2020 03:38:04 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/patch/?id=3Dlinux-4.14.y&id2=3Dv4.14.185
>
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> --
> Thanks,
> Sasha

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.187-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 27e703aa31e48c3ebe64c4d8665ab5cea76eac29
git describe: v4.14.186-78-g27e703aa31e4
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.186-78-g27e703aa31e4


No regressions (compared to build v4.14.186)

No fixes (compared to build v4.14.186)

Ran 35120 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- juno-r2-compat
- juno-r2-kasan
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15 - arm
- x86_64
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
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
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
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* perf
* v4l2-compliance
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
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
