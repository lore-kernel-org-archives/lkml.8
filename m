Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFBCC33CA9
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 04:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37856214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 04:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hAmHcKkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732191AbgALEzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 23:55:21 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35403 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732179AbgALEzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 23:55:21 -0500
Received: by mail-lj1-f195.google.com with SMTP id j1so6386460lja.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jan 2020 20:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e3re4IXkyyw/6+2ZpdvvKRwtPpdPNGOyATLsdF0oXqM=;
        b=hAmHcKkru7Ws+bYPtWoibuV5UJ72IuF6dgWGL5tJuMeheEKvkn+UBiWpIq8J4qR0mW
         uCJjZnwGvlY+QCH/RxCwWGPK5SFHCcFUq5GvYcMjwrQcxaHDsh7bDcwhvgeHrGZseHlN
         gACfjpW7OPENtY9heTGfHC5M/UCpS8SqRHwlfEGTMCqCRb5YLrhTr3NnJauFntM4LhRG
         LJRjxaN/8Op3CUFo/93QTWC8tSBTjx7Dx/fvUe1VEQCJxDUK5LuSFEh6lROpm3cpRbM6
         WXYkoM4Q02P/7ZWw+dNGXv1lG0t1QwYJVufPr4j4sdekbmMV6xYT7hr0C2wekAh2miNh
         Jlug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e3re4IXkyyw/6+2ZpdvvKRwtPpdPNGOyATLsdF0oXqM=;
        b=NC33+/oQu3imtvmy1HTLRsTztWU+vvv5PByd/7SEq+34Q5snHG+Dt4yMLaEsekU0pD
         nScgxKWs39M9kswM7/PFMxt0+zzK+2Qk+C2i5+OePHA/GPnasQHstcIZS4ooSGi69Fgx
         UEScBC0YXJaNHUcMw9gsOetb/shspL1bxECsy4Vq1oqiA63zhQ8rlJhRtkGpar0bVyos
         4ILl2EApJ6VQ7h30p3XCMJRK5zEVF5kZkhqPSjFbESSJ0qXU/M9zSAgvWpIilMIhhvAg
         rVpb0BM/XyuKUndj2RPjy0+1sPiCPFN+vFUbmII4LjZaFLVVqn795iCtPpLM2srVOsZR
         MgIw==
X-Gm-Message-State: APjAAAWE3UuQd1i3v1AngtZFwapT0zJ9L0pQRZklUPYuUbw+Pl4flj3n
        pBLLgTNl9vIm8F+AwYBEM0MoEKOnW4wIeD/iX5EqGg==
X-Google-Smtp-Source: APXvYqyWXRnqElnMRXdT/2ppNEwfNstxcJF5mmLRZ6EnkTVr4weuScXNYSC42S6L4+iVxmFc4PHQVgRO4GteHdVJHmk=
X-Received: by 2002:a2e:b017:: with SMTP id y23mr7516131ljk.229.1578804918969;
 Sat, 11 Jan 2020 20:55:18 -0800 (PST)
MIME-Version: 1.0
References: <20200111094844.748507863@linuxfoundation.org> <0668a7b6-502b-719b-a2eb-59519de7bf3e@roeck-us.net>
 <20200111175114.GA403776@kroah.com>
In-Reply-To: <20200111175114.GA403776@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 12 Jan 2020 10:25:07 +0530
Message-ID: <CA+G9fYuwQW1qqTSdYTCc6es5R6AJ6zHScmw1952raHHJ7x+uNw@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/91] 4.9.209-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Sat, 11 Jan 2020 at 23:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Ugh, I thought I dropped those earlier, but they came back through
> Sasha's autosel.  There's another build error with another coresight
> patch in there too, looks rare enough that your scripts didn't catch it
> :)
>
> I'll go push out a -rc2 now with the offending patches dropped.

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.209-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 0dd28c11952d3a45280706afe87a14db95f8cf21
git describe: v4.9.208-90-g0dd28c11952d
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.208-90-g0dd28c11952d

No regressions (compared to build v4.9.208)

No fixes (compared to build v4.9.208)

Ran 21877 total tests in the following environments and test suites.

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

Test Suites
-----------
* build
* linux-log-parser
* install-android-platform-tools-r2600
* kselftest
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
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
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
