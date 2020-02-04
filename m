Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640C4C3524A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 05:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4402086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 05:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BMVwg8aH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgBDFek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 00:34:40 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36874 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgBDFek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 00:34:40 -0500
Received: by mail-lf1-f68.google.com with SMTP id b15so11345148lfc.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 21:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0KHT9BhfgYaqDdW1CHcbpVPcZ9QsrnR6avg+5+waSTw=;
        b=BMVwg8aHsjGccry3A+S0CiSUUP/XULw3LG/W1EJR/js6Qkacit7jys9CFw9lm78wXw
         JUge7PysVYyGE0Enjc41ZGjwXaJTeUCQONfp72AQO9Iljaf3dJnEbbB1lbDX1RCYM0vQ
         FTDgo90bntWOaf1+xbP/XmxkVu9dhbNPV/s8gNmjd6PWnJtn5C2VQFS2wPCJ56JXPpEk
         OJL5pwfhUsHPI3isDiTMrit007ng0/t4EHRwNyib16no427IGIkOwpwqy28GnWDj7Dse
         ESE+ACxER3vDGT7yRgvOXqh43NVMEwqBX8iWw3ce5Bq/eGPPLDcZ06tA4RI50GL0Y7p5
         uZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0KHT9BhfgYaqDdW1CHcbpVPcZ9QsrnR6avg+5+waSTw=;
        b=jj8tAmekg57arOESQfGHpHjYfnzw8wWNEaSXOvZEwAJKkmIs4CujaFayEf58TBUeZT
         pQsxIPEtsZIJcdMQ8INEa/HHrNerxymcDOmbvX47EuHAqi6dkQh/3f7o1/cLwv5GbrQ5
         uBfqg+ebuTs1u2CY7+nY8cF65shnSBaJJ3KEbgUxyFKAXWJKYHKfNYYw69G69PxJ2qr6
         sUSzAqFzck/MCJXFqWODb59UW+1XzLcjfOo/EV9uWUQYYNx7T59gaW5pVXsey3WghZhZ
         Hjeu2j4MVm2LPewM2/hLabGEgwQdcQg2Z8f1RDn/pTz4NotcOyDLKBA84tL+VloTLlOL
         ZmnQ==
X-Gm-Message-State: APjAAAXMKQqS9G/SLSVRTs7xTbVaORNEEmVsUnyFX96ueL2zKb/LNDEZ
        QXIiwF+vJOacaK+CmnVKo7yAByGuH8AXVREi4gFYqLg3myg=
X-Google-Smtp-Source: APXvYqyh8ZtBIBNXC59ZOsX6YIz0B4nqBc5/8pd/XZs54VWPZaZL1d6OWZzI1+lD/ShiTe9kCo3277c4ajlkeA7VpuA=
X-Received: by 2002:a19:6d13:: with SMTP id i19mr13484357lfc.6.1580794476891;
 Mon, 03 Feb 2020 21:34:36 -0800 (PST)
MIME-Version: 1.0
References: <20200203161904.705434837@linuxfoundation.org>
In-Reply-To: <20200203161904.705434837@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 4 Feb 2020 11:04:25 +0530
Message-ID: <CA+G9fYu00d=x9DrhdoTva9b+SGK3fOwmAF2QvVa+qH0rCPx2mw@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/68] 4.9.213-stable review
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

On Mon, 3 Feb 2020 at 21:54, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.213 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 05 Feb 2020 16:17:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.213-rc1.gz
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

kernel: 4.9.213-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 1fec4502bd05d2ac63a18e776d588d9fac65a35c
git describe: v4.9.212-70-g1fec4502bd05
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.212-70-g1fec4502bd05

No regressions (compared to build v4.9.212)

No fixes (compared to build v4.9.212)

Ran 15083 total tests in the following environments and test suites.

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
