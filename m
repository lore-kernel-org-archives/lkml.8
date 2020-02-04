Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EF1C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 15:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48832082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 15:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fs5Wt2se"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgBDPp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 10:45:59 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34157 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbgBDPp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 10:45:58 -0500
Received: by mail-lj1-f194.google.com with SMTP id x7so19154603ljc.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 07:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k6Slq5vFgcD5zirO7zotlCMns+OlHVMHgfQPFMOibrQ=;
        b=Fs5Wt2seqoq40mV/saXyQsHcE43Oky3V01mtKkRbpnbqQtzDtANujVUntXS7wnWO9e
         fjnLd1hk/YDFFWRdWCw6B8mcZi0YOov/FKgdzqo2rflAee8SWhbiLY+e3w8DzgGqhsQ9
         zeeeSYOiis7XhXNAyV+Te+yKbgdqekShezVje5K6V0C7hDBmnpqfgcdW89eECwtqNxTw
         Ew2BKKLdObKmu42ous6FEnNmx6MOVJlksZ5uAdlW/EXl9l+lDobxhQc8MMozmhdeh7Q9
         XR3hP3Le1t4ersgUQK8E0J0rXJIMZ7YcoO5bsWDaEMK9jEaZdZ92k1KZBFEvgJUADe2H
         llRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k6Slq5vFgcD5zirO7zotlCMns+OlHVMHgfQPFMOibrQ=;
        b=G2Rckh1M23oxbRnPzGxsIumwpDbzH1QYHvsxn/NBw6BATT2P/9lzhwy5T+JGG+4nH8
         yRJaGnQwxkkVxhcucyPrxA0zDfphQz62KGieI6fCt/qyOrFlUDGi39VV2sPepSwgSDSR
         JbkKT4aEu1Ly3/ch/X2TkbDpBXsmWaNIo6rRk6Dx6iORLZWwKDMBZTiGHFN2CO0olj+4
         /075UHXMzRGtC7yqJefr0QPzOxxMTToT+DEaP56ezmqgj1XFAWxQWBmAl4LBzGFHTjVb
         we34tATn6HJG0J4sS3RqT3L8+gCnTWRmIAcDVbbbDqrZCvL43/g+JpA+GQg+jbz/B+fa
         GUDQ==
X-Gm-Message-State: APjAAAX342Lwm2wNcPGvJuV2tebQNaPUmdES5DEh0OZmdKoC4Rk56Wvs
        569ITZ8Shwvt47c+eWFT+IRaQp1hc375cT0uLh+Dhg==
X-Google-Smtp-Source: APXvYqwQOo0iPGAD/bwLoBLBOnzwCp+meSozRDAd8N/Bs4mMjPUH+km1/6apumCLz+RxjrXdzA+zqPY0JJ4VB+/39KY=
X-Received: by 2002:a2e:9008:: with SMTP id h8mr17642797ljg.217.1580831155328;
 Tue, 04 Feb 2020 07:45:55 -0800 (PST)
MIME-Version: 1.0
References: <20200203161902.288335885@linuxfoundation.org>
In-Reply-To: <20200203161902.288335885@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 4 Feb 2020 21:15:44 +0530
Message-ID: <CA+G9fYuzYzwqaL6_5=2+KmRHy=BDRS0WgW2dGSL6wi+_FFFhCg@mail.gmail.com>
Subject: Re: [PATCH 5.5 00/23] 5.5.2-stable review
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

On Mon, 3 Feb 2020 at 22:08, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.5.2 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 05 Feb 2020 16:17:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.5.2-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.5.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.5.2-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.5.y
git commit: 4ff4fd2d564ba792fa27ff72393eb5a4b5bd78e7
git describe: v5.5.1-25-g4ff4fd2d564b
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.5-oe/bui=
ld/v5.5.1-25-g4ff4fd2d564b

No regressions (compared to build v5.5.1)

No fixes (compared to build v5.5.1)

Ran 11148 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c
- hi6220-hikey
- i386
- juno-r2
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15
- x86

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* linux-log-parser
* ltp-commands-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-syscalls-tests
* kselftest
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* ltp-cap_bounds-tests
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
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance

--=20
Linaro LKFT
https://lkft.linaro.org
