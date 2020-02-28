Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4BAC3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0244B246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jvu1aH2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbgB1DmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 22:42:17 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41469 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730808AbgB1DmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 22:42:17 -0500
Received: by mail-lj1-f194.google.com with SMTP id u26so1547885ljd.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 19:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OISlAJW0jW4Lr02hVAHwd3xI+26eeGujzVymjaVvLFo=;
        b=Jvu1aH2oI8SupbOnIF8eEdCrg8+yDIZzPMCsLYGt6oXoZ8A4SqHYUfo3T+xAYcER1G
         WsxnsgwB9IT6B5jscsEEIS4K68diJMZldLx6jzCw5lIB1lIOrZPLNbyrUOrJmqRHQOAG
         yfKu11PFlPJkEhHFj72BKiuto/Iwf5eG9j7FMDdmoHRRuBJbL+UYD7ODkHRGpSgBHINX
         NNJZHCDyEnB4e0Osu7EikeK3s4uZR1UO5/hGCxyjgG0jBDIScjge+ANl7pRwnrI+EpIp
         vpES+N/XJQwP+V7YGzJ/FbVjoR4+LuzcoTEcASL8QPHDlTLe/g+Cl89fW7N8lvvCf/e6
         FfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OISlAJW0jW4Lr02hVAHwd3xI+26eeGujzVymjaVvLFo=;
        b=omif5Vu9PrMX5PLAqHffIgGBv/U2Z9UeCA6Z6ats87a6jHYK4/RFIj/Q0elU/+wsmn
         D57qdmD0QF1r0wS8trGuZdX5ei+f0uqJk/G4WTxysIlvli1aq8psdx0zBS7tS8Tt72Ab
         wHC3xJHC0AcbuXEV2yNS8bqrvZM/hjsaWQzb9ev1ZSd/8XXLQDxkkDdJDgVEUeGdvAhO
         zyawKu0Vy1/ZexxWipsJ1rZVY1f/8InEt7WRwK9tJBEh7xtFo/pwrXWmtcS2yC6Gk//F
         MBVIdrCrxzzkVHEqluTo/4LzV4AYF0/1t0mxTNTdsbRM04TAyHbQ93TYgY3+Pevx2QNE
         tj4g==
X-Gm-Message-State: ANhLgQ0g2Dc/1joh4C0SEam1Hzr8EOoXxzUoDjd89ZN4iCHFtxe4WYfu
        A461+Fqd31QgxWsBCy3+9FFfg6TazJnNwgBg4KWUn+CWBtY=
X-Google-Smtp-Source: ADFU+vucxwhaPH76rUyPKXAsDyqVUopg+9bwaXDlad423WZ/SxZoGZ4coFtv0ApSmIlIEgumHKBep3xwrGMzyP7nIk8=
X-Received: by 2002:a2e:8e70:: with SMTP id t16mr1449440ljk.73.1582861333620;
 Thu, 27 Feb 2020 19:42:13 -0800 (PST)
MIME-Version: 1.0
References: <20200227132228.710492098@linuxfoundation.org>
In-Reply-To: <20200227132228.710492098@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 28 Feb 2020 09:12:02 +0530
Message-ID: <CA+G9fYvk-f4za46SD3z2359G=XyT-NKHb=oA7uXRe3=u=9dm0w@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/135] 5.4.23-stable review
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

On Thu, 27 Feb 2020 at 19:54, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.23 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 29 Feb 2020 13:21:24 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.23-rc1.gz
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

kernel: 5.4.23-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: 8550aa6c78553db799becfc53c7e7890602862d6
git describe: v5.4.22-136-g8550aa6c7855
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/bui=
ld/v5.4.22-136-g8550aa6c7855

No regressions (compared to build v5.4.22)

No fixes (compared to build v5.4.22)

Ran 30904 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c
- hi6220-hikey
- i386
- juno-r2
- nxp-ls2088
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15
- x86

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* kselftest
* libgpiod
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
* ltp-fs-tests
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
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
* ltp-crypto-tests
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
* ltp-io-64k-page_size-tests
* ltp-io-kasan-tests
* ltp-ipc-64k-page_size-tests
* ltp-ipc-kasan-tests
* ltp-math-64k-page_size-tests
* ltp-math-kasan-tests
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
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
