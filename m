Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F8DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EF05207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FDRqXpYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgHUJcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 05:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgHUJcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 05:32:20 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31635C061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 02:32:20 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id o184so514322vsc.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 02:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xMiHLLlCWu0ELLmsItYP1jHARCHQiZD3ePG4Pc6IyeQ=;
        b=FDRqXpYbx9M0xF2VnsdaGsAujUfGgvnpNzeQp0XM0fOBoeieOsOVA953nX8aCOgrpA
         J327Q7CPlfLcdwXQ/NdYrmwTF4A7+FaAgTu9T0bY/Pm97YAW58dPsl0+bLpDmHV8OB0f
         5bPPyXcoN8ss+rxixT1I1YtnuEoOFynQyFkmuPVuRDj18VwNXfalSGtKODdkf5Y9ecSB
         Wj81pKBo1IHeJkRWO8FrqGP0holFykuNG2ZFivw9Bn+SFMdfjbUllinGfrchSc7DVkuZ
         7FEN6jBeSclre8npM71uPjRfUWeGe1wexEUx0UyW5WQmpSmj9ZrZzPitFtOeuw4cccgj
         jeIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xMiHLLlCWu0ELLmsItYP1jHARCHQiZD3ePG4Pc6IyeQ=;
        b=RiREjGdUq5FAhHv+GdRBcMRPhYwdHqwIhnR7WwbJWVwSzJj+YPcbkTJpGk2Ztsr/aS
         RH0DjKeEVQqLpqMtvjkEN+wDSctcglK7jAVfGOEeDo/xxADAvCOqFjNRl/yPWYOxKbRJ
         brAiohJwoPTUx8v5DssG9uETpdW157kcpRtjKf2sleJ8NkIkDUI1CXyLG2CkOKONEyLg
         qpeSJhqMCS5ss4bOWfQjuAnk8HZTRfITiPzqtCq84Q/KGDsl6VwVR0F1l7MVmBXPzeVb
         Jhere0Ko2ihg9nYW8q7FUYxKj/8xOpioY8fUhmrs30TurKQhU3lOaBj7e1BQvB6qUxCy
         4ioQ==
X-Gm-Message-State: AOAM530ozyPjU2xecJKfqd7OUfYeccTQk0QjrPYJW2RP/XlhctcNvQ3r
        K3z3UplBLCVjV7NU2ClRdNcBhAKqTNzyilP4spGGOw==
X-Google-Smtp-Source: ABdhPJxQTebcSALs/0rfjiCzJEwp3wy+hL/bUQVTwiZKj/gB488qWMce8GyuGujTUrKQH80pBBise3qYRH9Dfx692bg=
X-Received: by 2002:a67:6996:: with SMTP id e144mr1137301vsc.185.1598002339206;
 Fri, 21 Aug 2020 02:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200820135009.684062405@linuxfoundation.org>
In-Reply-To: <20200820135009.684062405@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 21 Aug 2020 15:02:07 +0530
Message-ID: <CA+G9fYusb1czZrXJhJyMWJRHRp-vBoiaGjBi40zWhH1tM7g7hQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/226] 4.14.194-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020 at 19:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.194 release.
> There are 226 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 22 Aug 2020 13:49:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.194-rc2.gz
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

NOTE:
On arm x15 and qemu_arm the following error noticed while inserting vivid.k=
o
This is an intermittent problem reproduced only 20% of time.

Failed test log details,
-----------------------------
+ ./v4l2-compliance.sh -d /dev/video0 -D vivid.ko
VIDEO_DEVICE=3D/dev/video0
VIDEO_DRIVER=3Dvivid.ko
v4l2-existence-check pass
[   36.810003] videobuf2_core: section 3 reloc 5 sym
'_raw_spin_lock_irqsave': relocation 28 out of range (0xbf042190 ->
0xc10455cc)
modprobe: ERROR: could not insert 'vivid': Exec format error
modprobe-vivid fail

Summary
------------------------------------------------------------------------

kernel: 4.14.194-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 6c7d4935a4ff2afa46df3377ea214a86c4ac5f56
git describe: v4.14.193-227-g6c7d4935a4ff
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.193-227-g6c7d4935a4ff

No regressions (compared to build v4.14.193)

No fixes (compared to build v4.14.193)

Ran 25712 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
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
* igt-gpu-tools
* install-android-platform-tools-r2600
* kselftest
* kselftest/drivers
* kselftest/filesystems
* kselftest/net
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-mm-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* ltp-commands-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-sched-tests
* network-basic-tests
* perf
* v4l2-compliance
* libhugetlbfs
* ltp-fs-tests
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
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
