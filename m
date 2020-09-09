Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E84BC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 05:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C17E82166E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 05:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r8BTY2YX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgIIFuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 01:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIIFuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 01:50:04 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3215EC061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 22:50:04 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id q200so403574vke.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 22:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F010r7AC1YmxCyRdEDXolV4x20/MgUGIBtdNub43n04=;
        b=r8BTY2YXWJS2Q8/TUQ4+8R7wSKt1iCjSQiKUdLv1Uk1+BTYHAVBBGeLCWDqAMKMcdw
         z9HTVx2+78jdZQAN9Lv0f6t5K3kSxXKL5bMoE8iIxPeT6AENYZMTKLdarozEa0BGMg1F
         5LxlQ26b9Ur02GDjlVWROx0KNve2Usc/mRah2B9x27mgbWBa2l9yDoionUcZdwWzhORh
         n0dF9D87eBSPHx0UL3WG4xiOOrPlbgQru65obZX1WC7oi70WAq/X3dNGx6zW6mZpSzFK
         36Yl5pAwJKrfXV6o1lIFGSN5PtqoZozRRrBTqOmXZiFDaeZ6LN4MEJJzx/oXFmfPNS41
         v/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F010r7AC1YmxCyRdEDXolV4x20/MgUGIBtdNub43n04=;
        b=iZXFyxIiWOiTM9YUTJKkIK4d5O4EkM/5fqZ/9+xYl9k6POSRrnRiN8vtvMpiAINbCA
         3PnMmbB9J+0+xzYR/bFYycF4Xt+YaMDbAqinMonNDVVsem9BVIFu46NwT42Z/NdgnApH
         5ttnh+CLOFAglB05h5oowkCy6xRv8e7LGka+CNkVQCZY918mesenwXfv7U+Kn1vb2j/S
         ERSt3BhzIwnUVzboKYJxz8hGrQ0zltAA718UusdVgpnejk7xNpXjCN2iTOxDOw1hkSeX
         GXz1XezD5rzcIVw2hS+amErlFzc+UObmGd1uo5IsdBAmb3/CF+6dXF9O9sWt/TG2sPA+
         T6Fw==
X-Gm-Message-State: AOAM530l8YKz4P/zh/GXNO7ilfCLwWkMq8crTdNn+SAWa5bHkRpc/A/R
        pg4HlKv7j6ZsVjwXenOF3lxh47mREPxDrigeScrsgg==
X-Google-Smtp-Source: ABdhPJzrw8UemA0Eeq/rU7p4oXABsliWLndCOKfYsQryv8InBoP/5ltU/Sm363Sxy8eg59T/fj1YD4N/rFhyrs/VrA0=
X-Received: by 2002:a1f:5f05:: with SMTP id t5mr1577677vkb.8.1599630603349;
 Tue, 08 Sep 2020 22:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200908152229.689878733@linuxfoundation.org>
In-Reply-To: <20200908152229.689878733@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 9 Sep 2020 11:19:52 +0530
Message-ID: <CA+G9fYveLrUmSB3T1ix3Q8iqYzTF80frS7AUDeW6tKEbFuuKqg@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/129] 5.4.64-rc1 review
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

On Tue, 8 Sep 2020 at 21:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.64 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Sep 2020 15:21:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.64-rc1.gz
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

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

Summary
------------------------------------------------------------------------

kernel: 5.4.64-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: be965cc6b079fbac3bf73ce195ae06aa5314fd99
git describe: v5.4.63-130-gbe965cc6b079
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/bui=
ld/v5.4.63-130-gbe965cc6b079

No regressions (compared to build v5.4.63)


No fixes (compared to build v5.4.63)


Ran 34523 total tests in the following environments and test suites.

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
* kvm-unit-tests
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
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
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-tracing-tests
* perf
* v4l2-compliance
* ltp-commands-tests
* ltp-ipc-tests
* ltp-math-tests
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
