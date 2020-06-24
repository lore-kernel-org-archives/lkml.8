Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05766C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D92E120738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pogJtTE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390997AbgFXN1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390974AbgFXN1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:27:41 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDAEC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 06:27:40 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n24so2516832lji.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 06:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dzisDFoO376N2yMUgD+QUQ/2UlOUEry3QcjYTnY5lMU=;
        b=pogJtTE7+VcSKyHQrRCXw1kz2Z8M7HbybVPEvQtOAdBAvfGOBwAWzGEspW3izztLrR
         M6sHISVXG9anaIjBqhbkTco8lAmHtkEUkBggrECt2pnLsqI7o2OWuUn0C//FoaqkYHzP
         R4XE+YuNp1hGfbFX+tl9QsSuWfVWt5AotcEKohCdZNaRGfqpFPvDKEoByPR1gFPyjcb5
         runcVat76gPKyTX0MfIOkOmfQW+bFwI31y9I+w2EyCa0dpfKU8Y7+JHYz29ERXns5dRG
         +ZbFODYl+GI3t0DYJfX1Hga2fIuHLKmy6akeneWs7VCW2SjCgBtnbEakaJt8EfBCvwSe
         Y5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dzisDFoO376N2yMUgD+QUQ/2UlOUEry3QcjYTnY5lMU=;
        b=BzxTt4JROH1gRaDtsL+Fw+DnBNxJuQ07Zpikq64HOxg54H7G2c2tTLLOi6PwfdfK0N
         TjwQy+I+uS0E2kL3ihenv1XiZ4RitWAHLaA2Gl48mIRhMK0Sr1afVe2E5qxVnMD2rgA3
         gDEC13HfbBVRyTxXm4Q+5bxV4x74YNKl35C8FclLzI9psUqcmDbVuwitctOPM7UAzRMD
         TY5fl9k1GX3Q3McdwGVkaiE0dX5ndbCTUPiQt6A8xrNFD9+7tBzYkw/TR5/fc6H+mgrK
         FBEKAzKdfvBbNX2TGsm24ibNwQw2wdjA8S5fChBe/sFY39lJ/i5OJfI6RshUOLjNY3bQ
         pTBg==
X-Gm-Message-State: AOAM530Bh/jKI+gP4o3NLn0n1RFPfUIjgu3a1b11Iug5OPsHvjmUyWaC
        1OnmFG2hFiAbCk3+thOcB1Tipv5iOHYIivAtvwso/A==
X-Google-Smtp-Source: ABdhPJwJrEPhf/vZAcc8A1kL5lsTBbQ1HIkMxDqu8xbkFdjXtNh65BENvTPdEFEBHgbkmBb92FIeCvrzFSBHU+ESpwo=
X-Received: by 2002:a2e:9116:: with SMTP id m22mr13816975ljg.431.1593005259017;
 Wed, 24 Jun 2020 06:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200624055938.609070954@linuxfoundation.org>
In-Reply-To: <20200624055938.609070954@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 24 Jun 2020 18:57:27 +0530
Message-ID: <CA+G9fYv-0e1e-B+yNiTCSWLSG0JpyLcGMcXaHe8CDkp2bs_8AQ@mail.gmail.com>
Subject: Re: [PATCH 5.7 000/474] 5.7.6-rc2 review
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

On Wed, 24 Jun 2020 at 11:40, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.7.6 release.
> There are 474 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 26 Jun 2020 05:58:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.7.6-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.7.6-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.7.y
git commit: a5e7ca280376ecfba57d9a5125ed89698efbdc31
git describe: v5.7.5-475-ga5e7ca280376
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.7-oe/bui=
ld/v5.7.5-475-ga5e7ca280376

No regressions (compared to build v5.7.4-851-ga5e7ca280376)

No fixes (compared to build v5.7.4-851-ga5e7ca280376)

Ran 32573 total tests in the following environments and test suites.

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
* install-android-platform-tools-r2600
* install-android-platform-tools-r2800
* kselftest
* kselftest/drivers
* kselftest/filesystems
* kselftest/net
* kvm-unit-tests
* libhugetlbfs
* linux-log-parser
* ltp-commands-tests
* ltp-controllers-tests
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
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* network-basic-tests
* ltp-cve-tests
* ltp-open-posix-tests
* v4l2-compliance
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-native/drivers
* kselftest-vsyscall-mode-native/filesystems
* kselftest-vsyscall-mode-native/net
* kselftest-vsyscall-mode-none
* kselftest-vsyscall-mode-none/drivers
* kselftest-vsyscall-mode-none/filesystems
* kselftest-vsyscall-mode-none/net

--
Linaro LKFT
https://lkft.linaro.org
