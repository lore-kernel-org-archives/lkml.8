Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB736C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6EE520709
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="koDs5S7+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgHRGBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgHRGBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:01:31 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9904DC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 23:01:31 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id a1so9524979vsp.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 23:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0TdEL2s5heQf75vwYJNfnjXqieaKBtucNXTrsuJPeQ0=;
        b=koDs5S7+XZMJddWqtOyc69D9o31EFTwKRwLy9ykOrV+Wqp1gqeGY90tLPCpxl7+625
         cVcwZ3TqptCJ+Q6Vhg5KOV6v3glJ7dqFwMfSoty+ERhhYf/EJtlAbS35uyIpZajiqqzn
         QdMu201Omd87V06VVt89dN7xNqiqSs/kzOm8pIAo6P8Rxl2hjfPyXx/peetzoGWsL/Lo
         tQ566JlG63tYHEbZOlMsWVnoknJL+RrPlKzlIpJq6T6kbIqfo1LTK/UtsUXE2mQbBw6M
         DZqJYkAEEex4fKPWTPW28/JklJ9Zfr9Gf3f7ioFhSxbBCUfTfSYfQHzfcnkcZiC8U07y
         ckxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0TdEL2s5heQf75vwYJNfnjXqieaKBtucNXTrsuJPeQ0=;
        b=Fi3qPZPnrazjsZpQFAvfo3UDvlcoasKujTSbXK7r9JkgAlE8FLOQNpPM2+p5VTHuI7
         AH9iiUOtW67gRgxh76uSNoZinxqmKhbsupYfkHOL2t6d1Ia+8mYH8Ue+hEpr7VoLFeVu
         1mvDNOMO8NKz+1vw8GTpo3KQgzn9j1JPVEc2VIVTbJlVUw/YCw4wV976NhWi31l92h1N
         nT5NL+7SybnOHxECBFJXggyyCd9mZCGWzNwDku5v+M7iF8BU0x3HM4au+vKHsOWjWwJi
         jtRSNeb9Td+dvnKRHgLRBK40QI/gGkmBbJkyWs2dsyXSvJtMF5cIZJhLHgWTBHcfdWuA
         RZMg==
X-Gm-Message-State: AOAM530HYc6At/fFQ+gAKSmSWWqAU80zLQzXNNLjS1m1T/ZTsxEuCX7A
        bLJMTC2JK9waN/YvArcXfad6qVmjUnugM99tI2UXQg==
X-Google-Smtp-Source: ABdhPJzo7tafMaTv/yDE2aoIjuAX18/1G22S96q7B0osOCU9B3d9xF2OIt2YPGUF59iPzOsR1lNvjL3TbiLOVqXNTxw=
X-Received: by 2002:a67:d84:: with SMTP id 126mr626997vsn.69.1597730490437;
 Mon, 17 Aug 2020 23:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200817143755.807583758@linuxfoundation.org>
In-Reply-To: <20200817143755.807583758@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 18 Aug 2020 11:31:19 +0530
Message-ID: <CA+G9fYu=TrfvO9soJJfwBKLV2VYRv2vJ8MQ37sqdaz6tHGDSyQ@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/270] 5.4.59-rc1 review
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

On Mon, 17 Aug 2020 at 21:31, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.59 release.
> There are 270 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 19 Aug 2020 14:36:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.59-rc1.gz
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

kernel: 5.4.59-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: 6982f544144f32263ec02a0eb61a60148824b853
git describe: v5.4.58-271-g6982f544144f
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/bui=
ld/v5.4.58-271-g6982f544144f

No regressions (compared to build v5.4.58)

No fixes (compared to build v5.4.58)

Ran 31881 total tests in the following environments and test suites.

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
* igt-gpu-tools
* install-android-platform-tools-r2600
* kselftest
* kselftest/drivers
* kselftest/filesystems
* kselftest/net
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-dio-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-tracing-tests
* perf
* v4l2-compliance
* ltp-containers-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-sched-tests
* ltp-syscalls-tests
* network-basic-tests
* ltp-controllers-tests
* ltp-cve-tests
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
