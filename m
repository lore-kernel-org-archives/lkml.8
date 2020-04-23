Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EE7C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 08:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EF8F208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 08:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DKmzfA7q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgDWIWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 04:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgDWIWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 04:22:17 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E845C03C1AF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 01:22:17 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id g10so4000473lfj.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 01:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ub0q5NPbZDsNxSsJk8eq8RrBvXG68eGB0APkodVuvvE=;
        b=DKmzfA7qdqU9K41fVBxyhWU6c/JnawnEVMmRlUZhlG4ikHVdF0BHhbXndHvyAL7zJ4
         SkjqXy8h9zy6yxopOY60xXirrTf4ls71CQoErQ/uh3DTVlO9c7wPMGP7EjARKbtv1Gxf
         dAgesSwWXDKag7B6ZsHCkWlTsl5hDnnPFTJ1zUBEsxF6/vDsZRJDzYIySCOf+HB+2NFb
         ekMlNwAYDa+uqsBWYIYWZf/Q8KwBixb9AkT5+NN5b6eiYGIlmCVy0N3MTzbTKcH8APGX
         K2yPAObhFV6iHNgFp06XcpU4HuOfZfFdXHk4oopKuNJxE1TWkm6xhN28ux2MIntRqw82
         RQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ub0q5NPbZDsNxSsJk8eq8RrBvXG68eGB0APkodVuvvE=;
        b=Vc9G9zOFybzIPyjO63vLiQaxULW4wBMIr3hH6hoANZWyo05EcNzMpt9gg/L+Fgj7mX
         kI+eVxYkoX3wESJiT9PXbmFX+OUTk+acvXaItJrztFeNKE0P2EwEIY5zcS2IGr8up0t8
         jP7INb1fUsft75WF8LKB4aNn5NgUndmM7bRM1qoAQQorRK4xTlhYUfaugZxb32pQ9z7W
         3O7zZ/RZL/qsI7ulXZmmnATQGcdxW5Ajz5qwbBH5GEqDcnkCgZ3+/4VRl27PaiZaPyx0
         Eg1NZHxc2/BMotXZRsGS1zBzmaxTQnx7hwjRS5FwUoTa8upAACo9/bribTQv1n7OtH2W
         cf4A==
X-Gm-Message-State: AGi0PuZ958YZTc4fEOXxfIp2knfs7oXzODmXmQwyGu1tmm/s1No1IFau
        j1/bn6xYRnHQ1Iq5XT/hjfH0vhox+3Aq1F+a6NGrSA==
X-Google-Smtp-Source: APiQypJChGVvNGQ9siEQewL+Ngm3zRQEKXs3Y+1CmUn+i1Yqc2rYikuFbZxWNRoKm6d0qWUjC4+nqvo1ycGzzXmc5XI=
X-Received: by 2002:a19:c602:: with SMTP id w2mr1577889lff.74.1587630135322;
 Thu, 23 Apr 2020 01:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200422095008.799686511@linuxfoundation.org>
In-Reply-To: <20200422095008.799686511@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 23 Apr 2020 13:52:03 +0530
Message-ID: <CA+G9fYspEmKLZJs9ZFhUsGvd1kq2pbk=i_xxnptnvkmDmqN8mA@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/64] 4.19.118-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Apr 2020 at 15:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.118 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 24 Apr 2020 09:48:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.118-rc1.gz
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

Note:
The platform specific issue on qualcomm dragonboard 410c has been reported.
Which started happening from 4.19.115-rc1.
https://lore.kernel.org/stable/OSAPR01MB36677B25C6FE12897832B3DD92D20@OSAPR=
01MB3667.jpnprd01.prod.outlook.com/T/#u

Summary
------------------------------------------------------------------------

kernel: 4.19.118-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: b5f03cd61ab67da20381e80c220d6727b914c3bb
git describe: v4.19.117-65-gb5f03cd61ab6
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.117-65-gb5f03cd61ab6

No regressions (compared to build v4.19.117)

No fixes (compared to build v4.19.117)

Ran 33561 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- juno-r2-compat
- juno-r2-kasan
- nxp-ls2088
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
* install-android-platform-tools-r2800
* kselftest
* kselftest/drivers
* kselftest/filesystems
* kselftest/net
* kselftest/networking
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-io-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* v4l2-compliance
* kvm-unit-tests
* libhugetlbfs
* ltp-commands-tests
* ltp-fs-tests
* ltp-hugetlb-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-sched-tests
* ltp-cve-tests
* ltp-open-posix-tests
* network-basic-tests
* perf
* spectre-meltdown-checker-test
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


--
Linaro LKFT
https://lkft.linaro.org
