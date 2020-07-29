Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F00C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 02:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 440A92070B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 02:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R9xhzvvJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbgG2CWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 22:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730901AbgG2CWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 22:22:30 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EB6C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 19:22:29 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id p27so2915961uaa.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 19:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cu/XwJZG01ps+VwDAo91AI0YAUkNe1l4eSo+Vz9jRRY=;
        b=R9xhzvvJZL8Zs+VbzaBxA4+4s873/l5rkxZ0XBBlKVscWK6btk2kvfUMdJSiF/K9C0
         eplSWUi2USSUwiM6HcRB0rcw7+ckjtr4aA19FQRysdNF57MFH40bS4tKMu22GRMU/4CY
         p3BpT0dr65wb6PZ+hyU4u6Ia5orS6/cFNlNVmYaIglLQhVibSzkFl9T9+yZUTdEqEuk7
         9lfDpO6x2Svm66nb6uH9YLRP1KqmzMKt0dHlG3vgZ9ZF9MOrDJbfg9tzUKwFQtf1xCxo
         b8WFhPBm2FSFqLR82DyJmQpeK1NCxH573V0JQ2ZM4H7EMK6ocXCJc9dI9D7uGw2LtA1k
         Wrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cu/XwJZG01ps+VwDAo91AI0YAUkNe1l4eSo+Vz9jRRY=;
        b=E00iDot4V1zKs4B7bjwI0cKxR/k5ymVx6bUWqhoK9uxRB//UCAcvLdmvpS36kQj9GA
         LdpMO6JyUOpEu/ETq6R5IA6h39CYKbP2U7ZiSNJColWn3+rwrNw1UpMcCKlqxR/0XhDV
         cilc3UvkxgdNdMYMeKwtdQ4MkyW1yf4KizXIfcYjF7kf3j+xu3qaVE8DLxtCf/SGZ6+U
         AVWV43WxALaqp268Hkyqgw4wnC+3WkVOWVq7R/Fi1kj+LiqKXamxdJ49YDkgtf0oabEn
         Ty8E+wDx/bNAv3u+Pn61hd/4k9n0nwpauiM8xRYJ5oiquL7rfXYHh0auEARGkmCcgcdE
         Fn5Q==
X-Gm-Message-State: AOAM531VYL+WYoiV+KtHECfbOahfLluYqJ0+LISGnoTAxOnpqUqgCmE/
        RqeB8AabcV28cL0wMfw2/xLllWZBOl3bviWQORMHMw==
X-Google-Smtp-Source: ABdhPJylTQn+ilT1es1s6Irl8QqRE1j7aRiVjOLhOEhKjvAPN4Rz+7sjnZEEOTPgIHC+THV+68P5LBEVG7jbsrOOZKY=
X-Received: by 2002:ab0:53d8:: with SMTP id l24mr15077965uaa.14.1595989348876;
 Tue, 28 Jul 2020 19:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200728153252.881727078@linuxfoundation.org>
In-Reply-To: <20200728153252.881727078@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 29 Jul 2020 07:52:17 +0530
Message-ID: <CA+G9fYvfC=PVM3HvQCmBZJdaEYGLQ2vjN1r=vL872XTRWW-PaA@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/86] 4.19.135-rc3 review
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

On Tue, 28 Jul 2020 at 21:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.135 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 30 Jul 2020 15:32:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.135-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.135-rc3
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: a2eeabffd1f3dd5af0e99af90bff26c8530d3ee9
git describe: v4.19.134-87-ga2eeabffd1f3
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.134-87-ga2eeabffd1f3

No regressions (compared to build v4.19.134)

No fixes (compared to build v4.19.134)

Ran 32834 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- juno-r2-compat
- juno-r2-kasan
- nxp-ls2088
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
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* perf
* v4l2-compliance
* kselftest
* kselftest/drivers
* kselftest/filesystems
* ltp-containers-tests
* ltp-controllers-tests
* ltp-dio-tests
* ltp-fs-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-mm-tests
* network-basic-tests
* kselftest/net
* ltp-open-posix-tests
* ssuite
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
