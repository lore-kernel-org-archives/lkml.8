Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97ADC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3C2D2072A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ataGrn/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgIBHVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 03:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgIBHVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 03:21:38 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B2BC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 00:21:37 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id h23so988707vkn.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 00:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C/xlusgyynj50LphPE7yRWxaC4UNPqGRAKI/CRVezGo=;
        b=ataGrn/bavsY1PRvhpV+cu88HQPOAAhirgJONpozGGMDtHBc+kh+kySUsmPZXd3X2L
         ka8TjO0gZaXexKQILzFQfNFFiia7TJAp2KCiKLVa1BnOhrhLtk6LLWci/jN1rDonHWxD
         d9etY3oEAiqrKP5wbGUNHrIRnxm4+nWPVwMKQzWYL2hDO86VMRJPMhIkMuVRB7SUmZI5
         sZy9A4WYoy9Ldwp1UKAygreXWXI7ZJjjrEkNeBd4DZSSnD7fM1fn6HAZQq4/7lEBf3Ba
         YLXUqdKG3KKB2+508vaVpsZX4CQZXsgN9WNQE3AE1C8F+/sNzuFophv2vFwKMGaMiLfy
         T5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C/xlusgyynj50LphPE7yRWxaC4UNPqGRAKI/CRVezGo=;
        b=RJxCaaC26qkE2biwYAy1fULkEiCeS4B69lrIZSbiaN0cM3/cZ3t3Nw4JfVQUvXKsem
         WYnkxKw5eGGXJn99cItYGSWv9O3KYFQ+/FxVR7E4WO3Ri2A2w1WInyVbsernbehvHCMk
         +jSWL9gCJe+BUPfA2s9VmeboIplW1JK30/zJxPOYkwcXT9I927wkfI9lDl+PgwXcp8PA
         OvJHuI87BatLf8BlHysQ4VjOLt+2OOrSZIRnYOphPdNwOqAY094URjg/FaaSIsti+nZz
         Ptxips70Jus7TSasDpMJP76+L6cG/QgCZWW24razC0uMqyHp11/D751trl79cUOjwMS6
         8DXg==
X-Gm-Message-State: AOAM530ZUjEh82hzIELihPM2ZoR5BWUXGj3dGLvyvZxeIetOBWQrNUH2
        DTR+8batADOv5c8lvds3zNF5LcIiw/v+obsd9qNjOg==
X-Google-Smtp-Source: ABdhPJwacFo6Gk9MVMl4j50TKlHV7IPvBrGweCgCAi90kEX4/2dzyup49X43PX+GIuNEe4taDCbntBpaU1PJI9ZYu24=
X-Received: by 2002:a1f:4357:: with SMTP id q84mr4600241vka.4.1599031296792;
 Wed, 02 Sep 2020 00:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200901150924.680106554@linuxfoundation.org>
In-Reply-To: <20200901150924.680106554@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 2 Sep 2020 12:51:25 +0530
Message-ID: <CA+G9fYuZvp9LbLfqNd=wHMRuyAHbuffB+Hh0c-7y7vBPBoeVRg@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/78] 4.9.235-rc1 review
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

On Tue, 1 Sep 2020 at 20:46, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.235 release.
> There are 78 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 03 Sep 2020 15:09:01 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.235-rc1.gz
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

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

Summary
------------------------------------------------------------------------

kernel: 4.9.235-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: defc50a6f06ca62b5e1fa42add038887484154e4
git describe: v4.9.234-79-gdefc50a6f06c
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.234-79-gdefc50a6f06c

No regressions (compared to build v4.9.234)

No fixes (compared to build v4.9.234)

Ran 24841 total tests in the following environments and test suites.

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
- x86-kasan

Test Suites
-----------
* build
* igt-gpu-tools
* install-android-platform-tools-r2600
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
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* perf
* v4l2-compliance
* ltp-syscalls-tests
* ltp-tracing-tests
* network-basic-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-native/drivers
* kselftest-vsyscall-mode-native/filesystems
* kselftest-vsyscall-mode-none
* kselftest-vsyscall-mode-none/drivers
* kselftest-vsyscall-mode-none/filesystems
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
