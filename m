Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5860C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 05:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B306720738
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 05:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IG0mHLZ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgHRFIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 01:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgHRFId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 01:08:33 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FBEC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 22:08:32 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id r197so4034831vkf.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 22:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sZJ3/gyYdiik+KpeaHCJ05p1bjMwQXfEEDjU78/km6Y=;
        b=IG0mHLZ9iuVrpBMaPoS9puVxVwEj+Y9VBMJsjBNq9rtwmIG6T8lW/Natd2y5Z3NqZH
         twjG7wnwFT8I4RE4cs75TmIUwKFx4KBInMrlnlYWWokWiypHTgH/UMaO8dTmmhh62w/9
         YFE7babolaSKLIZ2r9hKRUkpf6g7Z+LKOo4fRiM/Hsef4ER+Ud/5z4llC9iKLwYpuv2F
         r905GlEiEgfIh0jWJ/nVmuwksUdMsLgpCU8PzuxXc3MAlTurqWeFHl9gxzKIpue24tDI
         qSQ6fMA9haVeWgi/+xv2+77JAvbsRjT3NdKLU3DoIm6nSmCo6wmbOKoftmCVxHKCnc0f
         /uOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sZJ3/gyYdiik+KpeaHCJ05p1bjMwQXfEEDjU78/km6Y=;
        b=UpUphsNp9PwHS8g8ZIfLGwbpLFAA6Fiym0QbtPiOjnehalY5pPV41qmknMv5sIALkN
         ZkzdM4ovz8RA2HUQdAiY2pp4IOOtA1Gld/ubM+2BJW4ZDYACvEb3gdPdiartrd82KNLv
         MK/j0m++IUqXQlpFfR8K3VBoB6Ivxn3VU4TPysHDX1CZoRi4bR66FsENUvKF7wr+Ymoz
         eLm57ORCvj586SPpQySNtQKWBf68J4FDv1syXY0LSTNnuQGinx2Sygxme/q2se5QyJ8N
         EesdmnuE/R+U8AtLFVVppcwzIG8Gcjh9L/C+jXtEtilKu9dL9UN/PzWmT/Yv4B4rUv7p
         cKSw==
X-Gm-Message-State: AOAM531KAxgkufT+BDAgNSF5xO/Jrk5tOWZmER6itBRUuk98u3BgN43v
        +tJ3GtoFJwtSnbsxIu0kk94bh0Ti208mGHS2cn/d5eHxckx7NxpT
X-Google-Smtp-Source: ABdhPJxLmM8l840nc97KipawJ7NbABrAaKbOIIoUZLgHCrDls9rk7kXMXMG52gfPbwQrLW98LC18nkD23FMHXaU74F0=
X-Received: by 2002:a1f:2fc1:: with SMTP id v184mr10187699vkv.42.1597727311418;
 Mon, 17 Aug 2020 22:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200817143833.737102804@linuxfoundation.org>
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 18 Aug 2020 10:38:20 +0530
Message-ID: <CA+G9fYtidMe-oYY7ZZi-cYMz1HYxdsLAX-6oJHerfr1SD6taXw@mail.gmail.com>
Subject: Re: [PATCH 5.8 000/464] 5.8.2-rc1 review
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

On Mon, 17 Aug 2020 at 20:49, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.8.2 release.
> There are 464 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 19 Aug 2020 14:36:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.8.2-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.8.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.8.2-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.8.y
git commit: d74026bb5bef5450a546db519c5dc961c8fae71c
git describe: v5.8.1-465-gd74026bb5bef
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.8-oe/bui=
ld/v5.8.1-465-gd74026bb5bef

No regressions (compared to build v5.8.1)

No fixes (compared to build v5.8.1)

Ran 34528 total tests in the following environments and test suites.

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
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
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
* ltp-cve-tests
* ltp-sched-tests
* network-basic-tests
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
