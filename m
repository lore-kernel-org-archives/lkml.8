Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0A7C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27FB720738
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KPQmdM6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgHUHJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbgHUHJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:09:20 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39335C061386
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 00:09:18 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id v20so272687ual.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 00:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qsRUqzEHz2hvX10s1CFevWBJNZnWuTdz/MNYc/0zA9s=;
        b=KPQmdM6tkMN6Ep1FZeotANOOLSci5NOOGxEkF1HcuGUCH0aTX0g43BteJ055woCYUp
         lQuOBR77BnqN+Orh6DR7DcDg+ybOSpeMvHc+suyh0d/AttAJipgnR1FjjZ9CEJKHeBLP
         gJWKNkfye8KTdYMlYgPv03VBCim1VXDYtx0OkvHjMEuAWbhtA29AqbT/BZD1kXRroe05
         MfsYg/yS32ZISAC1psotBFbEpooPAhDJpOjRxMMkY07fUFU23xzs+hacDIfi0qCEuk6e
         6mG4gdkpbnqCETlJUzME9PzGa0sM9endCgHZs/eDL/AegTzzSlS3D32+N3wh/vcjGP0l
         4kSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qsRUqzEHz2hvX10s1CFevWBJNZnWuTdz/MNYc/0zA9s=;
        b=Bmk/XtGnwnEUVX9b/PjTtvctmLfRK+QcQA6pCrCFDvrNvWKlFDJ20ykZYX6AWrijSe
         pPOU5mejQcvXUGM9lMExB4r/8b0yo1jZdIoRzEkb3dtKI8HaUDC8FTNPhILOcM/L9bbh
         U2M+XF6cQYmJDFELrIWhhmUjFim200M30tf/XS/6S2OBXI/kqj3GlFHRQ7gdatZIwPY8
         jf5w2sALwJ7PolpVFOE1ZtYQnYcxIjr8pJ2hYluYCKm507X79mkoa7xXFxTIrLvGs7gr
         ZDhl7u0FDfwdy3HwKY6pxIfG7VmypW5dYfUVzRz80Jpx4IvbhcJvGB5Fne+NYILa8zG6
         4Qzg==
X-Gm-Message-State: AOAM5325lD3pEDn7KhW3NCeOVvU6OQ4IUT+7+HzBwBR0sPJGzsHJ4QJL
        dSEuid4P+fRih2jQBjp7Ftw4q6Lasm8PQa/es8julw==
X-Google-Smtp-Source: ABdhPJy7wu4Heg7705JtopAoAZHR1JI5IOZ9cyV+WUE9pxsUnoGhAkufrn8eY9LnpBDejLBXPLe8/Ac+q3xznWFvHs0=
X-Received: by 2002:ab0:462:: with SMTP id 89mr771846uav.34.1597993756959;
 Fri, 21 Aug 2020 00:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200820091537.490965042@linuxfoundation.org>
In-Reply-To: <20200820091537.490965042@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 21 Aug 2020 12:39:05 +0530
Message-ID: <CA+G9fYt5xa1LT3NCoW7JW2Zz5mx_84Z_XTDzChiRL63apkquMg@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/92] 4.19.141-rc1 review
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

On Thu, 20 Aug 2020 at 15:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.141 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 22 Aug 2020 09:15:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.141-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
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

kernel: 4.19.141-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 294e46de3a1d3cb90ac476ac92ffc835a7a1e716
git describe: v4.19.140-93-g294e46de3a1d
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.140-93-g294e46de3a1d

No regressions (compared to build v4.19.140)

No fixes (compared to build v4.19.140)


Ran 34142 total tests in the following environments and test suites.

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
* igt-gpu-tools
* install-android-platform-tools-r2600
* kselftest
* kselftest/drivers
* kselftest/filesystems
* kselftest/net
* kvm-unit-tests
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-sched-tests
* ltp-tracing-tests
* perf
* libhugetlbfs
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
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* v4l2-compliance
* ltp-open-posix-tests
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
