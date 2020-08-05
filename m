Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55165C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 06:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3084122B45
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 06:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D/4dCVHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgHEGDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbgHEGDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 02:03:09 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF921C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 23:03:08 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t18so36395497ilh.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 23:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WZ9AsbKXdiN9KsQoZuCEBbaE5QGvbp9chgZ8Va1ngsg=;
        b=D/4dCVHixTkkuuC6ayZkG537PmQQojDvvoMi5/IJb7OuAQapy59shQdpRXk9MTEhLq
         lTLAz0dNCqowJ9uj2+JEXozKsQuYNcbGPEBzIHlmyaw9smCSi4vnjdLinoQbkZG8+o5V
         ydy1Ok43gPmRpRiNMEsPa0soQjZ+O/w21pDLeD5Xm5xZTXWmpMF388IJ347WYqBS7Vs2
         EtBFg5dhMrQqoTh3Q+F+3+VT9PBo6aJnBrqEaicTWhWdAi8AMQ3c+rARbg2PJ3Gmj/eN
         J5Ywk7CoIHNQmWUK4WScVnKj9/6empHZOw3zTQ9P04jckN8fnZ/GU2ooOX4gSUe3KgOz
         xvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WZ9AsbKXdiN9KsQoZuCEBbaE5QGvbp9chgZ8Va1ngsg=;
        b=csy6GmmL3vC19WVTmQxqm3mW+sM/J1fte+sZQznPUoygeVxWO2+3SNCd6u5ZfOrqsj
         MyVQcNg7wpYh+KFiopXaWIHfww4tL9Biqtn1+w87FAbn8NkFR1XpfsJ6Jc79TMSbper3
         p7z3YDp2dyEY4qIxDrye8+i3Ott5ii26VodKIhi7P8nDJDcBs9dA2bHn8GprBZqpqbiE
         zgdzy4kHOEb5f4l2DBhOx2cE0RtEdaGgIXPT4/S4/Y8KpfEdy4Ul0ql6QxzscRFhlnJr
         bblUEbjkVYxMFuguqVCi0kFLoiZmIKvFcFKl+7ynV7d1Z0DHYPgz46vQSHVuDqxyNspM
         Px3A==
X-Gm-Message-State: AOAM532iePhsmxO0DQW29iXm+MQvGRbq32nOm7I2tF5JZLUVRtH/wT0c
        tahh6AIufKmIzV1DeiLoxiNM/peSUgmVspa+QeL+bs6+ij+ekA==
X-Google-Smtp-Source: ABdhPJwMT9aHKhep6X1QHr3mX+Zkrm/RNvYcFsR/jjRWx8y0dn9Chjq0eSgHYPIBV8c3bWQykQA55l2rZ4L5/Z+lBag=
X-Received: by 2002:a92:96c7:: with SMTP id g190mr2295604ilh.252.1596607387895;
 Tue, 04 Aug 2020 23:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200804085233.484875373@linuxfoundation.org>
In-Reply-To: <20200804085233.484875373@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 5 Aug 2020 11:32:56 +0530
Message-ID: <CA+G9fYsPq80QDQYbkCQPwS5DLCZXk7cZR8BeY6VHU4gyWGckwA@mail.gmail.com>
Subject: Re: [PATCH 5.7 000/116] 5.7.13-rc3 review
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

On Tue, 4 Aug 2020 at 14:24, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.7.13 release.
> There are 116 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 06 Aug 2020 08:51:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.7.13-rc3.gz
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

kernel: 5.7.13-rc3
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.7.y
git commit: d3223abaf6fdd20e0894b357a0f7f1da21a29226
git describe: v5.7.12-117-gd3223abaf6fd
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.7-oe/bui=
ld/v5.7.12-117-gd3223abaf6fd

No regressions (compared to build v5.7.12)

No fixes (compared to build v5.7.12)


Ran 34339 total tests in the following environments and test suites.

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
* ltp-cap_bounds-tests
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* perf
* v4l2-compliance
* ltp-dio-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cve-tests
* ltp-math-tests
* ltp-open-posix-tests
* ltp-syscalls-tests
* network-basic-tests
* igt-gpu-tools
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-native/drivers
* kselftest-vsyscall-mode-native/filesystems
* kselftest-vsyscall-mode-native/net
* kselftest-vsyscall-mode-none
* kselftest-vsyscall-mode-none/drivers
* kselftest-vsyscall-mode-none/filesystems
* kselftest-vsyscall-mode-none/net
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
