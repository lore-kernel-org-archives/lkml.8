Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46F4C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B766420720
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eAcfRzxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgA2FYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 00:24:13 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37854 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgA2FYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:24:12 -0500
Received: by mail-lf1-f65.google.com with SMTP id b15so10930793lfc.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 21:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3LtlN808L/eCSbIBoZuFWZkXYkhY8RQIoVO6UQH1e2E=;
        b=eAcfRzxtPLrP35bNQsSw+ImsilucwpYXka/5rc02WJqVXvNR2JDnLBaZddzjpcCMQX
         C8fAPpxqinvkP/iFe/kOsxYl2QLNaekJWsrDszFbilfj7emdGwvAQOStzJH5PHGJ6Wmb
         5g1d6PGvnwrPsWHtYA6uHy38CIvBUNXDspgUgePniIg87yEHTdkJiXF9s7UatU2I7Wz1
         XS3zwMWSuvY8jnDgrUO5KQi/fMeT/ND0TrsBm5+m/Myy/z9jzxnX38L/mp+JvXJtjdiR
         f2xWkL2nCEQc5z/INZqAOrAkqGv++EGWgOtr6PsQS8aIhd2+iJs1/rTI1ODlL7hYnEHX
         uoaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3LtlN808L/eCSbIBoZuFWZkXYkhY8RQIoVO6UQH1e2E=;
        b=cgBdFrU78iBTJaFKoR4Uf4OeaP73w624pjtAFUzg8szT65tliqqcP5YGUzzAJz9Wad
         5yDyUENA2iWN9zy67IAUHCEO7GnH4yF9KileEXqqojq3yTSfoDS62K7HT1pS1T8JTeGw
         DSVW1qsYrQDFJSoR6hBTfJ3oKdp3UckssaDL+fDH/G5yovA3uTGsTnM44QARnO9if2U/
         YwDjOnWEtp7MSxn6LqnfXWlPf5sTmcPvG+CBw6d1oS6oRheg1kT/tsdO8udEfNvecsV8
         eLkpwBGT2F12uREzC2wkD2IvSlgCs+dAmtq/w4ebNhOLOj30WHkjOIE/hLzTVJoCmU9i
         xgRQ==
X-Gm-Message-State: APjAAAUsug+SMTTAkmnggPS4p6CV5Cvd8+j4n6q8fuS+kjFvh42gRq+r
        1lVizxYdmO+VreN2boI6Tb7ZKEPCkO4nnUl/7i0l6g==
X-Google-Smtp-Source: APXvYqwwA7ZrSqc9LfOKonkJ6y8BQLNlPN2DFVLvqiuvKtRb97MAB9TuY4RqV1wSfz6TdIpOCtcbUgcRA0i10VfcdC0=
X-Received: by 2002:a05:6512:64:: with SMTP id i4mr4470456lfo.55.1580275450572;
 Tue, 28 Jan 2020 21:24:10 -0800 (PST)
MIME-Version: 1.0
References: <20200128135829.486060649@linuxfoundation.org> <20200128175119.GA8176@roeck-us.net>
 <20200128181435.GB3673744@kroah.com>
In-Reply-To: <20200128181435.GB3673744@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 29 Jan 2020 10:53:59 +0530
Message-ID: <CA+G9fYt66SB2RtYz2uE=5tDKJEtoNLRjvocUv60NgN0E-SUJZQ@mail.gmail.com>
Subject: Re: [PATCH 4.4 000/183] 4.4.212-stable review
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

> Will go fix this in 4.4.y and 4.9.y and push out new -rc2 trees with

This is 4.4.212-rc2 test report.

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.4.212-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: fc5b03776f2d3b13543520d5a61a0c56ee4d1a5f
git describe: v4.4.211-184-gfc5b03776f2d
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.211-184-gfc5b03776f2d

No regressions (compared to build v4.4.211)

No fixes (compared to build v4.4.211)

Ran 18829 total tests in the following environments and test suites.

Environments
--------------
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
* kselftest
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
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* perf
* prep-tmp-disk
* spectre-meltdown-checker-test
* kvm-unit-tests
* v4l2-compliance
* install-android-platform-tools-r2600
* kselftest-vsyscall-mode-native

Summary
------------------------------------------------------------------------

kernel: 4.4.208-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.208-rc1-hikey-20200101-645
git commit: 45aaddb4efb9c8a83ada6caeb9594f7fc5130ec3
git describe: 4.4.208-rc1-hikey-20200101-645
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.208-rc1-hikey-20200101-645


No regressions (compared to build 4.4.208-rc1-hikey-20200101-644)


No fixes (compared to build 4.4.208-rc1-hikey-20200101-644)

Ran 1568 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* kselftest
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

--=20
Linaro LKFT
https://lkft.linaro.org
