Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB34EC33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1926206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w4bY3R8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgAQOOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:14:20 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39467 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgAQOOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:14:19 -0500
Received: by mail-lj1-f196.google.com with SMTP id l2so26562327lja.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 06:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NAVl4mPYQplvO0E1VEcLtuftfASYI5IMVIWdknaGvCA=;
        b=w4bY3R8TtyJb7jkXithwHOwZVPqqwh2yl4FR0j7r+RWErw279gj5h/c5naJx/MsCYb
         18drbwEsvdJ0TvouP+nLV7sW5F1K3cOYwgT5gcVlvt7VwGkE8scxWSG+Ip3Zrsz9/k/1
         gx6nPqc/PvPWNlXlJRF2yB4tLn0oZ/cQS7BEOfzZBNNlt8QB3hzJf7S8fp5pLTXEVN5y
         iWvj4IMvNQfLXBKS6WZfxwi/80JcCzRPGtxDqFZu1+/dzXW9iYUjrsNnjDOtffG4tiOg
         I2cy8W0bhSNZuYEZrY1Y0z58q+vTy/mSqVA4+t7kCJMjO5YqXX6XXTqbdyUKUprHMW7x
         dcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NAVl4mPYQplvO0E1VEcLtuftfASYI5IMVIWdknaGvCA=;
        b=JiF2ta3hWyF0YpoFBziAXXq1gB+sKdJ+i3WjyHGxGRAJFBBX5QwaireeyONtKh7FGx
         y00HPY/dElzw+LZp3zGJxOKZcet20CNaXSpwpcOVv2N0OoXxE49NzmpVAwK0uRD/BuiS
         ufZI8ePrDwu1hLyKTqv3qyH6MJkvAK7WTrD+DF157vaz27D/FW6wP5KYUjW0RB0ZioAU
         Z3+8+8AkpTo62noVCF0x7mmDL1MqQ/sx48wx2PY4hu9swV0/PmISZ9bajMwm6L8LalQd
         W8uCqCN33Zzqhe44wLyGNf7gp33dFRTy8PKPf4we8GZq2ygCLAxNtTpwQfcssLBUTaZE
         /1jA==
X-Gm-Message-State: APjAAAXCPMKWpuQ/HVjPbh1EL+/7qBGLOSYeM6AzZInhJrHuxXHvbWDN
        PElqayASCCQr/EJieI1PIpBJpv1lMMxGS2GsRM1pCg==
X-Google-Smtp-Source: APXvYqwpOzoJj2hqKTH6cWieOe3rC3BLloHvdlHV9wBMM9oHOg7W/FAdqxxxJ+gcLiULKuLaCD3MTGedsFjV7mB+fO8=
X-Received: by 2002:a2e:b017:: with SMTP id y23mr5943206ljk.229.1579270457363;
 Fri, 17 Jan 2020 06:14:17 -0800 (PST)
MIME-Version: 1.0
References: <20200116231709.377772748@linuxfoundation.org>
In-Reply-To: <20200116231709.377772748@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 17 Jan 2020 19:43:51 +0530
Message-ID: <CA+G9fYv_DsFjC_d=K95z1NdhgrBqGbLAURKTpG608fd9DK2aCQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/71] 4.14.166-stable review
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

On Fri, 17 Jan 2020 at 05:02, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.166 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 18 Jan 2020 23:16:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.166-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.166-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: e0cdfda2225350bfbf0a3d0a6ba1c2717512f26b
git describe: v4.14.165-72-ge0cdfda22253
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.165-72-ge0cdfda22253

No regressions (compared to build v4.14.165)

No fixes (compared to build v4.14.165)

Ran 24180 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15 - arm
- x86_64

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* kselftest
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
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
* ltp-cve-tests
* network-basic-tests
* spectre-meltdown-checker-test
* ltp-open-posix-tests
* kvm-unit-tests
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
