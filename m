Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51213C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CF98207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E7dmo+MN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgHUJkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 05:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgHUJkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 05:40:16 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C541DC061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 02:40:15 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id r197so252209vkf.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 02:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1dXsLAdD/HVr0aypwMgxgpVJbDNFXP6FiKC2otHgH1Y=;
        b=E7dmo+MN5nYduaGj/JAiyY5OSzfBzBS2w/cF9WHN8nsuR54F0LS0QdQHVF9yssq2qZ
         /DB+Dl+YzEo/MNxIMaKd4A13ztlbPA45EDHE7ugicIdczck4cC5MH13zMs2tBT0EzqhD
         Fw0vEiTH40gIl89gCj6mi8aWi94kQW0xOwxFQgL4UyiYJnrapPBQiqzO9la4NjfLf3E7
         ULyRjtZqES8XGsDq37/lF1nliX/LaDrSW1gUBM92dBo+YT+MpW6WcUC3o5U7FKc7H46f
         siLME/fwmxiRwdIjZ+YAAkr+nLkLKPsgSCWgibNtGifOMCFXvdip0Hk21tvSCnvfkWQQ
         afGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1dXsLAdD/HVr0aypwMgxgpVJbDNFXP6FiKC2otHgH1Y=;
        b=KuYJeWFuAZeefd9peQzScLRj6YSQPA6waHhE+Nl5EphmqgGauuOdxxwsis6900WE5c
         CoLd6FeKUg0IwDfGxrHSVfKtVWwBLcI9WhqetxQ87sYi/zeMjifMhYwSudtNr38JieeT
         z0SYFMYlihXSuh4MuOoqh3zDkRZ56kzKtdQK0f+RfNojnQ9P4S7zFluOj+flxE/E7F9y
         dFA0EPF3hTqM0GMTOuQNrDXsjYHuVoNUaCJi34y3DiRasmzQNb6aU/fzPJc/NfogPcry
         zvYgyGThAzqYjyCfYUG6C1wDPkHG7p7ptleQ0y5IUbmfZ9Rxr6j4KAQHhDqvowbHBWTm
         WvLg==
X-Gm-Message-State: AOAM5315alYLF5kKk3bbi1oEzaq43SizYuETh4F2e5/3mkjNdsMyiERR
        SamccbHiko0obuJzrUrKTUVCvawOPnFJatfH5PmUcVvArMfohwgp
X-Google-Smtp-Source: ABdhPJzObFpOXs7+mNxh+vLL1/3RWAib08n7aBJ/mRdsRanKFNbQie33YlcYxXmCaGw0mbiF5GPKXIRaKFrlVrhhbJ8=
X-Received: by 2002:a1f:eecb:: with SMTP id m194mr991597vkh.40.1598002814707;
 Fri, 21 Aug 2020 02:40:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200820091602.251285210@linuxfoundation.org>
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 21 Aug 2020 15:10:03 +0530
Message-ID: <CA+G9fYvDcnBcnUJQWGutPj13C9HQ53E9bsGtJKmm48OrzuWZTA@mail.gmail.com>
Subject: Re: [PATCH 4.9 000/212] 4.9.233-rc1 review
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

On Thu, 20 Aug 2020 at 15:28, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.233 release.
> There are 212 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 22 Aug 2020 09:15:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.233-rc1.gz
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

kernel: 4.9.233-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 1a1baeef1d3674ffce6cf9dfa5b5778c60555587
git describe: v4.9.232-213-g1a1baeef1d36
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.232-213-g1a1baeef1d36

No regressions (compared to build v4.9.232)

No fixes (compared to build v4.9.232)


Ran 34241 total tests in the following environments and test suites.

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
* kselftest
* kselftest/drivers
* kselftest/filesystems
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-controllers-tests
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
* ltp-tracing-tests
* perf
* v4l2-compliance
* network-basic-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-native/drivers
* kselftest-vsyscall-mode-native/filesystems
* kselftest-vsyscall-mode-none
* kselftest-vsyscall-mode-none/drivers
* kselftest-vsyscall-mode-none/filesystems
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
