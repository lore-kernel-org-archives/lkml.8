Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6B5C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE593206B9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AEsQ8TC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgDTTN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 15:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725896AbgDTTN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 15:13:57 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09478C061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 12:13:56 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id f8so8967203lfe.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 12:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GZyFWRR965IjIXw8oEfhxd7ZMDSCPAh7CvEl6YVXZ68=;
        b=AEsQ8TC2nMUh0MZ+pASLBQqBmh1YauTumcgs9QVq410S7hu1vRBcPivKlukZptwrca
         X5PaZHx2/J5rDC0Gml57e9eFlJqN/cSr2fx0dT9iKYxqjud+ln/tdTKPcJFjYSQTk8V4
         87JHPMtXzNKW+f9+N4Ull/zXmUrdHjsut2tFvsdr6r2nFHJAfWNCmDBB+4cPrlt2nPxQ
         WcrQobkq2Kps0lT2jFQSSoEp0Q8NEIS9rLMVcTqfA6MWQ+qHuf7VeZoKdaCyAtoj8hrO
         4iP8wmYqxIqYhDkpn3ONEV8nzHOO8ANg/nhO8yM1dGncgQgcPQ6J7FPLzxbWstcBHMdF
         labg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GZyFWRR965IjIXw8oEfhxd7ZMDSCPAh7CvEl6YVXZ68=;
        b=qKaN8xSO3a8lWMMsji61zvo3bndhRKjCxkyul24Dzs8fsPs/qSrhX73GKM06k50ISo
         vJoLKyC3o0v2DRkH4ARGWDUO+Fy25cJoAF2kj+FZ04n1WCdiCtDp6VptWvjdllKmqOK7
         fLpEdQLlYu/pGHRwMeHxvfZcav+8wOrp4PMmLZLIdbsyNZkg+WUTxabwOawQMnSGAoyD
         rdYdRmLd0Z1cetKqK1Y9bduTEwo+x/Dd+I21hl7qpBgmOWUjQhpMjUxmm7m3YvNyHYiQ
         o9jiutSGckuR4YUYCg0G6Y5H2Uaq328kYWKlQqJWs5WBrxX9eCTnYR23pXgqN6/1CyPb
         v15A==
X-Gm-Message-State: AGi0PuYQxFun0ACvuVwaIC/JlXYPPOJ8GB3m8Mi7iZy1fX6VitsNc4je
        yLWHcjtBYH4Wvogh5qiBj4MAy5VCEUT0JPGcjKwVmg==
X-Google-Smtp-Source: APiQypIeS4XP76qqMB9uXJKcnoxD1hHd7lBsYnTAkx6QKrXADsmPEW5DmXo+4g1qs4MH2YNnJCLaOSpQIwCnjBDRadI=
X-Received: by 2002:a19:4014:: with SMTP id n20mr10922792lfa.6.1587410034394;
 Mon, 20 Apr 2020 12:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200420121500.490651540@linuxfoundation.org>
In-Reply-To: <20200420121500.490651540@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 21 Apr 2020 00:43:42 +0530
Message-ID: <CA+G9fYt=Cx5+0J=XTZvNXXgXBm7MgAqZhLMw2pEQdF0q=sr+Fw@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/60] 5.4.34-rc1 review
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

On Mon, 20 Apr 2020 at 18:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.34 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 22 Apr 2020 12:10:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.34-rc1.gz
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

kernel: 5.4.34-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: f969422316c773400cbec8d7fe672db7d4bb97af
git describe: v5.4.33-61-gf969422316c7
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/bui=
ld/v5.4.33-61-gf969422316c7

No regressions (compared to build v5.4.33)

No fixes (compared to build v5.4.33)


Ran 31223 total tests in the following environments and test suites.

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
* libgpiod
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* perf
* kvm-unit-tests
* ltp-cve-tests
* ltp-ipc-tests
* ltp-sched-tests
* network-basic-tests
* v4l2-compliance
* kselftest
* ltp-fs-tests
* ltp-open-posix-tests
* ltp-syscalls-tests
* spectre-meltdown-checker-test
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
