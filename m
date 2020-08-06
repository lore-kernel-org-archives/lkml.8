Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79433C433F7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF53122D0B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="any6vJdF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgHFLAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 07:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729394AbgHFKhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 06:37:21 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91335C0617A5
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 03:36:08 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id v6so33784003iow.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 03:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hj3R0tIfcIkpZhk/MOW24yuwzJti3fMgCq+xlKWe23s=;
        b=any6vJdFKrdkd+a4fKkNab188WSeW3kDjNjijmxdqJ1Y4AwYn4FLR/iQrpMyExolkK
         66mFi0t5w16+fsEhYOsaXPC7OJVlsPhTg+WoYRWPK0FdQfP7YIvZg6ds7gMUG92eJGlf
         QR/wHYZ3/YvNbqgsC9Df7dIJZMcVh4kmPbXY766NOOS+giXcztD5zCFd1TqLjGdL+pVO
         Rk1DiDsxHshnBfVWwBD5pTA0mCuqTXK04NlevzeDQqxbwa63QWFviu1CKXtu3YJ1qgJr
         2x+ZNON385FtWrcjVdXr3Pb9gwapMQ9nHVmz2lZTKPRtnV0lpchJrHtdsXLPNJk1IEsU
         K8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hj3R0tIfcIkpZhk/MOW24yuwzJti3fMgCq+xlKWe23s=;
        b=M39EbJGJCLTIpZHT78Xw3CI0nFBPA4BhYsh1gEIJm80hQ+PEfMHBbgFq29RDrdbB/2
         2/dN2KN+Yk5OYuvJldP2B0nPrTOQ26JytiknZuHTLZAk2uKXlGlWJ41sPoCbTJxG2grh
         zEnkdPovD2f+y6+r6VufYodeG1z4uwW3Z4x468u6jEBkwejNfMRQzIaQhKL+gfIny4u2
         sAv3+E7wj5ruzUYdY9eeRqgM6djldz12sJ9RvfXznHg1IXFdAwliPZ4dql5URdLnRW/n
         TwLcqhGRZetXnu8+CXLEr+h8dccUpqraGbQj5EZK0I/PO0s1fjR7zP5/ylBb11RK3cec
         qVQw==
X-Gm-Message-State: AOAM531fCcoM9zcrZpY+VN/IKTBvHb3RpyZCbzy/fpLRAcA83ZhOKVVV
        FxD4ydPG7bEYTnyl+ckAG23GJkWONfU084JfcpSZvw==
X-Google-Smtp-Source: ABdhPJzHUTWPq7F01xZd1/4hqfefGb4XRem0zi/X7ZLbxaLwgnPaMNDxLcsPytmk4P8gwPB+ZN1V8Vf8ZJycfMty5SQ=
X-Received: by 2002:a5e:d519:: with SMTP id e25mr9126780iom.36.1596710167873;
 Thu, 06 Aug 2020 03:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200805153507.005753845@linuxfoundation.org>
In-Reply-To: <20200805153507.005753845@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 6 Aug 2020 16:05:56 +0530
Message-ID: <CA+G9fYs3szBM=oz5f-zJudALL0Um_X9xR0cQKzq_HQXqrdut-w@mail.gmail.com>
Subject: Re: [PATCH 4.14 0/8] 4.14.193-rc1 review
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

On Wed, 5 Aug 2020 at 21:23, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.193 release.
> There are 8 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 07 Aug 2020 15:34:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.193-rc1.gz
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

kernel: 4.14.193-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: e8ffd3efac224a0f72ae9ddffc0522f6b2e169ba
git describe: v4.14.192-9-ge8ffd3efac22
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.192-9-ge8ffd3efac22


No regressions (compared to build v4.14.191-57-ge8ffd3efac22)


No fixes (compared to build v4.14.191-57-ge8ffd3efac22)

Ran 25279 total tests in the following environments and test suites.

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
* install-android-platform-tools-r2800
* kselftest
* kselftest/drivers
* kselftest/filesystems
* kselftest/net
* libhugetlbfs
* linux-log-parser
* ltp-commands-tests
* ltp-containers-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-io-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* v4l2-compliance
* kvm-unit-tests
* ltp-cap_bounds-tests
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-fs-tests
* ltp-hugetlb-tests
* ltp-ipc-tests
* ltp-mm-tests
* ltp-syscalls-tests
* network-basic-tests
* perf
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

--=20
Linaro LKFT
https://lkft.linaro.org
