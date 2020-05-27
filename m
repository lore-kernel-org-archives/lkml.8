Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4A9C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6714E2078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ONaHXwDo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388296AbgE0Itg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388113AbgE0Itg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:49:36 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4CDC061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 01:49:35 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w10so27973569ljo.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 01:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6esLd7lp43zEbTtvTec1bd3/AlFOraY5i1exF89Mlno=;
        b=ONaHXwDokW3gMzPIntv8wF7r860aStv4oHwg88P4jPBk3VE9zjW66yGArwM9AMFolu
         cfBa2ji46hO27uU7gaSsZDcfh2XUIWxA+AnLm2I9/sNLWYEg6Z4gtW7XM1ca6Wx+wrAS
         62NDDGTLUURQZKfPCKNmAe6GkXcVxsaN/Z3yAkNjMFTMIPgYdb+ycVyr70HXj9YjJfDk
         GPqz3HqEubVY7yfUgm68gBOU5Y7jB9YCRCUgQyvuUj7yytjzQQCzlKGsX1vlj+hk4HTH
         Bah6PJX2N2PuF0WHz3Sf2JU18q0eTEr1XCqdZdvjxVOB2jOiQcauhlPPC1Ylib8gGlVO
         0Etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6esLd7lp43zEbTtvTec1bd3/AlFOraY5i1exF89Mlno=;
        b=dvkj11eHvtQKVXWTppdjM3nxhti7RLIUg5KrZZmKx1bWpm+3tG8lDh1v0i0sakDaW+
         QzfU/HkNUWJcI4+gwNK/xsAiPxnstbDA1a2pMxj27jfCdrMXHgJuOupzwS9yjPSlPWAi
         fTi2rNEB95Fu81Li1nYtt366dSedQrfc8OEiOM2m4Js/bQBzvKTdnWeMM6VVJ7YYzyyv
         e8vPT61sqb0AH1a71HGJTP+pWXwaqR6mPpT35CrFWw2pqZc49xtc7kiPbvTnetFtrn4q
         wGFFsZjtXszPAQ2B/kcnVh46puVTquMD6Q58WDB4wl5CgXvBBYITq2VP9F7Cms880fq7
         Dupw==
X-Gm-Message-State: AOAM531nhn7+hCNa01nH21C4O8bv2/AU313oxeYOocA0Kmm+72Ar0JMt
        xC4pA8RJayZcodg1w8eRhXr9BQu0pOkQJDcvFEhYeQ==
X-Google-Smtp-Source: ABdhPJzbmy1mlXsY4y9WFoe6kKvpUK3nRSEwZCtOU1yuiHIMN2c0HPpyDzsSaxeroW+9wQqD3ez18Gok8TI4iJxAbjk=
X-Received: by 2002:a2e:89d9:: with SMTP id c25mr2747458ljk.366.1590569374271;
 Wed, 27 May 2020 01:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200526183913.064413230@linuxfoundation.org>
In-Reply-To: <20200526183913.064413230@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 27 May 2020 14:19:22 +0530
Message-ID: <CA+G9fYuXKptEVL0mj_NKFxNtz43=KdpotC1EQ=WKDp2JvxuOeA@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/64] 4.9.225-rc1 review
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

On Wed, 27 May 2020 at 00:29, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.225 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 28 May 2020 18:36:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.225-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.225-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 9b4a11d53bee477ce44d3c4b703db7f5d756ca79
git describe: v4.9.224-65-g9b4a11d53bee
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.224-65-g9b4a11d53bee

No regressions (compared to build v4.9.224)

No fixes (compared to build v4.9.224)

Ran 26523 total tests in the following environments and test suites.

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
* libhugetlbfs
* linux-log-parser
* ltp-commands-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* perf
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* kselftest
* kselftest/drivers
* kselftest/filesystems
* ltp-cve-tests
* ltp-dio-tests
* ltp-io-tests
* ltp-open-posix-tests
* ltp-sched-tests
* v4l2-compliance
* kvm-unit-tests
* kselftest/net
* kselftest/networking

--=20
Linaro LKFT
https://lkft.linaro.org
