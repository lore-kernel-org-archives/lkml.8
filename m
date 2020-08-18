Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7088C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 05:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CE6720738
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 05:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BHrcr6dE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgHRF4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 01:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgHRFz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 01:55:59 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BC3C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 22:55:59 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id o184so9524507vsc.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 22:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rUOtIFqdd1qkLc8pCB5I2kOGBtjE2ER0HN4jyBgrYCs=;
        b=BHrcr6dEzmkhYvtW+DqNvDkcidO2CQQmrLu0B9kDCd24MeTK+JCivHnQzB4JmCMFfg
         o1CXhM91TGvBp6d4n/yJpyACBNb4As3nw3OVqzQ7ovWFl8kaJjoyw5Hpu8vWiN/x6+jz
         XUctWX+0wtLd7gUOPZBHFpdSwc30zEb4DDgpkNKdWoiskYhHXWzGvbX9N0JZ3Rk0iZNN
         Brsnv4ORyQ2e42glV5sz9nP/lNi1ZD4/tsy4Yavh0FU1p5AXjmc0A9ecxY5jNzttI1GL
         jGpb1mF6TlQQMOKy9rWX6GRwYrck90Rf5+89seLTukWJDiRfR6CSTcVH5DKDF03fJSLT
         f/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rUOtIFqdd1qkLc8pCB5I2kOGBtjE2ER0HN4jyBgrYCs=;
        b=CHKw8/6afJucue9erzASXlOwmQaZJ87UYvTZ9bW3iwLUYwG9uAwpxYYPgQhgyv4Lzd
         35e1rtbUwGEC7ucOvo2kycl+StPQEmaiFHfC31OOiwEUBUgYzFARmfDFqLJMxNxPD0ZD
         RzVeAAWZvtErC648tq2dDI9tY05Rh679JNUd/XDozBsmvUABLat8eylF7UXE7BzwokFP
         rBy+0NH/gnag+vwcUfZeXrD6mOTRMirORFDL2+p/BuUxlFuIEXPwh8fcQeJxGxz1lMnE
         axl06SjwyPZrJUTMsNjfBATiKY1qeKIrbtAkTjbW5O7a9SBdCJi6n+IiYiA0svxq724r
         iOPw==
X-Gm-Message-State: AOAM532v/jlZuld38kOtZrcSKUKidT48udQ6QPgqpLJSLbPxgNtLJw9S
        4W3cKB1KS+QtgEBdKDCIZJ85merokCQ+lygpwE18qQ==
X-Google-Smtp-Source: ABdhPJwUd3AvEds/xLSwwDktPZnrkWi+SEFpzlIARnh+Aa9pkobGpWezZcY5LUjq/sZLczCeB2BM8/muIJXZyx2Os2E=
X-Received: by 2002:a67:ec13:: with SMTP id d19mr10925082vso.28.1597730158586;
 Mon, 17 Aug 2020 22:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200817143819.579311991@linuxfoundation.org>
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 18 Aug 2020 11:25:47 +0530
Message-ID: <CA+G9fYu-_oX6G9m5tLegNdmMXBTRh_jsaxxPad9Jc1YKUF3F5A@mail.gmail.com>
Subject: Re: [PATCH 5.7 000/393] 5.7.16-rc1 review
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

On Mon, 17 Aug 2020 at 21:14, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.7.16 release.
> There are 393 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 19 Aug 2020 14:36:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.7.16-rc1.gz
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

kernel: 5.7.16-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.7.y
git commit: 833b53db2607bc32cd4574e9cf2ddf924310a571
git describe: v5.7.15-394-g833b53db2607
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.7-oe/bui=
ld/v5.7.15-394-g833b53db2607

No regressions (compared to build v5.7.15)

No fixes (compared to build v5.7.15)

Ran 32256 total tests in the following environments and test suites.

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
* ltp-commands-tests
* ltp-containers-tests
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
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* perf
* v4l2-compliance
* ltp-controllers-tests
* ltp-sched-tests
* network-basic-tests
* ltp-cap_bounds-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-fs-tests
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
