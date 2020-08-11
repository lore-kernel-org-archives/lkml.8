Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFF8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFC97207DE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bxw3ARqT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgHKHLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 03:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgHKHLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 03:11:07 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFC2C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 00:11:07 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id g14so11625919iom.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 00:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VSak/sibdYSj81/k3MBKQ6bwNgDsKSWyLQ1rOxMv7Ms=;
        b=bxw3ARqTdLjsQuuAH5F06XYEll0OIQ1HFxg6+B26Rswy6NKcnud7dcYbr/ArHogY7y
         Y4X1ZVMPzcKnV2XnL3xAJ5GVzth4tKxUXEaQb96uEgFQpKC+8JWdk0TUWBKC5KBMMuye
         UhrYrmyLmsD58kSjL+q4Y2VpcKbWDl53nNTfgrADXsx3XAaKGI6+REFWDy0irO0SRqzA
         C37A38maCsoReudQ4CdBpqtMicIsSv89sWGGBRty1CUMZnPmIy1Z3iCh3xZ7fXB1c7q8
         cnfb4Br+21SR5Gr856IX9Vose3gflTzv2H8kNF9rh7QvXY75jtPsWjMiOkfTaTmSp5So
         EHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VSak/sibdYSj81/k3MBKQ6bwNgDsKSWyLQ1rOxMv7Ms=;
        b=T7zr8RkS63IPzANXTWkZcGpeKsU5FGdTYfBmbPPxgcw/g4f3321GdqwrxJiQVGRgQG
         n053X4COJSWtkncsoVr/SFwMWX0nI+mYlUzhP3ssWYhu0TSZ5tebXs5iNTeQk3m8Z3UR
         A63bkHFHClT60V8RRDZkhXVpMiWt2CSjoKhY9PteBbp3M5TOmucF/2Z0QFQCXyK/k5rm
         ep+cSNPWQw8R0wRLKXPKxlHKuPT4QiYO543EWwPeKOxZZHlC2/Q7GcmFsTgs5UxoRdda
         viOnElhe6c2Qjz8O1ee88Y8XNDGyosSHNFeeYlhaBDrfZYKJncGTwa/lF8w0M6qCLXpZ
         hvsw==
X-Gm-Message-State: AOAM530orAYv8sREUzi21RRGRKD6DY3VRkytaIY7isyrS1LbpKNppsoT
        2JdKoaK02bsWPN8/P9Mm52rpqZSPmdIMpNRY/iuVTw==
X-Google-Smtp-Source: ABdhPJzD5Xnn587ton3/LEk76XftXqRXP8qaUAYi9hqOsJksxVy9ItzXBoN27/XR30kZrlRvCE4DjWSJKcxeSvKo+qM=
X-Received: by 2002:a5d:9701:: with SMTP id h1mr8886370iol.36.1597129866291;
 Tue, 11 Aug 2020 00:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200810151812.114485777@linuxfoundation.org>
In-Reply-To: <20200810151812.114485777@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 11 Aug 2020 12:40:54 +0530
Message-ID: <CA+G9fYuS3Bdg7ZVk3eYU_h9PB_4pF4SF5h-fp=z5eRnsHPJ2ug@mail.gmail.com>
Subject: Re: [PATCH 5.7 00/79] 5.7.15-rc1 review
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

On Mon, 10 Aug 2020 at 20:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.7.15 release.
> There are 79 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 12 Aug 2020 15:17:47 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.7.15-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.7.15-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.7.y
git commit: 693b1e00f859c9979003e6728adb23f20c9784a2
git describe: v5.7.14-80-g693b1e00f859
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.7-oe/bui=
ld/v5.7.14-80-g693b1e00f859

No regressions (compared to build v5.7.14)

No fixes (compared to build v5.7.14)

Ran 34638 total tests in the following environments and test suites.

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
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* network-basic-tests
* perf
* kselftest
* kselftest/drivers
* kselftest/filesystems
* kselftest/net
* ltp-commands-tests
* ltp-containers-tests
* ltp-controllers-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-io-tests
* ltp-mm-tests
* ltp-open-posix-tests
* ltp-sched-tests
* v4l2-compliance
* igt-gpu-tools
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
