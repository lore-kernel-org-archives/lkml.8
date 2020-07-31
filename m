Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E08FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A9AA21744
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OyGuLvWY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387461AbgGaMnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733026AbgGaMng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:43:36 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719A4C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:43:36 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id 125so1629807vsg.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ptzHG9zuPWMQjc5H6HXuWxoVOZ3lKq9oK6uYzGg8CWE=;
        b=OyGuLvWYglrPqj1bn2UfJK3DPkvax9NvfZpJhSfaZ8c2XlMVqv1IxIQg+++id8xno6
         dN9wySfrTxHGwo+xAdZJiURwdC/o8pdR/vUSpSjFObuChrBeEPXTaqdAXwnhGLXKVvIh
         we+iUV7F52h6slJu716ntxoyV6S/Kbl6mljo8WEAHysQLTFXPDPmAvUI1TmQU2ImZ9+e
         AvPPSYjNdehiEGB/pDog6v2MAJucjF1EG05MFmxPJk9naKibwDdi9RqsfZG4KbFlC4Jv
         1JRpR2xl9y2CQ+908teHQnxyCd6qWS6P7vQVppOSlJzBnRT1M9iTJtqwl85GQxydqO5i
         WpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ptzHG9zuPWMQjc5H6HXuWxoVOZ3lKq9oK6uYzGg8CWE=;
        b=JvwOYuRRH9zIKeVfOysCBOlcUKnK4RPxuiQlOrF0XKJondV+9KYN1uqwp1JtFBJJWu
         iuKzLuKJzBQt/rGq1FYzs6WckOcVmPBUtL/mmlEd0LDvKxT+5DZwjfPNxQjcZBUXlWLw
         gZvmzPHAfBGj28jJdIuljflKSy2eki8BUL4se+NSlSgmyITdGnWZAaQjX4LsGo+Y3ej2
         TCaeOHfkEVAhQYQmhCb4r/YqLrM//S3UAI3ATVsRfQQOJWxBWR7pIPIqDlidABDZbcWG
         19E44JVeeX6P2SxjUp7nJM9OsQmGSXKKZkKPceLjr9Cp4Zfmz+YJ9KhWePlp1i8v/PeZ
         H20Q==
X-Gm-Message-State: AOAM531RU9eZNCws2qqJ6vYw6wknnZc5JpyzcZFbx/0gJGs8YRGaEdfO
        qDZ1tFWjnMNB7zbQNESXQITdnFXMxahR58rJ7kqXxw==
X-Google-Smtp-Source: ABdhPJzV5MEWdAdciXvU/+naYoHN+ac+cipTAxRsRkZlp7sFwnJg1s0JE26Ep+6vF6jKCO1j1FAh+PCmUjp3nLitDUY=
X-Received: by 2002:a67:504:: with SMTP id 4mr2937994vsf.22.1596199415578;
 Fri, 31 Jul 2020 05:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200730074420.811058810@linuxfoundation.org>
In-Reply-To: <20200730074420.811058810@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 31 Jul 2020 18:13:24 +0530
Message-ID: <CA+G9fYtUAseOUsQyf=iH7kTSGYUeo875_hhdCD1ayhddNn0PaA@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/61] 4.9.232-rc1 review
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

On Thu, 30 Jul 2020 at 13:40, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.232 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 01 Aug 2020 07:44:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.232-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.232-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 3c1be84608a0c22e5b574396a51ed93a7f3206ba
git describe: v4.9.231-62-g3c1be84608a0
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.231-62-g3c1be84608a0

No regressions (compared to build v4.9.231)

No fixes (compared to build v4.9.231)

Ran 34650 total tests in the following environments and test suites.

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
* install-android-platform-tools-r2800
* kselftest
* kselftest/drivers
* kselftest/filesystems
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-controllers-tests
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
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* perf
* v4l2-compliance
* kvm-unit-tests
* network-basic-tests
* ltp-open-posix-tests
* kselftest/net
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-native/drivers
* kselftest-vsyscall-mode-native/filesystems
* kselftest-vsyscall-mode-none
* kselftest-vsyscall-mode-none/drivers
* kselftest-vsyscall-mode-none/filesystems
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
