Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451CAC34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17FD5206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UHca1o/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgBSCjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 21:39:18 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40816 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbgBSCjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:39:18 -0500
Received: by mail-lf1-f65.google.com with SMTP id c23so16099453lfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 18:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=60VIe0tObFe5ZoC97rjmVnguUIDOMQa1br+X3tRbe10=;
        b=UHca1o/SHo7SCNMRYI5uY8DaMu5GNllMTWkGXc5MS7P+s59msv88R2RviPw2CrOdtu
         CBYu4sbldJnVT1FZ4EGw/g0beAcwJZibwEdKWreHa7YxWkDE+ddKocoIZ9UR7ShdnQVZ
         d0rJP2X2GMfBDkIsJTqnqbDLsagB+KbZGkN4sIy6+SQyvunqj6whX/S3KiHe+CCAuSUe
         V8V6ErHKDlLBVBklt76W8/t2SyUb3RxNGmYwe/GRHBAp/LmO2TRDnCr8tJNL5x5W3OeH
         aN2WCvS1jho5+x6IQlq90GqSRdcEHfB7aS4FipQh2m0FegTyCBpi43myQ0pZrYyZekNQ
         3Baw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=60VIe0tObFe5ZoC97rjmVnguUIDOMQa1br+X3tRbe10=;
        b=ZMpn5JTuW8twY2L2xCa2REAzTSxby3Qb/+cf7I8nZtWe9t+bkMz95vL6CX8C9e4krN
         ORN9LaKoTnrsqJxwTu+qnqRW2+YoTD2Eh2Y883lfVa7d9oArn0AspoTVeURANfbnsCTu
         XpXlSrq6Y5uPRsmtpLr92JsaK1FRY7TdeiRPwv8qLmrtqU8CemKT5oJ+cJ3sGEUb2JQT
         aADExrHG/tRJbbGIlBLIExxE5qGLhtMlBe1vwMXpxomax1y14nLxy3DNAUyfWR5pYCD7
         TlB07FElmqPZwLYA43KEKHvFwgjsN9RAl4IVYljay9050FyyrUaAzZWUwml3K/8uFt/f
         9bjQ==
X-Gm-Message-State: APjAAAUjde0nA3xqwyfJDf8cX4Ku07eqJJOAcN0pNat0g2h/yom8QRPn
        wRYvcwG9vhhUWQk0xXc+sZgJ8aCZyEWK0l/iQXusIdWvrmc=
X-Google-Smtp-Source: APXvYqzJM6Bp8/duZfOtgIHDfdILC0e0bJjneyJsmVwnnJSvPRPpbhC+jzIEaDDX+lRvrEHkDYny86gzlmRYtk6cP2U=
X-Received: by 2002:ac2:5467:: with SMTP id e7mr11383861lfn.74.1582079955688;
 Tue, 18 Feb 2020 18:39:15 -0800 (PST)
MIME-Version: 1.0
References: <20200218190418.536430858@linuxfoundation.org>
In-Reply-To: <20200218190418.536430858@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 19 Feb 2020 08:09:04 +0530
Message-ID: <CA+G9fYsdcDkYdinGRW+0dtEz-qojZi67dsbnuiOF1=LiWKaUYw@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/38] 4.19.105-stable review
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

On Wed, 19 Feb 2020 at 01:27, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.105 release.
> There are 38 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 20 Feb 2020 19:03:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.105-rc1.gz
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

kernel: 4.19.105-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 85265e81d664e50b5da918dbdf02b5bbb926b2ea
git describe: v4.19.104-39-g85265e81d664
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.104-39-g85265e81d664

No regressions (compared to build v4.19.104)

No fixes (compared to build v4.19.104)


Ran 23734 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- nxp-ls2088
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
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-fs-tests
* ltp-syscalls-tests
* network-basic-tests
* perf
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
