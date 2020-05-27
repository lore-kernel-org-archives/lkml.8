Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B583C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C6B12084C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ituUtedn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbgE0IbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729442AbgE0IbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:31:01 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A72EC03E97C
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 01:31:01 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b6so27885370ljj.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 01:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AKqc+Sak0/1Unpb4rC7cN11riWtJQ2hXeIWL6LgMdSU=;
        b=ituUtednA03mm4qjbWeWVpF3Tyl/ePiX8eUEtZlFVdtpE0suIg6Eu4JmMIRg6QTelz
         vGj6i/yRgaIBMbu5ccETmf6Gr86kemoVmma+HRd/XqiYjJZOi7PFwNGQhMbHvaJJ+0DS
         ZYCxDETC3+yJNhz7c6f9SACDtu3O9B2gvhLBf+DiO/SsqCDDemCG4853s4xsYzF+rXBf
         Q1I4MeFe4VVDNWWjqdMQi5Bv8f20XOYdIMsBtYYTvsAZMp3yhWD1t4s1WuWBVJYQ/Uq4
         FaFcE/tBTv+1KDvuYXHbWvlXxw6rZYx/qJ4lLORpll3Jni1VrQz/LJng21MqsW0AOunN
         sUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AKqc+Sak0/1Unpb4rC7cN11riWtJQ2hXeIWL6LgMdSU=;
        b=FhcaKDnCEmNZCDg0qzRYsAz4kCp7bER1f4lNcQRhWMgx9SsTmyTFWwimNi0tDCKMiY
         bW3CpLaL6csV1PgqXU8vU8XbC/AnS3op1vYrhPmcgn3PSwOD6biFuFIi9Ux1l6etw8ym
         cDJMoL4QGUTF8P5eM6lydYH+vX16mvsw71nAYTd/Eb2MCbwlPeBq9gjSN7G4JySrmXVL
         6ZohsOtDDWbCXDpPBzw85PXJP7/XpAz3IUxWA/MgwGoO7GbV5GjMr5+69/mDw/gxCa1c
         Obl1KiSefKGpk4VddsSmduyAPFQiBVjoniF3kNgO0o+LCQc6ZqYT76rYXldnh2MUc7CF
         T2Yw==
X-Gm-Message-State: AOAM5321q+a2ylVHc4oroU+z8zfUwXlYFcpZ4YeDUlQDBQd3bh40qmJc
        OWVIAWau3MRHnaSjxIBRh0spK1Z6IhXi79zo1uDfFw==
X-Google-Smtp-Source: ABdhPJx1Ns6B0WbfghucE7BlGuXzK4/57oaFdPf1BJdOyop3Rpv6tYr+tGtjxN1IY9RX1uk5PjwmgtRiSeT32kpWniA=
X-Received: by 2002:a2e:89d9:: with SMTP id c25mr2711833ljk.366.1590568259755;
 Wed, 27 May 2020 01:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200526183923.108515292@linuxfoundation.org>
In-Reply-To: <20200526183923.108515292@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 27 May 2020 14:00:48 +0530
Message-ID: <CA+G9fYsM8rJhvW3TnLEq7aKgwouD7T1z5uQs2yeS1gUwWG-DQA@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/81] 4.19.125-rc1 review
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

On Wed, 27 May 2020 at 00:33, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.125 release.
> There are 81 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 28 May 2020 18:36:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.125-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.125-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 59438eb2aa125985caa11179358001f38df0bc7e
git describe: v4.19.124-82-g59438eb2aa12
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.124-82-g59438eb2aa12


No regressions (compared to build v4.19.124)

No fixes (compared to build v4.19.124)

Ran 25492 total tests in the following environments and test suites.

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
* install-android-platform-tools-r2800
* linux-log-parser
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* install-android-platform-tools-r2600
* kselftest
* kselftest/drivers
* kselftest/filesystems
* kselftest/net
* kselftest/networking
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-io-tests
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-fs-tests
* ltp-hugetlb-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-open-posix-tests
* ltp-sched-tests
* ltp-syscalls-tests
* network-basic-tests
* perf
* v4l2-compliance
* kvm-unit-tests
* libhugetlbfs
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
