Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B70C3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42A52469D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tjPyr+q5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbgB1DJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 22:09:18 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35208 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730569AbgB1DJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 22:09:17 -0500
Received: by mail-lj1-f196.google.com with SMTP id a12so569951ljj.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 19:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TjCzG5NSP6eI0dKZwneA+fl8/Ikexg52Y5QCjmtem24=;
        b=tjPyr+q5fKYfhIxa/2RR8Jz7ZxB5Bh/V850E5RpGRzI6sj2Q6Y0R5bJO3+5R9dAiUk
         e2irt2I6htBM519JDf2PzRkRFAdpjO9NBZ/k95/IsqVWFkSCOpXaNANrM4WMl6AYuDeS
         FXJdsUuDIATid68YhPENzTo0BUndVZm5OdKdkCOATfOF4B8jsfjxrHgaZdkpKMUOSurB
         v6hl8pdhD5OjXnceNWEDsMKJST4ry6dsbt4db2pm+VxnBEn8GNSdYbhsHDSWPO9Pb26H
         cYMyxJjH2imihojFuSnWHAPWK1L3kzXK08HpxsdoAtRxUuU+HHOLKBYfLJlKMTaA3Z+k
         rljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TjCzG5NSP6eI0dKZwneA+fl8/Ikexg52Y5QCjmtem24=;
        b=pMyIlaGGIIMjzlc7GqfsHkR5TlzrGwucvULjDP8aso8oOygXEWsLDeIaPCeLwaW1tK
         hp9phGprn0RBK406QFPZo9+rUtZttydNCVi0HCzJmMPiwuytht1418uvVJmWOPwssWn7
         z+cxeoU3VTEAfxot4n62Dpkkmy+Jdl2ZBM4bDFSzPhj3O+Trxfns5IWpPZ0eNnNBpRNt
         qYXfwED19nE0xiOj0HpRUnx0cVGi1Il/8K3x7chro5D5htq9aYscQYOwFVBluCOZF+Yp
         RTVJeypD++36vNHtwtHDpQDIZ4QJssILzmAxoiyQ1qVoBFqhHtSv4od7tZe8LnDvS7V8
         bT+A==
X-Gm-Message-State: ANhLgQ1jfwLgOjAWWpCBMtihLILHzLDfrEt9qRzWy7isIhhAau/D8ec9
        tG6QOqnlUTqcpQZ5Cj9VmA6o8j0VW8TqhTLC+joF4Q==
X-Google-Smtp-Source: ADFU+vuSuY09khfpVx6XU3P6ALa1B0C+2ZslGsbVTOuskabM2UZA4frYa4LaFtE66juTafnLjXoXPUM8u7VL4x9ku9U=
X-Received: by 2002:a05:651c:1072:: with SMTP id y18mr1383581ljm.243.1582859355487;
 Thu, 27 Feb 2020 19:09:15 -0800 (PST)
MIME-Version: 1.0
References: <20200227132230.840899170@linuxfoundation.org>
In-Reply-To: <20200227132230.840899170@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 28 Feb 2020 08:39:04 +0530
Message-ID: <CA+G9fYsrUorARUDsqR__uMKNjxZa-jGe8AEro66wNhO3Ea0Lig@mail.gmail.com>
Subject: Re: [PATCH 4.9 000/165] 4.9.215-stable review
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

On Thu, 27 Feb 2020 at 19:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.215 release.
> There are 165 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 29 Feb 2020 13:21:24 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.215-rc1.gz
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

kernel: 4.9.215-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: b8e4943d6bee55c8a2c077fc7639d0b8e8127e1a
git describe: v4.9.214-166-gb8e4943d6bee
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.214-166-gb8e4943d6bee

No regressions (compared to build v4.9.214)

No fixes (compared to build v4.9.214)

Ran 26738 total tests in the following environments and test suites.

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
* ltp-cve-tests
* network-basic-tests
* spectre-meltdown-checker-test
* ltp-open-posix-tests
* kvm-unit-tests
* ltp-cap_bounds-64k-page_size-tests
* ltp-cap_bounds-kasan-tests
* ltp-commands-64k-page_size-tests
* ltp-commands-kasan-tests
* ltp-containers-64k-page_size-tests
* ltp-containers-kasan-tests
* ltp-cpuhotplug-64k-page_size-tests
* ltp-cpuhotplug-kasan-tests
* ltp-crypto-64k-page_size-tests
* ltp-crypto-kasan-tests
* ltp-crypto-tests
* ltp-cve-64k-page_size-tests
* ltp-cve-kasan-tests
* ltp-dio-64k-page_size-tests
* ltp-dio-kasan-tests
* ltp-fcntl-locktests-64k-page_size-tests
* ltp-fcntl-locktests-kasan-tests
* ltp-filecaps-64k-page_size-tests
* ltp-filecaps-kasan-tests
* ltp-fs-64k-page_size-tests
* ltp-fs-kasan-tests
* ltp-fs_bind-64k-page_size-tests
* ltp-fs_bind-kasan-tests
* ltp-fs_perms_simple-64k-page_size-tests
* ltp-fs_perms_simple-kasan-tests
* ltp-fsx-64k-page_size-tests
* ltp-fsx-kasan-tests
* ltp-hugetlb-64k-page_size-tests
* ltp-hugetlb-kasan-tests
* ltp-io-64k-page_size-tests
* ltp-io-kasan-tests
* ltp-ipc-64k-page_size-tests
* ltp-ipc-kasan-tests
* ltp-math-64k-page_size-tests
* ltp-math-kasan-tests
* ltp-mm-64k-page_size-tests
* ltp-mm-kasan-tests
* ltp-nptl-64k-page_size-tests
* ltp-nptl-kasan-tests
* ltp-pty-64k-page_size-tests
* ltp-pty-kasan-tests
* ltp-sched-64k-page_size-tests
* ltp-sched-kasan-tests
* ltp-securebits-64k-page_size-tests
* ltp-securebits-kasan-tests
* ltp-syscalls-64k-page_size-tests
* ltp-syscalls-compat-tests
* ltp-syscalls-kasan-tests
* prep-tmp-disk
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
