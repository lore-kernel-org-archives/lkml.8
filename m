Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE78C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 263EC2072C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QxlCezIM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731921AbgAXRSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 12:18:49 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37207 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731739AbgAXRSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 12:18:49 -0500
Received: by mail-lf1-f66.google.com with SMTP id b15so1621487lfc.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 09:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GGYB6jueNzLWlzDitXtevx7ZQ7yH7Ug1+jvT1w8K0OQ=;
        b=QxlCezIMXJU2YkAbdVDQKpQb4nJ7CkAZKu+LFvDeNyff+P0KqUExZjeTOqm6PSH87v
         tLNT1qMhznurTS16F5d4kgJVvMzNH4XaqRSmJrxgKHbAMWT6bsujqR5THdDDRMfDZzGC
         0yrtL3YmJ9HdAoV9iGp1n6hJbjMXuOOko/idoDsBSUkZ6xprD0CA018k1lMPuP466GP/
         vEUrvgR+bGjGT72lScwdloo573l02kGaBr+3rY8dgCkJ5UR+8mLHp5s556I5ROMStn04
         O9+Zj5Up560+OkkRymhdydHrwWpzZaMs1Sr7fvp54jhRDPl4cuxbaICpBHMTLrpK9c49
         ojiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GGYB6jueNzLWlzDitXtevx7ZQ7yH7Ug1+jvT1w8K0OQ=;
        b=W88A7jHc1CTG6rVXMZ5k3wBynAkTbcm7xduTIUGqprd18iYRWBINdhQYGQ+7fofgQw
         4bJVAGuWR3XbpPCXoiknM96tOgzlhz0055Jc73+zT2CI9Mc3HnlJvT2vhUpVx7r6QCBq
         vKZUbXXPyS2tKiLnzK6Q4lAVfg9Y2FNAl3ks4OQNH7vQQsd2GOS3ZRlFrVJDdhuphxoQ
         kyFQIUHdlmyi12Vm9MmRacV6uWwHWo+vac9PnZb/tgra9AVIF88OOGtIUd0izNVXO2D4
         tllHKdvkXlX3/gTh/OhPzdYUQZlJ1gFVdM71jWJorM2ltZGDbcnKy9Wm1/FNLXAusERA
         RUPg==
X-Gm-Message-State: APjAAAUhwVcwmZphACZu6ZlQt7ThQ1+xu4EHmw6v8XQJorNdFkBt09D6
        mzjporZOAyMrHGlAFTQ3M+E1cU+hYZwbyUE7f9jK+VFoVcA=
X-Google-Smtp-Source: APXvYqzTZIrbrs3d7PShNVk9imhxRJTbJ4cw3aSNA1Hig1k0j4P+eWe9ts2FI9mOG102SbwHaGQD6JFXKcIsZJV/Jis=
X-Received: by 2002:ac2:59dd:: with SMTP id x29mr1822640lfn.95.1579886326583;
 Fri, 24 Jan 2020 09:18:46 -0800 (PST)
MIME-Version: 1.0
References: <20200124092919.490687572@linuxfoundation.org>
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 24 Jan 2020 22:48:35 +0530
Message-ID: <CA+G9fYvBS+VcFuanjpKf+UgNa1Z=_Ctk1jGcZezVNtWRzpXSKA@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/343] 4.14.168-stable review
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

On Fri, 24 Jan 2020 at 15:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.168 release.
> There are 343 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 26 Jan 2020 09:26:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.168-rc1.gz
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

kernel: 4.14.168-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 44ca37a00ad6e970111780ebce3b3b2b127ba3d6
git describe: v4.14.167-344-g44ca37a00ad6
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.167-344-g44ca37a00ad6

No regressions (compared to build v4.14.167)

No fixes (compared to build v4.14.167)

Ran 22734 total tests in the following environments and test suites.

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
* install-android-platform-tools-r2600
* libhugetlbfs
* linux-log-parser
* ltp-containers-tests
* kselftest
* ltp-cap_bounds-tests
* ltp-commands-tests
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
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-open-posix-tests
* network-basic-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
