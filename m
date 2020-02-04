Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47ADEC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B96220730
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZsEAf/Yc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgBDNiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 08:38:07 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35775 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbgBDNiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 08:38:07 -0500
Received: by mail-lj1-f196.google.com with SMTP id q8so18648037ljb.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 05:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n/m3NWqGbb+4HJdRKqiqsaJ6PjbAVsfkhoBTq4U1QkY=;
        b=ZsEAf/YcuhuC44t1ZiPkUVNIPYrzUBgrLcwUxSs5WZbsDV0/kcBnFDTtwUUSC4wd9M
         oVGZQ0ybNKKbsoKtrbUPx7o9F1PvsVeM6SpsqzuCtCH0awXYQ3huy0yoPHRFkdkG9nIp
         hSxKXj+/rTvjVD91QSR6SIWyh5NjnACCQP6d6RY4NQYBfmQdY2pTsSAupGaYdAB8C8YW
         f1rxCZVTIcSuSwfQXwpKqH8M+hWvSGxUfftdHcteMV3b15UMFTIGPvv5bO4KitSQzhLW
         RWRh/2Z9EKCfqEf0cck22t893sJxz/BBOJC8WsFY+P9QmLy6V4BYvob5Ug4hDNxXOo2E
         A+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n/m3NWqGbb+4HJdRKqiqsaJ6PjbAVsfkhoBTq4U1QkY=;
        b=MBus7NrGkXolpw+bb7LVrwJXSiB25xLiCL9M/JuSRaKupNFH/hKk+/4/8gh0ZGPP2t
         50HrUK6r9DQVv/9Q377sdT7dHHMpzdwm0z2zk/75JQKL7BOyve/7BUpp3+gmgfH5JhZt
         gsGTZU6v8itjVqdGVXMbrpoV4TrqU3Y1Ac88wRid+1CqnrVrTHXcyGGZyOznr8rFxUyJ
         mDNggnFSWH4+wmEJl5dltl4l+BrejwO03nz4y3fNPkhFJgEvcNSIlAQ/hyK3vGLfRAvD
         7rAEcox6zGVPx0Ekp8SIrIO5Qs9ezcqLQNJrM+iJIXeR4f9s4MP+KklDNFACVGyc7SuQ
         7JXA==
X-Gm-Message-State: APjAAAUgTuxe+kWnz1c0Swio90J97YL19zvQCGvkQAoUB1kjyKq7Um/F
        vGo/iYYLV4aorMUIzALH2O9GOaxGu9w9DzokzB3ZmU2p8JQ=
X-Google-Smtp-Source: APXvYqzg70xarq/GVtWcCSLMMbK2uqnzbVPl7WsHYDFsLM43Rs6i4lwnDKroDPpkgGAnKIvpcLpStWwMNbxGN+RQR6E=
X-Received: by 2002:a05:651c:414:: with SMTP id 20mr16664224lja.165.1580823483575;
 Tue, 04 Feb 2020 05:38:03 -0800 (PST)
MIME-Version: 1.0
References: <20200203161912.158976871@linuxfoundation.org>
In-Reply-To: <20200203161912.158976871@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 4 Feb 2020 19:07:52 +0530
Message-ID: <CA+G9fYtJFiCNG2Z6hhgx=wzWDxhHaeP_zegynYG1eZx-Ejwvfg@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/70] 4.19.102-stable review
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

On Mon, 3 Feb 2020 at 22:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.102 release.
> There are 70 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 05 Feb 2020 16:17:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.102-rc1.gz
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

kernel: 4.19.102-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 32591972abd801a21846d4d355bc4e70784d02c6
git describe: v4.19.101-74-g32591972abd8
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.101-74-g32591972abd8

No regressions (compared to build v4.19.101)

No fixes (compared to build v4.19.101)

Ran 12112 total tests in the following environments and test suites.

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
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* kvm-unit-tests
* ltp-open-posix-tests

--=20
Linaro LKFT
https://lkft.linaro.org
