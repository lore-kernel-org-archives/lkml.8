Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3497FC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 117172087D
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uZdIhUej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgIBHNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 03:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgIBHNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 03:13:35 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACCBC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 00:13:34 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id n12so981857vkk.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 00:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9FyRqglKmbgC+YLd7eUpkAxWZYcCmplsY/5grczgp4M=;
        b=uZdIhUejpj0MS9lSXbyyF5E/+kgUutyQsFhsYKZAeayBijIkNIER6kBOjXFhmOiOMj
         /+oDnvt54tyNAa0Hq9UIIv9h1nbU6VvZT99Bp/cYH3i5pX22v5Uu8teHXRBXnwinupYV
         63wHJhG8A/Ksh3Wr4uVjwHJ0GTkvMtTv963Ra6CHlJepWzMfHNV+y2fmnKsbdBxeiFvN
         ySGWY3qKVSOw6NvWSftXayU1QgU4D5QVqiQ8bZ1RG6HJgjRP1Wth99dpD+AFOd2k4e31
         2FSE4bd9m00lnzzQ8LZHA7nNr275ea6z261YDoY3ktW6n7sU4gRhJDM6ndaoaMTiEnIH
         tLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9FyRqglKmbgC+YLd7eUpkAxWZYcCmplsY/5grczgp4M=;
        b=LLH6SIbdEawGSSRC4/WK+nEgzgtffi2+GLge+Ly6UKJ0ixZ3rdbI7pdruCZwLH7JFB
         IrUDqizKvvpZRs+ZdoH8BaWzuiXt+pbDjDMr6KyLwDB+sLaMYpZS5op7xv33WcBpUpf4
         FDWrlulfY5voCioGvOQRogp178Hqo/sFKNj+N5RIfKLflpT7Itp3CZkZ+5ZkkOd8/z8h
         CKpywQ3zd7JrkjzsCoqOOnNx0cWYYvbPT6SppCYVZ+zZe6Ytfk5Te4hr2lOS1koZO8mn
         BBLkOUI5wS960p/Gm7nzIzqrbdE5ofIv79cLvp49JEQPnNNm5uBEZTxM7TIZBS2M68ef
         92Zw==
X-Gm-Message-State: AOAM532Njxa4RHHCz7XVEkt6qX4Ga7XU9dC9au8xgc0DsnV/9V5MHhKc
        L9ESX/N/yx5ObxwrXbmOf0EZD/+S/Irwuzj+CTq3OUMLVdH+Ig==
X-Google-Smtp-Source: ABdhPJyrVAyQl3k4J4t4zLtuk6x7K8Pt+C7h2n0tGx6cjE6twG/jjc0/lGg6PvOYD0tQGrmUBPBp8lb5/xcH6L8oA8s=
X-Received: by 2002:ac5:c8b9:: with SMTP id o25mr4294526vkl.51.1599030813900;
 Wed, 02 Sep 2020 00:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200901150928.096174795@linuxfoundation.org>
In-Reply-To: <20200901150928.096174795@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 2 Sep 2020 12:43:22 +0530
Message-ID: <CA+G9fYtOetDR6EVygFx6S5wU6SL6fPYjwp25rbxYM_XmAqiLMA@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/91] 4.14.196-rc1 review
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

On Tue, 1 Sep 2020 at 20:49, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.196 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 03 Sep 2020 15:09:01 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.196-rc1.gz
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

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
Kernel BUG on arm64 juno kasan config kernel running
LTP tracing test suite found this BUG. This BUG is not specific
to this stable rc release.
BUG: KASAN: use-after-free in prepare_ftrace_return

Summary
------------------------------------------------------------------------

kernel: 4.14.196-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 54fa008d06cd73d42acafb918a6ae005eaef4875
git describe: v4.14.195-92-g54fa008d06cd
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.195-92-g54fa008d06cd

No regressions (compared to build v4.14.195)

No fixes (compared to build v4.14.195)

Ran 33060 total tests in the following environments and test suites.

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
* igt-gpu-tools
* install-android-platform-tools-r2600
* kselftest
* kselftest/drivers
* kselftest/filesystems
* kselftest/net
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-tracing-tests
* perf
* v4l2-compliance
* ltp-containers-tests
* ltp-dio-tests
* ltp-fs-tests
* ltp-io-tests
* ltp-syscalls-tests
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
* ssuite


--
Linaro LKFT
https://lkft.linaro.org
