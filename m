Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B9AC55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEC272077D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vysh96oz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgDWL2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 07:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727903AbgDWL2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 07:28:18 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D63CC035494
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 04:28:18 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id m2so4448722lfo.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 04:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4RXkqyEdVnf06F7mDWuAUymH6Dg037/S6JjirDYzTK8=;
        b=vysh96ozdvaPVfnRDhYy3fR7gUOBbe22xiJukVacT//kwYlmsx4nG6Kj4BhC/f50ey
         brZKRgW+ZSSs63D5dLRLtukvNIXOwENaTAB1lDOs9la3PZSKwQ9ovr2lhkqSYGggvn0A
         yKSK8yRiKqezPEW91qhTTgx2wOfuJWTr4ebYxZyZoCnq0WSxTzTdWONpalkuM3Gfo8Ro
         2THOQNTm2DHMC58NEj50gIhnzI4uHksRWoLH3o3K7UhgaD5w97U5H2VUF7hqwrVTbo4P
         odA66eZciq43PJ+4/hTHNhnMiRoqjdyEUu/hNZHM329uDCxxzW95tujWZzwwcDg3DuxI
         pmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4RXkqyEdVnf06F7mDWuAUymH6Dg037/S6JjirDYzTK8=;
        b=tdejNiHnnX8LOvzJPuna8/rE/1DAYCxQ4pxgSITboj3UbXteBX8Fbb78k8Pozr6gQ7
         QHE7daYvCOARQPSVBgNue8HTWs17F8DAQ1dHWFlz2h3SVaf2srWm0uqqfUovgl1iGmCh
         GWKYmmaYUdzte0ndewhry10IiVTrR897L58zqT1AVGgv2Ewcq5xvzh4/WRF3CsZtrmc6
         Uqy+isaWnBi+zxF3MoqJRe4jZD1VOhXqsSLSL7TxyBZG2ZAoXvvhMW9VhimmTAyzyIUV
         NVfkNdebO72XxCdbomH2jf+KqaK04JuFgVWJT8jae92z68jyDeSaO8QW/eezQaj8+2gt
         G+aA==
X-Gm-Message-State: AGi0PuYR8Tq+hRv48PKbl6fwC3E0oacAAOVbdnemQ4KmQveyNUhn/MAU
        +QTYofMXjkTedn9AsGUv82YgfS1WeuFVAOkmd4LJtQ==
X-Google-Smtp-Source: APiQypL9sh5T/y2+3giCj5f0XNXe9/5/Y2cLM6gvJuQuDBaFo17ExOMevue3DPHU49eT1QkW3HXz7ZfXzrey9235Xyc=
X-Received: by 2002:a19:c64b:: with SMTP id w72mr2131795lff.82.1587641296515;
 Thu, 23 Apr 2020 04:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200422095057.806111593@linuxfoundation.org>
In-Reply-To: <20200422095057.806111593@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 23 Apr 2020 16:58:04 +0530
Message-ID: <CA+G9fYv5ofZJfrKFNbj6kaGJfLsvS7gOvVAEq_q9cMq9f9cM6w@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/199] 4.14.177-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        Rob Clark <robdclark@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Apr 2020 at 15:42, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.177 release.
> There are 199 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 24 Apr 2020 09:48:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.177-rc1.gz
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

NOTE:
The platform specific issue on arm64 qualcomm dragonboard 410c and
hi6220-hikey have been reported.

stable-rc 4.14: Internal error: Oops: 96000004 - pc : __pi_strcmp+0x18/0x15=
4
https://lore.kernel.org/stable/CA+G9fYtoYzRbrUVhboUgOOqEC2xt_i4ZmYb9yq33fRm=
f653_pQ@mail.gmail.com/T/#u

WARNING: drivers/gpu/drm/msm/mdp/mdp5/mdp5_kms.h:178 mdp5_bind
https://lore.kernel.org/stable/CA+G9fYtcjK8MrygHu686rV4i+bYO2CR=3D=3DOFNrXN=
SM_HzWEhNFA@mail.gmail.com/T/#t

WARNING: net/sched/sch_generic.c:320 dev_watchdog on arm64 hi6220-hikey
https://lore.kernel.org/stable/CA+G9fYtR4cvY9N0NLYDOByHsDyQJwpaYuV8qss6s-D+=
_DS9x_A@mail.gmail.com/T/#u


Summary
------------------------------------------------------------------------

kernel: 4.14.177-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: cebd79de87875c1f054d7e674a496868b78e637f
git describe: v4.14.176-200-gcebd79de8787
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.176-200-gcebd79de8787


No regressions (compared to build v4.14.176)

No fixes (compared to build v4.14.176)

Ran 44120 total tests in the following environments and test suites.

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
* install-android-platform-tools-r2800
* kselftest
* kselftest/drivers
* kselftest/filesystems
* kselftest/net
* kselftest/networking
* libhugetlbfs
* linux-log-parser
* ltp-commands-tests
* ltp-containers-tests
* ltp-dio-tests
* ltp-fs-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-sched-tests
* ltp-syscalls-tests
* perf
* v4l2-compliance
* kvm-unit-tests
* ltp-cap_bounds-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* network-basic-tests
* ltp-open-posix-tests
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

--=20
Linaro LKFT
https://lkft.linaro.org
