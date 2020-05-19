Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3E9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 12:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 682202081A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 12:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w+HYtFzS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgESMzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 08:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbgESMzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 08:55:19 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDAFC08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 05:55:19 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w10so13605447ljo.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 05:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZhXFN1OP5LZ8pTJp0hhAj+h3HYNmi/vUY/+JhKBkwtE=;
        b=w+HYtFzS6/ILvzF+yI9JPMBoyxUvgZZ+tYjCzWQe5/RNMUHNL7d9gEpcnxhaIL0Bze
         z5dJhdNt/LlTR8k3z7r8Ia/iSn1efJUm6telt0E/9pK8DERziadv4Z7uUfIAEgVQ50J8
         QWxOTtedeFWgg55e/dWKP3ZoTVK7D9cXNAUlCXy5pX4BMh8oNO0WJ4oCbkOqYnPyyvFY
         hvX0hjpUSXoAmSXUxlqv2lZOaZEjy5xqHMWTsM6kwZv/Ey2Fr0zA7A7TiuBzdo0Jf+pU
         c+w1grnVtWoRBKhVudVbRPGZppZSiHXl7PJHDxTXcjb8UtLZr7dxUyr1b/rpOy1dCy+6
         M+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZhXFN1OP5LZ8pTJp0hhAj+h3HYNmi/vUY/+JhKBkwtE=;
        b=Zq9vCiqsvLlSMzsuw64jBlIsPIXK6hMyXIoG6E9FH+chBhWUZe+FO5UpMMAK9+ZkMv
         JQO0U+5ATYtr7XRlIi/j6PW9TM2+wDKHv6Ut2aZilal5lE6/tQUqfmDesyCuJ9xlVRsd
         kjPj48oS3ALY4iYVNoxd9bPaK6lcFXdZ29OU4ila3B1L9WyKJAZ0VPkag0rJQzE24TD6
         gCF/+qZLhXMa5IiH5LYF2AK1xZpWPRnoPR7Oas9rblIB9p7MCXcTq2Iy2qIP4LwUACEa
         oY9ERYthJpqWHS8TM6lOkmzrugDOoGsEeGIxb3KGuRB1EKh+E+3Nmw0DLrYh58p6e5Vz
         Nf/Q==
X-Gm-Message-State: AOAM532jCz6HThBiuENSH9dgdrm7yGn0Ki/vCV1J1w40bP1JnEm7dJi8
        AOIQWgos6wH922UxVERneI9UNDro690WnSJWFi5/ISGzRjaQiA==
X-Google-Smtp-Source: ABdhPJyDOZGAg+GjNy3Tf8KEX2A2lDHFEwnnpiYP84RbiwLs5SoAH9qqLoZNJYI0ItazM+pmQBdMku5NP0Sn8DPpg+Y=
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr12641949ljm.165.1589892917410;
 Tue, 19 May 2020 05:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200519054650.064501564@linuxfoundation.org>
In-Reply-To: <20200519054650.064501564@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 19 May 2020 18:25:05 +0530
Message-ID: <CA+G9fYuD66kXa-4kYNFsS+HBmu7qSSpCxSnVVSYzb++X=o=2cg@mail.gmail.com>
Subject: Re: [PATCH 5.6 000/192] 5.6.14-rc2 review
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

On Tue, 19 May 2020 at 11:17, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.6.14 release.
> There are 192 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 21 May 2020 05:45:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.6.14-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.6.14-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.6.y
git commit: 67346f550ad85f9ddd257856e32049416df51616
git describe: v5.6.13-193-g67346f550ad8
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.6-oe/bui=
ld/v5.6.13-193-g67346f550ad8

No regressions (compared to build v5.6.13)

No fixes (compared to build v5.6.13)


Ran 32348 total tests in the following environments and test suites.

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
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* linux-log-parser
* ltp-commands-tests
* ltp-cve-tests
* ltp-dio-tests
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
* ltp-cap_bounds-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-fs-tests
* network-basic-tests
* kselftest/net
* kselftest/networking
* ltp-containers-tests
* ltp-fcntl-locktests-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-open-posix-tests
* ltp-filecaps-tests
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
