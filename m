Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70B3C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 10:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB71206DA
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 10:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GvfVR5S4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgDLKFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 06:05:18 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44505 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgDLKFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 06:05:18 -0400
Received: by mail-lj1-f193.google.com with SMTP id z26so6017103ljz.11
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 03:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3poMWLMS+Y0AirDPgoxNpgkvsEj8CUgi4NnvvSus0Ys=;
        b=GvfVR5S4msaepb9ZqQaBViyW66mnM49/Ox6puWdnCxugNW8gaUnXwwK8Qp4JOChLsW
         ZwkR1Mzp/eaSQWfmj10rH+iABGjG5UMF/sk4A2jhdhxE7WaPH5hPt+0WvTVQZ06oa7Os
         JoDl94htWvSqFxUtvtviTo6bjaUdMFlXT0kgy2NaUeOIoRXkP6TwbBb3mSIpeWthChxN
         sPxSlU0x3wchTOmNTMiRXQtxpxAMpYyc899pe4NjvZjIjLbK21hRVcpvDxJjXLmMeCra
         oyz2M3H1eOr51VmKm2ZUkWwphOPxsbV5OdfB3iFsv51hHBqQbnY8+uwixV//wNCYMxop
         ThOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3poMWLMS+Y0AirDPgoxNpgkvsEj8CUgi4NnvvSus0Ys=;
        b=LTtQd79tl2NrV67c1nccFS1SPzc5z6gePja2WE4kjV4r9/v77Fgsdui+3xeLSdBOZ9
         6KaEySFJS9XDqlxlgB9eoJnEE/c2sSilRD355TQuLhrHLseznbtiAkhNgcPNr6OrATGM
         wFaKD66QldkB7tJINGGUw1O6yVFx4PeBZG1pT59wbWLZ7/TmVmQSYx8q3cwsmAv7RWSk
         05frnrTovMqSMjsycpHSajR/pOnfmY/RKS99d5rbwxtAz9YaJv1Nn5c1g8aMac8MFu38
         rdHo7AfdJZV7z3yHC96wA0yw2T6o60IMVb+1gMVNUwkkIgcvxU9yPj90UZWJuETqgGGd
         bzwQ==
X-Gm-Message-State: AGi0PuYsUsFZBQfrGx3t8OcVrQKnp2ZQlsrd4TKb3VgStFAu8cpGXCH0
        vHn9ubOSZVee3u1bE7U/DzajF7pp5qGkN6q9yznSSQ==
X-Google-Smtp-Source: APiQypIWimhBBeVhQTK+0MOOr30jp0Bt95mIG4YzyDh2pR6n4c3Lp99zRy9nAaxo36LuffWhKh5q6YbDwI+/a4BgRtU=
X-Received: by 2002:a2e:97d6:: with SMTP id m22mr7930949ljj.245.1586685916350;
 Sun, 12 Apr 2020 03:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200411115407.651296755@linuxfoundation.org>
In-Reply-To: <20200411115407.651296755@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 12 Apr 2020 15:35:04 +0530
Message-ID: <CA+G9fYuM6XSYk1nniG9d8oHQKw+rZZUfEVcmWAfjB6x_U-T6Pg@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/29] 4.4.219-rc1 review
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

On Sat, 11 Apr 2020 at 17:41, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.219 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 13 Apr 2020 11:51:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.219-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.4.219-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 8cd74c57ff4a364d0a753e448ce5eab18cc5bb75
git describe: v4.4.218-30-g8cd74c57ff4a
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.218-30-g8cd74c57ff4a


No regressions (compared to build v4.4.218)

No fixes (compared to build v4.4.218)


Ran 27015 total tests in the following environments and test suites.

Environments
--------------
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
* kselftest
* kvm-unit-tests
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
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
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* perf
* v4l2-compliance
* spectre-meltdown-checker-test
* install-android-platform-tools-r2600
* kselftest-vsyscall-mode-native

Summary
------------------------------------------------------------------------

kernel: 4.4.219-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.219-rc1-hikey-20200411-691
git commit: 9b98182ae4842aa200b9878be74c2fa565a1ab29
git describe: 4.4.219-rc1-hikey-20200411-691
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.219-rc1-hikey-20200411-691


No regressions (compared to build 4.4.219-rc1-hikey-20200409-690)


No fixes (compared to build 4.4.219-rc1-hikey-20200409-690)

Ran 1726 total tests in the following environments and test suites.

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
