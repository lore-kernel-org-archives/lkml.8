Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E3BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC0E4206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KFBU7HbF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbgF3FaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 01:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729603AbgF3FaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 01:30:09 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7636CC03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 22:30:09 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id m26so10578164lfo.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 22:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3P8VUSu2WiBr/qurMEzeXbZq0zeTuLHcyP6ucJPYd6E=;
        b=KFBU7HbFRHHS7+jxRqmGKQV+qRgOThL5SH5fGqhFbjKv/9vX9b8eAczZudaVHlYhQ/
         IuC1lYNU4r4JkBgET/q7d69WsICfDi8HttL82neHPwBHfFOmpMkzqI/92aKLTDCz/aaW
         VkC58YgDrT2QGCgatw64M6UTQXQ58gQyvTvcX+bzxNNYfKaHqHe7AEr3G1vs4BopFyd8
         snDxPEf+VESX7jLr8qeZXJd+L8A10ocr7CnLBHaH/9mcwLnZOL5T1qMQbVFCTPWHLR+c
         FY6gcrQuqhnqOKJr2/vinKA7xmFMW0CUl/2awX4dg50NEfTTmVapqj8TbbYTX7LCw2OO
         fqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3P8VUSu2WiBr/qurMEzeXbZq0zeTuLHcyP6ucJPYd6E=;
        b=lpz7WsOiLugVcc3pDWoHl64BfxLI0/EdxCPlsfV1wqqSYxzDDGFBtay2/UnwwUluT7
         du6w5xaGMq+1+reNVSBrihC6AKHMYcGPdmnzOuXwV4g/5dB9E/jUm5Ar8KLmPiZme86s
         n8uB/z418EqT7gIW/n1rqtU2+7E6CTKDDml3UsqXMuX+GxbpXUfNL89vaZdWlDQ4f4T6
         88/36z/h6LmQgoTg+zhAT8o64uy0w/vn8T2UQ+XTTs0H0ijPwGEiBgJZwJUlh21Kin3W
         /04HSsaLJMo5oRLH9Y6RNCEYcGWxX+AjTYuqq5ZBOg5W2uOA7uTVLB3lBlWyYjwal/TE
         y3Sg==
X-Gm-Message-State: AOAM5307Bz/d8wGiqt3MfTwS05AdDoHapZpaWsYZgSDYS4IwL7nwNVGH
        vJDB+Qd9ZYfJKSQqCEbAhPL0gVmDxHx4xg7Q+oRa7KH41N1WJg==
X-Google-Smtp-Source: ABdhPJzGQ6CtCkkYa1MWFgqN7pGAUutX3h5uR3FYzqqdqLZSOWFYzGGeCkjuy230N3ijOzjhlvQS8aMU4vzzemsXvYA=
X-Received: by 2002:a05:6512:74f:: with SMTP id c15mr424383lfs.26.1593495007724;
 Mon, 29 Jun 2020 22:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200629153502.2494656-1-sashal@kernel.org>
In-Reply-To: <20200629153502.2494656-1-sashal@kernel.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 30 Jun 2020 10:59:56 +0530
Message-ID: <CA+G9fYu21wswh1Db2pqxNT+mE_BVQZtejPHp7pA2+dzAOs5rxQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/131] 4.19.131-rc1 review
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

On Mon, 29 Jun 2020 at 21:05, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 4.19.131 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 01 Jul 2020 03:34:57 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/patch/?id=3Dlinux-4.19.y&id2=3Dv4.19.130
>
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> --
> Thanks,
> Sasha

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.131-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: d77d34fc48184da0390d7f79bdc17f44c512c458
git describe: v4.19.130-131-gd77d34fc4818
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.130-131-gd77d34fc4818


No regressions (compared to build v4.19.130)

No fixes (compared to build v4.19.130)

Ran 34302 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- juno-r2-compat
- juno-r2-kasan
- nxp-ls2088
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
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* v4l2-compliance
* kvm-unit-tests
* ltp-controllers-tests
* ltp-dio-tests
* ltp-fs-tests
* ltp-io-tests
* network-basic-tests
* perf
* ltp-open-posix-tests
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
