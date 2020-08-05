Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EB7C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 06:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7F3F21744
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 06:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oRw0sKEc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgHEGxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgHEGxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 02:53:12 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBA3C061756
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 23:53:11 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id k23so44775300iom.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 23:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E3FDGWcfDYMfmZzmjCmVff8ufX3JbPAPvNP4qUqkbYk=;
        b=oRw0sKEcr1FH3uJgTU7KO4GPlxBHZ7VQFoq0pxyRGoeWrNUlLNSJZ45gqE/sPYbFmJ
         go64ObjzG5EAwWKJxw7qc7pXQ3iatPjhA2ipGMPNRHsPw8fJWViuGLAO5o1DpSazSbrZ
         wrtmCU+GqwCsTNw8y5KJxeDYRi1UF1gCVrnIHwLssZtrB730T3S/AqB5Ijug5/1vfyC3
         NLTzlU+/Zp0ZvlJKKtanCZbv2uhA/VDXlHbumnk42obRo2YTJIVfCeK5AyQlwT2fuCv9
         dAM1j4DELm9A/urP7om8vlxErmZL4U8t3SI+y3z7hmltucgMMVNvmJPD9VTVL7zGqtu7
         Owrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E3FDGWcfDYMfmZzmjCmVff8ufX3JbPAPvNP4qUqkbYk=;
        b=IkJ1qpC/xCzUpSkc86M6nRy9UlJ60rxQlkgmorLsHD1mm5GLXR2+QH+bpoxnO5zBnd
         Zvx0hMxoxy7e5Y0jIagXMhAS9bLtNBysp4EgS6EIeCnt+nTD+3fXV0T3Jb4NGa7VMoEf
         EmmBSP/aT4rLG106UYb83fqxke95TTbERfDoL3kt28kKmhcuUHmZb/yM+DpLWqkHZYqN
         tKQEeJuRyf+4KB/ag2Pf8+frlCng4tufGpEe6nXtEAIUgvl1wSEa965s6lJYYmfZqOSS
         noo3bv5OrJ20VQUd8doPH6pPw4JjT98AMwGarMbiXJRaW++DmJE9MfhUjXqTgyw+zrs5
         ViAA==
X-Gm-Message-State: AOAM533Q/URnnPwq/LX9ug/GlgYh21jnduQAcK01NBhhXVmfe9Tiibhx
        eOA0sEYIyV7BGwQw6UCakVmlCgp75FYDORkZ6zJf/Q==
X-Google-Smtp-Source: ABdhPJw292/nirdA4CiSTWNrlYejai8h8/9xpGI2jxOgYtnzNx5JlV/4p993axYti0lQodF7npaxZ6qbY1skboXx/zw=
X-Received: by 2002:a5d:995a:: with SMTP id v26mr1887188ios.176.1596610390782;
 Tue, 04 Aug 2020 23:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200804085215.362760089@linuxfoundation.org>
In-Reply-To: <20200804085215.362760089@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 5 Aug 2020 12:22:59 +0530
Message-ID: <CA+G9fYt6Yxsh9QRn6yG3SsOoLKBUYbbp=e3JTd8oKTj=w=852g@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/47] 4.14.192-rc3 review
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

On Tue, 4 Aug 2020 at 14:23, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.192 release.
> There are 47 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 06 Aug 2020 08:51:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.192-rc3.gz
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

Summary
------------------------------------------------------------------------

kernel: 4.14.192-rc3
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 7083248d6b07cb6515a68a2615895a121d7429e0
git describe: v4.14.191-48-g7083248d6b07
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.191-48-g7083248d6b07

No regressions (compared to build v4.14.191)

No fixes (compared to build v4.14.191)


Ran 31440 total tests in the following environments and test suites.

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
* ltp-commands-tests
* ltp-containers-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-io-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* v4l2-compliance
* kvm-unit-tests
* ltp-cap_bounds-tests
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-fs-tests
* ltp-hugetlb-tests
* ltp-ipc-tests
* ltp-mm-tests
* ltp-syscalls-tests
* network-basic-tests
* perf
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
