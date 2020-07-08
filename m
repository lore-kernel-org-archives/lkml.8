Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C621AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F63420760
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zXDRP/bI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbgGHHAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730032AbgGHHAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:00:41 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CD4C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 00:00:41 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id t74so26255511lff.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 00:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dN7kD7Q1Rq4KZPUzBGzJoKUeTvUT8h427/XLCP0siXE=;
        b=zXDRP/bICz7BJrvShRWcIw26GN2IeV4EJhuSvEnjTAy8fGHDJV8KtACwYmk6uwEe4r
         BuCbZShWgCurUdUrAVg0yBebe49q5YgB0ZYlfIEibkTOqyc+fkkU1XdYvhO+j6p4/YDR
         0O6Pc9OXUo7jXq6D/ezE6ViR0X6dnhWxIwVEqGaApFkYmqiqQIvgzhPF/e2HH1NvUMGq
         bOL+ZDXnu5M3oMq5CgS2iy4YhR8H+x7cPW0GeObiUWz/5KP2Di4voisye95EOPRWGk5g
         az5CF/AEiyRTz10mf5WlWOSAj5GNZVpR78xmEaqEQolsfJzEl6QW3uznM2Q1UUGvCXXH
         SxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dN7kD7Q1Rq4KZPUzBGzJoKUeTvUT8h427/XLCP0siXE=;
        b=IC51N8dDYUdKQsLNDIiDSJsi/uU3DV4h658X3Mllp8TW05R3B3mkVV0keLhigz5hGs
         ye+cTCTz5Qi0ALUGHZoWMbVsmtEJGLLC4V2QJ3PyrDNOcd1topG8Q7FTYXjiqpyzJeYH
         eDhFDHr0TNSRSoQF/2bxUeFH4mKPtS7dXTn0qDpdFHadkl4UdHklqWS6mB0/lxHvg5jM
         LH6StZfPieseKo9wsUsbaJJASRuAt0YTCOs4f+Dt2+0uyIr97Tv+X3qe2kOOTgdP58BH
         CTuMkM01OY5pGaAL2JEvWiyXWEiEOUbNt1dobsoivEC5ouw/aWRHu+32O39G6XoHeQ5H
         hR2w==
X-Gm-Message-State: AOAM533/4v84/1VL+D+vauBj/Y0jn/6Kqnw1AapGLquVxMK3s/wtiSOQ
        BZgawGsDeCSTpZRmhw/PHBEh+MNhUrGLIg0yhlDujg==
X-Google-Smtp-Source: ABdhPJxuzf3IPe0k9fpHN75463rwiENlmj8qvoP+ZRpXWAU/gSJBP7lw6ZSMGOHpzAYVc8u9zL18+uCcbANt1lK8rCI=
X-Received: by 2002:a19:c78d:: with SMTP id x135mr35232317lff.82.1594191639066;
 Wed, 08 Jul 2020 00:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200707145747.493710555@linuxfoundation.org>
In-Reply-To: <20200707145747.493710555@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 8 Jul 2020 12:30:27 +0530
Message-ID: <CA+G9fYsewvEeJF60ANjuz5VqMgR1-PQLn44HVSHjkAh2NL9xxA@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/19] 4.4.230-rc1 review
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

On Tue, 7 Jul 2020 at 20:41, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.230 release.
> There are 19 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 09 Jul 2020 14:57:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.230-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.4.230-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: c19eba6b34341e17e0a49be45b010f483dd95de7
git describe: v4.4.229-20-gc19eba6b3434
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.229-20-gc19eba6b3434


No regressions (compared to build v4.4.228-155-gc19eba6b3434)

No fixes (compared to build v4.4.228-155-gc19eba6b3434)

Ran 17904 total tests in the following environments and test suites.

Environments
--------------
- i386
- juno-r2 - arm64
- juno-r2-compat
- juno-r2-kasan
- x15 - arm
- x86_64
- x86-kasan

Test Suites
-----------
* build
* kselftest
* kselftest/drivers
* kselftest/filesystems
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
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
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* perf
* v4l2-compliance
* kvm-unit-tests
* install-android-platform-tools-r2600
* install-android-platform-tools-r2800
* kselftest/net
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-native/drivers
* kselftest-vsyscall-mode-native/filesystems
* kselftest-vsyscall-mode-none
* kselftest-vsyscall-mode-none/drivers
* kselftest-vsyscall-mode-none/filesystems


Summary
------------------------------------------------------------------------

kernel: 4.4.230-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.230-rc1-hikey-20200707-761
git commit: 1e4ecd8e5eab1c328ff83cd29d52021eb6035bc8
git describe: 4.4.230-rc1-hikey-20200707-761
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.230-rc1-hikey-20200707-761


No regressions (compared to build 4.4.229-rc1-hikey-20200629-759)


No fixes (compared to build 4.4.229-rc1-hikey-20200629-759)

Ran 1861 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* kselftest
* kselftest/drivers
* kselftest/filesystems
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
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
* spectre-meltdown-checker-test
* v4l2-compliance

--=20
Linaro LKFT
https://lkft.linaro.org
