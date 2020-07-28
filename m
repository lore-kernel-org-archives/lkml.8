Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1760AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D662070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gD5oyV1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgG1Hda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 03:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbgG1Hd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 03:33:26 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B67EC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 00:33:26 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id g4so6201894uaq.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 00:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kFUreiBx4DAQ4kyny5W6AfS5Mm02EO+ZnUgg72kdYls=;
        b=gD5oyV1i8w/KdXveekmjEcaFARFgAjehfNAjfl6n0p/dPkHVwo4y5luASfFfH2VXa8
         JFx2Ypo+ELezn3mAo/NoWkuvx1WWMv0Bzwq3wKmWkFLPCMwusieD1LYkIYt1kR+lJ3wB
         dQIPHjsLMT5wL5Jpt7jYgd9ihQJBKAl3+KyG6n38JBrhPZ1kOF/oEdF0CPSGMxjJLu4V
         0nbeFF2v33R3NrcW7YrQAUW+5F6b6g96ba/Mjt1lnOw88ghg3FHOJ3Hys2Jb9GvtoEig
         vU+yIxVfa1LoevQwYXlc6TYhgQMNJ7Jo3f8ABRt0ipoRtEpwy62faNZ6T4nW0lt0etKY
         m1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kFUreiBx4DAQ4kyny5W6AfS5Mm02EO+ZnUgg72kdYls=;
        b=DcmlOtVqpiOL2osQXceo99Q5YtuAV/0PBg9aRntIVo/Dwb3wboiFyV/Hx6EN4Vzf1K
         CkQx5XQwj3LVlBo5sfR0xgr3SILTRGN1BgPxjdFD62IOlG6gw7084m/Wua7I/9WKSZC/
         6030QN6M9R8aX0W+p9wg2R7TEfPG8evowxRBwmAmRXv7SAMDBzpeH+1zJh/UmwIHEOuq
         GKF2SkbqbJH+F5+xBQmRW17jBh0Sb+kS5GbduOUEu/O0SP7f1D0pk6ne+iS3dgsUBnm8
         f0NhdrwJhllHtTYppXjXNtRGySJ48NoTDJO79sTJeC/s9yRDjEI4PvBvmOty68waX+ne
         ffXw==
X-Gm-Message-State: AOAM530McnU2VDl2XlrODQuaglL3HxUMoivcY2zRupLXfcKIcsJzhYi+
        1IORQKXZYVRtXrkaFLChPMVqKFtBcDEDOZRgZp4Hig==
X-Google-Smtp-Source: ABdhPJxQPFeiVSXVAcxqXs/QRzszmGGlCXP+gz7134mb4FE9yDaH5LTNBmZoSbGBtHc6RK+iAzIcKRmfYNoOZ7Vl1pY=
X-Received: by 2002:ab0:5a72:: with SMTP id m47mr18752328uad.86.1595921605067;
 Tue, 28 Jul 2020 00:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200727134932.659499757@linuxfoundation.org>
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 28 Jul 2020 13:03:13 +0530
Message-ID: <CA+G9fYv5XZr-OeycHzHS0fByAX25JCz7g31bZuQQy=RrsBxc1g@mail.gmail.com>
Subject: Re: [PATCH 5.7 000/179] 5.7.11-rc1 review
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

On Mon, 27 Jul 2020 at 19:49, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.7.11 release.
> There are 179 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 29 Jul 2020 13:48:51 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.7.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.7.11-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.7.y
git commit: 17edbab45dbfdee306397509538f3f12251f23b3
git describe: v5.7.10-180-g17edbab45dbf
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.7-oe/bui=
ld/v5.7.10-180-g17edbab45dbf


No regressions (compared to build v5.7.10)

No fixes (compared to build v5.7.10)


Ran 37112 total tests in the following environments and test suites.

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
* linux-log-parser
* ltp-commands-tests
* ltp-containers-tests
* ltp-controllers-tests
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
* ltp-securebits-tests
* ltp-syscalls-tests
* perf
* v4l2-compliance
* kvm-unit-tests
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-sched-tests
* ltp-open-posix-tests
* network-basic-tests
* igt-gpu-tools
* ssuite
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
