Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3084C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A4942073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VAmfbwNx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgGUKOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 06:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728542AbgGUKOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:14:19 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE913C0619D8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 03:14:18 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id k7so10092060vso.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 03:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kJbvVyFR0zBM0W6pL7x2QodtQCSEVZFmvI/ayR1jEiM=;
        b=VAmfbwNx78HIjPOEY6KPwT+mitpscRmnbWMT3CHqSw5yTZL+oY7yh1aS+7zl15UKOf
         hYvauov0RMX0l2WhE3gCtcFyWMDCf9JHBxMCQ54sBOcxHElrSoLpx6lnB0MKgEfN50QB
         DjCbz4ioWW8wjyp9X7TJqbbAXKXQJi+ko7sV/sYPP27USFe5aEnzDUEFOJ3Vg7edA+rX
         4rYen/NwBLgAVpbFuxp45tldd3YakoXMgEjkHAcke5HBXrdgP5+1ZtoQhwKJ3iFP8l5c
         HOCne9nProItLZy3P3d8a0zjfrEzSO3xONe3xlqC6a3aw1RnlDauBOfAz4TJeDr8c3Ik
         i/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kJbvVyFR0zBM0W6pL7x2QodtQCSEVZFmvI/ayR1jEiM=;
        b=TRvu8av6RuQMo3VjSdMf1FHzrp6PmMJdx/YVmh6ynS4saKUK7VzEPyZ4jNC4ahQiia
         6C+tMvvMnQ6/xG0NFOErCtjXc1T258Ggvcg578+JDEa3yQkXGJo3q/QUwA43QlS6XSCj
         EcuHHY5xZFrHAmdumRS3R7RlqAUM2YSrpNKG81Gs6ZTAxKHa6jgNwBQv7mWT5YSEF7n0
         bl8KLXBDcJrmTpI9JiNL9BuH18WeRn+RgaCUnQ99rBdms+Fat+l+F/0wJ3R3CHQOHQV2
         80Jt5FYaWY7cDgYrbADjhQPW56DbCkn1CzfVk8sboFc9WruokmyHwM+fi3n5akMBME5v
         yC5A==
X-Gm-Message-State: AOAM533CiThdYIw0/cUCqHwNf4e50NjP7ttdx7Sf7yS2FweXY+lYiMeP
        nfa91DyUBo8nepWQZbLCJNKYPMLm1LvzWn6F6D802g==
X-Google-Smtp-Source: ABdhPJybBxh7oPQBEUeVlR1/9qabatxAAH5T/waGnwu/y7utpbXUUDr92LbJRzWXF+u1dwzjq/Z2zRIO+9n8TCY0q5o=
X-Received: by 2002:a67:2d0e:: with SMTP id t14mr17738559vst.22.1595326457883;
 Tue, 21 Jul 2020 03:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200720152753.138974850@linuxfoundation.org>
In-Reply-To: <20200720152753.138974850@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 21 Jul 2020 15:44:06 +0530
Message-ID: <CA+G9fYvp9z0ugV7hb0dr+B_GEX7QK_T2QJ2hyDvwnAcq05arjw@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/86] 4.9.231-rc1 review
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

On Mon, 20 Jul 2020 at 21:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.231 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 22 Jul 2020 15:27:31 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.231-rc1.gz
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

kernel: 4.9.231-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 8c3f33eeb0cc6d2603144f45d841ed8f966dd728
git describe: v4.9.230-87-g8c3f33eeb0cc
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.230-87-g8c3f33eeb0cc

No regressions (compared to build v4.9.230)

No fixes (compared to build v4.9.230)

Ran 34431 total tests in the following environments and test suites.

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
* perf
* v4l2-compliance
* kvm-unit-tests
* network-basic-tests
* ltp-open-posix-tests
* kselftest/net
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-native/drivers
* kselftest-vsyscall-mode-native/filesystems

--=20
Linaro LKFT
https://lkft.linaro.org
