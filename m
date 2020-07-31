Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B76C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F72E21744
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b7SuJcKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733109AbgGaMrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730643AbgGaMrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:47:55 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A61C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:47:54 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id y17so3555586uaq.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SotxFjE0W+edo13KS7StpRXP9GOeYHuYYzY2O/efCC8=;
        b=b7SuJcKN5oU/UXsndJ1zeSo4qXRIus9fDZ8ltCYr17q9OqHG3GBmjNXqHrE5b/rkTN
         uilb8HTnFJMzgRSalOTgks4j4crnvlnwoU12u0XtszBHHhrdjg8y6HuXwqIWoiOHh3tO
         EmIF+IpFrEzaPS6C7hSBEZ1XE1q7iMtF+WdPwWiBsVYCjx8bZwz7xMxKnliGgRWj3c9M
         pgL22kBD2iAjozZPdxwsmbPjd3IfwVKNJ1dT5iNhD+Bq4y4jMNcZmZT3hZwm4RypPm/l
         5QFYXnHBRF13w9WAQlbJ1Rtt5iq9g89sTg52xh2syOBqohnnmCKSLPWWVh1EJs/yaEyo
         1MCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SotxFjE0W+edo13KS7StpRXP9GOeYHuYYzY2O/efCC8=;
        b=na/67ckL4iMH911f/s3xQO5JTjbrrBzm095/18wiTWn3YGiPoGujQLHdXAoqjTIU+J
         GajNYMr+C0WAV0yBqAMPOk8EKyRAxr7ig5OhC5+eMUVMh73UMms4m2sxxDQ033RdHLts
         G1/ngPDpPLFcJV2r3iKQ/EPkKrDm5Lc2rZ1YumgGAKJSOfMgSxm2puyXwC9ffJG/de97
         lCxtEQFyYRjjA6dFZbZCniRXGP2jkZaUdze7za+YqECrPpVeCNdjFbZxiELYE/yX8Zrg
         x1diVxJxX83mQ3VG/dPCS+wvqJrshL/umK8+nhJ119qX3AlqZIf9ipYxPG5Ka6XB2cIW
         2zIA==
X-Gm-Message-State: AOAM532HrY1GZXrAzY47a9mEMvJSZXW1mJuVBfiOYVUWuQG1tUnBR7xC
        NKfAUM+VUxLtkBHcpY8zuU7crf7PWOn9M2OWAk6c5g==
X-Google-Smtp-Source: ABdhPJxEzTUm0bHI0XFlA3EQvdfeNZhFf/eSQgUsFnGPYS4Sux3lFB4vyHHgisJYGFO9cdlGDO1xbZCeubHDCO4iTiQ=
X-Received: by 2002:ab0:5963:: with SMTP id o32mr2292610uad.142.1596199672211;
 Fri, 31 Jul 2020 05:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200730074421.203879987@linuxfoundation.org>
In-Reply-To: <20200730074421.203879987@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 31 Jul 2020 18:17:40 +0530
Message-ID: <CA+G9fYu6c8iZuB1t3z=j60+JNPZ=So=gyqBK0b9P6r7+kmKYjA@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/54] 4.4.232-rc1 review
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

On Thu, 30 Jul 2020 at 13:43, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.232 release.
> There are 54 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 01 Aug 2020 07:44:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.232-rc1.gz
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

kernel: 4.4.232-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 0ee6ef294be6266800b03470220722c82b6ceb47
git describe: v4.4.231-55-g0ee6ef294be6
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.231-55-g0ee6ef294be6

No regressions (compared to build v4.4.231)

No fixes (compared to build v4.4.231)

Ran 18356 total tests in the following environments and test suites.

Environments
--------------
- i386
- juno-r2 - arm64
- juno-r2-compat
- juno-r2-kasan
- x15 - arm
- x86_64
- x86-kasan

Test Suites
-----------
* build
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
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* perf
* v4l2-compliance
* install-android-platform-tools-r2600
* install-android-platform-tools-r2800
* kselftest/net
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-native/drivers
* kselftest-vsyscall-mode-native/filesystems
* kselftest-vsyscall-mode-none
* kselftest-vsyscall-mode-none/drivers
* kselftest-vsyscall-mode-none/filesystems
* ssuite

Summary
------------------------------------------------------------------------

kernel: 4.4.232-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.232-rc1-hikey-20200730-776
git commit: 2d0c7614039564b9d27d100caf1acb1eb33c1c9d
git describe: 4.4.232-rc1-hikey-20200730-776
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.232-rc1-hikey-20200730-776

No regressions (compared to build 4.4.232-rc1-hikey-20200727-775)

No fixes (compared to build 4.4.232-rc1-hikey-20200727-775)

Ran 1841 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* kselftest
* kselftest/drivers
* kselftest/filesystems
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
