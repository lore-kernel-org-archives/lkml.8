Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C20C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 07:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B29B206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 07:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HETgOJAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgFBHpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 03:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgFBHpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 03:45:54 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEFEC061A0E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 00:45:53 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id h188so5564258lfd.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 00:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+Rqjk/Xbtdib0IiL06nHtxev/7sEQLBo21mHm3Yd/2s=;
        b=HETgOJAbxUO3aGo2UA2n/Nf7NM3NTefbdRQlST2Y0agzPPQ7hGuz6MXn1LIj5Ha4B9
         pEKpXUKe9oBzsTqNhl9VHUUzxprECIMfBgWBpLkPAN0HhG8TJHYHO22Lj2mKoZ0rjfqt
         KFVP7TzUY/094c6+HXizsTCSdZls40mhJhGP0KByYBOUOeBP5u/kcxvPZgScRcZVkFBb
         55tUZJkdbjXne78xIAEbdBajQm7g+KyAdILxsD1qYB875ILU/5i0K25SZiUvjWkxEZuj
         9ZwljBryUHG1CajU/PbyPUTtWF5g2zpUp2fDhw6P1Z5Y2HqVPEtdSltx2p974Uk62lDL
         fpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+Rqjk/Xbtdib0IiL06nHtxev/7sEQLBo21mHm3Yd/2s=;
        b=YevgbYJ7K0mSjYrTwTriq0rnAjWffqOg4U7C4rCKWzTYt3xkLWcZxVulGbXE01fUUD
         TqLv/Rph+vDOR9kIBk0m/xxG6J5Zu0eed3HSCXLV5DqoC70Mr4YYyX5T+5KBT1rjArtb
         cdaBTlTifrvAHrpgd9z0RU+rOk3GsRSsz/nydGJetpKcT/DonNVde6k6DfvdayMrE3mv
         NoAXLkBCtqbn2J/QcLXQkx2mhZLtSsgXheFngN1wf+LLkqfBqfoq6XJy5epBDhGvj0yu
         Uq4Giqa1vhzRarIGfQdcNAQgtrOO6XnWSk4m6nFnon52CXNG1oVqfqyZsvk/m3M8xH/t
         RDmQ==
X-Gm-Message-State: AOAM531yksn4Qy3GEAurEheWU4rf38gDhjyY8s97G141TZsAh6dNUqJF
        8QRi4WB2RG8oRknBvqiZPWTxUOGlZYhcsA9BI6Kl4A==
X-Google-Smtp-Source: ABdhPJw7EUyRpnzBLg49ikdXxXIrG7kPkfVfgUWI/B3FYMT1PQO4OCk4EDirjZkuTebcGSPAU+obIjUG5JKAI4an5x4=
X-Received: by 2002:a05:6512:533:: with SMTP id o19mr13066918lfc.6.1591083952218;
 Tue, 02 Jun 2020 00:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200601174020.759151073@linuxfoundation.org>
In-Reply-To: <20200601174020.759151073@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 2 Jun 2020 13:15:39 +0530
Message-ID: <CA+G9fYsf4_7hUPd0MhSYQZT1a9qegqJGbrFiCtpL56x6OxTwDQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/95] 4.19.126-rc1 review
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

On Mon, 1 Jun 2020 at 23:33, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.126 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 03 Jun 2020 17:38:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.126-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
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

kernel: 4.19.126-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 47f49ba00628e7ce16eda75304e947f7ddb149d1
git describe: v4.19.125-96-g47f49ba00628
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.125-96-g47f49ba00628


No regressions (compared to build v4.19.125)

No fixes (compared to build v4.19.125)

Ran 28272 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- juno-r2-compat
- juno-r2-kasan
- nxp-ls2088
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
* install-android-platform-tools-r2800
* linux-log-parser
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* install-android-platform-tools-r2600
* kselftest
* kselftest/drivers
* kselftest/filesystems
* kselftest/net
* kselftest/networking
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-io-tests
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-fs-tests
* ltp-hugetlb-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-open-posix-tests
* ltp-sched-tests
* ltp-syscalls-tests
* network-basic-tests
* perf
* v4l2-compliance
* kvm-unit-tests
* libhugetlbfs
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

--
Linaro LKFT
https://lkft.linaro.org
