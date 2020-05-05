Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BCAC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0D6C2078C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o75AfWlt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbgEEPpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729612AbgEEPpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:45:13 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D66C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 08:45:13 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id t11so1751875lfe.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 08:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yF0rSv5G8dMiG2t0mZJS418QhuFNKXhIXOuNkoLggjA=;
        b=o75AfWltUD9X/y2+TGKaVDgLD1U3ggtfbDawvA2uueQVC/Qb/RZaIz6B4+WW2k4Id0
         LdT7tgHLS1cRyYtv0Ww64GCQfuiQSFOnTeYgN9FQHNqaxtmv+8pstfmAtPAcixCGziHG
         rtNjp/zd3VQahq6R8KbEsrNgQpYJl2w0kI/stJu/L3FrqMweTpoHlNvyyKOY2yJCRdC7
         bNazpewSsa4eJUPDeR/tG3Z0Q/0NtOGsDxkFC4ibE1GdjtpJe4FmNna034KjjN8tdq+I
         sSnekhNkhp08qhC7Pj4aVz064GhT1W8kEIMBG4TTtibTf5k+tjODCbNyr3DQb/hp0JKo
         ACNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yF0rSv5G8dMiG2t0mZJS418QhuFNKXhIXOuNkoLggjA=;
        b=S3XxdIiyCTGEahG7XuHMZo5EqSRWenQDXQYLQOlyoQK51YT8ZIh/70xqCdrin+lF1Z
         0sOQM29fIpuT+M/ZRNczkRxVIwbKbLY25oMHobb+xpN2ajs2D4ooTo56EIt5m+wfECWO
         h2XY+8vRHF2rw00K01T/8/v/nIQ/7fsorMDEIg534fvd5eCLTHFblQ3jZtZmWVG2fK42
         KUDDRbno3mEQGSyE5hEJwkuzkRKbH/Ja3PILwPcuvK6nioJJA5fdYjQYy0JLPWlsskOV
         tMCpRn/Fy4ur5jr1TNuQOE6ND/67MzWQBfgnzJE5mbK+tbMsqV4g0hW4mHHEZ/3GYk69
         Y/mQ==
X-Gm-Message-State: AGi0PuahHPWFr44nCikN9G/F+U8Cp4BrKrkTguKLmCxmtooO2SIIH05i
        xyugJvbBCeQ5XIlPVRrBKbzc8y029Z5RioaBfmjqRQ==
X-Google-Smtp-Source: APiQypLzj3q2ckmPSuxHoT7j0Si2HArFLe4uE91Czny4cnljFLAreRe7/ipkVasASjQusjOm4Q23/VFvqYR/e1fvbGI=
X-Received: by 2002:a19:4883:: with SMTP id v125mr2054645lfa.95.1588693511387;
 Tue, 05 May 2020 08:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200504165442.028485341@linuxfoundation.org>
In-Reply-To: <20200504165442.028485341@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 5 May 2020 21:14:58 +0530
Message-ID: <CA+G9fYvLpEwde0kaPcdvPW+FU=kmdyKYoGYhnD9OBirWtucmqg@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/18] 4.9.222-rc1 review
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

On Mon, 4 May 2020 at 23:30, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.222 release.
> There are 18 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 06 May 2020 16:52:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.222-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.222-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: f8abf65f20c5e9296d6aeb69c452160ab639d8be
git describe: v4.9.221-19-gf8abf65f20c5
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.221-19-gf8abf65f20c5

No regressions (compared to build v4.9.221)

No fixes (compared to build v4.9.221)

Ran 26505 total tests in the following environments and test suites.

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
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fs-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* perf
* v4l2-compliance
* kvm-unit-tests
* libhugetlbfs
* ltp-hugetlb-tests
* ltp-mm-tests
* network-basic-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-open-posix-tests
* kselftest/net
* kselftest/networking
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-native/drivers
* kselftest-vsyscall-mode-native/filesystems

--=20
Linaro LKFT
https://lkft.linaro.org
