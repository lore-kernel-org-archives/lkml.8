Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7391FC10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C19220873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lnn57H92"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgCKHxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:53:09 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33549 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgCKHxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:53:08 -0400
Received: by mail-lf1-f65.google.com with SMTP id c20so867279lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 00:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dmYpz/aYVnj1bUh+RSDK8X311SKNrr0dk2BrKf5slAo=;
        b=lnn57H92SdNASu+2A/R6UAAKJ+dWpQA2U1nV6pNZiM1cr/0Ln+gEkCR+zZrGXyS7+X
         fvZ05Mp8Ei+KOe/9zt2SjWDynKlCyrKu4UGWCLWh9AfDGFwbxzcCH/g6DQCK81xa8Adn
         R69XkTp4XMSFN54l2XgczZhCgw3phSfCYX3qHFxmP+NmUqq7X7dNr2ZxqWBEp5MO4jTA
         VkS4G6EFH+bvFIJJvC6lHE7wi+iDVOZtbXevt79LhROGLnBRvA1wHpHlgUTayXcJgGlX
         9VN5XSoWJLkQB7YURB7AcoeEMcz5dV/65P6GZEUGTg/r8YfJRJpdu05O5aSYNsN3vf8b
         RGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dmYpz/aYVnj1bUh+RSDK8X311SKNrr0dk2BrKf5slAo=;
        b=WzqtjG1i+DZpi90DA4udEfdfR7DlBQa3ZmY4qfPmwE34thP9afY4FqZqwoqtHxop8m
         6mlSVsVn18eWREfmP+Gjmgs9IrlPya9SG618/NMoTK7oRHbbpw16es7/RaILyreAlv8M
         LcJkXUiyomqqRnF8IYn3FEePPe0jUeHfCUDNUXANRgrUbazk2Yx8OeVgq8JfBGluqQPP
         EmAiggwCq3YJWtx8DWKZr4esHC1N1AITGqdrpy1Pl6kjb/KfosryZDTwcV9IZts/2YUR
         AgY70OElwSJ0XwDP70h4m90RWAPN/fIUm1Id9VN3KPdKpaNLh6d1elucL3pQjOhz5LWq
         lVFQ==
X-Gm-Message-State: ANhLgQ00XH5cvCsNlK6iUsu79rKJxhOH14u+gbqreYcZlJrGiESfV8cw
        Xl43ECmU4J5qRX7y0xBnZ5OegGIlKXxxg4FjdoSQXQ==
X-Google-Smtp-Source: ADFU+vsNiDJQhI3JYt02VwGMK03BIvdCMAH8jElfm3TdyDiJXGGw/8PAaypyOh6jVmy0oBjylxkwATDLsLWyFA3mqwQ=
X-Received: by 2002:a19:4c08:: with SMTP id z8mr1315189lfa.95.1583913186300;
 Wed, 11 Mar 2020 00:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200310123635.322799692@linuxfoundation.org>
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 11 Mar 2020 13:22:54 +0530
Message-ID: <CA+G9fYtAjT1iBMCpPjKBcjrPPuqQ-WPU-axgikmoifyxJYJ5vA@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/168] 5.4.25-stable review
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

On Tue, 10 Mar 2020 at 18:19, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.25 release.
> There are 168 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 12 Mar 2020 12:34:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.25-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.4.25-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: 877097a6286abcb4d5eaa7d683640e3a86b7a95c
git describe: v5.4.24-168-g877097a6286a
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/bui=
ld/v5.4.24-168-g877097a6286a

No regressions (compared to build v5.4.24)

No fixes (compared to build v5.4.24)

Ran 26864 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c
- hi6220-hikey
- i386
- juno-r2
- nxp-ls2088
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
* install-android-platform-tools-r2800
* kselftest
* libgpiod
* libhugetlbfs
* linux-log-parser
* ltp-commands-tests
* ltp-containers-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-math-tests
* ltp-mm-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-cap_bounds-tests
* ltp-cpuhotplug-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-ipc-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* kvm-unit-tests
* ltp-crypto-tests
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
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
