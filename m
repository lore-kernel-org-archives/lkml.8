Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074B0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8E23206E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LMu6SvHE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbgGHGiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 02:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729465AbgGHGiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 02:38:16 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37E2C08C5DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 23:38:15 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id s16so20733168lfp.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 23:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zRtYHN/dFZrk1ux8vnWM3v0UCwP4oOiGgHpRqcmPS8o=;
        b=LMu6SvHENu7qAl7iaQKssVUVU2fFV3prwXleYo8OZ2YOskTY+Uy0M+ixE/GbHKxR7g
         ee3lviZXot7ELUA0D4XSVDI2xfGleAqvtT6ZE3PKLhLX/5npgA0X5wOyxWJy9UlX3btl
         hbcdOSQRFMoYsGYT7CACpZElXQHC/kC/S3MxpuQj03ZMZjYLnBoN7tPwRkGFsfP23F6a
         zlrKPqp1k6UuQDS/gwon4SUlk9yyROrIMjWBY5KJ54xH5DN/b9QhGUKtobLqJTFuYMwJ
         N8HUvZnjFzLZezCFsj7ude6JfO9qGstU5mswlgmNyLvm74Q2BYBODXJ4XcwkRVI4Ydj6
         yFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zRtYHN/dFZrk1ux8vnWM3v0UCwP4oOiGgHpRqcmPS8o=;
        b=tx+aQkR9zPmRbN3Tc+rHGZnwXf8P3R3x+ZEOAFEXuXiymstK6/k65O+l7Mi9hKuSKq
         e3Csc4YSh+IXMJGMrv5yy9NaK3fLC9rhJyN7KXSKziUffZRgxrGYVh56C2V9W0AkrwTo
         3blW6XdCij/WtxvNsIHJBeJ4wp7vSO9y9tO0EVFzbSJqpIwZEWpF/SRrbN+pQIJoHaKW
         gk+15hn8xAMwuGHOH7+g1aYzC+NapIm6kYX7pBWw/ZZObrv/wC3IBlzFAnppZBOsSxJ6
         ENNnm/p1616A6Y+wkNM38cXDgz9YfnB92kGx7mkKQ1Ckf+cevSLoQGAe3p2L3H7toYTL
         YhJQ==
X-Gm-Message-State: AOAM530WMzeWGysICDIawEcem2U97PqdS1Scfrixwg6nP1/5hS2HPyXN
        R5HvEoLEutSCo0Wm4rNtBeJjsIZwyqSnrlOCgRkE1A==
X-Google-Smtp-Source: ABdhPJzrkBGWtHi5o2PCNj9XiCxc9fb7q7vMDN/uRp8F/piv6Qisru2h127HtJyN67/Syt+A8/DzyYEwHyYU4ujWjaI=
X-Received: by 2002:ac2:4db2:: with SMTP id h18mr35539733lfe.167.1594190294100;
 Tue, 07 Jul 2020 23:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200707145748.952502272@linuxfoundation.org>
In-Reply-To: <20200707145748.952502272@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 8 Jul 2020 12:08:02 +0530
Message-ID: <CA+G9fYuBk3qCrMv295RrzsXYYjR8ASz+fAeU3g70OzQmOpP_3Q@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/24] 4.9.230-rc1 review
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

On Tue, 7 Jul 2020 at 20:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.230 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 09 Jul 2020 14:57:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.230-rc1.gz
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

kernel: 4.9.230-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: e3bed594af79a41cf71d9942b412663a8c6b4fad
git describe: v4.9.228-216-ge3bed594af79
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.228-216-ge3bed594af79

No regressions (compared to build v4.9.228)

No fixes (compared to build v4.9.228)

Ran 29962 total tests in the following environments and test suites.

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

--=20
Linaro LKFT
https://lkft.linaro.org
