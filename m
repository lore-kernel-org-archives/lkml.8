Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E6FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B41620760
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v5ZHKcf3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgFJGdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 02:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgFJGdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 02:33:20 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F63EC03E96F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 23:33:20 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id r125so743222lff.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 23:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GvcRelPUF0lTHYubn6Hl/Od9vnBQZjZOkRv0X7ureLw=;
        b=v5ZHKcf3yGgVJJaHEmNF1IVYkneKKDDD2EX276YzYSJFf3YV9Ds68NTXM5cvZwDJya
         KbJeJ2GAXSL4hGPgRwFEOtM1VeloRs4dVj+rdDeAJUj+ccm4K37w5HzlEenQyDT4SJDV
         w94N5g0uaBtnNL9frizJTr0jptN3tvn8Lvz10CqU9wkjSAJIp2n+nzoc+nlkDItPZFNw
         jSqOIKtg/cYKjVGEKIhiYQeT/3xsoIvKpHId/moKbf6mL0LCt9LHHoNluTrCr2IUbPFa
         +ecVjaZp9TQiosYc5t1xapGZTD5rWq1PL662Ud1ZSQlSMe4GNjhniN9wrATcYL06usxX
         0iZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GvcRelPUF0lTHYubn6Hl/Od9vnBQZjZOkRv0X7ureLw=;
        b=E07xrUcVIxCzH8awBF8yg6vAO1p8a/PCU+eo4zFyOx7jmEOl/ec6GEM9xmgQP62a3r
         mp9cDCaTlccwFk/8RQ0/6IySH5Bmvh6dDEGkJV2eUKLVB6ggb5RfUjfIwrqxLLmLxHnL
         rcZcEJ3TpxkEmHuTC5/F/YoKAg/8WLNFjYTyXv5JC/crjJlayZ9TpJI0MLmosgLbFeqa
         vB6jMXp/wCFAQ3ftdRFEldE8DkobgLDljJ+YZed8abAf9TexWJjpk10DzUdvFnWwGl4Y
         WSDOhf/pZyd5yUXNaNNSX4ZDcBksQivFE9Y3TnYm4/ts4sywADwt9vusRtjGm2VWFbDZ
         Pjuw==
X-Gm-Message-State: AOAM533LSktVSunw7BwbyN0HAsaisDPF6J43FtIPEmoy68HsREAaia1u
        kxLxoHj/gMziAiQDS7Ylky4kpBOscewheW6QRO3loQ==
X-Google-Smtp-Source: ABdhPJw5lHs/NlF82J8x+nsPfSqtSd68tHK4MteAHzUqRA9s5H0zz7lCfDPIz33C6DHUMxg48LnuGctb5BDHoZam+Dw=
X-Received: by 2002:a19:c751:: with SMTP id x78mr853846lff.82.1591770798439;
 Tue, 09 Jun 2020 23:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200609174112.129412236@linuxfoundation.org>
In-Reply-To: <20200609174112.129412236@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 10 Jun 2020 12:02:57 +0530
Message-ID: <CA+G9fYt1cO0XtNNEDrVMD8jqPRLkvsF4uieA5C+RCJnm58U-Uw@mail.gmail.com>
Subject: Re: [PATCH 5.6 00/41] 5.6.18-rc1 review
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

On Tue, 9 Jun 2020 at 23:25, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.6.18 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 11 Jun 2020 17:40:51 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.6.18-rc1.gz
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

kernel: 5.6.18-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.6.y
git commit: 1bece508f6a987257cff511f9ba8b67da8734954
git describe: v5.6.17-42-g1bece508f6a9
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.6-oe/bui=
ld/v5.6.17-42-g1bece508f6a9

No regressions (compared to build v5.6.16-44-g6266fb28693f)

No fixes (compared to build v5.6.16-44-g6266fb28693f)

Ran 29892 total tests in the following environments and test suites.

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
* libgpiod
* libhugetlbfs
* linux-log-parser
* ltp-commands-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-math-tests
* ltp-mm-tests
* perf
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-sched-tests
* ltp-controllers-tests
* ltp-cve-tests
* ltp-ipc-tests
* ltp-nptl-tests
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* v4l2-compliance
* kvm-unit-tests
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
