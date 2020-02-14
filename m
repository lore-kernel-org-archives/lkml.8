Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E803C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 10:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413D1206ED
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 10:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HZhMwNBg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgBNKuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 05:50:12 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33654 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbgBNKuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 05:50:12 -0500
Received: by mail-lf1-f66.google.com with SMTP id n25so6483886lfl.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 02:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ODlouQrz5k3NXN/t+YKYjYUUvk9f6nTr7sug+WI6BqI=;
        b=HZhMwNBgbo5ESHIAu/iI4RkVKXRsp0lxNnnB7X9ilbk6RydMmk8EGj6zRXzZvhYEEH
         LsGWL80Fu6aLuwt4l+1rB69T3FSifwignmyYoYsXSCBRTybTQnvyxpDsK3lc6JkTwJ2/
         uL7KbaZGB7WctpV41e1TUYVOhaXQiJgc3vPrKMbz3XCsqN8AgMQ37ccWX0Yj/5aM6i+X
         vvFQPdNX5qTBuYbtwm3Br50pYtWy4kV8cQ7lLdTrIXMCt5EzXBE2UlqeYhzRSX/Wbh8R
         SRBMMtJh+mNWKD3+vElZYXT7arlYRDHy9S9HqZyDqtb5tFOQimm5sVhdwxuVLK1DzmFh
         E+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ODlouQrz5k3NXN/t+YKYjYUUvk9f6nTr7sug+WI6BqI=;
        b=V7+VXqKXW+mPpn1ovk33eyMztR00vmGsgdgr6/GAD1YNpTdD39a0PulKQupURBG15y
         JPRVFWQFNtpklYKucs/EgOBTrCPXFKykH1X55GdXGWcpw0WvCoPS/Q1J1gMppA+1XB4b
         s/2Gx6DTE1nO1/tQvugNFY9iUvgWYjc8TAqgfW11B06SaA70bqJfEAigAPCnRUXCtzJG
         POz+jXFq52t1o7jcbG5YQtMVZcReyqkaiGvt3OOOZ1F54t0yijC2lhhqnoIgmPodzH8v
         9no/YTSZ5sCzaFZ0SKvc2D75balA4gaOk6urbJTJC2nHdL5hMFTAmIhShIxpFZoST0Mm
         hCJA==
X-Gm-Message-State: APjAAAW97zzRdPZiGiDUBafQX8nyLXhbKRAhM2HPiMQ2gE5PwwdwKfeM
        l6pCIx1T/ufmKVleodNaakpT6ETnXi6VfZbIrRdxxleV2LQ=
X-Google-Smtp-Source: APXvYqz3dw87XPC9dwU1v/Eyq/JEmu0gvI8UKqpPuQv+JWWf4Ke5b5sd09zYz/xNK70QphOxbcZRbMD20VMDwV/9zVE=
X-Received: by 2002:ac2:5467:: with SMTP id e7mr1338180lfn.74.1581677410239;
 Fri, 14 Feb 2020 02:50:10 -0800 (PST)
MIME-Version: 1.0
References: <20200213151810.331796857@linuxfoundation.org>
In-Reply-To: <20200213151810.331796857@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 14 Feb 2020 16:19:58 +0530
Message-ID: <CA+G9fYu09cBCi7sSyP827V7xNMgkQGSGaf329DkF4Fx9sxhoQg@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/52] 4.19.104-stable review
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

On Thu, 13 Feb 2020 at 20:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.104 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 15 Feb 2020 15:16:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.104-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.104-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 504347304f1afcbdf2e57fe310584284576989ac
git describe: v4.19.103-54-g504347304f1a
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.103-54-g504347304f1a

No regressions (compared to build v4.19.103)

No fixes (compared to build v4.19.103)

Ran 17237 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- nxp-ls2088
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
* ltp-containers-tests
* ltp-dio-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-cpuhotplug-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
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

--=20
Linaro LKFT
https://lkft.linaro.org
