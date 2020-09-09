Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C59CC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E64AD2087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cOMX0UY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgIIIT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgIIITe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:19:34 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EEEC061755
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 01:19:32 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id e14so849834vsa.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 01:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kxsSOAH08Cb/1H/bCrBQPy36KVRAJlGoYW7Z2pWiU/Y=;
        b=cOMX0UY4FYViplh6wKAtEd2R02thFI01xq7M4Hwgzxr6DPjpx42kGVOuNX4FehUxDq
         jtAGZKKTc6CogSuICHLSl5SVGpHJkzvjjT7/R78wtczR//U3KOad5nXbPLZYPd4qgbCI
         6AxM0h99CzEZm/aoWs1a1guDPj1fzCO1LCRnLXGj3P8OFgLfJYndgpu075HF8j/XPbRD
         URtJTARScj6SDwUPxmmK9zlDqJjEbFzV60qjEY38Wub9w2YKtT4SfavjVepnbQsjPM6k
         83pCPUfZpfEz7OxT059ibeEv7jn1z7AZmPjRKol+duvekZVImqc5Z7Dfcc6fIHOHAYw0
         q5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kxsSOAH08Cb/1H/bCrBQPy36KVRAJlGoYW7Z2pWiU/Y=;
        b=tXwX8XvrwPsx3ac+U80ioqES4EWfARYPuvZbPDjZ6IfRkjSFmaGE7QHA9fJfbJtDhm
         Ltz8n6Ait3jesRjaN8Cz7R0yzpUZQjH+aKNpxRTwOP2cqILNZ2G+QB60SZw1jgFE4BIV
         7jpgT8KxAdMkpPeFz8dfpc7tYsa/KPAl/tq2/LjmBCRto/OiOpg1CkLY9rMN5Lc1PrWk
         CehyISOCwaCL45+8roF5Ue2pzHfVFoj8uYQyIv6DAoM5u/z+CFxpYdHVUPRkxkAGv/Ag
         dK5OmvyVVJqpsJexNKxsnP32Cp34cde1SpVQYWeL2r059hi9CPh4KbC+WOcs92KVyp8u
         sj9A==
X-Gm-Message-State: AOAM530E4OsyZhzFQHwjgRTV74owYWXulWI6dd+W1rRge81OodvyaCcl
        Fa4ABIam2VQxHUPPqKz1geGFNeIrlLpLdazroOTY4g==
X-Google-Smtp-Source: ABdhPJzGs/uInKpVTHQiAOSJVnUQ3v1i+kKqOuY/ow1h7pWk17jvJw6jTMYM/5DIOGoGbnIx822Dej3ONmk1xHi0lMk=
X-Received: by 2002:a05:6102:204b:: with SMTP id q11mr1845302vsr.40.1599639571640;
 Wed, 09 Sep 2020 01:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200908152217.022816723@linuxfoundation.org>
In-Reply-To: <20200908152217.022816723@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 9 Sep 2020 13:49:20 +0530
Message-ID: <CA+G9fYt2CNnV+-7jbvwff=0q=UvMp4baCPy61evpXtVT-f-xVw@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/65] 4.14.197-rc1 review
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

On Tue, 8 Sep 2020 at 21:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.197 release.
> There are 65 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Sep 2020 15:21:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.197-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
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

kernel: 4.14.197-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: d520aac0cd79e557dd7d2ae06370d104a9f48645
git describe: v4.14.196-66-gd520aac0cd79
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.196-66-gd520aac0cd79

No regressions (compared to build v4.14.196)

No fixes (compared to build v4.14.196)

Ran 33476 total tests in the following environments and test suites.

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
* kselftest
* kselftest/drivers
* kselftest/filesystems
* kselftest/net
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
* network-basic-tests
* ltp-fs-tests
* ltp-open-posix-tests
* ltp-tracing-tests
* igt-gpu-tools
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
