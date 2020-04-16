Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D22C3815B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 18:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 291B321924
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 18:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vjGtAumv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388163AbgDPSIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 14:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729050AbgDPSIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 14:08:00 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675BAC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 11:08:00 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id j14so6301026lfg.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 11:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/jeBVrKCSTz6BXkemvfuZzibOp/NI30GK2F1rleWJg0=;
        b=vjGtAumvfCtlRH6CAP/IO6Lap1bsQ2dTI3kRVDElmxEhvW+u66SIvtvF4cykEmiELV
         C2hRodFA6KCf/bIIaMhxpRm+QlZ51KL8OwsuqAbrUm+AEj3JT+/IBxpze6KHYP4ka4Mj
         V9ugTNcW5Cwbaax6NbR1IhXJtKdGPasEXfwF4CVmDS9PzDVa2zIkds2NHNWV/78XNzi/
         j2AHUAxyAkZk3oYwm6VZ6qik0+jGikyk802AIthfVwYZcYjTp1hbo+nKGOIx1VYigq5Q
         6eSsQwpcPediLoNTZcWv0iQvYzO2GQ9AWhrlEK+Pr9R6+0XeL8SwupStrlg2CJqAQasS
         7wbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/jeBVrKCSTz6BXkemvfuZzibOp/NI30GK2F1rleWJg0=;
        b=FjtxroxpdUKevX7r98UsIFVW2sxJh1MCX4ZgvzLjTtoI/phb4qu+BL+lieQKKI2qIN
         ccRp39+tFzjR4CGGtoSLuw0Dq1ttksi9IiTr4gNn6AfDSSXi3MJ5bvXVgYWnT0CrHNbl
         Vz3trMQhMaGGUdvfx8Gf7ZitVGrhkuiA/w+LvaAtaWnqBpCky3SEBSSFcTcu28X9fc0V
         x+u+s6+Gt2p4934bMLAdsPcSsd8n3NOD+0IH59pndIJ4LGwMbNLyygU4CEIRW2ERpE25
         VPFpCMO4caUV3kft7CfrRYyLVgnpKcSaIWmv+IWS8ZDHlKLUeGb7P3BgBPCh7W9DUR71
         ElFg==
X-Gm-Message-State: AGi0PuaSrCUcY2X07yPzT0jgFTjDLckLNgHMp9Tvz3fDIpCXcNO9DF3U
        mF4vHTMwKYJ8I9iJcOM1zEkqVcgraqpv5Rh/fVcX8A==
X-Google-Smtp-Source: APiQypIz1Nyt0YvK5h9ya5Ont4Bp/erVWj19vId3QI1k/cHk1N3ALIIaOb77r4ac04xrwFe3OnMJV0bWrWCZRgvd5oQ=
X-Received: by 2002:a19:4014:: with SMTP id n20mr6483217lfa.6.1587060478709;
 Thu, 16 Apr 2020 11:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200416131325.804095985@linuxfoundation.org>
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 16 Apr 2020 23:37:47 +0530
Message-ID: <CA+G9fYtm0vpovNM5exU69WnQxpa3LHaumogCE9V8BCHgdcFr2A@mail.gmail.com>
Subject: Re: [PATCH 5.6 000/254] 5.6.5-rc1 review
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

On Thu, 16 Apr 2020 at 19:26, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.6.5 release.
> There are 254 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 18 Apr 2020 13:11:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.6.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.


Summary
------------------------------------------------------------------------

kernel: 5.6.5-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.6.y
git commit: 576aa353744ce5f1279071363e4a55e97f486f39
git describe: v5.6.4-255-g576aa353744c
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.6-oe/bui=
ld/v5.6.4-255-g576aa353744c

No regressions (compared to build v5.6.3-39-g62251e4703ac)

No fixes (compared to build v5.6.3-39-g62251e4703ac)

Ran 33508 total tests in the following environments and test suites.

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
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* perf
* v4l2-compliance
* kvm-unit-tests
* kselftest
* ltp-dio-tests
* ltp-io-tests
* ltp-open-posix-tests
* ltp-sched-tests
* network-basic-tests
* spectre-meltdown-checker-test
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
