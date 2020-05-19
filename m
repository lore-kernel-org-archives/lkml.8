Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6831C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A380620809
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xYYcY2Dx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgESIUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 04:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgESIUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 04:20:09 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60879C05BD09
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 01:20:09 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v16so8696335ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 01:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fypbxrvkrndGX/CLErm06ghO8bWCVT16he/kHHLW3Ag=;
        b=xYYcY2DxMV0LuFmLPFjhqRuSOyCHYpAy0gkT1TnWfyg9ckS048Xi/9+I6QO6mjKNfC
         7o96Vd59xq6uQ8PGgtWq/touKpWKMldkxWl+IZjx7D3LWZEbMQ6W90e9v+uT6FKHTYWG
         py1PcDq9GRKp8xvribHb8zS0sV8T6E4nrdHWJU5GshbdD6G7RC4Gt6/j8EALV2zYRFxy
         BqNNJR/sIU/MjHrnNfOsNBf3vm3agHa4zf/tKBq/3HdYJ8slR3jHVT1tdDbNh2aurO0D
         dUFDdfaW7Vh1f5Ksrk09fmYwkDmRkqPw80nELy1SJiim9gS/ZCDVpXN1/9Nt+g82WF0S
         aWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fypbxrvkrndGX/CLErm06ghO8bWCVT16he/kHHLW3Ag=;
        b=t/VJeKWEM/XuuUQHSkxTwbmccu3lKIKhfbHdJy/aUKocmXzma5g3bpgwnCRBhDixi6
         EbjL6I14mIoj+HVu6MXRbxT2FwR16ZztqgCdae4cR8G3dpVMniYAbZVN49clclPlyEKz
         KPimVCKSPIJxYREpPoR+06hXE9yLkgLDH0xoqOzAtY3bDIDNFl06nAQ4lFHBwYmBAv14
         a0kfb5/TaDne2xC6zGLUr8cR7YuTEa8lFECFa5z9ltvvEw27S3NPEBhGfNzmEIzKbxQJ
         1q42294h6JAU/dLphrtgw6fqayJi5unjJO7yA4sUMa1vZ59eExj7XXVMoZ7ZSWFUd2Ww
         HlDA==
X-Gm-Message-State: AOAM533zKDAqnCi3gYi7lEwmT71V80dD9+rWin47raTgM1WTyKFBchjI
        JcKfKq/azNHFb2/rAiFSl4iKRyI5OHTz1kqDX/cJpg==
X-Google-Smtp-Source: ABdhPJw11c87+/vd6lSqaHZRJLJdPabZ0ec3xlVpbqbopIQVL4ckmrzXrEVJ3LJ0Hx584BH2fc/umWM1xkzCJHidpmk=
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr11974698ljm.165.1589876407651;
 Tue, 19 May 2020 01:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200518173450.930655662@linuxfoundation.org>
In-Reply-To: <20200518173450.930655662@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 19 May 2020 13:49:56 +0530
Message-ID: <CA+G9fYs8yHobkfZmTFMkNi7QPMWcTSMyvOcvMTaUXBi1=M=Y_A@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/90] 4.9.224-rc1 review
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

On Mon, 18 May 2020 at 23:13, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.224 release.
> There are 90 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 20 May 2020 17:32:42 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.224-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.224-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 7cb03e23d3f596ac9f89bee7cc836eb292321418
git describe: v4.9.223-91-g7cb03e23d3f5
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.223-91-g7cb03e23d3f5

No regressions (compared to build v4.9.223)

No fixes (compared to build v4.9.223)

Ran 31444 total tests in the following environments and test suites.

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
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* perf
* v4l2-compliance
* kvm-unit-tests
* network-basic-tests
* ltp-open-posix-tests
* kselftest/net
* kselftest/networking
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-native/drivers
* kselftest-vsyscall-mode-native/filesystems
* kselftest-vsyscall-mode-none
* kselftest-vsyscall-mode-none/drivers
* kselftest-vsyscall-mode-none/filesystems

--=20
Linaro LKFT
https://lkft.linaro.org
