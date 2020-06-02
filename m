Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB60FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FEDE206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nMe1g6II"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgFBQ0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 12:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgFBQ0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 12:26:31 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E59C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 09:26:30 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 82so6547892lfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 09:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zz7fhoTM9QdHAuOJqfvKMHbuIuwima0BEOw44sB2Lw8=;
        b=nMe1g6IIHJMCm7agcZhbi88PN9tZigbmBS+dW8ccOf/MvTzbXVXkZJoDldzhus1lPH
         pVMYG7UfYKrxJgkbOPMmlG5WMIlvtEljOoBaUm6+VSDeuU3FSEq17BNil2CnqtmvV5pl
         VugAUASmgGmZIADGrIqgshcL4/f3jOSJWAyGcZygo5o55vGR6iJv9kJGVhPZ5BbaZEtm
         miLDVpW8t1tw/rI4VFEfrbJc8tZFzmhYPWpSWcMheTFakUSxtoYSlCNX4fV4Rdjb13P0
         HkOJYHRRXDPUAf7swg/FmZTAkgtuzfe/sVcVVmPILs4UatoxHPoSDKGN54f33w2ksXqX
         0bSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zz7fhoTM9QdHAuOJqfvKMHbuIuwima0BEOw44sB2Lw8=;
        b=aPQdMPungzSaKCH9+dvTjsvM+xnciN5M5IzZzrD5HHtHNdke98jr/n1Oo+7qYASGIW
         W75JL5ek7rGTFoypq64ZBVOXxGb3D3jWGrRsNjRoJB7GadvwWUjRswyon82yTrWcDW1S
         EIgjJ+1/X1rSTS5Xrblhmj/3q3L9eOvqbOQYHo/BJeJAE5BVyzBjFOwxvW9Vy3KbTH82
         jN9cL2+qMiTNLSuz+cuXIcelt19/9IT7us9C5eISADVnxnTMjFOP4iBtcE3GKzAN4iXN
         5mUZ+7cCPdXhQDNJCS/ek0+OWRvdYsWqHcz5E7sOCHfvAT2WyiZ8sdf63wvYZUiOUj8n
         ZH2w==
X-Gm-Message-State: AOAM531mt5vV4Q5Cp8UxzLiVwjzfLZ3mA0sSM5T+ets6hfDeJDHn3Qa0
        vGOMm8vOV7tQVphVvlVNdo3EEc/l4r19SawsA3sap1+5JydrwA==
X-Google-Smtp-Source: ABdhPJzWp+hDdyYu66xB5+uDupO8bu8PKKwwmBhpKgNFT4R0wzQSvIIwDXbtCjXZKi//eLRufEIdjDNn/7OZIj4TqLc=
X-Received: by 2002:ac2:55b2:: with SMTP id y18mr104403lfg.55.1591115188968;
 Tue, 02 Jun 2020 09:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200602101934.141130356@linuxfoundation.org>
In-Reply-To: <20200602101934.141130356@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 2 Jun 2020 21:56:17 +0530
Message-ID: <CA+G9fYsPS4W5tyH2y6i2M-FrQ+A8tU61GUjLQ+KBW-_Rbb4_Rw@mail.gmail.com>
Subject: Re: [PATCH 5.6 000/174] 5.6.16-rc2 review
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

On Tue, 2 Jun 2020 at 15:55, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.6.16 release.
> There are 174 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Jun 2020 10:16:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.6.16-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.6.16-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.6.y
git commit: 4ceaad0d95e7a56ea839541b0e825af93e4817d9
git describe: v5.6.15-175-g4ceaad0d95e7
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.6-oe/bui=
ld/v5.6.15-175-g4ceaad0d95e7

No regressions (compared to build v5.6.15)

No fixes (compared to build v5.6.15)

Ran 32298 total tests in the following environments and test suites.

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
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fs-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* perf
* kvm-unit-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* network-basic-tests
* v4l2-compliance
* kselftest
* kselftest/drivers
* kselftest/filesystems
* kselftest/net
* kselftest/networking
* ltp-ipc-tests
* ltp-open-posix-tests

--=20
Linaro LKFT
https://lkft.linaro.org
