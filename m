Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51A1C4332E
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 09:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 758EF20739
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 09:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vwVo61a3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgCUJbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 05:31:35 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40377 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgCUJbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 05:31:35 -0400
Received: by mail-lj1-f195.google.com with SMTP id 19so9081618ljj.7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 02:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p8i599kpPWgrPCRTtjXEAjXY0Wen+gSlHpqgce9H2eU=;
        b=vwVo61a3QP8UTNdyRMgDoKlGie7u2m/EeMMBXP8XYAqtP92hF60R4WpdeA+3/ZmuSV
         3d/HDkRxTjbm0jJQCnix1K5loW3tQ4qaspPJHMIfnLgZlRUU7G73Pd3Ct1WW1QewOJFI
         QHGPxAcVgc9ec3MKmTd4Iow2iDVjRHJ956ZVJP5YM6L9d5bW+oDf99nd6QuSet4XSXKz
         cm9bG/3i0p6OJxocRs1qaOjojmyxY0bs9+mTHyWY/1ZBhS4cesR/Vg40K20sNO5gsktJ
         jpZYZsSjpR8cFD9U4zGsDTF6a65kRsp53dZFHBAWKCk+QadFEBIcBDUF8+IwXx8GhVQ2
         kAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p8i599kpPWgrPCRTtjXEAjXY0Wen+gSlHpqgce9H2eU=;
        b=KFfSMfJR+q4uBnBOxWvxdTTxgZ9GuuWKObxmSYTo29t/i8XP0eLbW/iuisaQ3RdxV3
         dvVoF6RPWFZfPnkd4F1De82vHM5O2nGlzxbaNc4JdOGIQEMygO9sfLjIe8NCJ4gOmq4Q
         Y6kozFZ3tVeq9jvj5tpUl+4wk18DzHhoXIWFu5vd6aLUB9lMUM11d4M/ML41ayizzClC
         rUdqBKcLWoq/EA17zjgcJZkzr7IUSPODf2hEdURJ4xjC8gUOZ9mUNw6jOz32JTklLz1X
         jAdVHkNyOpELhWG2IUVj7skWFCssygg3u4uApipy1cBTa1J3qlccU2Fyj3zZhS2PUclH
         GzUQ==
X-Gm-Message-State: ANhLgQ3ji5nvZNidHFw01TPs46IqfLBJ/KqZpzdqv8lSuQWiPVZkMdb7
        TzG1v93x7oDD1US9gER2Xgh4O8WD3mSJHu87g1kfGT/Gkv8rlg==
X-Google-Smtp-Source: ADFU+vvOsw427voDXCu6qnFhM80Digpcev95rPbF0LxdyDSvrYL13TK5F4Mtf7VIfwq5jpXgN7qhep77z5ZuLK7S6O4=
X-Received: by 2002:a2e:3309:: with SMTP id d9mr8147960ljc.73.1584783091383;
 Sat, 21 Mar 2020 02:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200320113334.675365993@linuxfoundation.org>
In-Reply-To: <20200320113334.675365993@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 21 Mar 2020 15:01:20 +0530
Message-ID: <CA+G9fYvPQvwe6gA5FwbK9AH8uj8vFkRvgaqQLjQSzLkORwp3kg@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/50] 5.4.27-rc3 review
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

On Fri, 20 Mar 2020 at 17:04, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.27 release.
> There are 50 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 22 Mar 2020 11:32:39 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.27-rc3.gz
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

kernel: 5.4.27-rc3
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: e72abf1f11a982a2a3fb555b5a9bd2eb2011dee8
git describe: v5.4.26-51-ge72abf1f11a9
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/bui=
ld/v5.4.26-51-ge72abf1f11a9

No regressions (compared to build v5.4.25-175-ge72abf1f11a9)

No fixes (compared to build v5.4.25-175-ge72abf1f11a9)

Ran 23187 total tests in the following environments and test suites.

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
* linux-log-parser
* perf
* kselftest
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
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
* v4l2-compliance
* libgpiod
* ltp-cve-tests
* spectre-meltdown-checker-test
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
