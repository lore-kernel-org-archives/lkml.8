Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BA8C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 03:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E70E24655
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 03:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V2kGHxSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgBSDeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 22:34:15 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38729 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgBSDeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 22:34:15 -0500
Received: by mail-lf1-f65.google.com with SMTP id r14so16168369lfm.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 19:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TYt7HJjvktLwYF5fWsjcRqKlBg9s9ySi5xDNucBdwwM=;
        b=V2kGHxSpVquxNbLsrIA4Tc8X0T0dQK8oblbDB63inYvlFgNXSQrjgAGT5vP3BQoMWu
         wUgyAd+JyD3fsz2NRRMnbOxsND22Z4FVr/Tb886Olr5cKqxgc59jsYDtdhBrxoeYyE7B
         syLOnxQkIOj/VbJBqYyShP1jm3e0aIsyXshXWfmDmtz05T3lEaVu1lkIqfzfzOfpFqqM
         ZRJVgtUsSU+ZLXrBDI5kwkuZCgAHMg59c/lzlRAmlt+ELnc67H1WApvcLKQQu3gC1QtQ
         B5HJTw7Wt52jYDhDvkFAd3rKhHwljQ5kN426zY0iBoRogMSnOxDd/8mRrS7RbTNwkxOx
         OCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TYt7HJjvktLwYF5fWsjcRqKlBg9s9ySi5xDNucBdwwM=;
        b=OuLJCzVWq0HcmpcMV3T8XMn4v9aaumS+6tlXJZV2sV7zLXXOtohDw7Hjh3rE4GDQmI
         q8xj+xduciXGMJMneinYPeXJ7ZOlgD6ETz4MmBSD14em42x5IZy4XJhxI9pqR4s9FqWM
         LBr06ItfgzXgXnM0/pfXTHNZw3LAWH/g+dip16gU47MG4KxXAqgZ37hyp6N+1QAei8cw
         bt6HwPSjU7o1oGyxst78/HCBFT35XeV+Add6wX5zFyoSSPGr0l1zPTzrpUCt+6pFnYMX
         ryJ9GCcJo75UDMIzv+Z3ievZwREYml/ASOcgIiMH8kQ1ujA0fvJr/sqvZphSm5NYpHCh
         0ceg==
X-Gm-Message-State: APjAAAXFMm4OXAMXANZNIR49QA85IwDKVJDN9Hu5bNuwAlIR02y7dZOB
        c2+XHfcyRexwGWTsC+s5w+NNqwZWpRkCJ7S2T2FPSw==
X-Google-Smtp-Source: APXvYqwvVYTdTd/xkQkW7M6vEezu20MskC8zCQh/UXfXhkGWKW9ijfCSFt8ZFACOfhqPHeFSpss0pRG6zZbylyWTw7U=
X-Received: by 2002:ac2:59dd:: with SMTP id x29mr11952854lfn.95.1582083252806;
 Tue, 18 Feb 2020 19:34:12 -0800 (PST)
MIME-Version: 1.0
References: <20200218190428.035153861@linuxfoundation.org>
In-Reply-To: <20200218190428.035153861@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 19 Feb 2020 09:04:01 +0530
Message-ID: <CA+G9fYtZeFz4mX2EW4yhT4vwTM+SBdDSJH=ZRvV4Lg1pQ0W0_w@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/66] 5.4.21-stable review
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

On Wed, 19 Feb 2020 at 01:28, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.21 release.
> There are 66 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 20 Feb 2020 19:03:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.21-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.4.21-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: 70464966e42b69820bd71947631574b2d9f13ea6
git describe: v5.4.20-67-g70464966e42b
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/bui=
ld/v5.4.20-67-g70464966e42b

No regressions (compared to build v5.4.20)

No fixes (compared to build v5.4.20)

Ran 20055 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c
- hi6220-hikey
- i386
- juno-r2
- nxp-ls2088
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15
- x86

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* kselftest
* libgpiod
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
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
* ltp-sched-tests
* spectre-meltdown-checker-test
* ltp-fs-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* network-basic-tests
* perf
* v4l2-compliance
* ltp-open-posix-tests
* ltp-syscalls-tests
* kvm-unit-tests

--=20
Linaro LKFT
https://lkft.linaro.org
