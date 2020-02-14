Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319BBC3B196
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 10:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080E424649
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 10:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BdDt59YU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387482AbgBNKhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 05:37:54 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34724 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387397AbgBNKhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 05:37:54 -0500
Received: by mail-lf1-f65.google.com with SMTP id l18so6464183lfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 02:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NTyOKnEcj2vaJvaU3stmgI+FJATDFCR+gafHxlW5xPM=;
        b=BdDt59YUPhGpoAuMX4F2OFg5/SNuEzQ0tHW5hsRZDURHVFEC52r+/8fJdxxhZ7v3SY
         lieNV7pMQyrr6Vpo6B4BaNZQHRgz9OBwif0b48n2tWEZ+bVE5Khngs6mqUaGZC04AVB+
         i8IOIQpdLSAvFEQe4UcIcfuQ4xnRgEsLGOLoNH70G6A6LW4BMswvhTBYsC0mMBV0EoJJ
         qXUNs0VgaFhhuXONLG3LCjPFsjYnoEZo3633YQetuI1JkwwJ/5a00h4kNzjABGRy9cgr
         BPMhDb5Z33MusATB3IKu7+0m/EpBd1dIzWDoFaXKuKKdwimMZ0hInecoTnkGHhn2cIp+
         xvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NTyOKnEcj2vaJvaU3stmgI+FJATDFCR+gafHxlW5xPM=;
        b=dhBueTieaUW2EQW25beL9O+QmtW/EQlOIiZdm588zFub+oJxXSaOZSgck5pNd6aREM
         KRk6mTZtx9+7OUdfjw4gcKx7mvn7B7bVKM2Be12isT7Z/QBYMavLZYqFbkg47vYxmaZv
         6jf1XaKRLpcDSLnfaoNOA9ENYetGaN78BQ7RO19MwTB3Hh79V/o94MZm+nTeM3iOp5dd
         T+ZcoX+JiD2Sjrwg0tDizREhcg1H0aSErUaDc+wM48FZapgOp/WzjQL2hSBJoxVP51/D
         0RLk/0F8KYvg3kK+uvfjGGXxYN2Xa6xi/botzBbIViFEAJGKQCRKLBsfsyxpJUHp0R7v
         hOpA==
X-Gm-Message-State: APjAAAVnLEe6AhIVmeLQUaxCu4yOsbBLthdD+1CrPLFn3AoNqZ870mv4
        Pim3MBBIqCQarNuT8lhGxGuTUfzJ9MU/Tep+AuOWSg==
X-Google-Smtp-Source: APXvYqxzQuvEtuDOtW1eT/Am7lCV1by3pScxcSBXjrhC35rlMb/+JfZ5zLh/4N89oJPjvyZCbSOQFBN7LGXKatxm8nQ=
X-Received: by 2002:a19:6d13:: with SMTP id i19mr1338992lfc.6.1581676671809;
 Fri, 14 Feb 2020 02:37:51 -0800 (PST)
MIME-Version: 1.0
References: <20200213151821.384445454@linuxfoundation.org>
In-Reply-To: <20200213151821.384445454@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 14 Feb 2020 16:07:40 +0530
Message-ID: <CA+G9fYthgNEw_ayne_vEM9VUsrBNxWKj2LFACfCQYd9-939=2A@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/91] 4.4.214-stable review
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

On Thu, 13 Feb 2020 at 20:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.214 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 15 Feb 2020 15:16:40 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.214-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.4.214-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: a4539ca32651f32bc7c45d0f09be1fb9fca3ec71
git describe: v4.4.213-92-ga4539ca32651
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.213-92-ga4539ca32651


No regressions (compared to build v4.4.213)


No fixes (compared to build v4.4.213)

Ran 19878 total tests in the following environments and test suites.

Environments
--------------
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
* kselftest
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
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
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* perf
* prep-tmp-disk
* spectre-meltdown-checker-test
* kvm-unit-tests
* v4l2-compliance
* install-android-platform-tools-r2600
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

Summary
------------------------------------------------------------------------

kernel: 4.4.214-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.214-rc1-hikey-20200213-647
git commit: 6ace76afa8ec0a1c445e766c7e1b86b8b551a94f
git describe: 4.4.214-rc1-hikey-20200213-647
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.214-rc1-hikey-20200213-647


No regressions (compared to build 4.4.214-rc1-hikey-20200213-646)


No fixes (compared to build 4.4.214-rc1-hikey-20200213-646)

Ran 1576 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* kselftest
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
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
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance

--=20
Linaro LKFT
https://lkft.linaro.org
