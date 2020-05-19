Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D41C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C512420709
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RYFFe8Pi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgESIQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 04:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgESIQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 04:16:10 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131ADC05BD09
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 01:16:10 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id d21so12706707ljg.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 01:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BjTBKYbgfQA5s94+kOx4r3jcG29cEry1R5hVu5dFmbw=;
        b=RYFFe8PinN5tjtTTYBG0NuoUy1gw1/GZRXCJOkkwHtjI+i8x8W4qFwIcVTVhqRUytx
         qzrv2QqUpfl5b8wL7NH4mfC9GpMaaoabCYNyAxiO0mOqwDmbsK+x//q2YRrxx6xhu18f
         8JXlZaKNClxp0zXkdmru/zrOzd9jfearAW0S3uSKga7WW73/jn2du7LxlVl6cTOKljIb
         DfHVvGrwVZc6LXBdj42B5XthQq8bQzMU/AI/eo8LppM7FsFqDABHDzC1DzdyvOTmhByZ
         uguAxF7n3dbQVI7lIgAsA05fGRHPdmi3e6v6oNXUdgzvdPYZfgOSfttlD+bYtDaDVULx
         Rwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BjTBKYbgfQA5s94+kOx4r3jcG29cEry1R5hVu5dFmbw=;
        b=fRlKNtTOwODP1rE51MdrIYhGfoEPkx5BbPKuskdaMOLwm6QP3L0lxNjKOke3gSfpur
         +zjLPkM0CPX1aJ/GSm2q/pNeRoBqi+A05hK0MIYrfFbT6mzOgPXNK4iVFJjCyh45tl0X
         2CZZozKhJJic8f4PrGS4iFN9gXbhMhj+xxY+qMaMMj1sN9TIxnEMs9tikaaIMF5wrSyV
         e5v5TOhps9kyI0c7t22kDVJOWVkkMj2GCym+RoMagP0C/PT7Ba5nwGeISnpxTEU4lUJS
         fvk07YZRqCuoBCSZhENKlGD0jtuitBNF22qu8M3o9JotJE9ZGdJIjF2cEdQLQjYCNAxz
         tpCA==
X-Gm-Message-State: AOAM530+scOxyuOjpDFPU7yBJgig7ZD/DlOJJNf1pYqCwe5CBAhkIZ+6
        TEleB8fLmIf4pkR6apQdhr2vOi3zC3S/rPbpReZ3VetBgT3CWg==
X-Google-Smtp-Source: ABdhPJzsA7H4sHipfjd7HaEjwKIUo79QFhef3eecrJK/YFKOd5AFF2gHq0QiAftKiUs9wvNLt6a4drLoUrcdEJ7+ys4=
X-Received: by 2002:a2e:9455:: with SMTP id o21mr13203272ljh.245.1589876168311;
 Tue, 19 May 2020 01:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200518173503.033975649@linuxfoundation.org>
In-Reply-To: <20200518173503.033975649@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 19 May 2020 13:45:56 +0530
Message-ID: <CA+G9fYuPzr_BEU_ytPSDW0B+khsUFMJt=t_W6BO=iLrxd_7Q4A@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/114] 4.14.181-rc1 review
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

On Mon, 18 May 2020 at 23:17, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.181 release.
> There are 114 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 20 May 2020 17:32:42 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.181-rc1.gz
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

kernel: 4.14.181-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 53d55a576a17377e7713aa3aaeee0f35b06a1f73
git describe: v4.14.180-115-g53d55a576a17
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.180-115-g53d55a576a17

No regressions (compared to build v4.14.180)

No fixes (compared to build v4.14.180)

Ran 32429 total tests in the following environments and test suites.

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
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
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
* v4l2-compliance
* ltp-fs-tests
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-native/drivers
* kselftest-vsyscall-mode-native/filesystems
* kselftest-vsyscall-mode-native/net
* kselftest-vsyscall-mode-native/networking
* kselftest-vsyscall-mode-none
* kselftest-vsyscall-mode-none/drivers
* kselftest-vsyscall-mode-none/filesystems
* kselftest-vsyscall-mode-none/net

--=20
Linaro LKFT
https://lkft.linaro.org
