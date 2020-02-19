Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE50C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 04:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0542176D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 04:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ak0EhH9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgBSEal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 23:30:41 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33701 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgBSEal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 23:30:41 -0500
Received: by mail-lf1-f68.google.com with SMTP id n25so16284758lfl.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 20:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tQXOB00HBxjlzLO1qBfpiT28gt4hbjnIniViFu7T9VE=;
        b=ak0EhH9NegZGX1HRgkqHtQ4Za/pV23poGMO4T/Fho6K0wcTs98gVsq9Sigrxe5XCz7
         HE8NsMbkmfRaK1eeAt8eFLq9N2brfYRPBhqodEg2AdvXEEtstg4T/JvhiwikB81TCp39
         MDjldQuqNqYNmULS1K0+GeErj4LA7dSTvAlStHtOPIor4fVtrYQGAQjdWADZG/PupVm8
         6cIjVKmMyyPEbY8zQgHYGZMF4irYAlDR7vkauIk28sCOMIeJ+Wf3bfA3ttIh7jiMZ+zs
         Lig1bfIGcLepw6ND7Wry8deiy0zuM7Et9Z/7r8Jgoe7R3nemiR8gBA4ECMCRkn1/IRa7
         /9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tQXOB00HBxjlzLO1qBfpiT28gt4hbjnIniViFu7T9VE=;
        b=WO8thtw5EZ7n5xEsBLkd/49pP1aEDOWOFo8+Ak8uCMY50yu/l384tEqUQDcsM67/Bx
         smFV0LnImXMzF9lo6It3aeD8iuZmqN9F/RO45D9hkjdGOE1EVmytZD4qiv4T2zUqPl5/
         O6ynJ4o+yGNgdR/gDtV9O7vdYmX2j6DYUMdAwZSEmXV/7wWNqbsSy4igyCJ3IRFw5tiC
         nsW0VuFWOqhcOD8FBBJxuisjymxvbCPekQwhn1NwKS/L4hQqax/8T4cbcsfoJOcwcITe
         hlj1CXjjifj+mOhY9AprtupaIebOoVuqYq/opb4QS9GSKlDDV2bG2PbJgjaBDe48Ta9Q
         G+jQ==
X-Gm-Message-State: APjAAAUpn5AY/cgJkz1g7zmAXsFcwvizj/Aec/2ggwx7orTMpAzFb1If
        jOrFS8wKfsYxyyKkjBe8ysW9i6549CVD1MturDPn4g==
X-Google-Smtp-Source: APXvYqyLgDrO+3jdNQ+nAazEdXoFPGbWzoQHMpqB4gMdDjJMeDO3qc0V8Mlb2HQoJ3frrLqajL++1lC58qSakIp4YGE=
X-Received: by 2002:ac2:5b41:: with SMTP id i1mr12288609lfp.82.1582086638894;
 Tue, 18 Feb 2020 20:30:38 -0800 (PST)
MIME-Version: 1.0
References: <20200218190432.043414522@linuxfoundation.org>
In-Reply-To: <20200218190432.043414522@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 19 Feb 2020 10:00:27 +0530
Message-ID: <CA+G9fYtcyGqf=L3nwt6Qfm6O4CeCVCwYqYrQcLwiB9DWVrY6hw@mail.gmail.com>
Subject: Re: [PATCH 5.5 00/80] 5.5.5-stable review
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

On Wed, 19 Feb 2020 at 01:32, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.5.5 release.
> There are 80 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 20 Feb 2020 19:03:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.5.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.5.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.5.5-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.5.y
git commit: 8aa3a43b129c3b5516b2310f4a93256da87dc711
git describe: v5.5.4-81-g8aa3a43b129c
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.5-oe/bui=
ld/v5.5.4-81-g8aa3a43b129c

No regressions (compared to build v5.5.4)

No fixes (compared to build v5.5.4)

Ran 25790 total tests in the following environments and test suites.

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
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-fs-tests
* ltp-syscalls-tests
* ltp-open-posix-tests
* network-basic-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
