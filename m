Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD63C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 16:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 859C920772
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 16:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RIMhhhmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgFFQMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 12:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728836AbgFFQMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 12:12:20 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89624C08C5C2
        for <linux-kernel@vger.kernel.org>; Sat,  6 Jun 2020 09:12:20 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s1so15456608ljo.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jun 2020 09:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OG5llYWkn5ZpZagpX7W+tCCaDr6jjTc5m5YMMo8l7Zo=;
        b=RIMhhhmoI8UwYKTaRLxkh0h69EFG+8vPgB0xAZcBNFa4lnNxKESC4KSXBt8gFrhAUE
         Oi+JRFdXlVPE34BG7/HmvYmzlnC+hDguRK/3Xj+fX/PSPcMnlccucMCKj3+aODceoNyE
         ypeL5bCX59z1VGqnVEkm5Cvy1e6gj0CXNxmJrezyXpcb6OJwFAwfVV2MtNqUk162Pjez
         7O9akbngW5USEJsCP3ZLJOHqa8N2maMpTB/bobZ5wK/F+qoXkn/SIDO/GEslzgB5+r1X
         NnR/t82w4yUl3Mu1uOPLVDcoZuhkJYXBfjnhcAn3/wMgF24LKVjWlHWYpH2shiAhSX2d
         3whA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OG5llYWkn5ZpZagpX7W+tCCaDr6jjTc5m5YMMo8l7Zo=;
        b=gSaMcJdkI7f58JSxei07/Oc8DvtW7HpbhC5/M7FPjfm0I1pDpeFGLUaXBe+382vajh
         vp93bs0LN7mS1SnPXdGhxuWmtb9x/DbSkb+UJZ2zQW41XmFwHv5C2+vC4XegyinXG8lJ
         LZuXDEHEbeFtiRvvocPju6pC+4TnJ//9apflhwLTM+Peds3b8LK4zZpmflLzlEL87e/W
         uotRTt8hyky8xNbKCNeZkJFe7p3gYNPCDTBoUp+ycYzvY3RGJl1R6Gn/yG/KlCGPeEa2
         eUaQAtw0GwSz9LEtw68xrmgXBkrVzptUUT9Ad0QigZX5Cl/jcWd0XtuPiyl673BKQ/q8
         iCHQ==
X-Gm-Message-State: AOAM530NYtjs0LafRqvFQ4xxgaAYawhKY0AjYIRPb1a8Wg7ZQXleDwZm
        dtcyhuKCkAEUIHnolpwB814S0CYRAIOIsP8XkH7/JQ==
X-Google-Smtp-Source: ABdhPJx1bJBffMprTiS1CSYX4PIv3MJoz0FvJRUKQinahJ0Wo/qcO1CalKfwe4bKmuLz4AUd5ISsCSvhslEIpIVUUWI=
X-Received: by 2002:a2e:9c91:: with SMTP id x17mr7774513lji.366.1591459938611;
 Sat, 06 Jun 2020 09:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200605140152.493743366@linuxfoundation.org>
In-Reply-To: <20200605140152.493743366@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 6 Jun 2020 21:42:07 +0530
Message-ID: <CA+G9fYvDNVD0h8mKCsg+v2J=+dDuC4fcHT2Qk+u_1FMFHtWtZw@mail.gmail.com>
Subject: Re: [PATCH 5.6 00/43] 5.6.17-rc1 review
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

On Fri, 5 Jun 2020 at 19:48, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.6.17 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 07 Jun 2020 13:54:56 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.6.17-rc1.gz
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

kernel: 5.6.17-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.6.y
git commit: 6266fb28693fc3d724b6a365a86e04a846a4f991
git describe: v5.6.16-44-g6266fb28693f
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.6-oe/bui=
ld/v5.6.16-44-g6266fb28693f

No regressions (compared to build v5.6.16)

No fixes (compared to build v5.6.16)

Ran 33592 total tests in the following environments and test suites.

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
* kselftest/drivers
* kselftest/filesystems
* kselftest/net
* libgpiod
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-dio-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* perf
* ltp-cve-tests
* ltp-hugetlb-tests
* ltp-mm-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-open-posix-tests
* network-basic-tests
* v4l2-compliance
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-native/drivers
* kselftest-vsyscall-mode-native/filesystems
* kselftest-vsyscall-mode-native/net
* kselftest-vsyscall-mode-none
* kselftest-vsyscall-mode-none/drivers
* kselftest-vsyscall-mode-none/filesystems
* kselftest-vsyscall-mode-none/net

--=20
Linaro LKFT
https://lkft.linaro.org
