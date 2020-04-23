Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96672C55191
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75D0620781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tv1q4y4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgDWHqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbgDWHqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:46:37 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF59C03C1AF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 00:46:35 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id u6so5162792ljl.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 00:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j4NxmKsBHTz6gYyauKIZjiC6fMYuhV3vv9EHXAmn6hY=;
        b=tv1q4y4FdeEKCuJ9FuDTHqWJ9x0mqHvVo3pFNBPrkAls04wqqrv2i/UTy+FKxcvhyj
         T1Qt2MYG8VO94JQyKsrPxh73IhYtk4zkp4LoJ41un5o6gSC/0oJrefSvaq78Czo/hbN0
         GR4W+7JrmK7e6jLTDi/ArGq146l3bju22RAdR7dWBK9S4NV1lNfzDVGDWsMvyX/CoMV1
         lZxskYPYSq535yAjL+8WuqNqSOvphOcjvaYGSr/OeV9XFYSzO6/5pVBJlp4IQpEBhfN4
         Xbr8nZpyCwj+NdwHNUJ624dVuSUCJtJW+t06ig8QZ2PlN5iT1eoIo1mHsfdFX0+nef/y
         ZS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j4NxmKsBHTz6gYyauKIZjiC6fMYuhV3vv9EHXAmn6hY=;
        b=cJcJVuH2IcVOmFxFd8XuwBaw+RdaINqgwB1CN+lAeJxuJNUzrZWDB4y/T6HpMF+ckg
         h/CxYWxB+mxqvbb71/qt3zP25/4ViGRzMAnl1dIX/9PSt6MWC4uD41QFVHCvP39gb8Ka
         0lOtCHXrc3/45OaIS8T2BgWkQj1Owf3oERZujj6kRQCYwcYtU6UX4UvvNWyCJzEapNt1
         FGhqAp9xve2xKRevgejwIRkbXpfgaOoKpoUoSPbPA5cg9YXbuwdY2hyvbKr6utNu/Iqj
         fvbk9VQ+buiDZotKR7Q6ufS95qvu+l/YOP6Wjj2trP0n29qXLr9qYKjhOwzx1TeL1hbH
         eNEw==
X-Gm-Message-State: AGi0PuawjNKcfaZ5aMoX7nIZs5E+kB52sxhjWVwooKMywvMoe9DWb9Xu
        XVJcZxwSRPuPEAHDgdDVEU5JfIZD4pq95A+BvGqwAnlY0x0C3A==
X-Google-Smtp-Source: APiQypInqUm6r2HKtqH7wmzEyhd8ssB9/VrFtHcQxoRwylbQ4mdJYQBN5ls4FKP3EwVU0VcOBIQa63T7KPwlXx1XX24=
X-Received: by 2002:a2e:9018:: with SMTP id h24mr1537378ljg.217.1587627994170;
 Thu, 23 Apr 2020 00:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200422095047.669225321@linuxfoundation.org>
In-Reply-To: <20200422095047.669225321@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 23 Apr 2020 13:16:22 +0530
Message-ID: <CA+G9fYt+DmKn-h_XoG1TseqP7J5BxgrwQPNqyaL+htn40qLo9w@mail.gmail.com>
Subject: Re: [PATCH 5.6 000/166] 5.6.7-rc1 review
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

On Wed, 22 Apr 2020 at 15:55, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.6.7 release.
> There are 166 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 24 Apr 2020 09:48:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.6.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.6.7-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.6.y
git commit: 0c5e841761a8a86b28a132964a4418cc9970cc82
git describe: v5.6.6-168-g0c5e841761a8
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.6-oe/bui=
ld/v5.6.6-168-g0c5e841761a8

No regressions (compared to build v5.6.6)

No fixes (compared to build v5.6.6)

Ran 36818 total tests in the following environments and test suites.

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
* libgpiod
* linux-log-parser
* ltp-containers-tests
* ltp-ipc-tests
* ltp-sched-tests
* perf
* libhugetlbfs
* ltp-cve-tests
* ltp-dio-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-mm-tests
* ltp-syscalls-tests
* network-basic-tests
* kselftest/net
* kselftest/networking
* kvm-unit-tests
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-securebits-tests
* v4l2-compliance
* spectre-meltdown-checker-test
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
