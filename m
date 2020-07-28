Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A737C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6876220714
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gh+RNdjJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbgG1MoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729379AbgG1MoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:44:03 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4902EC0619D2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 05:44:03 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id 4so1754341uav.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 05:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lamag6Aa8xzEi9MNZwHnYxjBf9+2A6cpklCTrsDoh4A=;
        b=Gh+RNdjJTAk6ipjYlV7bdCb0w+2JUMWgSRCx5z5IcDAjithhxopl7Z92M6ic/T1YzF
         CFRypxrbYTuYAO756tYXsKbuPUPT4VSgS6YJSPF6XlC3D3R6xEeJkWroI3DfzZYRM1LL
         vmO6CnSsssfs+K+zaog/rGp7NTttzSG8kgnYnz7LF5WJGq65zgk1HddQqsK4uVv604h8
         A0aB6ggLpK3J8cvqPUr+9jgC8ed9isGdtLNr5+SyVYt9zXKFyehHsIE+bmu3wSE76/j5
         ayEapCBEVj0u7dGIWP/pvewiOUuAbSdxbKkJpds8lwRPNOFwrhgmg2zkPdDAcFV/BRek
         yFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lamag6Aa8xzEi9MNZwHnYxjBf9+2A6cpklCTrsDoh4A=;
        b=F35EMYZNe2fB+udA5EPaup4RdnMVIr3ToAxcauxu7kHY5o3aQwBaGqg3ep5fm3F+aL
         M88p6SpuPLJjoI0qsVe/b3NLi57qzByVwpMY9CW30/CY9AZSY7hJ3YdI0dyQO8D8qFqX
         RCAAS+oTJao3tysVdJvpqNzzZjrWZm0vp8mH1XKeTBXNtoYMvKGaXHAEsLOIJq5giq0D
         VGkIV+ULvn15Ymwm/J/yV1q4RcTXBaW2FNIhKjKuY1rdi09JDIPYxO4KSR208jB5xSc5
         HZaULw0L4hIIJMHGomZLJsOY5Nz2Obe88q6OmJ6AWjXIlHY5WM7kzCsdJBKETI+U5nlq
         ME3Q==
X-Gm-Message-State: AOAM531JGNmZcgzuVIYnylQWzFRzkhZS89CCo9EqQbs8YizIF0AUvoBy
        ROt/9iBVRY29p4TzPe2c6emLmsnGH+Lb785c7naAfw==
X-Google-Smtp-Source: ABdhPJz8eUEacBI5xGPA1ODM83K3paHnnu+pjfbLJLVF+MbS+nbHVLCtgJw9MrHvNcK5mlOlZKsZHsEPMhLmkB6dTmg=
X-Received: by 2002:ab0:5963:: with SMTP id o32mr19678822uad.142.1595940242118;
 Tue, 28 Jul 2020 05:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200727134911.020675249@linuxfoundation.org>
In-Reply-To: <20200727134911.020675249@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 28 Jul 2020 18:13:50 +0530
Message-ID: <CA+G9fYs+EJiUDP-nibgM4A+nS5EauvVNuPVafM_iAFPfPD3a3A@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/64] 4.14.190-rc1 review
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

On Mon, 27 Jul 2020 at 19:37, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.190 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 29 Jul 2020 13:48:51 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.190-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
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

kernel: 4.14.190-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: f238f865e7549f70e465fb28f92c863900e76455
git describe: v4.14.189-65-gf238f865e754
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.189-65-gf238f865e754

No regressions (compared to build v4.14.189)

No fixes (compared to build v4.14.189)

Ran 31258 total tests in the following environments and test suites.

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
* igt-gpu-tools
* install-android-platform-tools-r2600
* install-android-platform-tools-r2800
* kselftest
* kselftest/drivers
* kselftest/filesystems
* kselftest/net
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-dio-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-mm-tests
* perf
* v4l2-compliance
* kvm-unit-tests
* ltp-commands-tests
* ltp-controllers-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
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
