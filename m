Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FA5C3F2D0
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 06:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD3B2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 06:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KQju49SH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgCKGwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 02:52:24 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42113 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgCKGwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 02:52:23 -0400
Received: by mail-lj1-f193.google.com with SMTP id q19so1010075ljp.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 23:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WT3pnklfoBS4yOV61C7/geEwosTMYRVTTR0l9jBg4aQ=;
        b=KQju49SHrxKbho6aylMsDKB6h0uom2QLjdm2U97IOCDc1OpQWcF22qgtcRGAyx6SMt
         gvrFvtDReuxH0JiuHo/VXjsajJTMuHB1/DEWPZi6nn8E2agxeYteo3Fiw3lTA2IYlZIo
         Nao0Dy4vJ3sErh4ksCVUe7ICmvVaSg8x4dgimrfMb2TP+/9yznu0zy2u+JIILrrWitez
         yul+HIEX6Wv8MpcxY+2dXGkKLWFGaBnWLKNo9MaLd6HRLx1WFWpep+EbpfbPhIyvkjHe
         GukSpmdviSYnrMnecZ4mzd4HQawLwqzzWwfw3kQ73A28BJnxvG7uNThjTszCThqgMcmy
         CN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WT3pnklfoBS4yOV61C7/geEwosTMYRVTTR0l9jBg4aQ=;
        b=btSzBMKrbcj/0jq/VAEECx9vkDDdkUep5+MWSbHjA0aibd07tArS4yY9rDzr9trszX
         pVSE84idUH4hfVL5O15569KlQwqaJguCgLE1atyhekQXAPK+Ud16vMlaiZr48rSs9PuS
         gJCc0z7nI4+3TD9YmZPicQCK2hu+ERxIgYoxJg9yjVsNZftTVCgG1PmY1u6/poZXgcYo
         XdcwIYOheGz3qacZxhI/C13FU29mNUd/68lKf8Lgl1nfJ/kmDTzo1XDxqn9eOrydl7VT
         bbXbRhvUk/ZPBo2l/L+9XPgnHtZ6j4napu9pusUhZDk9E7M0upvxqEgT+yDxgX38oVLH
         PWGw==
X-Gm-Message-State: ANhLgQ0HqIalr62xuUm+Cy5ET4y3lSbTvFdqGwthicqVw3eVWEMX8XGk
        4gzZTxEcDD8ZNsscZBoqstum7mO1aqnO7doe2MLW3A==
X-Google-Smtp-Source: ADFU+vuaq7Lwhh2W/BfOdQaSVOdOKtGbVemG/asA8TotKM/YFeCbk/4yr1rnMHVWT59x1G/YYiGD9A0SdpW+ZqnnTzU=
X-Received: by 2002:a2e:9008:: with SMTP id h8mr1172324ljg.217.1583909540891;
 Tue, 10 Mar 2020 23:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200310124530.808338541@linuxfoundation.org>
In-Reply-To: <20200310124530.808338541@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 11 Mar 2020 12:22:08 +0530
Message-ID: <CA+G9fYsZqjUV52Dm1Wtga1PbBARc0GkCF=aYw2UEfAKXkLiTPQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/86] 4.19.109-stable review
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

On Tue, 10 Mar 2020 at 18:42, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.109 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 12 Mar 2020 12:45:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.109-rc1.gz
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

kernel: 4.19.109-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 624c124960e89afb43869bce83b067d94cf661ca
git describe: v4.19.108-87-g624c124960e8
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.108-87-g624c124960e8

No regressions (compared to build v4.19.108)

No fixes (compared to build v4.19.108)

Ran 27602 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- nxp-ls2088
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
* install-android-platform-tools-r2800
* kselftest
* libhugetlbfs
* linux-log-parser
* ltp-commands-tests
* ltp-containers-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-syscalls-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-cap_bounds-tests
* ltp-cpuhotplug-tests
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
* ltp-sched-tests
* ltp-securebits-tests
* network-basic-tests
* kvm-unit-tests
* ltp-crypto-tests
* ltp-cap_bounds-64k-page_size-tests
* ltp-cap_bounds-kasan-tests
* ltp-commands-64k-page_size-tests
* ltp-commands-kasan-tests
* ltp-containers-64k-page_size-tests
* ltp-containers-kasan-tests
* ltp-cpuhotplug-64k-page_size-tests
* ltp-cpuhotplug-kasan-tests
* ltp-crypto-64k-page_size-tests
* ltp-crypto-kasan-tests
* ltp-cve-64k-page_size-tests
* ltp-cve-kasan-tests
* ltp-dio-64k-page_size-tests
* ltp-dio-kasan-tests
* ltp-fcntl-locktests-64k-page_size-tests
* ltp-fcntl-locktests-kasan-tests
* ltp-filecaps-64k-page_size-tests
* ltp-filecaps-kasan-tests
* ltp-fs-64k-page_size-tests
* ltp-fs-kasan-tests
* ltp-fs_bind-64k-page_size-tests
* ltp-fs_bind-kasan-tests
* ltp-fs_perms_simple-64k-page_size-tests
* ltp-fs_perms_simple-kasan-tests
* ltp-fsx-64k-page_size-tests
* ltp-fsx-kasan-tests
* ltp-hugetlb-64k-page_size-tests
* ltp-hugetlb-kasan-tests
* ltp-io-64k-page_size-tests
* ltp-io-kasan-tests
* ltp-ipc-64k-page_size-tests
* ltp-ipc-kasan-tests
* ltp-math-64k-page_size-tests
* ltp-math-kasan-tests
* ltp-mm-64k-page_size-tests
* ltp-mm-kasan-tests
* ltp-nptl-64k-page_size-tests
* ltp-nptl-kasan-tests
* ltp-pty-64k-page_size-tests
* ltp-pty-kasan-tests
* ltp-sched-64k-page_size-tests
* ltp-sched-kasan-tests
* ltp-securebits-64k-page_size-tests
* ltp-securebits-kasan-tests
* ltp-syscalls-64k-page_size-tests
* ltp-syscalls-compat-tests
* ltp-syscalls-kasan-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
