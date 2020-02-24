Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B541FC35669
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 04:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8367820658
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 04:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VfL//+FE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgBXEXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 23:23:15 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43538 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbgBXEXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 23:23:15 -0500
Received: by mail-lf1-f68.google.com with SMTP id s23so5778822lfs.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 20:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Pt6X+M8P6dFxT4s+RSDntz1k7U0jYotP7Nm27O/PO30=;
        b=VfL//+FEVZm5RDI7mmgGD7uzsh1Omu0HIAEOuDHhgNWvLikk21NIsxBl9aEjd/JInL
         6elbKWTGq/Enx4DQP6ZZOz/iGObmPL7BaV8V2HdRPz9DKwpe9rxiHXlb7Z8GMbMpKJze
         M8ES2O34HTz6V4DoeCrpiw3U4FOT1ShYlOsVjQYJ4EQkPj7pePt0xa1tL2sdWKnCqOmT
         czkCZSin+DvoPDVzcoAKcjDZkPzr4Zx5EsdglKiA9m51a+UNlB0vNSpa7rHC2ayYOg+f
         fd2h9eXR/84hfXOgzPaQf3AfZZwjAiusKj2qRb8HwLVTbZcEb8nsrAcGS9uxElEJKCRh
         NlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pt6X+M8P6dFxT4s+RSDntz1k7U0jYotP7Nm27O/PO30=;
        b=l6wZhm5pNnw/wHwE60/ik61kL7T6FyEgmYqtvKZledKQM2++PCTFmtIHJQfAZ0Qkyb
         jPw1MOXwSbdRoj+Ns7pfG6m/U2r67xv+/Bxm8fksSw5lsT5cAftmlIn2QdVBgXr7g2jT
         wg3raaP7PSEk/uRCeH1vlbwt3M6KMOR5I8qjjeu9zd6QIwrkcmgGo6h1grCOgAu7OqcS
         FoRk6iOj9XUhHYawY46ZaCrIBG+s7l/88nZ/GGdHRLbYzhxLNo/YJNxrNiTjt3P4dWyQ
         MZT4OfA0uyY5bhWy9vCmxnKe8ASVdRVsDtgR6p8XkfJa6Lo/10+vunxoNe6CQcrg30t4
         Cd+g==
X-Gm-Message-State: APjAAAWdb5StIDTSTZ/ymozHx+WL1hzaRQbaKZpDEQwc2pasB4k4haq1
        5iNbOVLPoe7VE9hGkYhvwcoI3c2kWrXq/+9FTxZ8Eg==
X-Google-Smtp-Source: APXvYqyxRLzyklshoJ5tT+wQkjYce6UzqZJxkoavKgN/1M6ZmRtjIadS4T5V+aHLwy+bvzEKFyPUOcAPm6w5qow9PuU=
X-Received: by 2002:ac2:4467:: with SMTP id y7mr3961379lfl.167.1582518192775;
 Sun, 23 Feb 2020 20:23:12 -0800 (PST)
MIME-Version: 1.0
References: <20200221072250.732482588@linuxfoundation.org> <20200223154121.GC131562@kroah.com>
 <20200223173122.GA485503@kroah.com>
In-Reply-To: <20200223173122.GA485503@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 24 Feb 2020 09:53:01 +0530
Message-ID: <CA+G9fYuBb14Ce6TauWj-Kd3n6jy9vgf9HE93MbwgqL6B_O4Pow@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/191] 4.19.106-stable review
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

On Sun, 23 Feb 2020 at 23:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Ok, -rc3 is now out, hopefully now things will work:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.106-rc3.gz

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.106-rc3
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 119e922a87ef462ac31618f71713a252895e3f11
git describe: v4.19.105-185-g119e922a87ef
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.105-185-g119e922a87ef

No regressions (compared to build v4.19.105)

No fixes (compared to build v4.19.105)

Ran 26767 total tests in the following environments and test suites.

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
* ltp-fs-tests
* network-basic-tests
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
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
