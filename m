Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3492CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1570E2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YZY7uiR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbgE0I0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729367AbgE0I0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:26:08 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A54EC03E97A
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 01:26:07 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id x22so13957815lfd.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 01:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H+gUIKNMd6nIo0QeylfVIxtbYuK8Y4jzDVJ5NocVzGY=;
        b=YZY7uiR3MicDEKmXgNXTyN7EBys2n8zTSHsWNeeH0uFIemltXHvsQ9pXw3Q2kW2qMb
         q7/m8qtqdi1p8vvsikFme3OMOIpQigKXrHG+64zBaAORnKYCL3Dl4/6L2AYRaTyiYGeC
         Q1OVlhFWU6qFRq6ZHxKUBYbKOka29kbsnnTxFEfIzfKwYaQCPlD02RFjMPYPudeiXJFI
         nI65s35sfP+TiI54SgypPB8QnURBUMU6jXqjfgBO6md5QY3Z94VWdT68s8hn+xDwLYh3
         DB734Tjio/anDyOodgZd0e5SCMw+blKM1YrH1RUZCMx8djIlxbVrXnM5J1ASEXMOZGsH
         HpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H+gUIKNMd6nIo0QeylfVIxtbYuK8Y4jzDVJ5NocVzGY=;
        b=HYbpmZ2HL9cW/SIfFzwGC4Oy2FNoTl0uiKwZOQ/NCplLgyWj09X4iEAfNg7jHbLzSm
         f+OThV0M0CBJbc3FtzE77+AIwR9Os1PZxTdlAaUzthRtWj719FgEJzppEsR6WkAFv9em
         EWoiTIGdRUVRiyXSlpk6HLnismX6HisZDS6WbZFkCaoNXvmVgig8VaVB6JfD+vibz3Kr
         XSJpO7LksJJ69z9M+0Ynho8UVHYmiyQUXXaFAwC9ro44GTHYBraXEpFz41gZFG1wOoTa
         3+FPtCKXnGS41adDdygHDCgZHHr8CRJiooDvpY1b2cgxB6m5SLie6TMmVMN2m5um03x/
         3zjw==
X-Gm-Message-State: AOAM532yHNLLz5Fzt0xVIG/daKIJILR/5xFekDcn8DF+Moql2wP8kE5Y
        yMKAJmKxTO2XWUf2dyJHGVpADM0/YK/RZSakIMQr5vMu9GRwBw==
X-Google-Smtp-Source: ABdhPJyVVN6Y6XEZBWD1DUFRPOteaNoJJwuuk5jsP5TZfMnAzrtAHsVy1ox2gdik4QCKLc2lrFDCbPoNshVZow9YSTg=
X-Received: by 2002:a05:6512:31c5:: with SMTP id j5mr2598058lfe.26.1590567965195;
 Wed, 27 May 2020 01:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200526183932.245016380@linuxfoundation.org>
In-Reply-To: <20200526183932.245016380@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 27 May 2020 13:55:53 +0530
Message-ID: <CA+G9fYv0206jNsGT4BPxiz_+SACHLyDZyfb2uYCukCL1yQ882Q@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/111] 5.4.43-rc1 review
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

On Wed, 27 May 2020 at 00:37, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.43 release.
> There are 111 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 28 May 2020 18:36:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.43-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.4.43-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: 00dd3347ad64830e7d9a5a6bd3036b9537887208
git describe: v5.4.42-112-g00dd3347ad64
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/bui=
ld/v5.4.42-112-g00dd3347ad64

No regressions (compared to build v5.4.42)

No fixes (compared to build v5.4.42)


Ran 31714 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c
- hi6220-hikey
- i386
- juno-r2
- juno-r2-compat
- juno-r2-kasan
- nxp-ls2088
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15
- x86
- x86-kasan

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* install-android-platform-tools-r2800
* libgpiod
* linux-log-parser
* ltp-containers-tests
* ltp-fs-tests
* kselftest
* kselftest/drivers
* kselftest/filesystems
* kselftest/net
* kselftest/networking
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-hugetlb-tests
* ltp-mm-tests
* ltp-sched-tests
* ltp-syscalls-tests
* network-basic-tests
* v4l2-compliance
* ltp-commands-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-securebits-tests
* perf
* kvm-unit-tests
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
