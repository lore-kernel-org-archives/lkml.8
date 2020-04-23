Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8ACC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 085D820728
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DQdZSTer"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgDWQFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729407AbgDWQFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 12:05:00 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79FDC09B041
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 09:04:59 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id f18so6739315lja.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 09:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hm2bR7NJE4YEd15tp6ZXOm1K8maVXsNNMYPSYBGCQdU=;
        b=DQdZSTern+IBZzJwVZXiyh/4VSSO/BdNVhzZMU+jA9jabJ1E7neFa3Gc0KHfg+qThG
         4mx7P9WXXTo9qMGYyWkglMEmm9zYCoiYWD+d3LF0gBHk8uEzihn91AtHvkEh4crkjE+M
         ijuVAcOYgB+PTNU+vXaL89vjCnu2N2jOnWUOpkccwzHr0qFpFXp3sQi1Fk5cRqY6cjT+
         zDk7i9QVa3qYuqx40sp/J4w7kVn068kpdJN/Ar5YeN2xgSXnI/VbTCfgcPZTtWbE6gRM
         tW94T6/i+mLhc+gfyqxyRXtE/WEfAnDRHRM+QFt5WUIwOjEBIYlbkSK3Ox788CjT4bvC
         fNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hm2bR7NJE4YEd15tp6ZXOm1K8maVXsNNMYPSYBGCQdU=;
        b=b9NQuHf4rl6LgW/9PLJPK9MFkxTbtq3Kk5JOnB84xpEn6Eod5nQHNOPPFG+U/SjkBg
         aMEBgngiu+ROd/hEmHwYx3OmGkFPM7PGDLlupmc1U6bx9zlwivPqLcIKt3yQlTGm3zzU
         XFJBV1GuwgRd1l9Nv1TzABnfO4E2s8koPpNWbJkZLevXUWCIKtnGs8QJyQ7MUl1gqzpw
         bMZbPFM3EgEScMohfUUmmBHvzKMPVB8zfY2IIO7nJTCswkhT3WQja1hIZXMrczfNueKA
         TozHrh07tYd3Pp1e6xXLAGiKdIykNFPpFr/sEcB1pE17c3ZLp1/3o8P/xF4m4HqcCQF2
         WktQ==
X-Gm-Message-State: AGi0PuYHc8t08To38pFmqEDo0n8QVs+8633vy7hBtHu7VaRvfXttR0D2
        v9l//mv3219/RhEKDQ4iChrIAf6q64LqbitEhrGOBg==
X-Google-Smtp-Source: APiQypIjBtFiqqA6Pm5Jvx80O9Av0E7JPyhm04I1pKSOhf27DjgRDj4v/wh/5hQ5sDhTJO7NzNhiZXmXtCuIpECz0nU=
X-Received: by 2002:a2e:9455:: with SMTP id o21mr2841437ljh.245.1587657897926;
 Thu, 23 Apr 2020 09:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200423103316.219054872@linuxfoundation.org>
In-Reply-To: <20200423103316.219054872@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 23 Apr 2020 21:34:46 +0530
Message-ID: <CA+G9fYsX4-vcoVqp-vjD+LLkfDT18ngM=QXs07xrCuUBgYf7vw@mail.gmail.com>
Subject: Re: [PATCH 4.9 000/124] 4.9.220-rc2 review
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

On Thu, 23 Apr 2020 at 16:04, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.220 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 25 Apr 2020 10:31:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.220-rc2.gz
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

kernel: 4.9.220-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 01b8cf611034623c2ad49e23a48b0b99231b708f
git describe: v4.9.219-125-g01b8cf611034
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.219-125-g01b8cf611034

No regressions (compared to build v4.9.219)

No fixes (compared to build v4.9.219)

Ran 28201 total tests in the following environments and test suites.

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
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* perf
* v4l2-compliance
* ltp-commands-tests
* ltp-containers-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-sched-tests
* ltp-syscalls-tests
* network-basic-tests
* kvm-unit-tests
* ltp-dio-tests
* ltp-io-tests
* ltp-open-posix-tests
* spectre-meltdown-checker-test
* kselftest/net
* kselftest/networking

--=20
Linaro LKFT
https://lkft.linaro.org
