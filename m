Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46F6C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 09:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BB42072E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 09:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="coGtTAGe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387728AbgDBJ3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 05:29:36 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42042 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgDBJ3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 05:29:36 -0400
Received: by mail-lj1-f194.google.com with SMTP id q19so2443755ljp.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 02:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A1N3cjpRhyvHKi63+qWeoH/cQuETGSuu6i+0dBsDHIQ=;
        b=coGtTAGeaDc78YWEsJNTZMlDsZCaIbylMttjom5Z70YBE5F2k93ON4BQmZoI51qBSG
         Hj0XLtAM56EEd0rs1R7c2WCtJ6zviwyxaKNTZhLByT0dOXstrfFqsaevsvjydwXAat9q
         gJp4Wftj6vxGKAJCls1wBulguntnRPWkhv5FmRnZFYFhAAyaFMojePw74yt5nlGTx7UL
         dZn036XZYD133ygBTMEcXuml8pgVxNUXm/39S7YnF9Y7abgqKcwwyOJmHb6COE6ILVri
         wDr8i4GYaN52bp0ny9O1c6iycmUFr5GTvPzKFF2Ff2Tt6bwT7q4Skr8jVj5TN/bw7ukq
         VemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A1N3cjpRhyvHKi63+qWeoH/cQuETGSuu6i+0dBsDHIQ=;
        b=O+oE8O6LPmbXJv5b/er2leRxuKBppq7WZj5M7qgNUmyKvkAsn9vhoJF3pCTJa3cguA
         wrb4KOExINLmVrhH3NcnepMLQf+/A9bLCHK1i0cIWQ1UBFqeo9nWQqSkiqqXE59uCx2n
         BhqYtYDhJHC/UdJoV2O0424sBtftRxrt6fM6szM5W7/qfNqvHU+IE1viwecxF9Ydmfyi
         QeYw1kB+9nI6ifTxNQzNvqLm6RUsKC1cBsDyq5ij2PD1lRHqe7OSLPvuSjwA097Qv3Zr
         mC78VADEYGVdLW8FCMV0YhNfxx3tiA8b/FFRqD8q7Q7BEdwlWcQ9+Czts+Df2jDTcIk8
         aaZQ==
X-Gm-Message-State: AGi0Pua2/NPv2W9F3qHHwPMWjbx6M4IbSknp46CSmdR8fcPSEJJbQzvO
        jkZzgheiDcDa/Y9GAPwR5n4wk9XjjeyOsWNgoZrfRj+Mzu8=
X-Google-Smtp-Source: APiQypJWbdvAHJJzctAi4UyRIqkykag4Hkn+oWpwV6OQZaBcStgupVm0wiJY4b3xonLdhHFBVGA3hi7c2RQIXHJdrCA=
X-Received: by 2002:a2e:8015:: with SMTP id j21mr1388436ljg.165.1585819773640;
 Thu, 02 Apr 2020 02:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200401161414.345528747@linuxfoundation.org>
In-Reply-To: <20200401161414.345528747@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 2 Apr 2020 14:59:21 +0530
Message-ID: <CA+G9fYv0bGh3y3y=yswry_n63F9dRzQbBwNUrHS9AVteqV5+NA@mail.gmail.com>
Subject: Re: [PATCH 5.5 00/30] 5.5.15-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Apr 2020 at 21:51, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.5.15 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 03 Apr 2020 16:09:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.5.15-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.5.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

NOTE:
kselftest: bpf_test_verifier: PASS
with test case fix patch,
Daniel Borkmann <daniel@iogearbox.net>
    bpf: update jmp32 test cases to fix range bound deduction

Summary
------------------------------------------------------------------------

kernel: 5.5.15-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.5.y
git commit: cd17199418ca9a1111bd23641def9c0f3df0dbcd
git describe: v5.5.14-31-gcd17199418ca
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.5-oe/bui=
ld/v5.5.14-31-gcd17199418ca

No regressions (compared to build v5.5.14)

Fixes (compared to build v5.5.14)
---------------------------------------------
  x86_64:
  qemu_x86_64:
     kselftest: bpf_test_verifier: PASS

Ran 29621 total tests in the following environments and test suites.

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
* ltp-cve-tests
* ltp-hugetlb-tests
* ltp-mm-tests
* ltp-sched-tests
* perf
* kvm-unit-tests
* ltp-dio-tests
* ltp-io-tests
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* v4l2-compliance
* spectre-meltdown-checker-test
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
