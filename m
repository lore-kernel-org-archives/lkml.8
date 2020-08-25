Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D74C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61FC42067C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U33AZncd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgHYJMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 05:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgHYJMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 05:12:18 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D58C061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 02:12:17 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id h19so2007094ual.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 02:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jE7fyxXiyeD/zjyIffJDN6llP2shlXse+KQvtM4Zc3c=;
        b=U33AZncdoe7pC60BjfBybyA4VCU9xkfxbfTh1DJzFO/j7jnlex2b7MYcwaFTV0gCJE
         OOu0aXt7jG3bNfrMJl8MZg16mGO0RjsBxIh7NU7TV9Q86eDv0X5ovj/zVrlVAXVq3z5Q
         ESSjPrVUK73a3yuSr2dBiajlhv6ZXX/a61IqAGL3D1p7biF7NSDmiFnfhT4NJQYTCTrt
         TWdNbwCUa6CmSB/U/eg3hv7B71gCd0HS10L87/0lqQQ+/apzYMSfgHg7dHqUM1CYFTE3
         CtcsB+wqz2bWJqeTPB8kJJ2jYan5tjgqgdzyiHR7SP8XDRJfvsBLYnxKyWMUqsKLb4d2
         KDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jE7fyxXiyeD/zjyIffJDN6llP2shlXse+KQvtM4Zc3c=;
        b=l0Mnn4E6PJy2fx1U0KXxPborpKXbLiL3ioaMFpNvI72RMJKPjtp9JLj6v2YAZg3pGT
         j7iW8LXdzAOs7821UExvOys4VRJu/dg7wlLrU15nWNq725sQiU/+qXJc665yze/HNL47
         Gzm7xSvndGVE6oWwVfcd8OnSbsICBmZyiUSR3BzYve8ZUIm6yFNBxznkxpvxAzOY60Be
         43x/dedraddWVbfJa3DSJ153yCobjOxpje5CMONeyo55AzvPhbNGLETkXRAPbmMFiSPn
         uqkFUXNnyuJrZ+z2WXHRRkOALjkfTjxBBZntPzre7evbB8mDzYDAM0w2yMyzhHASUTD1
         9TZg==
X-Gm-Message-State: AOAM533NVFU1PQyLKCcGn5XygqMe8xuHT4V1ap46Hd6y33ot73HBCXxg
        7EAY2k1CmXP1899zpMHBiYegUqfRT+pC6p41lqEj4A==
X-Google-Smtp-Source: ABdhPJzMiocbUNDCG4J3XaVWkUb9eExScfYJdhJxXpw9YL8Fi3wrOF1wnwitFoO1uajv2KpjUJTpXWf5v0BSu1rDwks=
X-Received: by 2002:a9f:35d0:: with SMTP id u16mr4584256uad.113.1598346736185;
 Tue, 25 Aug 2020 02:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200824164720.742523552@linuxfoundation.org>
In-Reply-To: <20200824164720.742523552@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 25 Aug 2020 14:42:04 +0530
Message-ID: <CA+G9fYs-iJh6wNPetu=61=TnU4pRTLROY3p7qTxdAh9F3nBhcQ@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/39] 4.9.234-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Aug 2020 at 22:19, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.234 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 26 Aug 2020 16:47:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.234-rc2.gz
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

kernel: 4.9.234-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 306b4f399ede253cce971b4320fa85046846fc70
git describe: v4.9.233-40-g306b4f399ede
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.233-40-g306b4f399ede


No regressions (compared to build v4.9.233)

No fixes (compared to build v4.9.233)


Ran 25581 total tests in the following environments and test suites.

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
- x86-kasan

Test Suites
-----------
* build
* igt-gpu-tools
* install-android-platform-tools-r2600
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
* ltp-tracing-tests
* perf
* v4l2-compliance
* network-basic-tests
* ltp-open-posix-tests
* kselftest/net
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-native/drivers
* kselftest-vsyscall-mode-native/filesystems
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
