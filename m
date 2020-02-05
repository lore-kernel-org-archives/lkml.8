Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1220C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 02:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88EC521927
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 02:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tHokK2VJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgBECDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 21:03:07 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42164 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbgBECDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 21:03:07 -0500
Received: by mail-lj1-f194.google.com with SMTP id d10so650259ljl.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 18:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LHnuyGIfX6fYhv02t7tNCctT4Vu0FVFSMgtbht1nPg4=;
        b=tHokK2VJWv9DFwK9Hpo89gftC36nsuBi9MlWxYJyShPVJLvflLi55DIXPRsHKTjC+t
         TGZstrCK4xEcQyfu2dQp6Swgo6i0ZIL+gtzWCCuq5Mu5wCtducyEgcnNTm0CJd23/6xx
         SwqIRNAiE2IpImTMRygXxLJMctqL5osUhRxhY8GV7YsoTlkSLqR1vZNYyKOeN6iFxPGw
         GCWFFKLgvt+oVISzd8n4fa5SsCBgva+KyTNzmhKTN8RvYNvpOQhrAHZ5f9HVrfzeqakg
         Nags0cOrZr8ahDpDt9cvrvz4GfJ8pRicN6siBXE4De9KDbg87kwcR19tBzlrcQI+tXvk
         CVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LHnuyGIfX6fYhv02t7tNCctT4Vu0FVFSMgtbht1nPg4=;
        b=pu3+eCmqHIM469W0FUBkoYNKWTHN2f5LbDgII2zyOqTb8aRhuWYgTIA5rRmi7UzP1I
         M5QWxhLFMPo16g0+MEob39SbGG8GLv6j1Ga4QDm9rwWFFyedUjcq8LcBwHe2aajUxuk3
         TmcJUSd5ff/ZhdnzvzzgZWhbpUY41rimmXYsr62xJkugFne0F3ZM+7OWm+kvj3seANCx
         bJ1gyTjHZGTApjSvYlKT7ScF+Vsp+IbnZFHiGdn3UTBoMbl18x4zNist9oZ70QKRqKSb
         jPZKiPQIOqJV7ZM/UosFwKkG92NmrUrxh2Gc/1KaaWw4uQL+8X5uSarmyFzDbEpa6JRP
         Gb6A==
X-Gm-Message-State: APjAAAWBeCyHiWNZIbXji4bFghGHKfrX3V76MrebMheRq1ypLtH+s/Rj
        AKHu4WFJccyAElh2TYLINZMflkSEo+IoLEh8iVKrW7lXSsk=
X-Google-Smtp-Source: APXvYqxJkaGaOKIUevDETw2wLDQ72vYdn6McchXmzJyPdTrB42eoHxTteyOCGp/L02ed8RNBtNkccykXLARWK7zPYII=
X-Received: by 2002:a2e:8e70:: with SMTP id t16mr18909666ljk.73.1580868184678;
 Tue, 04 Feb 2020 18:03:04 -0800 (PST)
MIME-Version: 1.0
References: <20200203161902.714326084@linuxfoundation.org>
In-Reply-To: <20200203161902.714326084@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 5 Feb 2020 07:32:50 +0530
Message-ID: <CA+G9fYv0jo8571dFpuN=DSdn9aVXNx7-jwn3V-DXFFPZ80-pAQ@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/53] 4.4.213-stable review
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

On Mon, 3 Feb 2020 at 21:51, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.213 release.
> There are 53 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 05 Feb 2020 16:17:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.213-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.4.213-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 758a39807529795c804023beb3dd12d9494760cf
git describe: v4.4.212-56-g758a39807529
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.212-56-g758a39807529


No regressions (compared to build v4.4.212)


No fixes (compared to build v4.4.212)

Ran 4894 total tests in the following environments and test suites.

Environments
--------------
- i386
- juno-r2 - arm64
- qemu_i386
- qemu_x86_64
- x15 - arm
- x86_64

Test Suites
-----------
* build
* linux-log-parser
* kselftest
* kvm-unit-tests
* libhugetlbfs
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
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance

Summary
------------------------------------------------------------------------

kernel: 4.4.208-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.208-rc1-hikey-20200101-645
git commit: 45aaddb4efb9c8a83ada6caeb9594f7fc5130ec3
git describe: 4.4.208-rc1-hikey-20200101-645
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.208-rc1-hikey-20200101-645


No regressions (compared to build 4.4.208-rc1-hikey-20200101-644)


No fixes (compared to build 4.4.208-rc1-hikey-20200101-644)

Ran 1568 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64

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
* perf
* spectre-meltdown-checker-test
* v4l2-compliance

--=20
Linaro LKFT
https://lkft.linaro.org
