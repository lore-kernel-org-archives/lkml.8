Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9528CC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 18:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0D820866
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 18:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TSKj+cex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730797AbgAKSik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 13:38:40 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33026 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730765AbgAKSik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 13:38:40 -0500
Received: by mail-lf1-f66.google.com with SMTP id n25so3969104lfl.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jan 2020 10:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D7Lx6QKdjPN+BsyGqorso54aPbuVDzfozGFEQTw1gzg=;
        b=TSKj+cexHQj4Z4RO0op0VRv/WUpumFvQUc0X7ow/LsDp2Fesb5wGLsmza6XNugs3Je
         VdBe35LyqIci6QgsSY9fkT/6eUIBw42R0yqOy7xZZH6wWYAoE4KS/aX7cg4P1lsHZACk
         etwXAGvYR0uRl8/7zrwkQUCrypSsxR7p1ERboAo79Iu5fkzzrkq+36m+F8sdMFg9qrkn
         Dbas8PZ6A/xYfK38A2Dxq3CT8nUnJtrQz0UUswbyF6SikAOpYRAIJi/tMpFm+3M4+omn
         LBHdf9kL1oljUMS1SHBds2KyW4Y5MQbLkZ2vqG5QA5FOla5zdHlSExv+4i1lgTkvy77b
         p/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D7Lx6QKdjPN+BsyGqorso54aPbuVDzfozGFEQTw1gzg=;
        b=WghH/47MdB9YEkGM3q+cwU8+1BhmKtdzaI2c6oytb5JeXyE7Ji9PQmy09YuS/YzUYq
         smYlxvdT2ynVqvdA71EOzbvrLvHTqfdOSmC3FOvSul7YyiguQ1jA0eAruWF5hm1N9MLb
         VkiuobZ9n10NZrUkr1Q7ZKLvls+0Fi/xDclAg2GWGpmn0Nfgf3QYClIm3PNHPARhmpPD
         pqv2GDbYA8v3QSPifS5LfRSG5Tnk0MH44PLAgguDn+v36OoKBeKghewzOCkScWKojtDh
         g9r5UKEG4Np1721IczYXDxBzI/8OolcR19BWyaEG+OzZU/a17UPKOufIoTvFxWjTTl2j
         axLA==
X-Gm-Message-State: APjAAAUHTyE107m1F5m85pftYZS/JX6g0yxZ8f0UVAQDHD2FjYf/1u4r
        TN2QUBNQFR8ToVqBBbgr7O/Mrg79/dyGAyocSqnY7g==
X-Google-Smtp-Source: APXvYqxD9cWv+2KgN4Z9MNDzFI26ADoxVvNk4b90d4uOrHAmc94LHbsZUCRQWSEgnT78Vi7YI6ck24w4exIC0wLHJ6I=
X-Received: by 2002:a05:6512:307:: with SMTP id t7mr3960987lfp.200.1578767918160;
 Sat, 11 Jan 2020 10:38:38 -0800 (PST)
MIME-Version: 1.0
References: <20200111094837.425430968@linuxfoundation.org>
In-Reply-To: <20200111094837.425430968@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 12 Jan 2020 00:08:26 +0530
Message-ID: <CA+G9fYvuO=c3iDZZmnvcsvj9V6N=om02boN7Xg52JMGLLdAr4A@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/62] 4.14.164-stable review
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

On Sat, 11 Jan 2020 at 15:39, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.164 release.
> There are 62 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 13 Jan 2020 09:46:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.164-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.164-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: f19c9ce5806662f4d9fd123d41bfdb5195bfc96f
git describe: v4.14.163-63-gf19c9ce58066
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.163-63-gf19c9ce58066

No regressions (compared to build v4.14.163)

No fixes (compared to build v4.14.163)

Ran 20812 total tests in the following environments and test suites.

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
* linux-log-parser
* install-android-platform-tools-r2600
* kselftest
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
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-open-posix-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
