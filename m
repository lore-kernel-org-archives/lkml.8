Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB0BC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD6C920657
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kaVNsLv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbgGUJYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 05:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGUJX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 05:23:59 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A51C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 02:23:59 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id q15so5999644uap.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 02:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uNdXsrJw867oGaku381wzCgFEymznkYsRyfyZoqefkM=;
        b=kaVNsLv6EVZ6oWPKMs3iaSnsO5eYisNPuqS/bS84HSI7g9204Wegf4uA4ICXp10t5R
         riIb2mTYfb/4ILsdjI0azm00bZ4O9c+KVWIMM/DGxW6N0rRuAnP2+0VybMxAMafljwjd
         XEQnc6ztM/10TeMDgiaaTdZnmwlDHAsR61cXtTQLFxZQwH9sbZaEritH2SBcBBnBVBfO
         W1alZyDOlkuGqgo9HAI/bNuBr1xOpem7BABIjxIOhHLBm9QatbpAElGQJNxN4HtvU0NX
         8Yop6qrQGkWNl9MsHRu7Ga6w3rWu6mqFFlH0xE0wHE7x/x/2iv3NkD1Q4eq6s8bq2iKZ
         pOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uNdXsrJw867oGaku381wzCgFEymznkYsRyfyZoqefkM=;
        b=g9UtK8pgOw9QQtDdafP/xZl7tQTsV9JzA0TBt31eD2/gKZJOp2cq3sl93wCAHvqXPW
         oo4w20CLdCOYqG2PsaPb9MNEk53YEK66nYv4PIzp3cktCWJNaZncQlutKVwSyITziQi4
         TjEZIM5uKC4elamt0r9R9c4WZ4q/Sa7OBG9EJwNE1XC4RZsiwscqOPX0FwUrYpMrnl2y
         Lr67cwpkmYP11FDBSF1xN1t6+wJjQ+ddrx+2zy+r/AF2SvaMOAOHIYPgf2/bxmupc9aH
         E27qYOQamUOHPbaz3YJEitvm5xjy9KtuRaXfTxMWHQBzNzUB46vrqj49L0q6zK/G6CTM
         CCtw==
X-Gm-Message-State: AOAM5332M5LfZ7JsAPmQkKmdTsaS+VuJxXq64psifsY9ojfS7uIyVqdz
        Hjfh7ino+CgLYEP2mCf49j+waxcKqE3yhvnseQjn9w==
X-Google-Smtp-Source: ABdhPJzpcSbMnaCtFWuVQg1tusxk4o2g2sLsmCvvrNYlgaSe89dheHObG/ddobVUIhYlQNIv34ETqcj+ol/QB33QNjo=
X-Received: by 2002:ab0:5963:: with SMTP id o32mr18894847uad.142.1595323438536;
 Tue, 21 Jul 2020 02:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200720152802.929969555@linuxfoundation.org>
In-Reply-To: <20200720152802.929969555@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 21 Jul 2020 14:53:47 +0530
Message-ID: <CA+G9fYsmL4OHGv_32mnhEDDXVcEe-PpSaYhrhMrOe=uNBD1r+w@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/125] 4.14.189-rc1 review
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

On Mon, 20 Jul 2020 at 21:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.189 release.
> There are 125 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 22 Jul 2020 15:27:31 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.189-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm, x86_64, and i386.

NOTE:
There is a platform specific kernel oops on db410c reported on mailing list=
.
https://lore.kernel.org/stable/CA+G9fYvGXOcsF=3D70FVwOxqVYOeGTUuzhUzh5od1cK=
V1hshsW_g@mail.gmail.com/T/#u

Summary
------------------------------------------------------------------------

kernel: 4.14.189-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 5b1e982af0f810358664827a6333affb4f5d8eb5
git describe: v4.14.188-126-g5b1e982af0f8
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.188-126-g5b1e982af0f8

No regressions (compared to build v4.14.188)

No fixes (compared to build v4.14.188)

Ran 34983 total tests in the following environments and test suites.

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
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
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
* libhugetlbfs
* ltp-cve-tests
* network-basic-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-native/drivers
* kselftest-vsyscall-mode-native/filesystems
* kselftest-vsyscall-mode-native/net
* kselftest-vsyscall-mode-none
* kselftest-vsyscall-mode-none/drivers
* kselftest-vsyscall-mode-none/filesystems
* kselftest-vsyscall-mode-none/net

--=20
Linaro LKFT
https://lkft.linaro.org
