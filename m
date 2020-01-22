Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCAAC33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 18:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC0F24656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 18:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qa32FX6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgAVSJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 13:09:33 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33045 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgAVSJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 13:09:33 -0500
Received: by mail-lf1-f65.google.com with SMTP id n25so340674lfl.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 10:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OFxya5tA8LrYO2BuOQKaxQRHAp4yJwOH675Bl3dC1XA=;
        b=qa32FX6eebttgk63TWZHl2iBc8Cnl4Wwm5X6+88kyTzEXOc/vKmpeDeUzmjetkv87N
         +ZWvXw8ePwsk+0GQe+hoIAu6XIObhGbx9oYKWMsIMy4HCoy1R/+lg+bq32LfiekFAnMM
         t/Z4xT065ediNrX2lBo+9XYo99lowPaz+F+ZkJ6s4knKcQgCpJREAYmy1k6bOcaxO5a3
         8Db6a7H9M9MiEdhQ3Wa2XMKZqxUfkCgMOBsXbOKDgFzGLyc6N5cY5mZtgN/JeLwEEq4J
         2R/OxYrS11xOKG59FeJElvLE+jookWiHwcUTeJZkhH1NWYIU/zQQgdD6L0pB4+yQuUDJ
         930A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OFxya5tA8LrYO2BuOQKaxQRHAp4yJwOH675Bl3dC1XA=;
        b=IGr3thM0dgEF2cqbzrjwG/40QT8NIOp0AXJDV9BBb2eqFNbBwJYzz3a2v2Z5adWjWk
         lk3aAg0bfEK3UJQrVjzJSbv7HLS04wf6mJHyJQRHl4K24ebEg4gF2k8080aXQyRTWAp+
         t43cL25LK3aTnVQZwpkpMxxicOaeMUDfAQewnZYRQl+AjFDTuKDxRcUTXWJiqBi/Y3ot
         QELX6zNc/UvTmVyq5/MxBbSUF5OQ53Bwp8fmdDlg8UO9WIrfPA2btvDAo7Pxja8n0o5s
         vBuOC+vIurjDplY5pYA4NA7qA05qMJwXSKv414j0zmpKYhf9PYwA2+DwSHo7xygL/tAL
         uOQw==
X-Gm-Message-State: APjAAAU4d/D12iPr1G8Z5x1dz46gqCckVCnb2m9QI/F0Eutnyqo+4XRZ
        6EFb6DqPwY8UKqPK4qU9RGCnyetxXKFZOIzhT5taB/DN3KA=
X-Google-Smtp-Source: APXvYqwQS7oqM8FV+mdprXZGpGm6L1PI92Zd2q3xXsY/S0ZfbeRy/E+ZkB3Gcnt4sJ/5YqktsR4uzTVRqoUIjju6OPE=
X-Received: by 2002:a05:6512:64:: with SMTP id i4mr2448962lfo.55.1579716571067;
 Wed, 22 Jan 2020 10:09:31 -0800 (PST)
MIME-Version: 1.0
References: <20200122092833.339495161@linuxfoundation.org>
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 22 Jan 2020 23:39:19 +0530
Message-ID: <CA+G9fYuFsU+3V_3wKdkfNEr=LB+QsPv6WCzFVfbi6gHR5T=vmQ@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/222] 5.4.14-stable review
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

On Wed, 22 Jan 2020 at 18:48, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.14 release.
> There are 222 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 24 Jan 2020 09:25:24 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.14-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.4.14-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: 8045d34c9af0cfa13922e1d6a3f53155e2bcdc17
git describe: v5.4.13-223-g8045d34c9af0
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/bui=
ld/v5.4.13-223-g8045d34c9af0

No regressions (compared to build v5.4.13)

No fixes (compared to build v5.4.13)

Ran 21655 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c
- hi6220-hikey
- i386
- juno-r2
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15
- x86

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* kselftest
* libgpiod
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
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
* network-basic-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance
* ltp-open-posix-tests
* ltp-syscalls-tests
* kvm-unit-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
