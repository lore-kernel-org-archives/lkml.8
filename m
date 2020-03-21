Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40435C4332E
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 08:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0857720739
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 08:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Haqv4YAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgCUIgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 04:36:52 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36255 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbgCUIgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 04:36:51 -0400
Received: by mail-lj1-f195.google.com with SMTP id g12so9034325ljj.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 01:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UX67wRN7rFBppvROxiGvXWoGuTK1VZF5KIrD6zZERok=;
        b=Haqv4YAUO52DsDYxsdaaY27+FxVjBJwJuvG7Pwgp+13yI8bN8XZBOpw+FiWAkAN3Fr
         kyKhCHnckzNtjICn5kPsMF1IpVg0W84aPwWGt0I8aFXFJ5BnJCqJWiZC1GaJ0XclGhWY
         ye5RIV6bKRwhLrdmFhJWc37wLkIpI2j4Onoy2XWr8D+rH2AGEMXmnurdvwV4N36rlAxe
         VV4Yhn3mPxRb80eJOyD1B+Hcv2ZeENVLY5vwbO4GFAPVhxEkJLTXbM5wI48ZGUgpXy4i
         a5pijDQlsTtU/IbZy/OI4TDo2xPLUNYEOpIyqxrevvsKkiUHi6Xy7U1hHR2nMkw7YQeE
         8e2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UX67wRN7rFBppvROxiGvXWoGuTK1VZF5KIrD6zZERok=;
        b=M30fsQlHaTQJsJwaFokPYb41SECrXOOVD613TpYPlwU045eiZc35nSOfXGF4VcUjYb
         I+FfTuhJrNsGrUMdsnlCfnb4dmebJSZL3QbFV6B9XoYwlpRdPAFu7zBKpC3/WQfyzY1y
         /5933vqGX8RODFSPm1IO5TSOaGTgBpPqVHSPbfHutp0HvoK1K8GTxoqnSLO9WkTFx2nK
         61JyR3oqOHj+cgD4ais1csKxKCL0Zzhmbx9dXe1SOtdMyBplS7Rs7Zy/p5D2A8ElrKzo
         eK/KdiQbD4yCpybutULcXFVhYcqPvhJB/JgDmCrASaceBKILeRs4IMUzMka7UVnJgD7F
         dsBQ==
X-Gm-Message-State: ANhLgQ24qKxaba8OY8IJnTmYBJnaDvoeabIB3x2W+VGo3Aj7d6o8sFF/
        tkeW/1guKQYyywASzMkClIjj4eB6x4xCtFcfIcqrQw==
X-Google-Smtp-Source: ADFU+vvPfcczI+GuuSBq7Xx4zKNRkVEOFJkItTF/T/z4q87PkQpWBiqqG3LBGTwZCQ9LlKSaP4r46vLjEkh70ZMrDQE=
X-Received: by 2002:a2e:9256:: with SMTP id v22mr7728795ljg.38.1584779807443;
 Sat, 21 Mar 2020 01:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200320113335.277810029@linuxfoundation.org>
In-Reply-To: <20200320113335.277810029@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 21 Mar 2020 14:06:36 +0530
Message-ID: <CA+G9fYtQk-x7qTZVcFo3CjiuPYNTr6RTLcDaSxh+AR_MyxjkVg@mail.gmail.com>
Subject: Re: [PATCH 5.5 00/54] 5.5.11-rc3 review
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

On Fri, 20 Mar 2020 at 17:05, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.5.11 release.
> There are 54 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 22 Mar 2020 11:32:39 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.5.11-rc3.gz
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

kernel: 5.5.11-rc3
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.5.y
git commit: bea94317c526b97d68c6f0aa31c56de3267c43a1
git describe: v5.5.10-55-gbea94317c526
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.5-oe/bui=
ld/v5.5.10-55-gbea94317c526

No regressions (compared to build v5.5.9-207-gbea94317c526)

No fixes (compared to build v5.5.9-207-gbea94317c526)

Ran 22328 total tests in the following environments and test suites.

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
* perf
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-cpuhotplug-tests
* ltp-fcntl-locktests-tests
* ltp-fs-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* network-basic-tests
* libhugetlbfs
* ltp-containers-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-mm-tests
* ltp-syscalls-tests
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-open-posix-tests

--=20
Linaro LKFT
https://lkft.linaro.org
