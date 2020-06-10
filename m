Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63C3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92E332078D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gwf8yYgo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgFJJI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 05:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgFJJI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 05:08:27 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5568FC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:08:27 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id r125so983988lff.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OMD4QNJ07KLWaMvx5NPnXsek59l/EkEXM1bu39Mq9/k=;
        b=gwf8yYgo9aFRXXo47yzGSS2TMtu4rgSCS0fzK8Q3uj0UolE1j5azkZey3dPdsYYrAo
         JTx/FYn4gQJFP8Wp/XuxacYBMvfHFD9CuJAboIK0VasbEWEIu56IgCnn9cE61QoiRbDw
         Fkt9US8MjM6xyZVZEEBfGeIvzIAHKhdbU6kJvXl8VFUALPLfMsIZFOdmjN2nBPOh77+Q
         3M6WteubXxag+eJ1hiK2JTTZ0d44uS0/HA/OpnZ0mnCeh6xgkjLnaXAw/gWuoQoQHGze
         FwHGSboDFOByx50qDM2YyXsPYoGE2q2pKSLmNQcM/hWhBi7M3V+4RVS+cdEoONivKpmI
         WSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OMD4QNJ07KLWaMvx5NPnXsek59l/EkEXM1bu39Mq9/k=;
        b=HPysgJi2hoUoj07me0cQfkWOiF4oKwbrznaE/lCfe/KQ7GXnbr8vWKsc1MbIU5GxZZ
         BfOlhrzH9I0GzdLpoK6Bx6eQy3Ilu8bUxNb+Td7dRYWJ9tJ8A0uuT0YJ8s8A4MvNdDus
         mBLgv31GWzKSK05WlLyk4m0T5TecTzwdoVQtHMXHRV4a2+oHen341w1ERdxYW/gXUFD3
         6ql50S5H8QZnDeEmfknLWElIifJUheBLL4+fvcsLbpnRRezjXDRHa0ShsCFPRGa27DbV
         jKKcRriBKToFpxOw3UKSG06OsNMoyR/HBUEnHrI09knnmiKr+3to3plwOuPhhEJ45ozr
         oc5Q==
X-Gm-Message-State: AOAM5314dOrv/+LJfL6DlhbULuoEThwyPMAnhjBh02kdcW6FIR+jPOWx
        QdQ6n0Sl9YO6PdlgSCcz28EAtAhABr7tgxTXb7VmjA==
X-Google-Smtp-Source: ABdhPJxG7tXH2FW9XuCIE9i1NdeKtmRWwHRJNYaO0F5YesWc+RV8SG+S3+DnaDEvAodhaSygStKZ+M7a6ZNZ6Qk3+K4=
X-Received: by 2002:a19:5013:: with SMTP id e19mr1140554lfb.95.1591780105648;
 Wed, 10 Jun 2020 02:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200609190124.109610974@linuxfoundation.org>
In-Reply-To: <20200609190124.109610974@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 10 Jun 2020 14:38:14 +0530
Message-ID: <CA+G9fYs6D0qVH9fRANwPWqAMbQxaYQQRCRYPZinrXGTmUodZGQ@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/42] 4.9.227-rc2 review
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

On Wed, 10 Jun 2020 at 00:48, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.227 release.
> There are 42 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 11 Jun 2020 19:01:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.227-rc2.gz
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

kernel: 4.9.227-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 2d9a8182e06a681d0d198e8fb777ff32d9c581c7
git describe: v4.9.226-43-g2d9a8182e06a
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.226-43-g2d9a8182e06a


No regressions (compared to build v4.9.226)


No fixes (compared to build v4.9.226)

Ran 22181 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
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
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
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
* ltp-controllers-tests
* network-basic-tests
* ltp-open-posix-tests
* kselftest/net

--=20
Linaro LKFT
https://lkft.linaro.org
