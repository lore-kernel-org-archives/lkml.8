Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF6FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A37120890
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i6CaNHHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388148AbgE0Iga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388139AbgE0Ig3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:36:29 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5584C03E97C
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 01:36:28 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id e125so13981129lfd.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 01:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QKsW+LhuFWLts/ySjADgQNoFzggmEchkHP7oLX/Do3w=;
        b=i6CaNHHWAemICJMG3E4jUdEtdfGKJczZRr1T4YUUhn3dMDDZfcQCPu5K8DYghAxn9Y
         oJuncuLRz7sn9Ddytod4rQFcggTYj4mwJneTvFyln+xXP3Uo9VChHBvSbkR4fz4HbYCj
         NqoQZKZzqkTkT+zhLuTlN5uqRL8NiROQmmJxtGhwgzpVBeTQzebf4XSl948CZSwP/ru/
         UgydlbV1zurvniK3QP6SKsZKyE2QYeT1B4altGQZaHFdaFJQptL/hge9U9rpwH+RFuFo
         Lfbihq/kmAyo+r8Rsyh77krZZDvr9x03Ggq9fdlmwknQbtq7Taml3bZKnte+32ptMxSn
         dzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QKsW+LhuFWLts/ySjADgQNoFzggmEchkHP7oLX/Do3w=;
        b=WNfNyIMD5jXSPcrOsQeTGGSzEmCgGJmeNdmwSsblahmJl2TX5WQoYjQ8aelKmDsp1c
         nMkWc8pONTboBMgwTtNd7WqxwXNUX6GrqHCmJ8Ko1o/UExNWhCx48i+jcjqE4c2svseW
         kfmF5bOqUywxAPfqkSdpz4kTn6koWhSTayYGcVBu02xj1C8GY9fRYoHxVfL8LTmWKUh9
         T00YSSpcUDvZ2vV2eIsEnp2jSdeXrdvtPbEOI5qMyOOABXVAb8Pumn06d1b3yS8uY++K
         4/wBEFHRfuUO5INKEsJEkyZjoIr6O1DFxus8MMqRRdVucvoEzegKdq1iYZuKQLWI9gLi
         PmtA==
X-Gm-Message-State: AOAM532V3I+gANuFsfDk96Wi2Gl74J2Bk/rHhOoWY5rUtaNSCU4gJ7j2
        I6eriqejmUtvgbfyzwMCauOWwvmHTnYEeTr9vFPFoA==
X-Google-Smtp-Source: ABdhPJyqmBFhBjUEn3fuSHjl4enmpZNm21AwzDnEj+9k9X0lHcqmaCgAP5tTagvmwteflc4q7J2dFXwtq0Vpwp6THT0=
X-Received: by 2002:ac2:55b2:: with SMTP id y18mr2553554lfg.55.1590568587062;
 Wed, 27 May 2020 01:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200526183907.123822792@linuxfoundation.org>
In-Reply-To: <20200526183907.123822792@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 27 May 2020 14:06:14 +0530
Message-ID: <CA+G9fYsZyFybO=M+5RDHi6vFXmuxC+My6YE_g9ur7mSJ3O0bKQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/59] 4.14.182-rc1 review
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

On Wed, 27 May 2020 at 00:31, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.182 release.
> There are 59 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 28 May 2020 18:36:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.182-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
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

kernel: 4.14.182-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: ce8b534d70e21cb589da3731a1f61fabda583756
git describe: v4.14.181-60-gce8b534d70e2
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.181-60-gce8b534d70e2

No regressions (compared to build v4.14.181)

No fixes (compared to build v4.14.181)

Ran 25832 total tests in the following environments and test suites.

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
* install-android-platform-tools-r2800
* linux-log-parser
* ltp-containers-tests
* ltp-fs-tests
* ltp-commands-tests
* ltp-math-tests
* ltp-syscalls-tests
* kselftest
* kselftest/drivers
* kselftest/filesystems
* kselftest/net
* kselftest/networking
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* network-basic-tests
* perf
* v4l2-compliance
* kvm-unit-tests
* install-android-platform-tools-r2600
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
