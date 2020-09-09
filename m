Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F978C2D0A8
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8D542087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HC5Ww9Nt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbgIIIME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729860AbgIIIL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:11:58 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C935C061755
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 01:11:58 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id j185so857078vsc.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 01:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nKdqPjqDFfHRMf/XA+KUr72ZflIzyRtrjQk6IDY1xAE=;
        b=HC5Ww9NtA0ci3XvaOTxTTQu5xn6MYQ0fbWSI8XpDmXdD5/zURS4DHti0j2deZrqQxf
         BsoHZHOPDTzwpJPG4nrr1DUYw4E/2CnLlOAqnFAkGomr9XXzd+8f+BdL+zyRL3H5Gk3t
         0sT4JTOY7gmPywBd8128yMTp9sjQ3cVxGf+r5gHyiLALFuE7obUQhn/SAGmMZg/d5xB8
         HV9elqNF5GSxucmsrHz+a9YXID4gvx+rERxM6KecjYsmsgnUog4jmMExk0s8jIM8Aj9g
         48tfp85bAoEPAQpkCGuccLvfy9hzRaUkqFisvSatHNuA1X/VHC122zDIk/6EJ0+1TWR+
         BE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nKdqPjqDFfHRMf/XA+KUr72ZflIzyRtrjQk6IDY1xAE=;
        b=NCNgb5VY7SA/LrU+B6+ijYevTXmWSTRENjDyg/hEyNFjfMRmh7cdXjllvYiIZfenXd
         O/rILR/mmWfi5gwQ6SJSjbW07fmebLBdEyGX4Ia7xUAuGX1ndzYQ61VA2kp5sqxa8XrE
         u0k2/+NVsDQbr2+LHl6aP9fvHgXWzYdga652ACf9YHsXOzpCC0bCkvJeU8kqyZety3ay
         n4JO46DmZMqBeHvLB+5sGQPJ2QrZV1nLx7xc9Aa1niaKCkJGmkKdxDPg73WjlVgyiSRf
         It3PFq7HhRLj8QXtXi+py50xfOLiDjeLbJRDCgTuO2l+8xh8XXQmmVxkTHPswMVMU3FB
         KBDg==
X-Gm-Message-State: AOAM530i9Xi71FhAEVFGhpqC2UcLuSkXPNzo+gcfFs8iOy2K/2XJomk1
        GqGrBY5evAv6uP6oH4I6J9Yy2fpZ0pBb0GZPqkoL7w==
X-Google-Smtp-Source: ABdhPJwOrsN0F3PCf7X8sxg5rr2tDNxsyMAPCRs0iEwwBZyxPVE2ENQnIIsDNxArWPzu2lDFlX3pP59bN7/EAYDZoDk=
X-Received: by 2002:a67:7c52:: with SMTP id x79mr1548525vsc.21.1599639117011;
 Wed, 09 Sep 2020 01:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200908152221.082184905@linuxfoundation.org>
In-Reply-To: <20200908152221.082184905@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 9 Sep 2020 13:41:45 +0530
Message-ID: <CA+G9fYsjO2khWuitvNrtrmVuOW3hQiWNc+XHoTmTE0+xKT3dBw@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/88] 4.19.144-rc1 review
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

On Tue, 8 Sep 2020 at 21:18, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.144 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Sep 2020 15:21:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.144-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
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

kernel: 4.19.144-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 539e30e8c9cd0a71379976e504f64e148d714ba3
git describe: v4.19.143-89-g539e30e8c9cd
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.143-89-g539e30e8c9cd

No regressions (compared to build v4.19.143)

No fixes (compared to build v4.19.143)

Ran 36520 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- juno-r2-compat
- juno-r2-kasan
- nxp-ls2088
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
* kselftest
* kselftest/drivers
* kselftest/filesystems
* kselftest/net
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
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-sched-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* perf
* v4l2-compliance
* ltp-controllers-tests
* ltp-fs-tests
* ltp-hugetlb-tests
* network-basic-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-securebits-tests
* igt-gpu-tools
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-native/drivers
* kselftest-vsyscall-mode-native/filesystems
* kselftest-vsyscall-mode-native/net
* kselftest-vsyscall-mode-none
* kselftest-vsyscall-mode-none/drivers
* kselftest-vsyscall-mode-none/filesystems
* kselftest-vsyscall-mode-none/net

--=20
Linaro LKFT
https://lkft.linaro.org
