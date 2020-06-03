Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735BCC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 06:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BE822068D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 06:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fsGluz86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbgFCGND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 02:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgFCGND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 02:13:03 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11DFC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 23:13:01 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id c17so1163319lji.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 23:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xk20P2S7rDaUSDVCxxVxeXJ0wXIWFWiSC2tdp+gpqnA=;
        b=fsGluz86vOjHN2TBk7/t+PLrMaZOi9+uqgGmTsnkoQdc28EmAYL4vUmyrI1Yx+4r9v
         dc9hA378SMDasdLLSt7ed+YXpkCM+PQ27N06g3k5Y0rnIGfR81Fq80Vj0MYO8g9SBTxt
         B5d2A7eg62WtGZjEuQ6+xjGev3ubE0hFTJ8NzMfWpjQ7NzXRtVOK32KIw3QtTaQ7nRWk
         WNJ2rB9leySe6hSWTDOiPTu9xUnryNQVS5WzaFroFjlroZIwnPReQQr13Wl5e9kCV+t+
         GAGdkTK2bPbCfp391bf8sH/zhTp+mKjKFisqEm9BmoFBmgKJjCt7qWk3mUq1BnraSRYO
         UjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xk20P2S7rDaUSDVCxxVxeXJ0wXIWFWiSC2tdp+gpqnA=;
        b=QTbQ/b0EpSJ0KPY1d9NAZSU69E2iv429riwtb9m8Ca8BW3Eb3q2Rt52hfaHHGKqsTC
         adFVNMA3Jadxh4YTfxnix4ZpNvEtf3vTon6nic8uaIoOHCNmhCgmcAO4d0qIMWYc5yo9
         BA2pAXfvOjrYSNrXFtBiHpsvvMDiXe1rLc/q1QPgXgyDd4dFG+39sL7GyeWEtF5a1cXm
         z4GwEBJpTmDAX94JG+us8mektKFsE71R2GIbiByj/rH+6fm2qC3EC4OyvdzLgL4NPlFF
         deKqZ2hLbeHzWM04kaIhPLXmtpBhsL7tjYDdp0IjrrSqnfzgijGiUpycKqcnk27oqFBq
         HYcQ==
X-Gm-Message-State: AOAM530BTvxNkdg+LfkTP259Uhp1Y1wPiAvJolbbfwhTma1LWqm0ga1H
        /dj+MzbmyZ3PV8I8QR6ecKMJpvj7BemaKEmnEjckDw==
X-Google-Smtp-Source: ABdhPJx7/ynr7nesYDFxGz07duEAXFlWwMJoMBfkXUk50wTWbVm+zrhC5l4zwQj/Mj/wyO9X0MbnDFPlUTk/LMPDkBk=
X-Received: by 2002:a2e:974e:: with SMTP id f14mr1205380ljj.102.1591164779850;
 Tue, 02 Jun 2020 23:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200602181325.420361863@linuxfoundation.org>
In-Reply-To: <20200602181325.420361863@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 3 Jun 2020 11:42:48 +0530
Message-ID: <CA+G9fYsU+pP971z2sOjyJbW3jiiTa=TK+GJTCZ+-TF36krCepw@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/55] 4.9.226-rc3 review
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

On Tue, 2 Jun 2020 at 23:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.226 release.
> There are 55 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Jun 2020 18:12:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.226-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.226-rc3
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: a836fd8c024d14989c7cbfb91040e805b093f1d7
git describe: v4.9.225-56-ga836fd8c024d
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.225-56-ga836fd8c024d

No regressions (compared to build v4.9.225)

No fixes (compared to build v4.9.225)

Ran 25363 total tests in the following environments and test suites.

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
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
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
* v4l2-compliance
* kvm-unit-tests
* ltp-containers-tests
* network-basic-tests
* ltp-open-posix-tests
* kselftest/net
* kselftest/networking
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-native/drivers
* kselftest-vsyscall-mode-native/filesystems
* kselftest-vsyscall-mode-none
* kselftest-vsyscall-mode-none/drivers
* kselftest-vsyscall-mode-none/filesystems

--=20
Linaro LKFT
https://lkft.linaro.org
