Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0927BC47259
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9F76206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E97CcwnJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbgEEPfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729576AbgEEPfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:35:15 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A557C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 08:35:15 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b2so2092910ljp.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 08:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZAA7onJRPzZjOTBQ9x3ajcbhIJAzkJ5I/J+jTuQ6Q2k=;
        b=E97CcwnJoQaWV6oA4UNCFfR3iGM9N7GMOtrF7Z8NZseCnvGZ1XoEc39IlimdrqV3sr
         Jkbwry7o484iTCPcczKikLU+FulNIGgt/IHOxwCJKojkNmNYUbZM01VjMBtHP/04I+uQ
         X5zzLXbn7p1fUf4kVf+wHRCo+ZhmTYZehCp7oad6Az005kGNjfRgAOdgj09e2EWXqg7P
         a0uzcZM/aLFEbvDVhtyeGyi61vWpC3Gf5QozbKrCbwB+rJsR1z0HJ86CAlqvdtPty4Kf
         qxyFa3pGTaVU5QJ3cnXpxPt9h2qIdjf69DxSnCxixQ+C+xcVTXwTFKht1E2HrVj/uY8U
         P6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZAA7onJRPzZjOTBQ9x3ajcbhIJAzkJ5I/J+jTuQ6Q2k=;
        b=FT9NsmsnjfNHgRsOSW/5R2mJE8WkiXJ8A37c89lDAAboZQgnyciGFoqxvzTgvt2PdC
         EM5SQPmx6FzCstFDQ2hli4Aeo2g4d9sHoDf/e4cebaq4VfQWKYISmZkLD10FmhGxgVqT
         bBhFumaJtQFQd037pxKG8Ht0AYpp8iohdEJyCZzE4XemZ0Q9erxdqCdQaTiew1u6nomA
         yui4mdP2zVoQZHrU7lXVd3XQqeSXOw0OQTmSf7zwYIA0MCNu4i2jzOqK8w+NSgvPvrLt
         uQdQvbfnjThckChR5dEdFnnwAFS2TUgWz+WPwiM1cmuugPwQk1CBZrblhmA7H4yjwC7J
         3WQQ==
X-Gm-Message-State: AGi0PuZ54yKMqm6vx4bIqEhwnzTEwRPL+wwLTBlLKph3erHqPiZuthEF
        r7WUGd3IZj/mbUorNa4A7I0ZNyj8ayYs0oSrzg0zsA==
X-Google-Smtp-Source: APiQypLDoWYmW4L26SDbyERJjIZ2DuJK2gWx85BAOQiZuPUtk8T4uqvnKdZi0zoVn+YVKnNsmihG6a84YQ8CsLN2JBI=
X-Received: by 2002:a2e:8999:: with SMTP id c25mr2201549lji.73.1588692913181;
 Tue, 05 May 2020 08:35:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200504165442.494398840@linuxfoundation.org>
In-Reply-To: <20200504165442.494398840@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 5 May 2020 21:05:01 +0530
Message-ID: <CA+G9fYuvxY=67EPMOHuYQEkFHELHq0fODx4ZPw_Fi9QgRymhqQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/26] 4.14.179-rc1 review
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

On Mon, 4 May 2020 at 23:31, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.179 release.
> There are 26 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 06 May 2020 16:52:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.179-rc1.gz
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

kernel: 4.14.179-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 6d39cf91974673a74d6d976ecc107e43bb5c3eb4
git describe: v4.14.178-27-g6d39cf919746
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.178-27-g6d39cf919746

No regressions (compared to build v4.14.178)

No fixes (compared to build v4.14.178)

Ran 28789 total tests in the following environments and test suites.

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
* kselftest/net
* kselftest/networking
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
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-sched-tests
* ltp-syscalls-tests
* v4l2-compliance
* ltp-hugetlb-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* network-basic-tests
* perf
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-native/drivers
* kselftest-vsyscall-mode-native/filesystems
* kselftest-vsyscall-mode-native/net
* kselftest-vsyscall-mode-native/networking
* kselftest-vsyscall-mode-none
* kselftest-vsyscall-mode-none/drivers
* kselftest-vsyscall-mode-none/filesystems
* kselftest-vsyscall-mode-none/net
* kselftest-vsyscall-mode-none/networking

--=20
Linaro LKFT
https://lkft.linaro.org
