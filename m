Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC5AC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 05:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C0E20719
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 05:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Azmg9Eu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgCYFP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:15:58 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46563 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgCYFP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 01:15:58 -0400
Received: by mail-lf1-f66.google.com with SMTP id q5so685253lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 22:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u3sxRhWQUyC52T2bD+6qS7G0Nu9lQIcnTtKEQUjYFy0=;
        b=Azmg9Eu8MTFmU6YNB/REW+8MtWCCV5cSg1DQ8g2Y7Mn7ntbUlIVVaLVNG5+yAA0Wpa
         e0IYaR3esQQVJbgSTRbQNEvyuBu5j0oTCKY2DEfPqnc6rBV7tYUOEal5fXiFQDYDWQ7g
         /dRYg9yzmn9/yxGu7qDfVUiiyT0P+Y7A7mzSL53v6fPFLZt6HXs80lRmK1W3m2IaCd4s
         +DHtHWzERL5nSQZoi9mmZnXDyikJktU1qrLbtt2HOjWduvNpkyguANZuaWM/vHp1S0Xe
         Omz8E+1AQAJxJXpw4iQB4mKwhinv+JwG/mxpCNIH7q/wvhpOcyvOJKDA4crSoB9SFdIB
         4wJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u3sxRhWQUyC52T2bD+6qS7G0Nu9lQIcnTtKEQUjYFy0=;
        b=gGOjwEnTNJm+kUpn0kFX9sxXjLXvdbWvShj4CaPXYI+5NMeEOeh/oXJ3pi/MJ3iiqW
         9Wr8tkoEKiuteCYwFXYfbhynxcMh+5mIpa9axIXfCtbcvpIPL3ctvE1raIQ7IWooNYJn
         3LGsYPDYq8Up+1TSlW4HTxdIYd3/UhEd40x1NwmlHgIqYVw2FNpfb1o5qVKn4YBOiy21
         s8Ql3YxS5tG9sZ6VdKlxrDr9ym3WDA6vtBBvN+GnbfimR8u9KzD/d27d5CK6/W4wzmT+
         CXMhD5OFTrmB1v9r1NfBw1Oh+iQ4doVA0YwNtmlfFZsjYesvYFHp7rZ800KIFO4joaGA
         izrw==
X-Gm-Message-State: ANhLgQ2uN34JJsU12ya1aoyqEAeApfb/3D453+nYYO8LHW/RIU/EHJCb
        MJNzxGGc1AONs9YfY02AtIIzCC1FNIAexT1BPb6Myw==
X-Google-Smtp-Source: ADFU+vsd8UcCRfMVthnR1HjdgyeQtvnn3T9U+pcFRwM3ZItacZeerqQ4BqTc2Z4F9ym9+02KGIdee6ObxCLb5mk8/QY=
X-Received: by 2002:a05:6512:3188:: with SMTP id i8mr1116301lfe.26.1585113354323;
 Tue, 24 Mar 2020 22:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200324130806.544601211@linuxfoundation.org>
In-Reply-To: <20200324130806.544601211@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 25 Mar 2020 10:45:43 +0530
Message-ID: <CA+G9fYtfn=F8zof9nakvt6jae=cO+0FMA9O3gJq+1Fz9uCo-bQ@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/102] 5.4.28-rc1 review
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

On Tue, 24 Mar 2020 at 18:50, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.28 release.
> There are 102 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 26 Mar 2020 13:06:42 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.28-rc1.gz
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

kernel: 5.4.28-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: 14bb11f6495febf1ba14babcf03935cc83827808
git describe: v5.4.27-103-g14bb11f6495f
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/bui=
ld/v5.4.27-103-g14bb11f6495f


No regressions (compared to build v5.4.26-51-ge72abf1f11a9)


No fixes (compared to build v5.4.26-51-ge72abf1f11a9)

Ran 27616 total tests in the following environments and test suites.

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
* install-android-platform-tools-r2800
* libgpiod
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-ipc-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* perf
* kselftest
* kvm-unit-tests
* libhugetlbfs
* ltp-commands-tests
* ltp-containers-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-io-tests
* ltp-math-tests
* network-basic-tests
* v4l2-compliance
* ltp-fs-tests
* spectre-meltdown-checker-test
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
