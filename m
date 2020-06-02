Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D307C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 081A5206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uGcctUsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgFBRkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 13:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgFBRkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 13:40:06 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A94C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 10:40:05 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id r125so6649774lff.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 10:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dLJrgH5zMtfibk7etWOY3mqShPtnbXCa7eJ2xauqAo4=;
        b=uGcctUsxo7RRq6hbD/gMToHKnzm2mnWci/27rpnEfpCLXB2c6as+ZnwvA6ezEkHlZH
         niJimd8I+cFdKQtjDMmsE0GvVKu92FGpBmmWaWQYpCjqhG1WYTyvqyuFgdo0a8Yw+9ak
         DdO2uPw1V3BwXLqFv2ODlW8YO0d1x9OcJOGMzGE9Ru6merd0hyhhG+zk5U3yK4HmQFI2
         2zmAGhqecz3XIEd+Tla1WuEmiieDYBvbkzePRQkHschE2Sg8flcT18H8y4en3ZGX/Z9R
         sEDVyKdliUC8QswPnT1nJHr1+8aaSyKjZk8vBC6TSZneKIOnL1drhSJ1HCp0D1L1hjI4
         0K5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dLJrgH5zMtfibk7etWOY3mqShPtnbXCa7eJ2xauqAo4=;
        b=beRWqQuJTWQov3N9W2ugKTB44iO38z301G29ap8/nI4KQoas2Eo+3UlqEij3QBEJ1L
         96Y42KG5R9uX4n1arY6+9UqXONjUW0rCmQiNgY6kIUglrl/3M3GMIjpXiO2cQiRMgAex
         H/AoS1VYc/vTwo8XqLUkDMxQFOdenYnVQRFuSq2F5k5rBhLv9RXYaMD6qZwUEQ8fgRKO
         NCVr2dh/2jlVDs98S/lu6CWcwGkMl85HCMMiDWrrqIZctXh3dIUJ+0DaZaotGFmp6fZn
         R1QrDpLB++j5YWQsSKQ7LCagUAsrN0evPp5Hg+3DEZWsK3mZibrHzu3Uhj/x/jYyAi6M
         B6NA==
X-Gm-Message-State: AOAM531xjeXMBwmPknuBsp0fkky54hK2mkzLPIVcvWXkCsporKs0MzGo
        SaPa3P3cJFTHAd0y+PZZVKbjUjTsCAWAQvbjKJDFDA==
X-Google-Smtp-Source: ABdhPJyUua6FvTRJvp9p5S5Md/iOKZBYNsP4v8dYt1Fu6QDoTbqP2bHsYuM1ct2JGqz8P9W5zikoRgMEnh0ww2bbJOo=
X-Received: by 2002:a05:6512:31c5:: with SMTP id j5mr274903lfe.26.1591119604021;
 Tue, 02 Jun 2020 10:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200602101919.871080962@linuxfoundation.org>
In-Reply-To: <20200602101919.871080962@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 2 Jun 2020 23:09:51 +0530
Message-ID: <CA+G9fYtGJZ2Q0jRxW8Z65G4we-tABaVTwyqa3wf+fr0Jdt_vfg@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/139] 5.4.44-rc2 review
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

On Tue, 2 Jun 2020 at 15:54, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.44 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Jun 2020 10:16:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.44-rc2.gz
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

kernel: 5.4.44-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: f5694d7c427e7134b05b816e56fc41c191c4782b
git describe: v5.4.43-140-gf5694d7c427e
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/bui=
ld/v5.4.43-140-gf5694d7c427e

No regressions (compared to build v5.4.43)

No fixes (compared to build v5.4.43)

Ran 25227 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c
- hi6220-hikey
- i386
- juno-r2
- juno-r2-kasan
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
* kselftest/networking
* libgpiod
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* perf
* v4l2-compliance
* kvm-unit-tests
* ltp-commands-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-sched-tests
* network-basic-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-native/drivers
* kselftest-vsyscall-mode-native/filesystems
* kselftest-vsyscall-mode-native/net
* kselftest-vsyscall-mode-native/networking
* kselftest-vsyscall-mode-none
* kselftest-vsyscall-mode-none/drivers
* kselftest-vsyscall-mode-none/filesystems
* kselftest-vsyscall-mode-none/net
* kselftest-vsyscall-mode-none/networking

--=20
Linaro LKFT
https://lkft.linaro.org
