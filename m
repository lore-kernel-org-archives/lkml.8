Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F973C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2BFE20663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dLWJ2Tcd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgGOGVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 02:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728530AbgGOGVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:21:47 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644C4C061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 23:21:47 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id i80so414974lfi.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 23:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v2wuTVz9P4mwdq6L6Z7DCEAHLkfBGhYGvO53+VjpkQE=;
        b=dLWJ2TcdhQb13BOA9YB3K/O3wCXuCzdnqeAazsW8c2lUxAAPBSKVl+MgtLXLXOsow/
         9LnDts/FiAKkGASjhyd/P49VHgfalkxfc9aCbSdI2VudyqRN5YKHsAX6000fHLOVk0Gg
         x66lDfttzCx/cTmgg1JLz2MaS0XHWmSFbfmDpbcDTUr6xwXYFRk3res+LMF3Uj81oNHW
         lkiDVnjXK85ZlyzppgxdVFrNwqQYFD6IGVhrJT9PFxc4eWFpypJ0tDKj0Y2aJzEUq0ij
         z7EUET3CqkYl8KMwXkUAt6OdOaq/qjL5SfQT4AF0Xv1HWT/ZxmI9QgGcWsHJHuJESrBe
         tgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v2wuTVz9P4mwdq6L6Z7DCEAHLkfBGhYGvO53+VjpkQE=;
        b=jL32vaM/Le94s0FsD/fNYPyQzd3bfxFhrMRUaKnyk2x6DRmPzdiXFvNDxb2sVVgwQ/
         lijPGVL7+9Os3hDb+2e/VUzPaIUy8+nyMf0/S1rwNPGWeIFVNeVRWZ/1Nowx8p5/XNcp
         WObPgAGEN/VT2FfV4zghvZV78e6YuPOKcwgvoXkOl/pmiaYwo7QIXJs9pSS4Xav1eSeN
         +VKHCNMHbJzwtUj+p2lLC4hnfW5y4Jg+KPkEbMYOLTafX9mo/YtOgl6/SfKiMKQPzhKu
         XjvmTXCIvwX3joBK4asJGZ5L7CjledvaClZMphyjikimzncq6Hk+G7yzkgG/4JKKOziR
         Qfug==
X-Gm-Message-State: AOAM5321zssarrjMq4wNdXe+SPNhUCz2jtLy+aDa1dg5leEm55jfAXaQ
        vqDCHEBG0Jb+KsGlBMlio3/ZEwAfm4sI/MDmnUqtSwRG1XOZUg==
X-Google-Smtp-Source: ABdhPJxjFHflG0oTbQ/TMqZOlczkYPmMoYYULz8cGpvA/ShKMsc/7O6zHiaDIDi0o/62Vq6Qt31ijhEBheQLhufYxHA=
X-Received: by 2002:a19:2292:: with SMTP id i140mr3860109lfi.95.1594794105528;
 Tue, 14 Jul 2020 23:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200714184105.507384017@linuxfoundation.org>
In-Reply-To: <20200714184105.507384017@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 15 Jul 2020 11:51:33 +0530
Message-ID: <CA+G9fYvcgHOAU9X0VSiC-jSw=9YR4JYSxPqR4PF33N8qfHaO7w@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/109] 5.4.52-rc1 review
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

On Wed, 15 Jul 2020 at 00:18, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.52 release.
> There are 109 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 16 Jul 2020 18:40:38 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.52-rc1.gz
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

kernel: 5.4.52-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: e41ac96492edd546629b9fefe57c4f3c9415643c
git describe: v5.4.51-110-ge41ac96492ed
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/bui=
ld/v5.4.51-110-ge41ac96492ed


No regressions (compared to build v5.4.51)


No fixes (compared to build v5.4.51)

Ran 34148 total tests in the following environments and test suites.

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
* install-android-platform-tools-r2800
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* v4l2-compliance
* kvm-unit-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-controllers-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-math-tests
* ltp-syscalls-tests
* network-basic-tests
* ltp-open-posix-tests

--=20
Linaro LKFT
https://lkft.linaro.org
