Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A83AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41974206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oOyIZzNA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731199AbgF3Hpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731143AbgF3Hpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:45:42 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A1BC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:45:41 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id y18so10757530lfh.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aby7tMI/7Qek+geP8T3b8SZIhiOoFIotWz0ecg3N6fE=;
        b=oOyIZzNAYzMKfQYUr1FjUFgGccp10sq5gT2sbYPUiG02DmoOj+0mqGizsH8pXNlaOE
         r3NziXpBdKECtCYKWlT3EaxlHnvOzU932AzaF+pIZIweENnTZavpvEG/R8x8XDZ/Ke3K
         hrUl0LhYQU8Vi9odF53uNBlbCL48I0oEwHDm3zZpFPAYQoF+y9LNwyTqX4uBkY1WeZMI
         LQWfXFi259wNZniWz+P939zDcMj9YgD/HfAfDGy8tD5Aq1jX7B6z3t+fEtcywP3LxL4C
         QIFoGqApgd22dJafVQ16vZUnENcSeC8Lk5iVr6UTYn8Go+MvoFk2ywD7S6NS3yuFNWF3
         cNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aby7tMI/7Qek+geP8T3b8SZIhiOoFIotWz0ecg3N6fE=;
        b=ZB3cqjPsGNaD34K7TYLX1y8APkNjHFziIFXgXWvFBfIvufnFsouqPpwOGJgLXbeoHW
         tO20Ml3ZVxSKyL2ihcku8IS6x8jV7Kk4M/jZMrElpdTGSABtaDtCpE//+DCk+Gl3nlBO
         +HGqAk9CwldrFVtcFgy/KlYCvifS/ftK7nqOM4rJSmM3pkCyY6Jf9j0pbiDEgZQMW4nd
         BrkJ8irckaKv1WdTINC6PYkPAH/qYvvLjo26rIiRrRldqf0YW0IZ89n4Kz1FnVmCqtpp
         x8Lw3Xd7fhbSwE1/N8rdr476xjHgLivIIPjFkYfLFV4vb5LeiuvZHnCuWbSz0UrdVcQX
         n66A==
X-Gm-Message-State: AOAM532Cx34y7t/Q+SBF6/Kp+Pnt2SCxxaVpKaIWpWgTpq51qQvCmTu6
        Ej4LeIy4v8JqRNfgfNkvMfbQwgghk+DmUGLHQxRHWRcMef72Ig==
X-Google-Smtp-Source: ABdhPJyKM+fYc4VIv2+DWIxNNmFxTpQ19J2hKSpg9c6Z8goxsVLCJkW6KpBXrwLaIltVxi1rRTS57P/7NtlV0IKZpVc=
X-Received: by 2002:ac2:5226:: with SMTP id i6mr11442262lfl.55.1593503139917;
 Tue, 30 Jun 2020 00:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200629154007.2495120-1-sashal@kernel.org>
In-Reply-To: <20200629154007.2495120-1-sashal@kernel.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 30 Jun 2020 13:15:28 +0530
Message-ID: <CA+G9fYsKK_XhNA80ojV6V08F0GGAFVNyFVRF7RVR6jswkR15GQ@mail.gmail.com>
Subject: Re: [PATCH 4.9 000/191] 4.9.229-rc1 review
To:     Sasha Levin <sashal@kernel.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020 at 21:10, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 4.9.229 release.
> There are 191 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed 01 Jul 2020 03:40:00 PM UTC.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/patch/?id=3Dlinux-4.9.y&id2=3Dv4.9.228
>
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> --
> Thanks,
> Sasha

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.229-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 082e807235d793b91b22c2e836fbea167c5cd6a0
git describe: v4.9.228-191-g082e807235d7
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.228-191-g082e807235d7

No regressions (compared to build v4.9.228)

No fixes (compared to build v4.9.228)

Ran 33260 total tests in the following environments and test suites.

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
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* perf
* v4l2-compliance
* kvm-unit-tests
* network-basic-tests
* ltp-open-posix-tests
* kselftest/net

--=20
Linaro LKFT
https://lkft.linaro.org
