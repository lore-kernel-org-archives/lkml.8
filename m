Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28750C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0147D20714
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IYdxs+SP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgGUKju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 06:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbgGUKjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:39:48 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF01DC0619D8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 03:39:48 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id d11so10129460vsq.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 03:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ae35Tla40gXKHZjTtmHTfp8nZLfz9N4dIm/F0WXzT/w=;
        b=IYdxs+SPmNfXhZFEpEij367uN7D3kbB7UbHK+MWWom5Ik+GD7exLfkqZii16E3nTVQ
         VVtR55n1FrNqBWymuCHGxFT4S/wfhlEXrUKzGo5JIoWlsCfe6R4YhxHkaQXUGzf9pEph
         6LY0Btw8zPZV8Ho2tSPIlj1XzM8/ytip4f8ysR0xWhaaqVtZg9XS8T7MoeT0EIeCXRNc
         1DqdIaZkIKcMFVLgw57iLLhRb4kIHh/BTxZXPVDI3ldtFwXuYi0OjTed0/Xlpio3JSUV
         eszYL5QFVA0+o1tyccpuRGKfdKVWjKtIg/TIYUWbigmaeL9GtzCQ03dRrEOr+FLfqAW8
         1IKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ae35Tla40gXKHZjTtmHTfp8nZLfz9N4dIm/F0WXzT/w=;
        b=ngqb0NuFk+X0mTjoO1dnRC4W7NNP+lbNSUxfPVlWP73h3ktpeoYChYsX7611zCT//x
         4Gm3czwDSOPc8/3dfpxzYzPZIUK3yzxOmMyjnVbYDDmmcRTUR384EAuoZhb7EBRGZhsf
         oACB3mXiOheJ9Hbn52QuN6JLDMFOSBqAdQKX6JzIxsLEcYdiDI9sgiVguwd4oVWpWxxQ
         wH/5PO032Mf+8O3l+WMb55PkOLyOp6NLpsKxO1Yz/xTnXCPKocw3lJDk9QW6kwQzAMGD
         aFnBpY+HF6TEB5rtWkbBzV6t1PiKuwhtdt3ZxUT4Sx76wcAxBmfPLhuzoeM0IFPfk5T5
         S6tg==
X-Gm-Message-State: AOAM533b+qlbt/xqXMI8QgXBupjzvmCuO6/1RgeUwr1ZOpmYIEo0LUqO
        MQJP2mrbFpKTLjqYTnhLyGkvydljSS5PHDlCAGITbA==
X-Google-Smtp-Source: ABdhPJwzajFOu6faBxm/CsPowOjhtM0yGbBDebrKk3YoiwfyHkzF+dmbuCnMJrYtxuE+PljJsHRf1xGBsSBZ18stYWA=
X-Received: by 2002:a67:fbcd:: with SMTP id o13mr19411078vsr.41.1595327987494;
 Tue, 21 Jul 2020 03:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200720152747.127988571@linuxfoundation.org>
In-Reply-To: <20200720152747.127988571@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 21 Jul 2020 16:09:36 +0530
Message-ID: <CA+G9fYvFVdh1w0kkLDknyut8sk3Kx0=yQLtKqZK9mTKHNtF=GQ@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/58] 4.4.231-rc1 review
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

On Mon, 20 Jul 2020 at 21:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.231 release.
> There are 58 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 22 Jul 2020 15:27:31 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.231-rc1.gz
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

kernel: 4.4.231-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: ecea46f8864653c4a4fa6c4f0b690500ba217149
git describe: v4.4.230-59-gecea46f88646
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.230-59-gecea46f88646

No regressions (compared to build v4.4.230)


No fixes (compared to build v4.4.230)


Ran 17639 total tests in the following environments and test suites.

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
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* perf
* v4l2-compliance
* kvm-unit-tests
* install-android-platform-tools-r2800

Summary
------------------------------------------------------------------------

kernel: 4.4.231-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.231-rc1-hikey-20200720-772
git commit: 89cea942179d0a31521a87d7de038e694b36a952
git describe: 4.4.231-rc1-hikey-20200720-772
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.231-rc1-hikey-20200720-772


No regressions (compared to build 4.4.231-rc1-hikey-20200717-769)


No fixes (compared to build 4.4.231-rc1-hikey-20200717-769)

Ran 1840 total tests in the following environments and test suites.

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
