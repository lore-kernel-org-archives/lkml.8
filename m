Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F8CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 05:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D0FA2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 05:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gL/syhdA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgHYFwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 01:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHYFw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 01:52:28 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E937DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 22:52:27 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id x142so2553427vke.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 22:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M7XsooAFuHGHi3D3V0DX30y9bL0P0cmujAiQdt5pyvk=;
        b=gL/syhdAGBBcGdIdbtXPT1t60LAH98hYc36gXrkjtycE/sDFAmczB9X0gWxvo517R1
         sz0MN2T1y2dSGtS3fuwu7plCdEwko7Ob3bYzFzIXTtOtk+o0HGZRqOAWsUS9BXze5qgJ
         qQnUXylr/jEGboVLqrS/+YH2Wzkpf9DqWp+D1+W8qnvBe1tgHDqEolim3uTHbi7LNLaZ
         uBig9RtB9UFxPMP9EKqkPFlUDP01FTcj3ru8hZy+eH5oolaP44elR+3q4WuS+9iroM8s
         EwxwKHl/kyYM/55LA1b2r+/BGv3pEIPYfM7A0oCxY5EXm7dGw2lr/kEXkXSPugA4C1QV
         3+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M7XsooAFuHGHi3D3V0DX30y9bL0P0cmujAiQdt5pyvk=;
        b=Yq5VBDOgtMwjLtSK5lc6La1YBwjqHmEgQPPzdeI5Sohqd9wxEighup34wGwNFa5vAX
         8i9CjBDWNHAj7c/7LNuAty428ZOKNZdEvk7J9UQmCu8UvT13cuGNnM/miqidL+zt8MXU
         CuDgBIJxDddFI29JYEYiqXdnUi6sI72IOplegFmI8kmfQxOYzbiMV+U6epdSDEYX4dBq
         Snnpwc+qSm7l7oqu+zGUJcuGKS8YqQQREgDIN6eZnmKd1eNh2QnXHQN1jfVoq6wOMn8R
         4iVPGHehzgYsDsA2QqwXXQpmow3n2rDTaojc3zdmmyWk8HI8pHseMF+FyjHzqxJr0TgG
         0ZIg==
X-Gm-Message-State: AOAM5303JP+JOa9kwq25zpBVnrhglkHDx+CkoDMEyBhliutmNSg2gJn8
        HMkRsptubbXWgwJzEedPL4HLxltLz0RwOu1lMbQtUA==
X-Google-Smtp-Source: ABdhPJyQ208O7MAlUBfz9+NVG8ImFQwisVQrPUl0rUjQUurqJzeS/28Syl8UyLGYyB5/ubAXEePM3Uv/VQXWn+ndhzI=
X-Received: by 2002:a1f:2fc1:: with SMTP id v184mr4748425vkv.42.1598334746920;
 Mon, 24 Aug 2020 22:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200824164737.830839404@linuxfoundation.org>
In-Reply-To: <20200824164737.830839404@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 25 Aug 2020 11:22:14 +0530
Message-ID: <CA+G9fYuodyaEJdGG75fQCrp9+WDZaj8W-V6uSgOaJLfGxQDJ7w@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/109] 5.4.61-rc2 review
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

On Mon, 24 Aug 2020 at 22:19, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.61 release.
> There are 109 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 26 Aug 2020 16:47:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.61-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.4.61-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: d3dbec480949413c968365e6f8c25b1e7847e4dd
git describe: v5.4.60-110-gd3dbec480949
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/bui=
ld/v5.4.60-110-gd3dbec480949

No regressions (compared to build v5.4.60)

No fixes (compared to build v5.4.60)


Ran 36416 total tests in the following environments and test suites.

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
* ltp-containers-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fs-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-mm-tests
* ltp-syscalls-tests
* perf
* v4l2-compliance
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* network-basic-tests
* ltp-controllers-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-open-posix-tests
* ltp-tracing-tests
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
