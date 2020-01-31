Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE72FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 14:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92FF420707
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 14:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DAqb78GR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgAaOyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 09:54:53 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44534 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbgAaOyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 09:54:52 -0500
Received: by mail-lf1-f67.google.com with SMTP id v201so5042909lfa.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 06:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pGT1zhBW/FS2v9vojokmlKIL7wGNrqqrsuA224XUr1k=;
        b=DAqb78GRfuuhNUzt9u8NcWSL0it+aZhQ3vY1ePn7Z10l4rQD8yqmRNf3uIM8WOggl1
         XXkH6TM4ERxFieJuuWzqEGRUfgVz3c+9YxfxYf0e4xOnflUDKCEEusmXqZ0A11Atk8rG
         0VhyJGKTA39VuxefC3NlNAPuIu50uVp38iTvKaE6iVO/+OhQmfjjXznk3ku9Dbm2LAGk
         1Yb+pAWvTKSNvidx7T1DelliDsHKMlnHeQUD/MHonreUO2e+vhnfhnZQ7MqeXEvFeV+H
         i0ftOG1cAtcvR95b3O6vQQ46f/jch6aU7oEkzxyqAiUGYffbFyWygMM5Kz+M4KmRpa4+
         0hng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pGT1zhBW/FS2v9vojokmlKIL7wGNrqqrsuA224XUr1k=;
        b=oiw/rkNjh8gx0vLairR8AW+lpxYlpElJrzDdJMYCtqVqkwgvLPmC0MzAaG0RH2VDdo
         FbUatFIIVJP3m+mDawYicpVFNpgEzesSUj+YogWsmJX5RHFbzbEoy7/Vw29AcloCxjbM
         mO/aq7KQyGU/zbcAbn/gDXd0gwAstAgKiFz6vZY4DwFSsQNbWd1FRpi/xVjxvZd6Ja2r
         pWomkmTWKh/PfvS16h8itP0F0mqIWu0S4RloQ70hsxx6c1wmBb1NEURCgnKfIUwTvEv8
         8bE2LrqJa4RpibE1+0qiD5Py6W+g8B3KdoaYYQpzCjJ/Q2XtMnaesuxZUdsqbFxGPKe2
         rc2Q==
X-Gm-Message-State: APjAAAV1c7dsPyGi/L4l/LN00LlPqCh2DMMPQrFSdNF8lupBz2xE9koA
        xclZ/cUi9weBa/3A7Ab01u9DlcgUMSrgGnftGuI4Tg==
X-Google-Smtp-Source: APXvYqxbMOPQ8LiPV6zFpqgTSlPFgjc9mgan2vcHQ/MV3r4mQTfUls2EL9VwedRJxidied0QNDLx4r02QwSnJhz7qKU=
X-Received: by 2002:ac2:5b41:: with SMTP id i1mr5706344lfp.82.1580482490310;
 Fri, 31 Jan 2020 06:54:50 -0800 (PST)
MIME-Version: 1.0
References: <20200130183608.849023566@linuxfoundation.org>
In-Reply-To: <20200130183608.849023566@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 31 Jan 2020 20:24:39 +0530
Message-ID: <CA+G9fYsFgp483JYaVj7NZszd_Wh9JOE6t3Tzfikdwsu_xpfaGQ@mail.gmail.com>
Subject: Re: [PATCH 5.5 00/56] 5.5.1-stable review
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

On Fri, 31 Jan 2020 at 00:11, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.5.1 release.
> There are 56 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 01 Feb 2020 18:35:06 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.5.1-rc1.gz
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

kernel: 5.5.1-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.5.y
git commit: ad64b54689dd4e8943ba6ebd8461ab5273f4d665
git describe: v5.5-57-gad64b54689dd
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.5-oe/bui=
ld/v5.5-57-gad64b54689dd

No regressions (compared to build v5.5-54-g04aed3481f3d)

No fixes (compared to build v5.5-54-g04aed3481f3d)


Ran 24154 total tests in the following environments and test suites.

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
* kselftest
* libgpiod
* linux-log-parser
* ltp-cap_bounds-tests
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
* ltp-mm-tests
* ltp-sched-tests
* ltp-syscalls-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-commands-tests
* ltp-fs-tests
* ltp-math-tests
* ltp-open-posix-tests
* network-basic-tests
* kvm-unit-tests
* libhugetlbfs
* ssuite
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
