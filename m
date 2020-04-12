Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA84AC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 08:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC37206DA
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 08:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Siu8yDwN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgDLIi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 04:38:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41794 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgDLIi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 04:38:28 -0400
Received: by mail-lj1-f196.google.com with SMTP id n17so5896319lji.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 01:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R2le0evq9gz9HfqkaJ4JdCZcgFC4TsWNJcMqPXjUYfs=;
        b=Siu8yDwNbubWcGrVEJhG9J6GsFQiht3jv9w0TOIa4/Z6Q+C2xEK+tuLAFiWteRYxc/
         JuUQf4KNbogBKKHDbD9b9NPDai5qvhCquDNUs5vzn2/hUaLB8w+Z5vokPIQLDcCAGq9T
         +ZKjHwK4iNZT7zDrMjacSrTLdUwtETCMCDGcsdMLjCL9apd9Jui0S1+gpNpE3hfEhRBW
         kbt4fCPI5HcGoENmFO9n/Qz5YK9wezBqmb0ht9TsA5+1thQlqB2kJ5auBIGFcXRZamtg
         3F73ilMCsPhndtWwN/AkOuPYdLTa3CIqgXxtXQN1NfLsQtiXBNERJRNe5pD73qOf3kyq
         G56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R2le0evq9gz9HfqkaJ4JdCZcgFC4TsWNJcMqPXjUYfs=;
        b=ahK+8Aa2YnkVAKQuDcRFg/NAWy8pHr5yqTYxRef/c7BIkKEaYl7HHrr6VOa+ekaxPq
         mP4rAi2uXb8nvpXVRLL/WcMg/O1EESMmnIdN9HF/wdO3IEgNtragkk1aazcBM+DUqkmR
         txDbCj/o4mvN1Wvq8OtHd2aH95poFIXXERe9SX6NNjQq2TmxYykgpmGkr68V4wte5Lmk
         w2aVk/6/Tv3gy+fO3jPw4NTuU4NMbvS5t3MAcBeM6d8uB2lLZ7LpO3/AImktmb+FKYuU
         vlS1Q6jjlwQ5lv95EUgvbaeEAyu+a8M2MZsDY3IfGXnGqVgXpLOmxS7ZqL8sLysBQKwN
         fzTA==
X-Gm-Message-State: AGi0PuYjVdTWoPrYsAZ5gLR2nCEfAH39jirxr+HXW3+0aj1xaIN0fv8j
        MYGvGd74FCSrG8buaejyBwEl1Wv6Iz+LqwcBBNFB4g==
X-Google-Smtp-Source: APiQypL4Bbi8BcupFNGHBvd5y8ZZ4Vqv40Zz/fqHI2Rmp56kIoH0egpqJZxPgCJBIMTulXrTEsiL28LXpGUtZvY1TkU=
X-Received: by 2002:a2e:97d6:: with SMTP id m22mr7779074ljj.245.1586680706756;
 Sun, 12 Apr 2020 01:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200411115508.284500414@linuxfoundation.org>
In-Reply-To: <20200411115508.284500414@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 12 Apr 2020 14:08:15 +0530
Message-ID: <CA+G9fYsv4coG14Ah=6ExiFZLn3mUhdxOyx9Hir-cb7HEP7w65g@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/54] 4.19.115-rc1 review
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

On Sat, 11 Apr 2020 at 17:45, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.115 release.
> There are 54 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 13 Apr 2020 11:51:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.115-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.115-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 3b903e5affcf69ffcfc0ebb8c3f2c016b646682d
git describe: v4.19.114-55-g3b903e5affcf
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.114-55-g3b903e5affcf


No regressions (compared to build v4.19.114)


No fixes (compared to build v4.19.114)

Ran 22940 total tests in the following environments and test suites.

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
- x15 - arm
- x86_64
- x86-kasan

Test Suites
-----------
* install-android-platform-tools-r2800
* kvm-unit-tests
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-ipc-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-io-tests
* ltp-math-tests
* ltp-sched-tests
* network-basic-tests
* v4l2-compliance
* ltp-fs-tests
* ltp-open-posix-tests
* kselftest
* perf
* spectre-meltdown-checker-test
* build
* install-android-platform-tools-r2600

--=20
Linaro LKFT
https://lkft.linaro.org
