Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4355AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20620206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uy3fPRUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733003AbgGaMPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732842AbgGaMPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:15:44 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29618C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:15:44 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id 4so9444275vsf.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1gowMH0CRwwMnTHOVHU5jY/2lEG6qeP7P342f23hLe8=;
        b=Uy3fPRUd0/4F2GahA2w1QyYu+RiazzcsITzsOpRGCrz//KczrF1IFtYoww4zguNEI6
         ndyjHmV+yXgrT69dIDVKbiqx/hvpAKv1JUMz3M2lzgtl3DG2OHP6ZS7nWEEQcWqO9JQj
         XsfrMjTS0xZYOeXT8QcCBJC0N6io339/+cdmOyUfARxXVyW8vuPInnkcX0TX73rVSzju
         jI2nZVD/os+rJjrz+tnuuEUqTZY53UOXszbavlZ+dpPNJPZLJhreW+oMYVxYALvWJPWn
         bwwTeQKpDwBYy57drWjXNVF+Tb/p7FS5/QDPxdSGFbolZ+l1flT79HfryLOHhLxICPEz
         6bTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1gowMH0CRwwMnTHOVHU5jY/2lEG6qeP7P342f23hLe8=;
        b=UlQVfX81J+GEZUlThqUVcVNKlpxlcDBcIfRbeK+XMEWzSgbr2zTXUvy17V3noOlEQL
         KJ59PkEoPlv1J7C38DpqThzD5cmXdIui/Ad/+Stl54fx1gM4CgQyDihStG9WH/c7Focw
         wpH2ptiwPOnUjxbX2yuUqZRuv05l68t477BJ0upVXwykN7AWiC8NKI6IvWkWxggOIMLd
         QJ59kKh5Tw5CxQw0CNWXUmkyKTTYk3N3UBZlJVU3xnsvoaICZDLrUGyyKZqNsTRLfC6Q
         q36b/DP6XDUG/ujbgRNCqht7XjNXChfDmwR8s21Vr/o8SNAQ0A1oUfCYUFpcD0GJXrdg
         EKpg==
X-Gm-Message-State: AOAM533stYiYV9irNridv0QBk74oOCZEXTWx+/s8ReG3opeAhDJgZrZ8
        mG37eg7EYIL0IGjaJUrsJg+AeAOeNf098tMihlIM1g==
X-Google-Smtp-Source: ABdhPJwqa3AabQ8T7tGM5gvXPn/waAtUx7Bx6tpvelDIEjRtH3c5BSOGnIJ7IJCjmtRRgG9WBTERlbBA78mRy1LKeEs=
X-Received: by 2002:a67:e412:: with SMTP id d18mr2862509vsf.41.1596197743258;
 Fri, 31 Jul 2020 05:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200730074418.882736401@linuxfoundation.org>
In-Reply-To: <20200730074418.882736401@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 31 Jul 2020 17:45:31 +0530
Message-ID: <CA+G9fYvKSWvopcjec-+eczak44XUsKf3Qb00uMOE9-iFfq_xVw@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/14] 4.14.191-rc1 review
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

On Thu, 30 Jul 2020 at 13:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.191 release.
> There are 14 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 01 Aug 2020 07:44:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.191-rc1.gz
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

kernel: 4.14.191-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: f743b8ea46fbaa440f9ccf7a4da9fa4a874941b0
git describe: v4.14.190-15-gf743b8ea46fb
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.190-15-gf743b8ea46fb

No regressions (compared to build v4.14.189-80-gf743b8ea46fb)

No fixes (compared to build v4.14.189-80-gf743b8ea46fb)

Ran 34716 total tests in the following environments and test suites.

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
* igt-gpu-tools
* install-android-platform-tools-r2600
* install-android-platform-tools-r2800
* kselftest
* kselftest/drivers
* kselftest/filesystems
* kselftest/net
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-dio-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-mm-tests
* perf
* v4l2-compliance
* kvm-unit-tests
* ltp-commands-tests
* ltp-controllers-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-native/drivers
* kselftest-vsyscall-mode-native/filesystems
* kselftest-vsyscall-mode-native/net
* kselftest-vsyscall-mode-none
* kselftest-vsyscall-mode-none/drivers
* kselftest-vsyscall-mode-none/filesystems
* kselftest-vsyscall-mode-none/net
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
