Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1556AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE21E20706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lvjB5WsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbgHYJjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 05:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729541AbgHYJji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 05:39:38 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86C7C061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 02:39:37 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id z12so3516621uam.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 02:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F8RyGpZce9sAtHij6G4iz6UyxcewKV8KKBjMizxZZg0=;
        b=lvjB5WsQEamNsogOYnOkO2KqSCkLezH9ELsoxVWqTQDZu9eRMNcwv/BidPSjqMFTeF
         PdCdQLqi+HOaSN7udm3Sf+IBPXpeF4BNccDLeGfTxbDQxSx5SyCF3mUgZON6RCuLfUzX
         jiZJk0Z5MLsNi5wqPC2J5ZFFouxLDGb0D5ifGiTvVuGXnZmrLYNWwSDB27+PvTxH49xh
         qqWcM3SGhR3yDLMNXccgyiHL8NATSxhhxW0nDm0b9vzvNwEIQhgya6Jx4LglVMT8znqg
         gpyUDITlfKS23GaDK4bASeO285Vm3Q90ZTfNCRbWE0cvZ0kDlFr3BcBUtBCZmdyWbDgb
         ST5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F8RyGpZce9sAtHij6G4iz6UyxcewKV8KKBjMizxZZg0=;
        b=KeLHpxR9tJ2b52j24aqqJTxlHc4q6OihT7/QZDnaq9mecKKYW0eCm8bgQrsKOIBj2Y
         kHQKFWYGH1ivvztans30P+D70nlwaZzvd+7fYvPNoLICrIMbYkcgBcJEK0XSW5+KTxjA
         oftymvJgJsO+Zam9+5qWsyL+g5Ap5TD5vttfWhAqkeSWYQ0C56KqYP0JJzRSD2LdeRdK
         ApLPzOWAXAGs23MeYrRh8+eyXIMcq63knAP2HZ/52tbifw/wcAVyh2PSs0TIk3mcbQqc
         ECq24ESz2O+XJNr7h0I9LdpMec+wg1Oox0obeE/eEtuWmuRhr6xpZOM0P7aoJ5O6Gcwl
         pEMQ==
X-Gm-Message-State: AOAM532rV+JBKPSYu009GXZzOWvRC5vrkXAgvXIzdDjW3dhNENaX049x
        CoXpQbi42MYZCPzTbGX/29mO/QjDN+6DT0PYXBCiNw==
X-Google-Smtp-Source: ABdhPJwp0p0ddB7u/7I04UCjNq2hZXxvMKYM+Ggvedee/phyfyhZmOV+JkAmnNvHqPv/wObuQQF4jPQG57cVcm7VN9g=
X-Received: by 2002:ab0:462:: with SMTP id 89mr4940799uav.34.1598348376894;
 Tue, 25 Aug 2020 02:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200824164719.331619736@linuxfoundation.org>
In-Reply-To: <20200824164719.331619736@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 25 Aug 2020 15:09:24 +0530
Message-ID: <CA+G9fYvcdGS-_trOL-bkXBczE+2nzXFanpQA_wdDccAMWbkOLg@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/34] 4.4.234-rc2 review
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

On Mon, 24 Aug 2020 at 22:19, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.234 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 26 Aug 2020 16:47:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.234-rc2.gz
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

kernel: 4.4.234-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: f607f7ffa21bbfffe114016abd04ab8be10838d2
git describe: v4.4.233-35-gf607f7ffa21b
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.233-35-gf607f7ffa21b


No regressions (compared to build v4.4.233)


No fixes (compared to build v4.4.233)

Ran 2225 total tests in the following environments and test suites.

Environments
--------------
- i386
- juno-r2 - arm64
- x15 - arm
- x86_64

Test Suites
-----------
* build
* linux-log-parser
* network-basic-tests
* perf
* install-android-platform-tools-r2600
* kselftest
* kselftest/drivers
* kselftest/filesystems
* kselftest/net
* libhugetlbfs
* ltp-commands-tests
* ltp-containers-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* v4l2-compliance

Summary
------------------------------------------------------------------------

kernel: 4.4.234-rc2
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.234-rc2-hikey-20200824-799
git commit: a3ff3221390a8c2a5665927f3144210b3066b8ab
git describe: 4.4.234-rc2-hikey-20200824-799
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.234-rc2-hikey-20200824-799


No regressions (compared to build 4.4.234-rc1-hikey-20200824-798)


No fixes (compared to build 4.4.234-rc1-hikey-20200824-798)

Ran 1841 total tests in the following environments and test suites.

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
