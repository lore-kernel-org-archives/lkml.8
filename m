Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6688AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AC9B20724
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nCp7a5Hc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404044AbgFXOBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389668AbgFXOBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 10:01:06 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E482C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 07:01:06 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d7so1315145lfi.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 07:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=txAQaxbTCMLo8x/+VG8IbEhFhSU5w166AKvUL10WpzU=;
        b=nCp7a5HcgIUlFf75HKyQfQgq+wlGBvm48Kvsh1VneHiH4d59er8QEZEJP+PtudAXz3
         NUf3R3/ME+60d93sJr/U0J9keJLAH1XSeFNRf/uJqb+aeq8yIXDAH082LWuh1kXFcSuc
         45/EEs4aHxpzVfu0m7I4yiJ+6FuivyPiVK1g0L6R5CTbKKFoVwi5i2EQZpyn+sk/3mko
         15aMpgNpCVUG9ZTXeY4NUk3ZQU2fdLnnqgVLoiiIJ67tcr4kP5+a1e9nMQOeHpwi+X2v
         NWTqHRktpBwCt5hSW7HhWwJPs8w1fLeeCjJdTZTEJ1UTFpzTIZQI0Sl1pygFcJnIyAlZ
         8ygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=txAQaxbTCMLo8x/+VG8IbEhFhSU5w166AKvUL10WpzU=;
        b=ZOdR6H9IGM77wLi0mZtCMb7zFymtdmRpg+SypeQP0PYlyweJjKSFDYM/5gMUSrAob/
         OQOhhlB/go2GDdNHGpwx3QTBBB8bKe56l9JGxOD+0c02CV1sEcuD9Uz0RuIf+eoyImF+
         8PMVVar5mkjHNHWHS1lld8QyPdyyJBkou8B9sQtQI3RkyI3rP7QAe1cSn7os4voZXYBN
         0RuGG7EEVc4T7o/fg1ImqRxP/1a0eczR8MEzYUZtREN5p+31TmWDN0A57z977Z8ZyqPk
         9V6God2FyZWuPlXdYYE5NIlEbGXhvbFGBr2ZswQCwiIEMcGtWobxSKuMOcGW2rvE6WvB
         03Dg==
X-Gm-Message-State: AOAM532HwplKvglrldmyqsw2vBDgCjdf7WxIsRQ26w5MtQySFS//sMzg
        xETMx8ZvEdHF7YIk+/Du6hUkllWgvsznldI/79q9xQ==
X-Google-Smtp-Source: ABdhPJxRHCgryN28ag9fEQT7zXllZ1PRtu0A1X9BXy038Szqr4/3TXTkrTEHaWX33k5G5pbdjY8OmnBz/IM506eC79k=
X-Received: by 2002:ac2:5325:: with SMTP id f5mr15440767lfh.6.1593007264743;
 Wed, 24 Jun 2020 07:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200624055901.258687997@linuxfoundation.org>
In-Reply-To: <20200624055901.258687997@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 24 Jun 2020 19:30:52 +0530
Message-ID: <CA+G9fYvz0P+M2j-xuAATQScmXgz=gJOXJdHGdPdsC0KveNO6zQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/203] 4.19.130-rc2 review
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
> This is the start of the stable review cycle for the 4.19.130 release.
> There are 203 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 26 Jun 2020 05:58:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.130-rc2.gz
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

kernel: 4.19.130-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: f12dcdbf9d549ca30275420a0c7f1c27ba80bf23
git describe: v4.19.129-204-gf12dcdbf9d54
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.129-204-gf12dcdbf9d54

No regressions (compared to build v4.19.128-266-g7e6addf7237f)

No fixes (compared to build v4.19.128-266-g7e6addf7237f)

Ran 31466 total tests in the following environments and test suites.

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
* install-android-platform-tools-r2600
* install-android-platform-tools-r2800
* kselftest
* kselftest/drivers
* kselftest/filesystems
* kselftest/net
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-hugetlb-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* kvm-unit-tests
* ltp-controllers-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-io-tests
* ltp-sched-tests
* ltp-syscalls-tests
* network-basic-tests
* perf
* v4l2-compliance
* ltp-open-posix-tests
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
