Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE8EC2BB85
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 08:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A655520708
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 08:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tebMGg3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgDLIvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 04:51:38 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45608 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgDLIvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 04:51:37 -0400
Received: by mail-lj1-f195.google.com with SMTP id t17so5904932ljc.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 01:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pUaWyJBANBIsSu7R/tcWw2JGAIRnPcaSbBQB9PvP+EE=;
        b=tebMGg3/T7EnCmpjv9uu+uJzLAgBtO+1Vr0hkW97KsHIs2vgInARxQjy4sQ5s1lOU9
         dyUbwL8eniOKOKutdRX1jszpB1KSqrdKReN/+5qFzU9JeW57wHGeufp2OKl54ojtYhjd
         OlFTN/G5B9evz+5yTBtpiVmrilPU4JhdjErcuEeYeb70kK+7UGwLs3FKPRC6U4vvjlks
         rwavAcGPBNGe50Tg3JTUaI5YIX69y0GUNBz/nGZteB3Yyh/4A8gR11aFroPTbgR/hjaO
         Wo+xMWNcYpSSArbqdLAJcKrzK9VRykp0Zo2KhwZfHR3Kf1bUyK1HaLcz5UUJbeYZJ1dF
         DR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pUaWyJBANBIsSu7R/tcWw2JGAIRnPcaSbBQB9PvP+EE=;
        b=m5wrd/Rk9l3V7+pi8jhvDBjNMFW9lE+nDiMVi812eb6FRzAo8T7bu2V85CTjqngnVR
         8KmFRHDS6hzPNEbNxQTxIIIChhDBGm3uQoElHDIe6evdAD+O4KEnNbNRadqxsxepXiw1
         6E/68nW01VuimQlTlHU/On2LRBb2V0z/f+FxlyKjU8cR18j+OEuyweZjN/d1OeAP4Hl6
         3hkp0KD4E6TfKuG4iOHZebNZE/7KiEcJUipH/7pi6cBE6zlEHdvLjS6H/US+qeBrdkod
         iekYgbIIikh9B7uxyIfhFxox9EwOQDpBUmBsoRzvpLe6dW/lApYnrc0xmKlabnhJvidS
         Dumw==
X-Gm-Message-State: AGi0Puaru/CdVFTPKA76MBQkMd9/GEnKpkwESw98nkz3I3PMHQt8WTV7
        lnKBN2elgCq/wlRnNm7PKdWUgaFoMSBXMzz8jemoOg2gKz4=
X-Google-Smtp-Source: APiQypJHGvxCXtrEW6SrynlvYzXZK5Z6Ab3LG5+qUTAVclUsUTIdEB9LH6XDqMt3XPcsEr3E8tuIzalu61iDCm4YVzw=
X-Received: by 2002:a2e:a495:: with SMTP id h21mr7498580lji.123.1586681495507;
 Sun, 12 Apr 2020 01:51:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200411115437.795556138@linuxfoundation.org>
In-Reply-To: <20200411115437.795556138@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 12 Apr 2020 14:21:24 +0530
Message-ID: <CA+G9fYt1VxRP3ssQrO1zvCO9hdLO+eqC_X0i8kkos3DQesge5A@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/38] 4.14.176-rc1 review
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

On Sat, 11 Apr 2020 at 17:45, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.176 release.
> There are 38 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 13 Apr 2020 11:51:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.176-rc1.gz
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

kernel: 4.14.176-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 42fb2965c7ca26057bc47af5ef45f170bbf2cade
git describe: v4.14.175-39-g42fb2965c7ca
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.175-39-g42fb2965c7ca


No regressions (compared to build v4.14.175)

No fixes (compared to build v4.14.175)


Ran 32276 total tests in the following environments and test suites.

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
* libhugetlbfs
* linux-log-parser
* ltp-commands-tests
* ltp-containers-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fs-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-sched-tests
* ltp-syscalls-tests
* perf
* v4l2-compliance
* kvm-unit-tests
* ltp-cap_bounds-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* network-basic-tests
* ltp-open-posix-tests
* spectre-meltdown-checker-test
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
