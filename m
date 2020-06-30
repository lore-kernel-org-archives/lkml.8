Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CD7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D285A20720
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pTpqk02a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgF3FO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 01:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgF3FO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 01:14:27 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE8DC061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 22:14:27 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c11so10573784lfh.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 22:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W69ph+i0GrUHBE6EcCTuT/obYcwfDKs0cbLyOStqOtc=;
        b=pTpqk02aElatHhMshdGJvvxKDo+gn5r+Y5C8oJa5VR6XW/ufOsRmN6rKqFSkDMFldr
         NIjKL9FJ/D/qmY/tSL/kaizmj6RY1k9g2F7scQZlqvf3bEM5FzTv3EFnmayHtWQsezTM
         UHweAyFsN2MNPY39HDzkYbPXvA5fq79JNmhdr/gD3TGQvE0jU0OSHewzV1mdaHzUvyw0
         hXbnegzNBrMvJI+6jdO2j9buU3bgxf63F/zC8y/YqBEfHqGLHu8/ba8Crk+DqI3G1fEj
         dSfBUWQvlKjgOLV3qRpyWL1OHCVI0K6qUkom5qULrF46JRKbGfsCZ5aSYcV2edvduRyr
         YZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W69ph+i0GrUHBE6EcCTuT/obYcwfDKs0cbLyOStqOtc=;
        b=QWB9Wx3b5wEp3ZYAM1/UNX+TeF1ECXWm9D4s1EtYB708Qw5G7jVkk4WB2DzXYCUT0Q
         KOu5Q0Tn7XBsiYVeKFD7Sc9iBSRG/dqJB+6HNLrJvjtnNhIWkUNGutrWUN6xUqvH9rfY
         EMAfjuGIIfmMEYAfWUi3M8QPhrKL014Id8jWhiEyp1TSUWK79DJn8SBoERnw4UpoYmld
         cruXZJInugjYSKN7ZgrApFuwWD9SBJ4TFA2aQQ7Du69fHjNBY5tvpept6jVBr/2RaI/T
         EsxWAi3sgwlQC9TvChSfNyTZBhUOFz0MEiOQYR94vPeDtIr843gHjnTMQldtbLosBini
         mM9g==
X-Gm-Message-State: AOAM5306XXKxOTO0bzVhrVRc30wp0udnalka/ytakqYqZiOrOytAaq0J
        4MmdD5UqLoNUH6A4qyWvwVDmg9wjaKkFKPYcPAdUBw==
X-Google-Smtp-Source: ABdhPJyQyCEgfdcfcd4bxOyQ1pV8XyLXbUtS8COBDcfz+GkZVBiKtmMhGz4nw8J25sfNsNCGjyX9Ud3h+W31/CCxGN4=
X-Received: by 2002:a19:4285:: with SMTP id p127mr10507224lfa.74.1593494063781;
 Mon, 29 Jun 2020 22:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200629151818.2493727-1-sashal@kernel.org>
In-Reply-To: <20200629151818.2493727-1-sashal@kernel.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 30 Jun 2020 10:44:12 +0530
Message-ID: <CA+G9fYu0Vq2KbqonYwp-mm+STOg5yKDjqHvSeFQ_u-VbaLjgUA@mail.gmail.com>
Subject: Re: [PATCH 5.7 000/265] 5.7.7-rc1 review
To:     Sasha Levin <sashal@kernel.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020 at 20:48, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 5.7.7 release.
> There are 265 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 01 Jul 2020 03:14:48 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/patch/?id=3Dlinux-5.7.y&id2=3Dv5.7.6
>
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.7.y
> and the diffstat can be found below.
>
> --
> Thanks,
> Sasha

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.7.7-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.7.y
git commit: 97943c6d41ef2b05f4e064eb49a538ff4b405809
git describe: v5.7.6-265-g97943c6d41ef
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.7-oe/bui=
ld/v5.7.6-265-g97943c6d41ef

No regressions (compared to build v5.7.6)

No fixes (compared to build v5.7.6)


Ran 36511 total tests in the following environments and test suites.

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
* libhugetlbfs
* linux-log-parser
* ltp-containers-tests
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
* ltp-mm-tests
* ltp-sched-tests
* ltp-syscalls-tests
* perf
* v4l2-compliance
* kvm-unit-tests
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-math-tests
* network-basic-tests
* ltp-controllers-tests
* ltp-nptl-tests
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-securebits-tests
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
