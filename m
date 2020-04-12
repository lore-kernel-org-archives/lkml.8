Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66448C2D0EC
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 05:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3922E20692
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 05:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qRPfn3gH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgDLFib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 01:38:31 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40704 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgDLFib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 01:38:31 -0400
Received: by mail-lf1-f65.google.com with SMTP id 198so4183365lfo.7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 22:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YJb1IrFatNyDwLHwXKKwjPCgXOVxPWmrVgBNW47BrBo=;
        b=qRPfn3gHP9YhDHguGhvkaTZPp4TECE0lNLyXVIR3Q16v0yznO5VV/hIVnJHnREsxga
         cnxRdT/tIqvlIfc6M1Q64Ii9+Gc5WXo7jr5tUfOGhDe9E/3gl1/hqKCfuRigmHkTQyTk
         xijuHofb5hByWKiC316i+zRBYRuIWHvm1eME+iXpKI+Lz2fb1/7GvDIGSOLOQQwoN5bQ
         Gd5bq/RQOqimZYt88WuQTIKjlxImvhbCoYDuBxJaUe3OOkCG69sh0z4Mu1e9q9UBlXpB
         axrsKPAslff5mw1ek5eANYyAGuqmgjV4occ/GZW6vHJI7hvUIgWZFMOotNljJWl9yuHr
         y9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YJb1IrFatNyDwLHwXKKwjPCgXOVxPWmrVgBNW47BrBo=;
        b=fHidwK5HTIW6cGeO1LPwFt6mYEkTgjw0yLlGtgYdqhjoYa7+XvtH471ofcZFiWELP+
         OqTrF2Cduz3sexVwD8g5rReM/2cbfJ1wYNC8pSkmiZ/zeUa6g0Rzw/aCpHSZbiW9KTki
         vLnz0QTgqVEkK/sUfqPUdEQ4LqSDlCyhoN7ZziZ550HoFeZkBOWt4Rrbe5PL3krp3P/V
         gI5HU9y1jDt4bPj61zMN+BirKVDjdRy1Ft0ki7atZBptjLYm9qVTr34ho76TupAqyb4L
         2PFRsCJjSqbGRheAl6WMY6qitzyAxHTlWAjyOcVH1BZk3QsX30Dwt7OYRcYs2poU5ejP
         0wIQ==
X-Gm-Message-State: AGi0PubGvt011f0B30KOTlI9H9fij417RtbPmQUswjWVIkD1l8QkL5QT
        Lnm9fJAOM1f7Ul0pCM8fCvVy+g3/1yrE6mGMYyVRLA==
X-Google-Smtp-Source: APiQypJe0lx25S7QjgoaYFi3qKXzEyrs3gDvvOZ3Ap1l1/OFurhQRgWTFkufDg33aHoJs1d+5BYIMDv3FeHyoHdIol4=
X-Received: by 2002:ac2:4da7:: with SMTP id h7mr6829654lfe.95.1586669909579;
 Sat, 11 Apr 2020 22:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200411115459.324496182@linuxfoundation.org>
In-Reply-To: <20200411115459.324496182@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 12 Apr 2020 11:08:18 +0530
Message-ID: <CA+G9fYuC0s59WRDmBzy7gx62snosjDAX6EigYSGmvX+46cRASw@mail.gmail.com>
Subject: Re: [PATCH 5.6 00/38] 5.6.4-rc1 review
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

On Sat, 11 Apr 2020 at 17:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.6.4 release.
> There are 38 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 13 Apr 2020 11:51:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.6.4-rc1.gz
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

kernel: 5.6.4-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.6.y
git commit: 62251e4703ac6d416aeeec0bfe2af46dfa423a7b
git describe: v5.6.3-39-g62251e4703ac
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.6-oe/bui=
ld/v5.6.3-39-g62251e4703ac


No regressions (compared to build v5.6.2-47-g4491f12cfc6a)

No fixes (compared to build v5.6.2-47-g4491f12cfc6a)

Ran 31688 total tests in the following environments and test suites.

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
* libgpiod
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-ipc-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* perf
* v4l2-compliance
* network-basic-tests
* kvm-unit-tests
* ltp-commands-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-io-tests
* ltp-math-tests
* ltp-open-posix-tests
* spectre-meltdown-checker-test
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
