Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62075C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34D2E206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w8pM9LlJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgF3FWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 01:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgF3FWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 01:22:17 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D97C03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 22:22:17 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q7so7699957ljm.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 22:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9qTa0QzfsDsmvRz7fKgPnwC59SuVUu6TJ3V+opbP+k4=;
        b=w8pM9LlJOVX1fGUrk3Rkss+ak9nYoksk4J6M94Ungd5A1tb3glYYTk/6XssGlVq9Mx
         pzjfJdHsvwPu2MfTyEpkz/m9bw7Qu++JyMtSbv5VWVkVGCwbFcRTa5a4DTrxXT3NCST2
         0a51+egH5SNx8zII3jLk7x2jtOFEsC1Af4xdxUUlh8iZqJdfEKRqYQmIf1MySNNusWlq
         tbBkQS93j87RYcu8csugDk+JuRXO+BXeDxLKMna4pZim3rbuiU7U/c2gTG3tva0fyHq+
         dHf1PUFZpxRZaz7FtPWzcD3dE/oz5UTXLVdjYK26Z4dx75DVod1cDkAIUOg4MAcG1GiF
         5ZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9qTa0QzfsDsmvRz7fKgPnwC59SuVUu6TJ3V+opbP+k4=;
        b=FGnKfWpq7t8kj79QZB7SCnfMJAYNkS80xovHI1GeEx3POFjHZrRrdz4G2rD2HCgzU6
         tsKCV2tvr1hvckuGzpW8sYY3JNQH/Elv/lITppYfN7hQ5E7nKS7ieAQwZfhH/eww83Mi
         4okD+gbyKFMz3bCLaGk+jCaUZTX3pCW5BJ5caoe/50SiuIx4PRRN5eUWz7pz3eOXNMac
         drmpo1YzhdlFo3+sd8z4aGgFHWkQ0hFvGChaTpjvV2dpNYWQ1WrF5D2AEVgRCGRu0424
         uhYNOPvS+TeMMm5vhJDjKMLdasBH3CiZGDWOjx7n8RzDbArgsVdEs9zEPuBFGpFDFxU0
         AqWg==
X-Gm-Message-State: AOAM530UktDZNwiKupP1aBJBF4vPfSIgJiqUnkzsVTTFWuTQZcM6BAXT
        +rID4hRAJMvhezUQT8iD9cj7pzVfFq7Z60AWAhAdqg==
X-Google-Smtp-Source: ABdhPJzbcG26GiwMn5Y85LLRVheOo7eBUCzTe4DBikJ3MwAAL14sldLdOTOQ9coABbisMAUnWXpnmguh9Iqy47lsMEY=
X-Received: by 2002:a05:651c:1a6:: with SMTP id c6mr1927013ljn.358.1593494535598;
 Mon, 29 Jun 2020 22:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200629152523.2494198-1-sashal@kernel.org>
In-Reply-To: <20200629152523.2494198-1-sashal@kernel.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 30 Jun 2020 10:52:04 +0530
Message-ID: <CA+G9fYtVNQj2=W38guCJDPxGYW_Ec9zC9dswNyXNZngLPgxc9A@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/178] 5.4.50-rc1 review
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

On Mon, 29 Jun 2020 at 20:55, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 5.4.50 release.
> There are 178 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 01 Jul 2020 03:25:02 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/patch/?id=3Dlinux-5.4.y&id2=3Dv5.4.49
>
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> --
> Thanks,
> Sasha


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.4.50-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: 7d61c4b6865ab9c9f22e4ddbc65645c0c4b0427e
git describe: v5.4.49-178-g7d61c4b6865a
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/bui=
ld/v5.4.49-178-g7d61c4b6865a

No regressions (compared to build v5.4.49)

No fixes (compared to build v5.4.49)

Ran 36125 total tests in the following environments and test suites.

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
* kvm-unit-tests
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-mm-tests
* ltp-sched-tests
* ltp-syscalls-tests
* perf
* v4l2-compliance
* ltp-commands-tests
* ltp-controllers-tests
* ltp-cve-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* network-basic-tests
* ltp-open-posix-tests
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
