Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AE8C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1792720734
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CaV54r4A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgFQIzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 04:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgFQIzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 04:55:18 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DA8C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 01:55:17 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i3so1913386ljg.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 01:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DKUBgryVX8raW8V6LX9CcUkjsYO+vcdlONyVIxz7SUc=;
        b=CaV54r4A+HlePitwPGO+qincgGOuG7ADF7vr8aNNZPfSQ0HMLdkDcagXdk+UkvKG7v
         SD9DYhETNNOcqAe7x52dJVBAMM3Y2gekLHw5gW5HL0ShX9n98wfCQ7kQe1atFlcRpyT+
         bsgZjLXR/mJhH6r8b7Iqrkgj7u4vg2RfOX2b2LxqD+LvZGo6MIAjLU1EHr0L4HviYdmr
         v+PnmPaxITLbIqkPyJx/PHbYYyH8VCatiQpG5I6lZkhp0zcyZxL+rnK4utvEmFV3e/ff
         fy3lPLqHy2tBcMD1q5aGNMf9SJMSp9zrDGWUYJJGKvhbE0vLO3S+sIQoqfixBYR7eaiq
         orKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DKUBgryVX8raW8V6LX9CcUkjsYO+vcdlONyVIxz7SUc=;
        b=HYs768sJ+PoUdG/j94p83EyEKj0JGhekOoAhzWhFJdvch3bKxvMg8T7EAMdcJMfcpV
         NpJoWY9+bzEALKIqV5yeFOQGPcvooRtEjoM5J+g7hbYy1ZQzRRM+0f3UhjtYY/LYGtBr
         EStjAdbrweJqvWkMzK0WR11iJ40JafncsrLHM3vJJcYJvfflGXEB1gW9gRqeZ0HLVZ+A
         xrJ7jxitqP0W5tODUv/cT84cbNnkFP8n92mb/iDi/+1NM3PfRXbCbsEmx671nMg3bLX0
         R/4JSeDc61Vda4NWlXypPyGlFdj47oWQ5ycOwMfXupismfXZLHMsx28+DPxA1FVUfvhm
         dbQg==
X-Gm-Message-State: AOAM5325zemsbou93kIaM/bfV/Duv13qnbGLeBOzRp6DgeUQ0hmpy801
        Lx5BQjdFaLzWIckslPQmVkZOQgR6OnxZQXngu+WlsrC8PSqO1Q==
X-Google-Smtp-Source: ABdhPJxY09Oi8zHnXXIrikOGhhUvTJ3aDyHIWr9Fl2s0RZWrwI83gNkh5JRQmgvS8xuTKX91WW9ttN8gjjYCmH0p+dM=
X-Received: by 2002:a2e:b88c:: with SMTP id r12mr3449089ljp.266.1592384115874;
 Wed, 17 Jun 2020 01:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200616172611.492085670@linuxfoundation.org>
In-Reply-To: <20200616172611.492085670@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 17 Jun 2020 14:25:04 +0530
Message-ID: <CA+G9fYuHkeN-ubz7w7=A+auuxPPBSS-2oLWLSs-OyDjYfejJDA@mail.gmail.com>
Subject: Re: [PATCH 5.6 000/158] 5.6.19-rc2 review
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

On Tue, 16 Jun 2020 at 22:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.6.19 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 18 Jun 2020 17:25:39 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.6.19-rc2.gz
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

kernel: 5.6.19-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.6.y
git commit: b60e06c9887321691c8d341e86c085ed3a6a4138
git describe: v5.6.18-159-gb60e06c98873
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.6-oe/bui=
ld/v5.6.18-159-gb60e06c98873

No regressions (compared to build v5.6.17-42-g1bece508f6a9)

No fixes (compared to build v5.6.17-42-g1bece508f6a9)

Ran 30750 total tests in the following environments and test suites.

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
* ltp-controllers-tests
* ltp-open-posix-tests
* network-basic-tests
* kvm-unit-tests
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
