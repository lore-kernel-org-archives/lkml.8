Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62863C47254
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 09:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FEA22495C
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 09:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xkEMgR8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgEIJMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 05:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725989AbgEIJMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 05:12:54 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C4CC05BD09
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 02:12:53 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id a4so3336077lfh.12
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 02:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NH5lD5ReCvuDXdnJIc25F9anPktjSNQNPjUWKb7zcRU=;
        b=xkEMgR8OVYAbPPTR9yK//LAflR7pjobYWSKUHP3QDgV7tZhNTaULDwbMtzteLEDZRB
         S8376RVtQI+8Pge8StPfTKPEeV3Z6u0wthHzn8NMzwzok3oNX0JSHiXpRG+DinzeyDwM
         vFc5UJIWl7iaZKxU4oCr7B6Ao2jZGwuVChQMeXwFVc3ylvSG8c4bYEfOHZO99mMEz58v
         WatqSgetGsOpE4NjBBSnMeivlinupeTDgsObjz6RPNOCxHxkTQOHv34053QP3lZbBSt/
         QyDo/ZAkZC5PLjAXplQ4d/DrDLPUVYTqK0ro4bdF0qG3bOFnOgjgIPL6K+qJ5WbFGCUE
         Azug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NH5lD5ReCvuDXdnJIc25F9anPktjSNQNPjUWKb7zcRU=;
        b=kT2wYapGPDMBmVSulhkQYSTR2vzui5Bvf/Mtu5pPmcp9zCLSvVHzU6z5yr27hzeXzN
         AkLGRmp3pRYy0Wrg6xtA8NGJIITbIXaz44GBXs939NeTSle/Ffc9D/pU+klj4qgpyhsk
         LtwwqTbKIrlpaqOdye5RTsF6MF+IUMUlLbwQlvTx8vz2K0YPFKxKGXjwyUEZmvm5MHqc
         z95o77ALIMqOq9Dzftyqm3hv2WY1CnFkhEvRmHcxmt8GJRZhgQZ+XrItZcGb2b/yMq8k
         988mBY+kR+H/KsMb/JmdJ6cXwNKW+9qCSCEGa5LfClNL2B0yxBwtk/FP9A3JWNv6y3Mc
         kteg==
X-Gm-Message-State: AOAM530kcHe8TOlfmP3ZNlIyr5noKd84GB25PjWYizW+vCDK6vw/IgSw
        JSxbJwvBm0pFv+PC2gf3iEBCBAoCt/lV5E51gonN9A==
X-Google-Smtp-Source: ABdhPJx4q8/q5J3rWO+JsRwO4Wxo+t/KuoDcfklq+xptYCzmO+n4zMtJUF5IkhtxoJBEvReRTmjS5g3O4dJWByCYc8E=
X-Received: by 2002:a19:3817:: with SMTP id f23mr4480647lfa.6.1589015571823;
 Sat, 09 May 2020 02:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200508123033.915895060@linuxfoundation.org>
In-Reply-To: <20200508123033.915895060@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 9 May 2020 14:42:40 +0530
Message-ID: <CA+G9fYtjXqhauJOmRHbMO+uw0=dB=5q_wR_eROkyHWHe0h3f3w@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/22] 4.14.180-rc1 review
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

On Fri, 8 May 2020 at 18:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.180 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 10 May 2020 12:29:44 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.180-rc1.gz
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

kernel: 4.14.180-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 3b98623002348651d84865b1576cdc13caed64ed
git describe: v4.14.179-23-g3b9862300234
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.179-23-g3b9862300234

No regressions (compared to build v4.14.179)

No fixes (compared to build v4.14.179)

Ran 29537 total tests in the following environments and test suites.

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
* kselftest/net
* kselftest/networking
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
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
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-native/drivers
* kselftest-vsyscall-mode-native/filesystems
* kselftest-vsyscall-mode-native/net
* kselftest-vsyscall-mode-native/networking
* kselftest-vsyscall-mode-none
* kselftest-vsyscall-mode-none/drivers
* kselftest-vsyscall-mode-none/filesystems
* kselftest-vsyscall-mode-none/net
* kselftest-vsyscall-mode-none/networking

--=20
Linaro LKFT
https://lkft.linaro.org
