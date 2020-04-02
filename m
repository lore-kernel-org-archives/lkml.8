Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02C4C18E5B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8536C2063A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W+yspeD4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387537AbgDBHqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:46:01 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42605 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgDBHqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 03:46:01 -0400
Received: by mail-lf1-f67.google.com with SMTP id s13so1861058lfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 00:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=POxEV3gj5cjnPO9rMI9IMD58/NUgIZeKUsyUnyCZ2LE=;
        b=W+yspeD4JWWsnqpgdHoGlADkiuEdPw59EKlpn0eViFz5wlHzKZFkn1Z7OyaHwxPlLj
         Y8gTLnmmrwKafg4eJmpFAnfM34L/NErzk5P0YdYUk4Rpx6KzxIqnJYeaZsvbFAEzDedJ
         gZKSN+cq5RKj4+jc9odCyX78ivhNB1AZbczFK575LPeEdhHIVAL+J/cN2LMeif/yj9Z1
         amKW27YaVIRJdlbzKLvVA91rFUImtGdXXGyztq7kit7Rs9s9wrnSx+KOt8sn1giAA2xZ
         WDpGbAeqKeojXLXL1rBBcwD0Nc8Hdqd4uTpKpYh8sPAtppfiHmgakSSkbLFdeDO73DPy
         lsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=POxEV3gj5cjnPO9rMI9IMD58/NUgIZeKUsyUnyCZ2LE=;
        b=AyMnGDJsqKBWvlFd1/fvh4vtAooioLwGDyplDMo5IaMKn+++OP5vb+AHp5qv7hMC5Z
         zwDFbP7niNowYKpl5lkQYZ7g9WilFzwpDrgaUgIWkOjc2lsSBHLBSFFE7XFxrimVOsPj
         584WbQz38rFmOIYfom7hMAi9J9E59jhxH51RwFbcIQupbPce/ed7kQB8YpwbLI9LL0es
         U3aOEJBg8Y5FGCatZFB6Hr5NQ7XnnSYiu9rSGKZ/dUn15tDlLCUgiQaoa0YQf4NNwco5
         SJnZGTnV3Ssk9Ej508tETCLpjo6uvG5Cs+5jcEET0kGrB/JzNBkdWoHdvQh+bMetWAQ6
         6Guw==
X-Gm-Message-State: AGi0PuY+IHZ10ZSp6D5kFWi31E7YRacTXGgiM08RQ/HuZyJ8JfhwjeH9
        36sC1y/E3BOLRfgB35LH7l+0c290IzFmb3YuTN1ZiZXeNzg=
X-Google-Smtp-Source: APiQypL6BCglL+mKXWvslatfZWl30Hc678f0SMa9dY0CVlHkkFRnHXupeBxR23E9415HjLdGtIqX1ujoq7hN32HdbkU=
X-Received: by 2002:a05:6512:21b:: with SMTP id a27mr1309779lfo.55.1585813557262;
 Thu, 02 Apr 2020 00:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200401161530.451355388@linuxfoundation.org>
In-Reply-To: <20200401161530.451355388@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 2 Apr 2020 13:15:45 +0530
Message-ID: <CA+G9fYswn5TeEeuoNLx6i95tsaEirahBjU1V7Rc7ZMj2Lc6K+g@mail.gmail.com>
Subject: Re: [PATCH 4.9 000/102] 4.9.218-rc1 review
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

On Wed, 1 Apr 2020 at 22:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.218 release.
> There are 102 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 03 Apr 2020 16:09:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.218-rc1.gz
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

kernel: 4.9.218-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 61ccfbbfe9f63b4a44ef11f9ad40d362970cc8fc
git describe: v4.9.217-103-g61ccfbbfe9f6
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.217-103-g61ccfbbfe9f6

No regressions (compared to build v4.9.217)

No fixes (compared to build v4.9.217)


Ran 28143 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- juno-r2-compat
- juno-r2-kasan
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15 - arm
- x86_64
- x86-kasan

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* install-android-platform-tools-r2800
* kselftest
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
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
* ltp-syscalls-tests
* perf
* v4l2-compliance
* kvm-unit-tests
* ltp-commands-tests
* ltp-cve-tests
* ltp-math-tests
* network-basic-tests
* ltp-ipc-tests
* ltp-open-posix-tests
* spectre-meltdown-checker-test
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
