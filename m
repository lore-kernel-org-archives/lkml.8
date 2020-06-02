Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4876DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 07:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21FBE20738
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 07:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fZKp17fa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgFBHeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 03:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgFBHeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 03:34:20 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF33CC05BD43
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 00:34:18 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e4so11345845ljn.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 00:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RW++pOMwCI1RAUvP2W3CAZyAmDLRUSkgYoW4MV3g1tI=;
        b=fZKp17fazIZa0p7CjOii2rss4IOhRcKSIy+BhnCKyCpmpo4svBV14OwIfKcKBRtjSj
         4orYoLt7ffF0jpbrBKIBDwqmq6zhJkU/HTWIsI3anJPKIe1r6klkKUQk9nKyXu1DsAe8
         40sP+ZRV2LWXr4r6L21jEGzFMI33MmjPZQ+O76M50egIypCRHHt53BPCNMLcJKI6rRdM
         +8eOGj1gDXh9XUTxEMl9hlLz5Hdu0AiqmRw49QNOWGNscgpCNoyV588H3Ap8Ka6Iu9UG
         Ie0cDiUQL1n6OSj2jzKM8jcfgOM3fwNVjvjL3YDgKH3bOvTRvv98fr3QQ6wGEuKItF78
         fdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RW++pOMwCI1RAUvP2W3CAZyAmDLRUSkgYoW4MV3g1tI=;
        b=DQ4wrVvZAQOg90EFulsdp4HvgVIHxGSKuIPl4mQOisM0I+TGH8uMawr2H4Iogv4R5Y
         CoF107Pf4ycGcVSF5o439Sm6mCn5BgqNICy5p3UlinjyZgzvT0n1V0h/0nMg1bA2LLTK
         L9iJW1zDmOqI5ds6177YO/D4AkOxqo5Ri330ZbRtGgJCC39kwgtlzvpPUOvQdDNYXCY/
         XF6cqyQFPhiMMlnSA4T1lrV9NbfMn3QYMoNvx4GyWE8r6GWv0TdOL7226oos9w3Sn1MU
         7pRf00uHmuX0fqkJfPBW5XGNnrnAdX33AGnb1tbD9z+euS3i09kvQymS9wKiUYeudut8
         2kJQ==
X-Gm-Message-State: AOAM532LvFrLyys8Z1nN15kpPSQoyNgZKKJcZZ3K1H0Mfpgkfm2q4SK1
        OoV1DyCO8iYYoTGzipZcs81zRFolWqbg+ioR8pbk8Q==
X-Google-Smtp-Source: ABdhPJyfCwApzJsdvkbUX69Ms9OAygXh35EEDxMK+BkZf5Ns/uTKmVMhUozwLT5M8q08X14k2b++bbrJ/K5nlRdHPYY=
X-Received: by 2002:a2e:150f:: with SMTP id s15mr11977399ljd.102.1591083256916;
 Tue, 02 Jun 2020 00:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200601174016.396817032@linuxfoundation.org>
In-Reply-To: <20200601174016.396817032@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 2 Jun 2020 13:04:05 +0530
Message-ID: <CA+G9fYuWxDfeskK14Lo1A15qo12DNfpQfN=10=rjaUvBNn9d8A@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/77] 4.14.183-rc1 review
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

On Mon, 1 Jun 2020 at 23:30, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.183 release.
> There are 77 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 03 Jun 2020 17:38:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.183-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
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

kernel: 4.14.183-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 9093a4315f917688b56194625b7ad0e407705072
git describe: v4.14.182-78-g9093a4315f91
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.182-78-g9093a4315f91

No regressions (compared to build v4.14.182)

No fixes (compared to build v4.14.182)


Ran 31002 total tests in the following environments and test suites.

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
