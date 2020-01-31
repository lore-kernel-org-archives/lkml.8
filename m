Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB0BC35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 14:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3382067C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 14:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kn2qo6N7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgAaOkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 09:40:55 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:32915 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbgAaOkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 09:40:55 -0500
Received: by mail-lj1-f196.google.com with SMTP id y6so7371100lji.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 06:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E78cpWVR+JWbKfqWlblxjUUd03oruo9y7UPdP05nLRs=;
        b=kn2qo6N7ctCVqTCAQY66vsASQSL/irE4cutJss93fzuT9ekzHWe5UeEw6NRf1eS+Ms
         64/O/YbhHtDoSE9XooZFkJ0MP5kK6CW4iGSSDOtuS+wm3M69W+xp2Mth0oWhIQN0tm1j
         hkTofUTy/10rz4vJQ/OUfHUVbUSNtNlPupgXBV7ho4jferV/1WNkmIs2rP6G24paaLcf
         XLnzmbBUtsjVZa68PoRHEJzuMx2X1rr2LEHweAnFdgSq9ar8vkomLZ1pcnO7Fnjnjijg
         2rKZw9KALsDqAtToa5OYG9L9FrkA19vMDaiDILiTFy3ihvS9vyd2fY2UxVwqjAQtdrCI
         px6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E78cpWVR+JWbKfqWlblxjUUd03oruo9y7UPdP05nLRs=;
        b=GJlg+2ywY5G4XNgebdWudyA1EZkxzNIQ8FgCGTH6XoR743xyQHSxaq5ord7OOStkA1
         7yOC/elUr6R3AM57aKOxr6XgGk9MVI+u8L6PEBNNAJPUF9dZK7nxyAWVdIMU6YrZc+SB
         coxif2xR5kuDWdQJ46H4UFd7wO37A9c01XWXSipewisUTScU+TdfY2t9Ik5Un83y5VDI
         53wJBvPndHrw/rHmhBb04+2IrT+DLgpEcOPICZpOtxx6CWFj9xbFTHSwZXSwJ5lKnfBd
         1ZIt1rWTBwKpGn5MXCo56N41kXt/PKhEzRZDbn+/KUes1dtXEDUfGZI5JAFAVU4U9fir
         5jDQ==
X-Gm-Message-State: APjAAAXcwCJ/s9OZQSrXRZ/AeL1nHhE6Ae3kHz1IpeHQ22TaQlIIRq7M
        oDOm41ZuQi/8aOHlYpkexTU/OnUUYlKH1WBRdpV3qcCvxaY=
X-Google-Smtp-Source: APXvYqyt8xD32Q4xfIlEwpD6XZvGxzOSoe85kMZ36zxqgAAj0mOF9xPbf6riUU/wYcWJkLhaqGkY/SBM58C+Kp1YLJY=
X-Received: by 2002:a2e:e12:: with SMTP id 18mr6210420ljo.123.1580481652596;
 Fri, 31 Jan 2020 06:40:52 -0800 (PST)
MIME-Version: 1.0
References: <20200130183608.563083888@linuxfoundation.org>
In-Reply-To: <20200130183608.563083888@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 31 Jan 2020 20:10:41 +0530
Message-ID: <CA+G9fYuqVN5F3Awa39SzTNGLWWA8Jdagmx-sg15NRvW5y_0g_A@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/55] 4.19.101-stable review
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

On Fri, 31 Jan 2020 at 00:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.101 release.
> There are 55 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 01 Feb 2020 18:35:06 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.101-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.101-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 985d20b62b7cab0f7e2cf0e9253560f494e1a572
git describe: v4.19.100-56-g985d20b62b7c
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.100-56-g985d20b62b7c

No regressions (compared to build v4.19.100)

No fixes (compared to build v4.19.100)

Ran 24206 total tests in the following environments and test suites.

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

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* kselftest
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-ipc-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* spectre-meltdown-checker-test
* v4l2-compliance
* libhugetlbfs
* ltp-commands-tests
* ltp-dio-tests
* ltp-fs-tests
* ltp-io-tests
* ltp-math-tests
* network-basic-tests
* perf
* ltp-open-posix-tests
* kvm-unit-tests
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
