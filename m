Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74434C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 508FF206F1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TCeAAJHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgFQHZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQHZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 03:25:10 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C85C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 00:25:10 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id d7so643774lfi.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 00:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NBcvyI8n8mcl8pFmre/YEhhWOCxkmqr93q9SNpHj6AY=;
        b=TCeAAJHU0EBOzLN4IVmZFmkJhthcHcN4UVfGDvgGblyACZg9SzIIlwFEkXtV7J0csc
         EbSYK1ijp2RZv6cBdg2CZG8hjmoq200sCpHSv23DAjmmzQiUnorC7pf4UvFhb4/f8D+F
         iYWEsHY69Cz5LJ1DPCE2PJ4dtQWjr4RHHhGJrAv1iRT5NLst1fNKo5VORSkLdX0NrxhT
         TiJX7vqAwBYT1o05XLldvJbQK78OWbIv20PDQN2PPX0MI0aKlykA6NSckCxtxJ4ZwQKH
         z/zYJBj6B5ZzKoczj2tCzxT0GRM7NfwMUyrgGGEaBvgyADfhY5v3QVP99FdcXpxXe/wR
         2Nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NBcvyI8n8mcl8pFmre/YEhhWOCxkmqr93q9SNpHj6AY=;
        b=MVV79mQo3Zy7hQect+dD4rN03eLCfTHIm9z0togoDmlsuCj7KeG76yUcq0PN/JkNc9
         ruZqzWFpx1R7QwknoXJtgd/rRxiH/PXNDydtm1rLl9kK6HWR+F31YUwS1rFMJbzgO1f/
         /3+3Q4P4vkaQ0CILvYVj+22K2DQRf+lox66+GQ0D8neVhQIC0FWuCIPmfwlB/+VPUPUz
         omcGypSHzGLFQCNtKnCKmz1IipGkGCiMkYQTN42396lMJamABBPnPk1ztIPkgjvlBiE7
         2dM6wjOFIx8hzbFUariZFxdDVyrW3ZcYsyVGCZvc0zuJbdqWC51vpVvn4wHx0RMduGQc
         0eXA==
X-Gm-Message-State: AOAM531iCWmnak56hUGseCKWVspgeiOS2+2zNiKm3kG4i9oF4cf4kkWh
        Z1CAp4vMCDIeH9yZjFAkl2B24OId8ChwOwFV2oENqg==
X-Google-Smtp-Source: ABdhPJyU7JeiKPrBiW/e15v4R/wbxTaFvBmDKHV7eA18MzDsA0i4Crhlnxn2+q7mBbv8Gi8oEnu3vETuUmCeAxhnKm0=
X-Received: by 2002:a19:2292:: with SMTP id i140mr3714997lfi.95.1592378708022;
 Wed, 17 Jun 2020 00:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200616172615.453746383@linuxfoundation.org>
In-Reply-To: <20200616172615.453746383@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 17 Jun 2020 12:54:56 +0530
Message-ID: <CA+G9fYsBwdUZtXTqoLJNm=8XPy+Hq4rUbZSmyGg=rLWRdF_j7Q@mail.gmail.com>
Subject: Re: [PATCH 5.7 000/162] 5.7.3-rc2 review
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

On Tue, 16 Jun 2020 at 22:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.7.3 release.
> There are 162 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 18 Jun 2020 17:25:43 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.7.3-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.7.3-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.7.y
git commit: 55b987cbccd9e2536c0ceec2c1be7207560add0e
git describe: v5.7.2-163-g55b987cbccd9
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.7-oe/bui=
ld/v5.7.2-163-g55b987cbccd9

No regressions (compared to build v5.7.1-25-g00f7cc67908b)

No fixes (compared to build v5.7.1-25-g00f7cc67908b)

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
* install-android-platform-tools-r2600
* install-android-platform-tools-r2800
* kselftest
* kselftest/drivers
* kselftest/filesystems
* kselftest/net
* kvm-unit-tests
* libhugetlbfs
* linux-log-parser
* ltp-commands-tests
* ltp-controllers-tests
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
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* network-basic-tests
* ltp-cve-tests
* ltp-open-posix-tests
* v4l2-compliance
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
